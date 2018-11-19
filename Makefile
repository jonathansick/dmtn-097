main=strategy
all : $(main).pdf

RERUN="(There were undefined references|Rerun to get (cross-references|the bars) right|Rerun to get citations correct|rerunfilecheck .* has changed)"

%.pdf : %.tex *.tex biblio.bib Makefile
	rm -f $*.bbl
	pdflatex $<
	bibtex $*
	@egrep -q $(RERUN) $*.log && pdflatex $< ; true
	@egrep -q $(RERUN) $*.log && pdflatex $< ; true
	@egrep -q $(RERUN) $*.log && pdflatex $< ; true

clean:
	rm -f *.log *.lof *.aux *.blg *.out $(main).pdf *.synctex.gz *.bbl *.brf *.toc


aa-sub :
	make $(main).pdf
	toto=$(main)-referee;\
	rm -f $${toto}.tex;\
	sed 's/\documentclass\[twocolumn\]{aa}/\documentclass[referee]{aa}/' $(main).tex > $${toto}.tex;\
	make $${toto}.pdf;\
	rm -f `ls $${toto}* | grep -v pdf`
#	make answer_to_referee.pdf 

