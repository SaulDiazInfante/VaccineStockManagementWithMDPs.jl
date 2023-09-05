"""
        get_stencil_projection(t, parameters)    

        Returns the index of corresponding projection of time t to the 
        stencil and in accordance with the parameters vector.
        The projection can be defined as a evulaution of function
        ``
            \\eta(t): = 
            \\sup_{i \\in \\{1, 2 \\dots, N \\}}
            \\{
                t \\geq t_i: t_i = i * h
            \\}
        ``
# Arguments
- `j::Float`: time to project to the stencil
- `parameters::DataFrame` Data Frame loaded with `load_parameters(...)` 
    function 
...
"""
#
function get_stencil_projection(t, parameters)
    stencil = parameters.t_delivery
    grid = findall(t .>= stencil)
    projection = maximum(grid)
    return projection
end
