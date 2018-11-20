DOCTYPE = DMTN
DOCNUMBER = 097
DOCNAME = $(DOCTYPE)-$(DOCNUMBER)

GITVERSION := $(shell git log -1 --date=short --pretty=%h)
GITDATE := $(shell git log -1 --date=short --pretty=%ad)
GITSTATUS := $(shell git status --porcelain)
ifneq "$(GITSTATUS)" ""
	GITDIRTY = -dirty
endif

export TEXMFHOME = lsst-texmf/texmf

$(DOCNAME).pdf: $(DOCNAME).tex meta.tex
	xelatex $(DOCNAME)
	bibtex $(DOCNAME)
	xelatex $(DOCNAME)
	xelatex $(DOCNAME)

.PHONY: clean
clean:
	rm -f DMTN-097.aux
	rm -f DMTN-097.bbl
	rm -f DMTN-097.blg
	rm -f DMTN-097.log
	rm -f DMTN-097.out
	rm -f DMTN-097.pdf
	rm -f DMTN-097.rec
	rm -f DMTN-097.toc
	rm -f meta.tex

.FORCE:

meta.tex: Makefile .FORCE
	rm -f $@
	touch $@
	echo '% GENERATED FILE -- edit this in the Makefile' >>$@
	/bin/echo '\newcommand{\lsstDocType}{$(DOCTYPE)}' >>$@
	/bin/echo '\newcommand{\lsstDocNum}{$(DOCNUMBER)}' >>$@
	/bin/echo '\newcommand{\vcsRevision}{$(GITVERSION)$(GITDIRTY)}' >>$@
	/bin/echo '\newcommand{\vcsDate}{$(GITDATE)}' >>$@
