module DesignDriveCoilFiltGUI
using FFTW,Gtk,PyPlot,Optim
using LinearAlgebra
using PyPlot
using CSV
using Reexport

@reexport using DesignDriveCoilFilt

# using Interpolations

include("Filter_Designer_GUI.jl")
export useFilterDesignGUI

end
