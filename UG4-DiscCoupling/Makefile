# Makefile for the "Introduction to UG4" presentations
# System of Equations. Coupled discretizations
# Jul. 6, 2025

# Base of the file names:
FILENAME = LDL-UG4-disc-coupling

TEXFILE = $(FILENAME).tex
PDFFILE = $(FILENAME).pdf

# Source files:
SOURCES = $(TEXFILE) ddf_model.tex disc_basics.tex ug4_disc.tex coupling.tex conclusion.tex

# Pictures:
PICTURES = DarcyDomain.pdf DiscDetails-Entire.pdf DiscDetails-Global.pdf DiscDetails-Local.pdf \
	Elder-2d-Scheme-ext.pdf FV-Elem-Donald-bnd.pdf FV-Elem-Donald-Scheme.pdf FV-Elem-Donald.pdf \
	StationarySolverFull.pdf ug4-coupling-scheme-export.pdf ug4-coupling-scheme-linker.pdf \
	ug4-coupling-scheme-simple.pdf ug4-coupling-scheme.pdf

$(PDFFILE): $(SOURCES) $(PICTURES)
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

$(SOURCES):

clean:
	rm -f *.{aux,nav,log,snm,toc,vrb,out}

cleanall: clean
	rm -f $(PDFFILE)

# End of File
