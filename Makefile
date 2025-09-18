# Makefile for all the presentations

folder: all
	mkdir All-Slides
	cd UG4-1-Installation; mv LDL-UG4-1-Installation.pdf ../All-Slides; make clean; cd
	cd UG4-2-SimExample; mv LDL-UG4-2-SimExample.pdf ../All-Slides; make clean; cd
	cd UG4-3-Solver; mv LDL-UG4-3-Solver.pdf ../All-Slides; make clean; cd
	cd UG4-DiscCoupling; mv LDL-UG4-DiscCoupling.pdf ../All-Slides; make clean; cd

all: 1-Installation 2-SimExample 3-Solver DiscCoupling

1-Installation:
	cd UG4-1-Installation; make; cd

2-SimExample:
	cd UG4-2-SimExample; make; cd

3-Solver:
	cd UG4-3-Solver; make; cd

DiscCoupling:
	cd UG4-DiscCoupling; make; cd

clean:
	cd UG4-1-Installation; make clean; cd
	cd UG4-2-SimExample; make clean; cd
	cd UG4-3-Solver; make clean; cd
	cd UG4-DiscCoupling; make clean; cd

cleanall:
	cd UG4-1-Installation; make cleanall; cd
	cd UG4-2-SimExample; make cleanall; cd
	cd UG4-3-Solver; make cleanall; cd
	cd UG4-DiscCoupling; make cleanall; cd
	rm -rf All-Slides

# End of File
