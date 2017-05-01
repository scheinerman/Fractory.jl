export AffineMap, square_check, visualize

"""
An `AffineMap` represents a mapping of the plane to itself.
"""
immutable AffineMap
  A::Array{Float64,2}
  b::Array{Float64,1}
end

AffineMap(M::Matrix) = AffineMap(M,[0,0])
AffineMap() = AffineMap(eye(2))

"""
`f(x)` where `f` is an affine map and `x` is a vector
is standard funtion application taking `x` to `Ax+b`.
Equivalent form: `f*x`.
"""
function (f::AffineMap)(x::Vector)
  return f.A * x + f.b
end

(*)(f::AffineMap, x::Vector) = f(x)


function (*)(f::AffineMap, g::AffineMap)
  A = f.A * g.A
  b = f.A*g.b + f.b
  return AffineMap(A,b)
end

"""
`square_check(x)` checks if the vector `x` lies in the
unit square.
"""
square_check(x::Vector) = (0 <= x[1] <= 1) && (0 <= x[2] <= 1)

"""
`square_check(f,x)` checks if `f(x)` is in the unit square.
"""
square_check(f::AffineMap,x::Vector) = square_check(f(x))

"""
`square_check(f)` checks if `f(x)` is in the unit square
for four values of `x` corresponding
to the corners of the unit square.
"""
function square_check(f::AffineMap)
  corners = ([0,0], [0,1], [1,0], [1,1])
  return all(square_check(f,x) for x in corners)
end

function quad_draw(pts, marker::String="-")
  x = [v[1] for v in pts]
  y = [v[2] for v in pts]
  plot(x,y,marker,color="k")
  nothing
end

function visualize(f::AffineMap)
  corners = [ [0,0], [0,1], [1,1], [1,0], [0,0] ]
  quad_draw(corners,":")
  poly = map(f,corners)
  quad_draw(poly)
  axis("equal")
  axis("off")
  axis([-0.25,1.25,-0.25,1.25])
  nothing
end
