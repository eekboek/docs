#! make -f

.PHONEY : orig

EBSHELL = ebshell

build :	ix.html

ix.html : ebsqlite_ebcheat help.txt cheater.pl
	perl cheater.pl help.txt

# Ask ${EBSHELL} for help, and then ask for explicit help for each
# individual command.
help.txt :
	${EBSHELL} -X -f ebcheat.conf  -c help | \
	  sed -n 's/^  \* \(.*\)/help \1/p' > input.txt
	${EBSHELL} --echo -X -f ebcheat.conf < input.txt > help.txt

install : build
	cp commands.tt2 ../src/commands.tt2
	cp commands.html ../src/commands.html
	rsync -aH --delete --exclude='*~' topics/ ../src/topics/
	rsync -aH --delete --exclude='*~' css/ ../src/css/

clean :
	rm -f *~
	rm -f input.txt help.txt details.html ix.html ebsqlite* commands.tt2
	rm -fr topics

# Create an empty database so we can run ${EBSHELL} to extract help info.
ebsqlite_ebcheat :
	${EBSHELL} --import --file=leeg.ebz -X -f ebcheat.conf
