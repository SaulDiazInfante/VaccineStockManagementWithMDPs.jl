using VaccineStockManagementWithMDPs
using Test
using DataFrames, CSV
using CairoMakie
CairoMakie.activate!()
#
sampling_size = 100;

df_par, df_mc, path_par, path_mc = montecarlo_sampling(
    sampling_size,
    "data/parameters_model.json"
)
df_stat = get_simulation_statistics()

function panel_plot(n_paths::Int)
    f = Figure(
        size=(1000, 700)
    )

    axtop = Axis(f[1, 1], ylabel="Stock")
    axmidle = Axis(f[2, 1], ylabel="Vaccination rate")
    axbottom = Axis(f[3, 1], xlabel="time", ylabel="Decision")
    ax_right = Axis(f[:, 2], xlabel="time", ylabel=L"I_S")
    for i in 1:n_paths
        data_path_i = filter(
            :idx_path => n -> n == i,
            df_mc
        )
        lines!(
            axtop,
            data_path_i[!, :time],
            data_path_i[!, :K_stock]
        )
        band!(
            axtop,
            data_path_i[!, :time],
            0.0,
            data_path_i[!, :K_stock],
            alpha=0.3
        )
        lines!(
            axmidle,
            data_path_i[!, :time],
            data_path_i[!, :opt_policy] .* data_path_i[!, :action]
        )
        band!(
            axmidle,
            data_path_i[!, :time],
            0.0,
            data_path_i[!, :opt_policy] .* data_path_i[!, :action],
            alpha=0.2
        )
        lines!(
            axbottom,
            data_path_i[!, :time],
            data_path_i[!, :opt_policy]
        )
        lines!(
            ax_right,
            data_path_i[!, :time],
            data_path_i[!, :I_S]
        )
        filename = "panel_0" * string(i) * ".png"
        save(filename, f)
    end
    f


end

function plot_confidence_bands()
    f = Figure(
        size=(1000, 700)
    )

    axtop = Axis(f[1, 1], ylabel="Stock")
    axmidle = Axis(f[2, 1], ylabel="Vaccination rate")



    lines!(
        axtop,
        data_path_i[!, :time],
        data_path_i[!, :K_stock]
    )
    band!(
        axtop,
        data_path_i[!, :time],
        0.0,
        data_path_i[!, :K_stock],
        alpha=0.3
    )


end


dark_latexfonts = merge(theme_dark(), theme_latexfonts())


with_theme(dark_latexfonts) do
    panel_plot(5)
end


