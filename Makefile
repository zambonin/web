SRC_FILES = $(wildcard *.tex)
OUTPUT_DIR = static

all: $(SRC_FILES:.tex=.pdf)

%.pdf: %.tex
	latexmk -outdir=$(OUTPUT_DIR) -interaction=nonstopmode \
		-shell-escape -pdf -use-make -cd $<

clean:
	latexmk -outdir=$(OUTPUT_DIR) -cd -C $(SRC_FILES)
	$(RM) $(OUTPUT_DIR)/*.bbl
