export PixelPicture, draw, randomize!, set_point!, get_points

"""
`point2pixel(n,xy)` determines which pixel in an `n`-by-`n`
grid corresponds to the point with coordinates given by `xy`.
Retuns a tuple.
"""
function point2pixel{T<:Real}(n::Int, xy::Vector{T})
  x = xy[1]
  y = xy[2]
  i = Int(round((n-1)*(1-y)+1))
  j = Int(round((n-1)*x+1))
  return (i,j)
end

"""
`pixel2point(n,ij)` determines the `xy`-coordinates of the point
in the middle of the `i,j`-pixel in an `n`-by-`n` grid. Returns
a vector.
"""
function pixel2point(n::Int,ij::Tuple{Int,Int})
  i,j = ij
  x = (j-1)/(n-1)
  y = 1 - (i-1)/(n-1)
  return [x,y]
end

"""
`PixelPicture` is a square grid of pixels representing a picture
in the unit square. Create a new one with `PixelPicture(n)`.
"""
type PixelPicture
  data::Matrix{Bool}
  function PixelPicture(n::Int)
    new(zeros(Bool,n,n))
  end
end

"""
`size(P)` returns the size of a `PixelPicture`. Since these
images are square, we return a single number.
"""
function size(P::PixelPicture)
  (r,c) = size(P.data)
  return r
end

function show(io::IO,P::PixelPicture)
  n = size(P)
  print(io,"$n-by-$n PixelPicture")
end

"""
`get_points(P)` returns the set of x,y-vectors in the unit square
in this `PixelPicture`.
"""
function get_points(P::PixelPicture)
  n = size(P)
  pix_coords = ( (i,j) for i=1:n for j=1:n if P.data[i,j] )
  result = ( pixel2point(n,ij) for ij in pix_coords )
  return result
end

"""
`randomize!(P)` fills the `PixelPicture` with random noise.
"""
function randomize!(P::PixelPicture)
  n = size(P)
  P.data = rand(Bool,n,n)
  nothing
end

function set_point!(P::PixelPicture,xy::Array{Float64,1})
  n = size(P)
  i,j = point2pixel(n,xy)
  if 1<=i<=n && 1<=j<=n
    @inbounds P.data[i,j]=true
  end
  nothing
end

"""
`draw(P)` draws the `PixelPicture` on the screen.
"""
function draw(P::PixelPicture)
  clf()
  spy(P.data)
  axis("off")
  nothing
end
