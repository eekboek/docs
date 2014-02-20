#! make -f

TTREE	:= perl -Mlib=lib /usr/bin/ttree
TPAGE	:= perl -Mlib=lib /usr/bin/tpage

default : build

build : etc/ttree.cfg
	$(TTREE) -f etc/ttree.cfg

etc/ttree.cfg : etc/ttree.tt2
	$(TPAGE) --define "cwd=$(shell pwd)" \
	  $< > ttree.cfg~ && \
	  mv ttree.cfg~ etc/ttree.cfg

