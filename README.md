# LaTeX sources of introductory presentations to ug4

This repository contains sources of presentation of an introductory course to ug4. Every presentation is located in a separate folder. To create the pdf file, you need a working LaTeX installation and the make utility. Enter the folder of the presentation and run

make

To clean the auxiliary LaTeX files, run

make clean

To delete all the created files (including the pdf file of the presentation), run

make cleanall

There are two types of the presentations: A course of short presentations and a couple of long presentations with more detailed overviews. Whereas the former are prepared for beginners and (some of them) have supplementary materials (scripts and geometries) for some practice, the latter are devoted either to all-in-one reviews or explanations of particular features.

## The course of short presentations

The idea is that one presentation is used for a 1.5-hour class, with some practice using provides scripts. The scripts are located in separate folders named like the presentation but with the suffix "_supp".

Currently available presentations:
- Installation and Architecture (UG4-1-Installation)
- ug4: Example of a Simulation (UG4-2-SimExample, supp. materials in UG4-2-SimExample_supp)
- Solvers in ug4 (UG4-3-Solver, supp. materials in UG4-3-Solver_supp)

## The Long presentations

Currently available presentations:

- Numerical solution of coupled PDEs with ug4 (UG4-DiscCoupling)
