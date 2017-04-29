export Fractal

type Fractal
  F::IFS
  P::PixelPicture
  function Fractoral(FF::IFS,PP::PixelPicture)
    new(FF,PP)
  end
end

function Fractal(F:IFS, n::Int)
  @assert n>0
  P = PixelPicture(n)
  return Fractal(F,n)
end
