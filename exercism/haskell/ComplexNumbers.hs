module ComplexNumbers
(Complex,
 conjugate,
 abs,
 exp,
 real,
 imaginary,
 mul,
 add,
 sub,
 div,
 complex) where

import Prelude hiding (div, abs, exp)
import qualified Prelude as P (exp)

-- NOTE: Implementing Num and Fractional instances would be better,
-- giving us other functions for free, like (^)

-- Data definition -------------------------------------------------------------
data Complex a = a :+ a deriving(Eq, Show)

complex :: (a, a) -> Complex a
complex (x, y) = x :+ y

-- unary operators -------------------------------------------------------------
conjugate :: Num a => Complex a -> Complex a
conjugate (x :+ y) = x :+ (-y)

abs :: Floating a => Complex a -> a
abs (x :+ y) = sqrt $ x**2 + y**2

real :: Num a => Complex a -> a
real (x :+ _) = x

imaginary :: Num a => Complex a -> a
imaginary (_ :+ y) = y

exp :: Floating a => Complex a -> Complex a
exp (x :+ y) =
  let n = P.exp x
   in (n * cos y) :+ (n * sin y)

-- binary operators ------------------------------------------------------------
mul :: Num a => Complex a -> Complex a -> Complex a
mul (x :+ y) (a :+ b) = (x * a - y * b) :+ (x * b + y * a)

add :: Num a => Complex a -> Complex a -> Complex a
add (x :+ y) (a :+ b) = (x + a) :+ (y + b)

sub :: Num a => Complex a -> Complex a -> Complex a
sub (x :+ y) (a :+ b) = (x - a) :+ (y - b)

div :: Fractional a => Complex a -> Complex a -> Complex a
div (x :+ y) (a :+ b) =
  let n = (a * a + b * b)
   in ((x * a + y * b)/n) :+ ((y * a - x * b)/n)
