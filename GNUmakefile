#! make -f

# Run (installed) tt2 tools, with our library for the plugins.
TTREE	:= perl -Mlib=${PWD}/lib -S ttree
TPAGE	:= perl -Mlib=${PWD}/lib -S tpage

## CONFIG ##  Where the sources of EekBoek reside.
EBSRC	:= $(shell cd ../src; pwd)
EBSHELL := ebshell

export TTREE TPAGE EBSHELL EBSRC

default : all

.PHONY : html htb

all : site-version htb

install : htb-install

################ On-line documentation (HTML pages) ################

site-version ::
	echo "[% site.eekboek.latest = \"${VERSION}\"; -%]" > lib/config/macros

html : etc/ttree.cfg
	$(TTREE) -f etc/ttree.cfg

clean ::
	rm -fr htdocs

etc/ttree.cfg : etc/ttree.tt2
	$(TPAGE) --define "cwd=$(shell pwd)" \
	  $< > ttree.cfg~ && \
	  mv ttree.cfg~ etc/ttree.cfg

clean ::
	rm -f etc/ttree.cfg

################ Wx Help (HTB archives) ################

htb :
	${MAKE} -C help build

htb-install :
	${MAKE} -C help install

clean ::
	${MAKE} -C help clean
