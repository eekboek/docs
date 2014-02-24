#! make -f

subdirs := nl # en

build   : ; $(foreach lang,$(subdirs),${MAKE} -C ${lang} build   ; )
install : ; $(foreach lang,$(subdirs),${MAKE} -C ${lang} install ; )
clean   : ; $(foreach lang,$(subdirs),${MAKE} -C ${lang} clean   ; )
