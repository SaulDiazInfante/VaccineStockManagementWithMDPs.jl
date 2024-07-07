using VaccineStockManagementWithMDPs
using Test
using DataFrames, CSV
using CairoMakie
CairoMakie.activate!()

path = joinpath("data", "df_mc.csv")
df_mc = DataFrame(CSV.File(path))
dark_latexfonts = merge(theme_dark(), theme_latexfonts())
with_theme(dark_latexfonts) do
    get_panel_plot(df_mc, 5)
end