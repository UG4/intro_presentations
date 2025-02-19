-- A very simple LUA script for ugshell with LUA utils
--
-- D. Logashenko

ug_load_script ("ug_util.lua")

InitUG (2, AlgebraType ("CPU", 1)) -- init the library for 2d, set the defaults (1 = scalar distributions)

dom = util.CreateDomain ("sample_grid_2d.ugx", 4) -- create domain, load and refine the grid

approxSpace = ApproximationSpace (dom) -- create the approximation space object
approxSpace:add_fct ("c", "Lagrange", 1) -- add one piecewise linear component - 'c'

u = GridFunction (approxSpace) -- create the grid function with the component 'c'

function my_values (x, y)
	return x*x + y*y
end

Interpolate (my_values, u, "c") -- set the values of the DoFs of the grid function

WriteGridFunctionToVTK (u, "my_values")

-- End of File
