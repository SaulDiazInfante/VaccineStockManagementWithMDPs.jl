# SPDX-License-Identifier: MIT
"""
Module for simulation of a Vaccine stock Management with 
Markov Decission Processes. See
(https://www.overleaf.com/read/hqmrsgtnfvkh)[https://www.overleaf.com/read/hqmrsgtnfvkh]
to details.
"""
module VaccineStockManagementWithMDPs
    using JSON, DataFrames, Distributions, CSV, PlotlyJS, LaTeXStrings
    using Dates, ProgressMeter
    export greet_vaccine_stock_management_with_mdps
    export load_parameters
    export get_stencil_projection
    export rhs_evaluation!
    export get_stochastic_perturbation
    export compute_cost
    export get_vaccine_stock_coverage
    export get_vaccine_action!
    include("functions.jl")
    include("load_parameters.jl")
    include("get_stencil_projection.jl")
    include("rhs_evaluation.jl")
    include("get_stochastic_perturbation.jl")
    include("compute_cost.jl")
    include("get_vaccine_stock_coverage.jl")
    include("get_vaccine_action.jl")
end
