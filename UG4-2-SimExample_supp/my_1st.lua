-- A very simple LUA script for ugshell
--
-- D. Logashenko

InitUG (2, AlgebraType ("CPU", 1)) -- init the library for 2d, set the defaults (1 = scalar distributions)

dom = Domain () -- create the domain object

LoadDomain (dom, "sample_grid_2d.ugx") -- load the grid into the domain

refiner = GlobalDomainRefiner (dom) -- create the grid refinement strategy

for i = 1, 4 do
	refiner:refine () -- refine the grid
end

approxSpace = ApproximationSpace (dom) -- create the approximation space object
approxSpace:add_fct ("c", "Lagrange", 1) -- add one piecewise linear component - 'c'

u = GridFunction (approxSpace) -- create the grid function with the component 'c'

function my_values (x, y)
	return x*x + y*y
end

Interpolate (my_values, u, "c") -- set the values of the DoFs of the grid function

WriteGridFunctionToVTK (u, "my_values")

-- End of File
