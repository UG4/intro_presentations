-- Solution of the Poisson equation (the simplest version)
--
-- D. Logashenko

-- Load utility scripts (e.g. from from ugcore/scripts)
ug_load_script("ug_util.lua")

-- Parameters of the problem
dim = 2 -- Dimensionality of the problem
gridName = "unit_square_01_tri_2x2.ugx" -- the grid
numRefs = util.GetParamNumber("-numRefs", 4, "Number of refinements") -- read option -numRefs from the command line (default value = 4)

function ExactSol (x, y)
	return math.sin (20 * x) + math.sin (20 * y)
end

function RHS (x, y)
	return 400 * (math.sin (20 * x) + math.sin (20 * y))
end

function Dirichlet (x, y)
	return ExactSol (x, y)
end

-- initialize ug with the world dimension and the algebra type
InitUG (dim, AlgebraType("CPU", 1));

-- Load a domain without initial refinements.
dom = util.CreateDomain (gridName, 0)

-- Refine the domain (redistribution is handled internally for parallel runs)
print("refining...")
util.refinement.CreateRegularHierarchy (dom, numRefs, true)

-- set up approximation space
approxSpace = ApproximationSpace (dom)
approxSpace:add_fct ("c", "Lagrange", 1)
approxSpace:init_levels ()
approxSpace:init_top_surface ()

print("approximation space:")
approxSpace:print_statistic ()

-------------------
-- set up discretization
-------------------

-- local assembling
elemDisc = ConvectionDiffusion ("c", "Inner", "fv1")
elemDisc:set_diffusion (1.0)
elemDisc:set_source ("RHS")

-- boundary condition
dirichletBND = DirichletBoundary ()
dirichletBND:add ("Dirichlet", "c", "Boundary")

-- global assembling
domainDisc = DomainDiscretization (approxSpace)
domainDisc:add (elemDisc)
domainDisc:add (dirichletBND)

-------------------
-- set up the linear solver
-------------------

-- set up solver (using 'util/solver_util.lua')
solverDesc = {
	type = "cg",
	precond = { type = "gmg", approxSpace = approxSpace, smoother = "ilu", baseSolver = "lu" },
	convCheck = {
		type		= "standard",
		iterations	= 100,
		absolute	= 1e-12,
		reduction	= 1e-10,
		verbose		= true
	}
}

solver = util.solver.CreateSolver(solverDesc)

-------------------
-- assemble the data
-------------------

A = AssembledLinearOperator (domainDisc)
u = GridFunction (approxSpace)
b = GridFunction (approxSpace)
u:set (0.0)
domainDisc:adjust_solution (u) -- set the boundary conditions etc.
domainDisc:assemble_linear (A, b) -- apply the discretization, assemble the matrix and the rhs

-------------------
-- solve the discretized problem
-------------------

solver:init (A, u) -- initialize the solver (for ex., compute the ILU decompositions)
solver:apply (u, b) -- apply the linear solver

-- Compute the error
L2_error = L2Error ("ExactSol", u, "c", 0, 4)
print("L2 error on grid level "..numRefs..": "..L2_error)

-- Write the numerical solution for visualization
solFileName = "poisson_sol_GL"..numRefs
print ("writing solution to '" .. solFileName .. "'...")
WriteGridFunctionToVTK (u, solFileName)

print("done")
