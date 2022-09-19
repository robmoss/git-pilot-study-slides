#
# Build HTML presentation slides from Markdown files, using pandoc.
#
# NOTE: This currently supports pandoc 2.5, which is the supported version on
# Ubuntu 20.04.
#

# Identify each slide set.
SOURCES := $(wildcard *.md)
OUTPUTS := $(SOURCES:.md=.html)
OUT_DIR := public

# Slides are written in Markdown, with \( ... \) used for inline maths.
PD_ARGS := --from=markdown+tex_math_single_backslash
# Produce HTML slides that use reveal.js (https://revealjs.com/).
PD_ARGS += --to=revealjs
# Display list items one by one, rather than all at once.
PD_ARGS += --incremental
# Produce standalone HTML documents.
PD_ARGS += --standalone
# Display maths with KaTeX.
PD_ARGS += --katex=https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.16.2/
# For compatibility with pandoc 2.5, display slides using Reveal 3.7.0.
# See https://github.com/hakimel/reveal.js/issues/2396 for details.
PD_ARGS += -V revealjs-url=https://unpkg.com/reveal.js@3.7.0/


#
# Default action: build each slide set.
#
all: $(OUTPUTS) | $(OUT_DIR)
	@cp $(OUTPUTS) $(OUT_DIR)

#
# Build a slide set from a Markdown file.
#
%.html: %.md
	@pandoc $(PD_ARGS) --output=$@ $<

#
# Create the output directory.
#
$(OUT_DIR):
	@mkdir $(OUT_DIR)

#
# Remove generated slides.
#
clean:
	@rm -f $(OUTPUTS)

#
# Identify targets that are not file names.
#
.PHONY: all clean
