# Must prepend a dot due to Requires.jl
using PlotlyJS
using Wannier

export plot_band_diff

"""
    plot_band_diff(kpi::KPathInterpolant, E1::AbstractArray, E22::AbstractArray; kwargs...)

Compare two band structures.

`E1` in black, while `E2` in dashed orange.

# Arguments
- `kpi`: KPathInterpolant
- `E1`: band energies, 1D of length `n_kpts`, or 2D array of size `n_bands * n_kpts`
- `E2`: band energies, 1D of length `n_kpts`, or 2D array of size `n_bands * n_kpts`

# Keyword Arguments
See also the keyword arguments of [`_get_band_plot`](@ref).
"""
function plot_band_diff(
    kpi::KPathInterpolant, E1::AbstractArray, E2::AbstractArray; kwargs...
)
    x = Wannier.get_linear_path(kpi)
    symm_point_indices, symm_point_labels = Wannier.get_symm_point_indices_labels(kpi)

    P1 = _get_band_plot(
        x, E1; color="grey", symm_point_indices, symm_point_labels, kwargs...
    )
    # orange and slightly thinner
    P2 = _get_band_plot(
        x,
        E2;
        color="red",
        dash="dash",
        width=0.9,
        symm_point_indices,
        symm_point_labels,
        kwargs...,
    )

    addtraces!(P1, P2.data...)

    return plot(P1)
end
