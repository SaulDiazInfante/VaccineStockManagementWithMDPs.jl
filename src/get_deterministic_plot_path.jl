"""
Returns two figure that encloses a the visualization of
the reference deterministic path with the evolution of the
dynamic model and the regarding policy. 

# Arguments
- `df_mc::DataFrame`: DataFrame with the opt_Policy col from MonteCarlo Sampling 
- `pop_size::Float64`:
- `file_name_f1::AbstractString`:
- `file_name_f2::AbstractString`:
"""

function get_deterministic_plot_path(
    df_mc::DataFrame,
    pop_size::Float64,
    file_name_f1::AbstractString,
    file_name_f2::AbstractString)
    #
    f1 = Figure(
        size=(680, 576)
    )
    # colors
    f2 = Figure(
        size=(680, 576)
    )
    color_ref = (:grey0, 1.0)
    ax_top_1_f1 = Axis(
        f1[1, 1],
        ylabel=L"$K_t$ (Number of doses)"
    )
    ax_bottom_1_f1 = Axis(
        f1[2, 1],
        ylabel=L"$\psi_V^{(k)}$ (Vaccination rate doses/day)"
    )

    ax_top_1_f2 = Axis(
        f2[1, 1],
        ylabel=L"S"
    )
    ax_top_2_f2 = Axis(
        f2[1, 2],
        ylabel=L"E"
    )
    ax_top_3_f2 = Axis(
        f2[1, 3],
        ylabel=L"I_S"
    )

    ax_bottom_1_f2 = Axis(
        f2[2, 1], ylabel=L"I_A"
    )
    ax_bottom_2_f2 = Axis(
        f2[2, 2], ylabel=L"V"
    )
    ax_bottom_3_f2 = Axis(
        f2[2, 3], ylabel=L"Coverage $X_{VAC}$"
    )
    #
    df_ref = filter(
        :idx_path => n -> n == 1,
        df_mc
    )
    hidexdecorations!(ax_top_1_f1, grid=false)
    hidexdecorations!(ax_top_1_f2, grid=false)
    hidexdecorations!(ax_top_2_f2, grid=false)
    hidexdecorations!(ax_top_3_f2, grid=false)

    # Stock-Vaccination Rate

    lines!(
        ax_top_1_f1,
        df_ref[!, :time],
        pop_size * df_ref[!, :K_stock],
        color=color_ref
    )

    lines!(
        ax_bottom_1_f1,
        df_ref[!, :time],
        pop_size * df_ref[!, :action],
        color=color_ref
    )

    # Epidemic states

    lines!(
        ax_top_1_f2,
        df_ref[!, :time],
        pop_size * df_ref[!, :S],
        color=color_ref
    )

    lines!(
        ax_top_2_f2,
        df_ref[!, :time],
        pop_size * df_ref[!, :E],
        color=color_ref
    )

    lines!(
        ax_top_3_f2,
        df_ref[!, :time],
        pop_size * df_ref[!, :I_S],
        color=color_ref
    )

    lines!(
        ax_bottom_1_f2,
        df_ref[!, :time],
        pop_size * df_ref[!, :I_A],
        color=color_ref
    )

    lines!(
        ax_bottom_2_f2,
        df_ref[!, :time],
        pop_size * df_ref[!, :D],
        color=color_ref
    )

    lines!(
        ax_bottom_3_f2,
        df_ref[!, :time],
        pop_size * df_ref[!, :X_vac],
        color=color_ref
    )

    #= l = Legend(
        f[5, 1, Top()],
        [med_line, band_],
        ["median", "95% Conf."]
    )

    l.orientation = :horizontal
    =#
    filename_f1 = file_name_f1 * ".png"
    filename_f2 = file_name_f2 * ".png"
    save(filename_f1, f1)
    save(filename_f2, f2)
    return f1, f2
end
