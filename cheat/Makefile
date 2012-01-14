.PHONEY : orig

all:	ix.html

ix.html : ebsqlite_sample orig.txt cheater.pl
	perl cheater.pl orig.txt

orig.txt :
	ebshell -f ebcheat.conf  -c help | \
	  sed -n 's/^  \* \(.*\)/help \1/p' | \
	  ebshell --echo -f ebcheat.conf > orig.txt

install :
	for i in cheat.css kop.html ix.html details.html index.html; \
	do \
	  echo '[% META type = "text" %]' | cat - $$i > ../doc/src/cheat/$$i; \
	done

clean :
	rm -f *~
	rm -f orig.txt details.html ix.html ebsqlite* 

ebsqlite_sample :
	ebshell --import --file=leeg.ebz -f ebcheat.conf
