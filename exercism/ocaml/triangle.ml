let is_triangle x y z =
  x > 0 && y > 0 && z > 0
  && x + y >= z && y + z >= x && x + z >= y

let is_equilateral x y z = x = y && y = z && is_triangle x y z

let is_isosceles x y z = (x = y || y = z || x = z) && is_triangle x y z

let is_scalene x y z = not (is_isosceles x y z) && is_triangle x y z
