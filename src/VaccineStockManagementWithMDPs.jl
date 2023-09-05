# SPDX-License-Identifier: MIT
"""
Module for simulation of a Vaccine stock Management with 
Markov Decission Processes.
See (https://www.overleaf.com/read/hqmrsgtnfvkh)[https://www.overleaf.com/read/hqmrsgtnfvkh]
to details.
"""
module VaccineStockManagementWithMDPs

    using JSON, DataFrames
    export greet_vaccine_stock_management_with_mdps
    export load_parameters
    export get_stencil_projection
    export rhs_evaluation!
    include("functions.jl")
    include("load_parameters.jl")
    include("get_stencil_projection.jl")
    include("rhs_evaluation.jl")
end