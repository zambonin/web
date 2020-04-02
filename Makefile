SRC_FILES = $(wildcard *.tex)
OUTPUT_DIR = static
KBFS_FOLDER = $(shell keybase config get mountdir)
KEYBASE_USER = $(shell keybase config get current_user)
KBFS_PUB_FOLDER = $(KBFS_FOLDER)/public/$(KEYBASE_USER)

all: $(SRC_FILES:.tex=.pdf)

%.pdf: %.tex
	latexmk -outdir=$(OUTPUT_DIR) -interaction=nonstopmode \
		-shell-escape -pdf -use-make -cd $<

clean:
	latexmk -outdir=$(OUTPUT_DIR) -cd -C $(SRC_FILES)
	$(RM) $(OUTPUT_DIR)/*.bbl

keybase: /usr/bin/keybase
	cp -r $(OUTPUT_DIR) index.html $(KBFS_PUB_FOLDER)
	sed -i 's/keybase.pub/org/g' $(KBFS_PUB_FOLDER)/index.html
