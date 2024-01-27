using VaccineStockManagementWithMDPs
using Test
using DataFrames
#
p = VaccineStockManagementWithMDPs.load_parameters()
p_sto = VaccineStockManagementWithMDPs.get_stochastic_perturbation();
t = 90; 
a_t = 0.25; 
k = 0.0015;
S = p.S_0[1];
E = p.E_0[1];
I_S = p.I_S_0[1];
I_A = p.I_A_0[1];
R = p.R_0[1];
D = p.D_0[1];
V = p.V_0[1];
X_vac = p.X_vac_interval[1]
X_0_mayer = p.X_0_mayer[1]
K_stock = p.k_stock[1]
k_0 = p.k_stock[1] / p.N[1]
CL = sum([S, E, I_S, I_A, R, D, V])
opt_policy = 1.0
N_grid_size = p.N_grid_size[1];
time_horizon_1 = p.t_delivery[2]
t_interval_1 = LinRange(0, time_horizon_1, N_grid_size)
operational_levels = p.operational_stock_levels
solution = zeros(Float64, N_grid_size, 13);

header_strs = [
    "t", "S", "E", "I_S",
    "I_A", "R", "D", "V", "CL",
    "X_vac", "X_0_mayer", "K_stock",
    "action", "opt_policy"
]
x_0_vector = [
    0.0, S, E,
    I_S, I_A, R,
    D, V, CL,
    X_vac, X_0_mayer, K_stock,
    0.0, 1.0
]
hat_N_n_0 = sum(x_0_vector[2:8]) - D
opt_policy = operational_levels[end]
t_delivery_1 = p.t_delivery[2]
x_0 = DataFrame(
    Dict(
        zip(
            header_strs,
            x_0_vector
        )
    )
)

x_df = DataFrame(
    Dict(
        zip(header_strs, x_0_vector)
    )
)
x_new =
    VaccineStockManagementWithMDPs.rhs_evaluation!(
        t, x_df, opt_policy, a_t, k, p
    )
x_new_df = DataFrame(
    Dict(
        zip(header_strs, x_new)
    )
)
x_c =
    VaccineStockManagementWithMDPs.get_vaccine_stock_coverage(k_0, p)
t = 80.0
k = 2

a_t = VaccineStockManagementWithMDPs.get_vaccine_action!(x_c, t_delivery_1, p)

x = VaccineStockManagementWithMDPs.get_interval_solution!(
        t_interval_1,
        x_0,
        opt_policy,
        a_t,
        k_0,
        p
);
time = x[:, 1]
#
# TODO: GetSolutionPath documentation
@testset "VaccineStockManagementWithMDPs.jl" begin
    @test(
        VaccineStockManagementWithMDPs.
            greet_vaccine_stock_management_with_mdps() =="Hello VaccineStockManagementWithMDPs!"
    )
    
    # Test for load_parameters.jl
    @test(
        VaccineStockManagementWithMDPs.load_parameters().N_grid_size[1] == 500
    )
    
    # Test for get_stencil_projection.jl
    @test VaccineStockManagementWithMDPs.get_stencil_projection(t, p) == 2 
    
    # Test for rhs_evaluation.jl
    @test sum(x_new[2:8]) == 1.0
    
    # Test for get_stochastic_perturbation.jl
    @test p.t_delivery[2] != p_sto.t_delivery[2]
    
    # Test for computing_cost.jl
    @test(
        VaccineStockManagementWithMDPs.compute_cost(x_df, p) == 
        999999.9621877202
    )
    @test(
        VaccineStockManagementWithMDPs.get_vaccine_stock_coverage(
            k, p
        ) >= 0.0
    )
    @test(
        VaccineStockManagementWithMDPs.get_vaccine_action!(
            x_c, t, p
        ) >= 0.0
    )
    sol = VaccineStockManagementWithMDPs.get_interval_solution!(
        t_interval_1,
        x_0,
        opt_policy,
        a_t,
        k_0,
        p
    );
    cl_sol = sum(sol[end, 2:8]);
    @test(
        isapprox(cl_sol, 1.0, rtol=1e-2, atol=1e-3)
    )
    names_str = ["time", "S", "E",
        "I_S", "I_A", "R",
        "D", "V", "CL",
        "X_vac", "K_stock", "action"
    ]
    df = VaccineStockManagementWithMDPs.save_interval_solution(x;
        header_strs=names_str,
        file_name="solution_interval.csv"
    )
    @test(
        issetequal(names(df), names_str)
    )
    # TODO: Compile and test save_invterval_solution.jl
    sol_path = VaccineStockManagementWithMDPs.get_solution_path!(p)
    @test(
        isapprox(sol_path[1].CL[1], 1.0, rtol=1e-2, atol=1e-3)
    )
end
