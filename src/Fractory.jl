module Fractory


using PyPlot
include("AffineMap.jl")
include("IFS.jl")
include("PixelPicture.jl")

export step!

function step!(F::IFS, P::PixelPicture)
  pts = get_points(P)
  old_bits = P.data
  new_pts = F(pts)
  set_points!(P,new_pts)
  return P.data != old_bits
end

end
