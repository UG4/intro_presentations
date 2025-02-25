# Makefile for the "Introduction to UG4" presentations
# 2. Example of a Simulation
# Feb. 18, 2025

# Base of the file names:
FILENAME = LDL-UG4-2-SimExample

TEXFILE = $(FILENAME).tex
PDFFILE = $(FILENAME).pdf

# Source files:
SOURCES = $(TEXFILE)

# Pictures:
PICTURES = Discretization.pdf FV-Elem-Donald-Scheme.pdf FV-Elem-Donald.pdf FV-Elem-Donald-bnd.pdf \
	bilinear-geometric.pdf Circle-lev0.png Circle-lev1.png Circle-lev2.png Circle-phi.png

$(PDFFILE): $(SOURCES) $(PICTURES)
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

$(SOURCES):

clean:
	rm -f *.{aux,nav,log,snm,toc,vrb,out}

cleanall: clean
	rm -f $(PDFFILE)

# End of File
