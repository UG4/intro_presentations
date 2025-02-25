# Makefile for the "Introduction to UG4" presentations
# 3. Solvers in ug4
# Feb. 25, 2025

# Base of the file names:
FILENAME = LDL-UG4-3-Solver

TEXFILE = $(FILENAME).tex
PDFFILE = $(FILENAME).pdf

# Source files:
SOURCES = $(TEXFILE)

# Pictures:
PICTURES = NSDuese.pdf LinearSolverFull.pdf StationarySolverFull.pdf

$(PDFFILE): $(SOURCES) $(PICTURES)
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

$(SOURCES):

clean:
	rm -f *.{aux,nav,log,snm,toc,vrb,out}

cleanall: clean
	rm -f $(PDFFILE)

# End of File
