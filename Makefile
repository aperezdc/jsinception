
all: out/index.html out/livecoding.mp3

out/index.html: jsinception.rst jsinception.css
	hovercraft $< $(dir $@)

out/livecoding.mp3: livecoding.mp3
	mkdir -p $(dir $@)
	cp -L $< $@

jsinception.css: jsinception.css.in
	cpp -nostdinc -w -P $< | sed 'y/$$/#/' > $@

all_ttf := $(wildcard *.ttf)
all_eot := $(patsubst %.ttf,%.eot,$(all_ttf))
all_woff := $(patsubst %.ttf,%.woff,$(all_ttf))

fonts-woff: $(all_woff)
.PHONY: fonts-woff

fonts-eot: $(all_eot)
.PHONY: fonts-eot

fonts: fonts-woff fonts-eot
.PHONY: fonts

%.woff: %.ttf
	sfnt2woff $<

%.eot: %.ttf
	ttf2eot $< > $@

