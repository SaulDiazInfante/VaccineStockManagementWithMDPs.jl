using VaccineStockManagementWithMDPs
using Test
using DataFrames, CSV
using CairoMakie
CairoMakie.activate!()

path_lower_q = joinpath("data", "df_lower_q.csv")
path_median = joinpath("data", "df_median.csv")
path_upper_q = joinpath("data", "df_upper_q.csv")


df_lower_q = DataFrame(CSV.File(path_lower_q))
df_median = DataFrame(CSV.File(path_median))
df_upper_q = DataFrame(CSV.File(path_upper_q))

function plot_confidence_bands(df_lower_q, df_median, df_upper_q)
    f = Figure(
        size=(1000, 700)
    )

    axtop = Axis(f[1, 1], ylabel="Stock")
    axmidle = Axis(f[2, 1], ylabel="Vaccination rate")


    lines!(
        axtop,
        df_lower_q[!, :time],
        df_lower_q[!, :K_stock]
    )

    lines!(
        axtop,
        df_upper_q[!, :time],
        df_upper_q[!, :K_stock]
    )

    band!(
        axtop,
        df_lower_q[!, :time],
        df_lower_q[!, :K_stock],
        df_upper_q[!, :K_stock],
        alpha=0.3
    )

    lines!(
        axtop,
        df_median[!, :time],
        df_median[!, :K_stock]
    )

    lines!(
        axmidle,
        df_lower_q[!, :time],
        df_lower_q[!, :action]
    )

    lines!(
        axmidle,
        df_upper_q[!, :time],
        df_upper_q[!, :action]
    )

    band!(
        axmidle,
        df_lower_q[!, :time],
        df_lower_q[!, :action],
        df_upper_q[!, :action],
        alpha=0.3
    )
    lines!(
        axmidle,
        df_median[!, :time],
        df_median[!, :action]
    )
    f
end

dark_latexfonts = merge(theme_dark(), theme_latexfonts())
with_theme(dark_latexfonts) do
    plot_confidence_bands(df_lower_q, df_median, df_upper_q)
end