CC=js /opt/lessc/bin/lessc
YUI_COMPRESSOR = java -jar /opt/yuicompressor/yuicompressor-2.4.6.jar
YUI_COMPRESSOR_FLAGS = --charset utf-8 --type css

CSS_FILES = $(filter-out %.min.css,$(wildcard \
	css/*.css \
))
LESS_FILES = $(filter-out %.css,$(wildcard \
	css/*.less \
))

CSS_GENERATED = $(LESS_FILES:.less=.css)
CSS_MINIFIED = $(CSS_FILES:.css=.min.css)

less: $(LESS_FILES) $(CSS_GENERATED)
minify: $(CSS_FILES) $(CSS_MINIFIED)

%.css: %.less
	@echo '==> Lessing $<'
	$(CC) $< >$@
	@echo

%.min.css: %.css
	@echo '==> Minifying $<'
	$(YUI_COMPRESSOR) $(YUI_COMPRESSOR_FLAGS) --type css $< >$@
	@echo

clean:
	rm -f $(CSS_MINIFIED) $(CSS_GENERATED)

# target: help - Displays help.
help:
	@egrep "^# target:" Makefile
