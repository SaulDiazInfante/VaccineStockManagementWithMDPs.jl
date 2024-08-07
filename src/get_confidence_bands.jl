"""
Returns a figure that encloses a panel visualization with 
the confidence bands from quartiles 0.5 and .95 for the variables:
vaccine stock, vaccination rate, and Symptomatic Infected.
Also plots a counts for the optimal decision at the left, 
and the Infecte class evulution on the right for a number of 
n_paths realizations.

# Arguments
- `df_lower_q::DataFrame`: 
- `df_median::DataFrame`:
- `df_upper_q::DataFrame`:
- `df_ref::DataFrame`: DataFrame with the opt_Policy col from MonteCarlo Sampling 
- `pop_size::Float64`:
- `file_name::AbstractString`:
"""

function get_confidence_bands(
    df_lower_q::DataFrame,
    df_median::DataFrame,
    df_upper_q::DataFrame,
    df_mc::DataFrame,
    pop_size::Float64,
    file_name::AbstractString
)

    f = Figure(
        size=(1000, 700)
    )
    # colors
    color_q = (:azure, 1.0)
    color_m = (:orange, 0.4)
    color_ref = (:grey0, 1.0)
    axtop = Axis(f[1, 1], ylabel="Stock")
    axmidle = Axis(f[2, 1], ylabel="Vaccination rate")
    axbottom = Axis(f[3, 1], xlabel="Decision", ylabel="Count")
    axright = Axis(f[1:3, 2], xlabel="time (days)", ylabel=L"I_S")
    #
    df_ref = filter(
        :idx_path => n -> n == 1,
        df_mc
    )

    # Stock
    lines!(
        axtop,
        df_ref[!, :time],
        pop_size * df_ref[!, :K_stock],
        color=color_ref
    )
    i = 1
    filename = file_name * "_0" * string(i) * ".png"
    save(filename, f)

    lines!(
        axtop,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :K_stock],
        color=color_q
    )

    lines!(
        axtop,
        df_upper_q[!, :time],
        pop_size * df_upper_q[!, :K_stock],
        color=color_q
    )

    band!(
        axtop,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :K_stock],
        pop_size * df_upper_q[!, :K_stock],
        alpha=0.3
    )
    lines!(
        axtop,
        df_ref[!, :time],
        pop_size * df_ref[!, :K_stock],
        color=color_ref
    )
    i = i + 1
    filename = file_name * "_0" * string(i) * ".png"
    save(filename, f)
    lines!(
        axtop,
        df_median[!, :time],
        pop_size * df_median[!, :K_stock],
        color=color_m
    )
    i = i + 1
    filename = file_name * "_0" * string(i) * ".png"
    save(filename, f)

    # Vaccination rate
    lines!(
        axmidle,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :action],
        color=color_q
    )

    lines!(
        axmidle,
        df_upper_q[!, :time],
        pop_size * df_upper_q[!, :action],
        color=color_q
    )

    band!(
        axmidle,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :action],
        pop_size * df_upper_q[!, :action],
        alpha=0.3
    )

    lines!(
        axmidle,
        df_ref[!, :time],
        pop_size * df_ref[!, :action],
        color=color_ref
    )

    lines!(
        axmidle,
        df_median[!, :time],
        pop_size * df_median[!, :action],
        color=color_m
    )
    i = i + 1
    filename = file_name * "_0" * string(i) * ".png"
    save(filename, f)


    # Symtomatic Infected class
    lines!(
        axright,
        df_upper_q[!, :time],
        pop_size * df_upper_q[!, :I_S],
        color=color_q
    )

    lines!(
        axright,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :I_S],
        color=color_q
    )

    band!(
        axright,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :I_S],
        pop_size * df_upper_q[!, :I_S],
        alpha=0.3
    )

    lines!(
        axright,
        df_ref[!, :time],
        pop_size * df_ref[!, :I_S],
        color=color_ref
    )

    lines!(
        axright,
        df_median[!, :time],
        pop_size * df_median[!, :I_S],
        color=color_m
    )
    i = i + 1
    filename = file_name * "_0" * string(i) * ".png"
    save(filename, f)

    # Counter plot
    count_opt_decs = countmap(df_mc[!, :opt_policy])
    barplot!(
        axbottom,
        collect(keys(count_opt_decs)),
        collect(values(count_opt_decs)),
        strokecolor=:black,
        strokewidth=2,
        #colormap =colors[1:size(collect(keys(count_opt_decs)))[1]]
        color=[:red, :orange, :azure, :brown]
    )
    i = i + 1
    filename = file_name * "_0" * string(i) * ".png"
    save(filename, f)
    f
end
