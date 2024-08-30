"""
Returns a figure that encloses a panel visualization with 
the confidence bands from quartiles 0.5 and .95 for the:
epidemic states.

# Arguments
- `df_lower_q::DataFrame`: 
- `df_median::DataFrame`:
- `df_upper_q::DataFrame`:
- `df_ref::DataFrame`: DataFrame with the opt_Policy col from MonteCarlo Sampling 
- `pop_size::Float64`:
- `file_name::AbstractString`:
"""

function get_epidemic_states_confidence_bands(
    df_lower_q::DataFrame,
    df_median::DataFrame,
    df_upper_q::DataFrame,
    df_mc::DataFrame,
    pop_size::Float64,
    file_name::AbstractString
)
    #
    f = Figure(
        size=(700, 1132)
    )
    # colors
    color_q = (:azure, 1.0)
    color_m = (:orange, 0.4)
    color_ref = (:grey0, 1.0)
    axtop = Axis(
        f[1, 1],
        ylabel=L"I_S"
    )
    axmidle_0 = Axis(
        f[2, 1],
        ylabel=L"D"
    )
    axmidle_1 = Axis(
        f[3, 1],
        ylabel=L"V"
    )
    axbottom = Axis(
        f[4, 1],
        xlabel="time (days)",
        ylabel=L"X_{VAC}"
    )
    #
    df_ref = filter(
        :idx_path => n -> n == 1,
        df_mc
    )
    hidexdecorations!(axtop, grid=false)
    hidexdecorations!(axmidle_0, grid=false)
    hidexdecorations!(axmidle_1, grid=false)
    # Symptomatics

    lines!(
        axtop,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :I_S],
        color=color_ref
    )

    lines!(
        axtop,
        df_upper_q[!, :time],
        pop_size * df_upper_q[!, :I_S],
        color=color_ref
    )

    band_ = band!(
        axtop,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :I_S],
        pop_size * df_upper_q[!, :I_S],
        alpha=0.3
    )

    med_line = lines!(
        axtop,
        df_median[!, :time],
        pop_size * df_median[!, :I_S],
        color=color_m
    )

    # Deaths
    lines!(
        axmidle_0,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :D],
        color=color_ref
    )

    lines!(
        axmidle_0,
        df_upper_q[!, :time],
        pop_size * df_upper_q[!, :D],
        color=color_ref
    )

    band!(
        axmidle_0,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :D],
        pop_size * df_upper_q[!, :D],
        alpha=0.3
    )

    lines!(
        axmidle_0,
        df_median[!, :time],
        pop_size * df_ref[!, :D],
        color=color_m
    )

    # Vaccinated
    lines!(
        axmidle_1,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :V],
        color=color_ref
    )

    lines!(
        axmidle_1,
        df_upper_q[!, :time],
        pop_size * df_upper_q[!, :V],
        color=color_ref
    )

    band!(
        axmidle_1,
        df_lower_q[!, :time],
        pop_size * df_lower_q[!, :V],
        pop_size * df_upper_q[!, :V],
        alpha=0.3
    )

    lines!(
        axmidle_1,
        df_median[!, :time],
        pop_size * df_median[!, :V],
        color=color_m
    )


    # Coverage
    df_q_low_x_cov = 100.0 * df_lower_q[!, :X_vac]
    df_q_up_x_cov = 100.0 * df_upper_q[!, :X_vac]
    df_q_med_x_cov = 100.0 * df_median[!, :X_vac]

    lines!(
        axbottom,
        df_lower_q[!, :time],
        df_q_low_x_cov,
        color=color_ref
    )

    lines!(
        axbottom,
        df_upper_q[!, :time],
        df_q_up_x_cov,
        color=color_ref
    )

    band!(
        axbottom,
        df_lower_q[!, :time],
        df_q_low_x_cov,
        df_q_up_x_cov,
        alpha=0.3
    )

    lines!(
        axbottom,
        df_median[!, :time],
        df_q_med_x_cov,
        color=color_m
    )

    l = Legend(
        f[5, 1, Top()],
        [med_line, band_],
        ["median", "95% Conf."]
    )

    l.orientation = :vertical
    filename = file_name * ".png"
    save(filename, f)
    f
end
