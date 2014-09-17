
all: out/index.html out/livecoding.mp3

out/index.html: jsinception.rst jsinception.css print.css
	hovercraft $< $(dir $@)

out/livecoding.mp3: livecoding.mp3
	mkdir -p $(dir $@)
	cp -L $< $@

jsinception.css: jsinception.css.in fonts.css.in css.in
	./ccss $< > $@

print.css: print.css.in fonts.css.in css.in
	./ccss $< > $@

all_ttf := $(wildcard *.ttf)
all_eot := $(patsubst %.ttf,%.eot,$(all_ttf))
all_otf := $(patsubst %.ttf,%.otf,$(all_ttf))
all_woff := $(patsubst %.ttf,%.woff,$(all_ttf))

fonts-woff: $(all_woff)
.PHONY: fonts-woff

fonts-otf: $(all_otf)
.PHONY: fonts-otf

fonts-eot: $(all_eot)
.PHONY: fonts-eot

fonts: fonts-woff fonts-otf fonts-eot
.PHONY: fonts

%.otf: %.ttf
	font2otf $<

%.woff: %.ttf
	sfnt2woff $<

%.woff: %.otf
	sfnt2woff $<

%.eot: %.ttf
	ttf2eot $< > $@

