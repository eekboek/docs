.PHONEY : orig

all:	ix.html

ix.html : orig.txt cheater.pl
	perl cheater.pl orig.txt

orig :
	ebshell -f ebcheat.conf  -c help | \
	  sed -n 's/^  \* \(.*\)/help \1/p' | \
	  ebshell --echo -f ebcheat.conf > orig.txt

install :
	for i in cheat.css kop.html ix.html details.html index.html; \
	do \
	  echo '[% META type = "text" %]' | cat - $$i > ../doc/src/cheat/$$i; \
	done
