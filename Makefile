
all: out/index.html out/livecoding.mp3

out/index.html: jsinception.rst jsinception.css
	hovercraft $< $(dir $@)

out/livecoding.mp3: livecoding.mp3
	mkdir -p $(dir $@)
	cp -L $< $@

jsinception.css: jsinception.css.in
	cpp -nostdinc -w -P $< | sed 'y/$$/#/' > $@

