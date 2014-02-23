#! make -f

.PHONEY : orig

build :	ix.html

ix.html : ebsqlite_ebcheat help.txt cheater.pl
	perl cheater.pl help.txt

# Ask ${EBSHELL} for help, and then ask for explicit help for each
# individual command.
help.txt :
	${EBSHELL} -f ebcheat.conf  -c help | \
	  sed -n 's/^  \* \(.*\)/help \1/p' | \
	  ${EBSHELL} --echo -f ebcheat.conf > help.txt

install :
	cp commands.tt2 ../src/commands.tt2
	cp commands.html ../src/commands.html
	rsync -avH --delete topics/ ../src/topics/
	rsync -avH --delete css/ ../src/css/

clean :
	rm -f *~
	rm -f help.txt details.html ix.html ebsqlite* commands.tt2
	rm -fr topics

# Create an empty database so we can run ${EBSHELL} to extract help info.
ebsqlite_ebcheat :
	${EBSHELL} --import --file=leeg.ebz -f ebcheat.conf
