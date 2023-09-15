using VaccineStockManagementWithMDPs
using Test
using DataFrames

@testset "VaccineStockManagementWithMDPs.jl" begin
    @test(
        VaccineStockManagementWithMDPs.
            greet_vaccine_stock_management_with_mdps() =="Hello VaccineStockManagementWithMDPs!"
    )
    p = VaccineStockManagementWithMDPs.load_parameters()
    p_sto = VaccineStockManagementWithMDPs.get_stochastic_perturbation()
    t = 90
    a_t = 0.25
    k = .0015
    S = p.S_0[1]
    E = p.E_0[1]
    I_S = p.I_S_0[1]
    I_A = p.I_A_0[1]
    R = p.R_0[1]
    D = p.D_0[1]
    V = p.V_0[1]
    X_vac = p.X_vac_interval[1]
    X_0_mayer = p.X_0_mayer[1]
    K_stock = p.k_stock[1]
    CL = sum([S, E, I_S, I_A, R, D, V])
    opt_policy = 1.0
    header_strs = [
        "t", "S", "E", "I_S",
        "I_A", "R", "D", "V", "CL",
        "X_vac", "X_0_mayer", "K_stock",
        "action", "opt_policy"
    ]
    x_0_vector = [
        t, S, E,
        I_S, I_A, R,
        D, V, CL,
        X_vac, X_0_mayer, K_stock,
        a_t, opt_policy
    ]
    x_df = DataFrame(
        Dict(
            zip(header_strs, x_0_vector)
        )    
    )
    x_new = 
        VaccineStockManagementWithMDPs.rhs_evaluation!(
            t, x_df, opt_policy,a_t, k, p
         )
    x_new_df =  DataFrame(
        Dict(
            zip(header_strs, x_new)
        )
    )
    @test(
        VaccineStockManagementWithMDPs.load_parameters().N_grid_size[1] == 500
    )
    @test VaccineStockManagementWithMDPs.get_stencil_projection(t, p) == 2 
    @test sum(x_new[2:8]) == 1.0
    @test p.t_delivery[2] != p_sto.t_delivery[2]
    @test(
        VaccineStockManagementWithMDPs.compute_cost(x_df, p) == 
        999999.9621877202
    )
end
