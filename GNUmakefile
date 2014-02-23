#! make -f

TTREE	:= perl -Mlib=$(shell pwd)/lib /usr/bin/ttree
TPAGE	:= perl -Mlib=$(shell pwd)/lib /usr/bin/tpage
EBSHELL := ebshell
export TTREE TPAGE EBSHELL

default : all

.PHONY : html htb

all : html htb

################ On-line documentation (HTML pages) ################

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
