# Makefile for the "Introduction to UG4" presentations
# 1. Installation and Architecture
# Feb. 18, 2025

# Base of the file names:
FILENAME = LDL-UG4-1-Installation

TEXFILE = $(FILENAME).tex
PDFFILE = $(FILENAME).pdf

# Source files:
SOURCES = $(TEXFILE)

# Pictures:
PICTURES = Pan-Scheme.pdf PanSolution3d-coil_and_pan_v3-lev4.pdf coil_and_pan_v3_res.pdf

$(PDFFILE): $(SOURCES) $(PICTURES)
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

$(SOURCES):

clean:
	rm -f *.{aux,nav,log,snm,toc,vrb,out}

cleanall: clean
	rm -f $(PDFFILE)

# End of File
