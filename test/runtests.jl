using VaccineStockManagementWithMDPs
using Test
using DataFrames

@testset "VaccineStockManagementWithMDPs.jl" begin
    @test VaccineStockManagementWithMDPs.greet_vaccine_stock_management_with_mdps() == "Hello VaccineStockManagementWithMDPs!"
    @test VaccineStockManagementWithMDPs.greet_vaccine_stock_management_with_mdps() != "Hellow World!"
    p = VaccineStockManagementWithMDPs.load_parameters()
    t = 90
    a_t = 0.25
    k = .0015
    x_df = DataFrame(
        S = p.S_0[1],
        E = p.E_0[1],
        I_S = p.I_S_0[1],
        I_A = p.I_A_0[1],
        R = p.R_0[1],
        D = p.D_0[1],
        V = p.V_0[1],
        X_vac = p.X_vac_interval[1],
        K_stock = p.k_stock[1]
    )
    x_new= VaccineStockManagementWithMDPs.rhs_evaluation(t, x_df, a_t, k, p)
    @test VaccineStockManagementWithMDPs.load_parameters().N_grid_size[1] == 500
    @test VaccineStockManagementWithMDPs.get_stencil_projection(t, p) == 2 
    @test sum(x_new[1:7]) == 1.0
end
