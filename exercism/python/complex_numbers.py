import math

class ComplexNumber:
    def __init__(self, real=0, imaginary=0):
        self.real = real
        self.imaginary = imaginary

    def __eq__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return self.real == other.real and self.imaginary == other.imaginary

    def __add__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return ComplexNumber(self.real + other.real, self.imaginary + other.imaginary)

    def __radd__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return ComplexNumber(self.real + other.real, self.imaginary + other.imaginary)

    def __mul__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return ComplexNumber(self.real * other.real - self.imaginary * other.imaginary, self.real * other.imaginary + self.imaginary * other.real)

    def __rmul__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return ComplexNumber(self.real * other.real - self.imaginary * other.imaginary, self.real * other.imaginary + self.imaginary * other.real)

    def __sub__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return ComplexNumber(self.real - other.real, self.imaginary - other.imaginary)

    def __rsub__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)
        return ComplexNumber(other.real - self.real, other.imaginary - self.imaginary)

    def __truediv__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)

        conjugate = other.conjugate()
        denominator = (other * conjugate).real
        numerator = self * conjugate

        return ComplexNumber(numerator.real / denominator, numerator.imaginary / denominator)

    def __rtruediv__(self, other):
        if not isinstance(other, ComplexNumber):
            other = ComplexNumber(other)

        conjugate = self.conjugate()
        denominator = self * conjugate
        numerator = other * conjugate

        return ComplexNumber(numerator.real / denominator.real, numerator.imaginary / denominator.real)

    def __abs__(self):
        return math.sqrt(self.real**2 + self.imaginary**2)

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)

    def exp(self):
        return math.exp(self.real) * ComplexNumber(math.cos(self.imaginary), math.sin(self.imaginary))
