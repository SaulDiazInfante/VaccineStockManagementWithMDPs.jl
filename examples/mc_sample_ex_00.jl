using VaccineStockManagementWithMDPs
using Test
using DataFrames, CSV
#
sampling_size = 50;

df_par, df_mc, path_par, path_mc = montecarlo_sampling(
    sampling_size,
    "data/parameters_model.json"
)
df_stat = get_simulation_statistics()
