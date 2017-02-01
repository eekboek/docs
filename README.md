# EekBoek on-line documentatie

Het bouwen van de documentatie vereist een recente versie van de
Template Toolkit, alsmede een van de perl modules Image::Info of
Image::Size.

De makefile is GNUmakefile. Deze wordt in principe aangeroepen vanuit
de source tree (repo 'eekboek', make target 'docs').

Vanuit deze repo zijn de volgende targets te gebruiken:

### html
Genereert de documentatie in HTML vorm in de directory htdocs.
Dit is voornamelijk om de documentatie te testen.

### htb
Genereert help/nl/docs.htb voor de documentatiebrowser.
