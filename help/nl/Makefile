
default :
	echo 

build : docs.htb

docs.htb :
	rm -fr src && mkdir src && rsync -aH ../../src/ src/
	${MAKE} -C cheat build
	${MAKE} -C cheat install
	cp docs.* src/
	cp license.* src/
	$(TTREE) -f etc/ttree.cfg
	rm -f docs.htb
	cd htdocs; zip -r ../docs.htb *

clean :
	rm -fr htdocs
	rm -fr src/topics/*
	${MAKE} -C cheat clean
