using VaccineStockManagementWithMDPs
using Test

@testset "VaccineStockManagementWithMDPs.jl" begin
    @test VaccineStockManagementWithMDPs.greet_vaccine_stock_management_with_mdps() == "Hello VaccineStockManagementWithMDPs!"
    @test VaccineStockManagementWithMDPs.greet_vaccine_stock_management_with_mdps() != "Hellow World!"
end
