"""
Returns a figure that encloses a panel visualization with 
vaccine stock,
vaccination rate, and optimal decision at the left, 
and the Infecte class evulution on the right for a number of 
n_paths realizations.

# Arguments
- `df_mc::DataFrame`: DataFrame with the MonteCarlo Sampling
- `pop_size::Float64`: Population size to scalate Incidence and Number of doses
- `n_paths::Int`: Number of sampling paths to plot
"""

function get_panel_plot(df_mc::DataFrame, pop_size::Float64, n_paths::Int)

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
            pop_size * data_path_i[!, :K_stock]
        )
        band!(
            axtop,
            data_path_i[!, :time],
            0.0,
            pop_size * data_path_i[!, :K_stock],
            alpha=0.3
        )
        lines!(
            axmidle,
            data_path_i[!, :time],
            pop_size * data_path_i[!, :opt_policy] .* data_path_i[!, :action]
        )
        band!(
            axmidle,
            data_path_i[!, :time],
            0.0,
            pop_size * data_path_i[!, :opt_policy] .* data_path_i[!, :action],
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
            pop_size * data_path_i[!, :I_S]
        )
        filename = "panel_0" * string(i) * ".png"
        save(filename, f)
    end
    return f
end
