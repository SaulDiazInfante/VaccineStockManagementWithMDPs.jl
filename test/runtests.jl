using VaccineStockManagementWithMDPs
using Test

@testset "VaccineStockManagementWithMDPs.jl" begin
    @test VaccineStockManagementWithMDPs.greet_vaccine_stock_management_with_mdps() == "Hello VaccineStockManagementWithMDPs!"
    @test VaccineStockManagementWithMDPs.greet_vaccine_stock_management_with_mdps() != "Hellow World!"
    VaccineStockManagementWithMDPs.load_parameters()
    @test VaccineStockManagementWithMDPs.load_parameters().N_grid_size[1] == 500
end
