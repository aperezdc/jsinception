
out/index.html: jsinception.rst jsinception.css
	hovercraft $< $(dir $@)

jsinception.css: jsinception.css.in
	cpp -nostdinc -w -P $< | sed 'y/$$/#/' > $@

