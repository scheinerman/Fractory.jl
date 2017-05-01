module Fractory

using PyPlot
import PyPlot: draw
import Base: show,(*),size

include("AffineMap.jl")
include("IFS.jl")
include("PixelPicture.jl")
include("Fractal.jl")

end
