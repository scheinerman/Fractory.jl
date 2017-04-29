export Fractal
"""
A `Fractal` contains an `IFS` (iterated function system) and a
`PixelPicture` (bitmap image) that the `IFS` generates.

Standard constructors:
* `Fractal(F::IFS,P::PixelPicture)`
* `Fractal(F::IFS,n::Int)`
""" 
type Fractal
  F::IFS
  P::PixelPicture
  function Fractoral(FF::IFS,PP::PixelPicture)
    new(FF,PP)
  end
end

function Fractal(F::IFS, n::Int)
  @assert n>0
  P = PixelPicture(n)
  return Fractal(F,n)
end
