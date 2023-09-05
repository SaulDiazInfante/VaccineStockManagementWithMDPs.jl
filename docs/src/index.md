```@meta
    CurrentModule = VaccineStockManagementWithMDPs
```
# VaccineStockManagementWithMDPs.jl
Julia code for the simulation of a Vaccine Stock plugged to a SEIRVD 
structure and a sequeital set of decisions.

# load_parameters.jl

```@docs
load_parameters(json_file_name="../data/parameters_model.json")
```

# get_stencil_projection.jl

```@docs
get_stencil_projection(t, parameters)
```

# rhs_evaluation.jl

```@docs
rhs_evaluation!(t, x, a_t, k, parameters)
```

# References

1. "Julia Programming for Operations Research" by Changhyun Kwon and Youngdae Cho: This book focuses on using Julia for solving optimization problems and is suitable for readers with a background in operations research or mathematical optimization.

2. "Julia High Performance" by Avik Sengupta: This book covers various techniques to write high-performance code in Julia, making the most of its just-in-time compilation and multiple dispatch features.

3. "Hands-On Design Patterns and Best Practices with Julia" by Tom Kwong: This book introduces design patterns and best practices for writing maintainable and efficient code in Julia.

4. "Think Julia: How to Think Like a Computer Scientist" by Ben Lauwens and Allen Downey: This beginner-friendly book takes a hands-on approach to learning Julia and covers fundamental programming concepts through practical examples and exercises.

5. "Learning Julia: Build high-performance applications for scientific computing" by Anshul Joshi and Rahul Lakhanpal: This book provides an introduction to Julia for scientific computing and covers topics such as data manipulation, visualization, and parallel computing.

