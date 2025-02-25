-- Solution of the Poisson equation (the simplest version)
--
-- D. Logashenko

-- Load utility scripts (e.g. from from ugcore/scripts)
ug_load_script("ug_util.lua")

-- Parameters of the problem
dim = 2 -- Dimensionality of the problem
gridName = "stripe.ugx" -- the grid
stripeD = util.GetParamNumber("-stripeD", 0.0001, "Diffusion coeff. in the stripe")
numRefs = util.GetParamNumber("-numRefs", 6, "Number of refinements")
numSmooth = util.GetParamNumber("-numSmooth", 1, "Number of pre- and postsmoothing steps")
solver = util.GetParam("-solver", "linear", "linear or cg: the iteration")

print ("Diffusion coeff. in the stripe: " .. stripeD .. "\n")

-- initialize ug with the world dimension and the algebra type
InitUG(dim, AlgebraType("CPU", 1));

-- Load a domain without initial refinements.
dom = util.CreateDomain(gridName, 0)

-- Refine the domain (redistribution is handled internally for parallel runs)
print("refining...")
util.refinement.CreateRegularHierarchy(dom, numRefs, true)

-- set up approximation space
approxSpace = ApproximationSpace(dom)
approxSpace:add_fct("c", "Lagrange", 1)
approxSpace:init_levels()
approxSpace:init_top_surface()

print("approximation space:")
approxSpace:print_statistic()

-------------------
-- set up discretization
-------------------

elemDisc_Bulk = ConvectionDiffusion("c", "Bulk", "fv1")
elemDisc_Bulk:set_diffusion(1.0)

elemDisc_Stripe = ConvectionDiffusion("c", "Stripe", "fv1")
elemDisc_Stripe:set_diffusion(stripeD)

dirichletBND = DirichletBoundary()
dirichletBND:add(1.0, "c", "LeftBnd")
dirichletBND:add(0.0, "c", "RightBnd")

domainDisc = DomainDiscretization(approxSpace)
domainDisc:add(elemDisc_Bulk)
domainDisc:add(elemDisc_Stripe)
domainDisc:add(dirichletBND)

-------------------
-- set up the linear solver
-------------------

solverDesc = {
	type = solver,
	precond =
		{
			type = "gmg",
			approxSpace = approxSpace,
			smoother = "ilu",
			preSmooth = numSmooth,
			postSmooth = numSmooth,
			baseSolver = "lu"
		},
	convCheck = {
		type		= "standard",
		iterations	= 64,
		absolute	= 1e-12,
		reduction	= 1e-10,
		verbose		= true
	}
}

solver = util.solver.CreateSolver(solverDesc)

print ("Number of pre- and postsmooting steps: "..numSmooth)

-------------------
-- assemble the data
-------------------

A = AssembledLinearOperator(domainDisc)
u = GridFunction(approxSpace)
b = GridFunction(approxSpace)
u:set(0.0)
domainDisc:adjust_solution(u)
domainDisc:assemble_linear(A, b)

-------------------
-- solve the discretized problem
-------------------

solver:init(A, u)
solver:apply(u, b)

solFileName = "stripe_diffusion_GL"..numRefs
print("writing solution to '" .. solFileName .. "'...")
WriteGridFunctionToVTK(u, solFileName)

print("done")
