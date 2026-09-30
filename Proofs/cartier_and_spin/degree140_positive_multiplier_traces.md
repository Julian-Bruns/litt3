# Proof of the positive-multiplier trace tests

Use [the statement](../../Theorems/cartier_and_spin/degree140_positive_multiplier_traces.md)
and the accepted incoming critical-curve construction. No earlier program
or verification output is replayed for this argument.

## The only possible finite-scale pole is zero

The vector field V0 is regular on affine normalized C, including above
multiple zeros of d. At finite W, phi and the pullback of f are regular.
Thus f*phi^m*v is regular above every finite scale except possibly zero.
The remaining points have W=infinity and map to scale zero. If z=1/W
has positive order r at such a normalized point, the critical quadratic
gives ord(Lambda)=e>=3r. Also ord(phi)=-5r. Since V0 is regular,
ord(v)>=e-1, even when the leading derivative cancels in characteristic
five. Therefore the possible pole order is at most5mr-e+1.

For a completed separable extension of ramification index e, a function
of pole order at most a has traced pole order at most floor(a/e): apply
the extended valuation to its conjugates and then use the integral value
group downstairs. Consequently the traced pole at zero is at most
\[
\left\lfloor\frac{5mr-e+1}{e}\right\rfloor
\le\left\lfloor\frac{5m-2}{3}\right\rfloor=b_m.
\]
Here f has no pole because its image on X is affine. Multiplication by
ell^(b_m) removes every finite pole.

## Degree at infinity

At O4 and O7 the accepted orders of v are bounded by37 and40, and phi
has poles20 and7. Their traced poles are therefore bounded by
floor((37+20m+p)/4) and floor((40+7m+p)/7).

At a finite zero of phi away from t=0, write ord(phi)=a>0. Lambda has
pole2a, so phi^m*v has possible pole at most(2-m)a+1. Its traced pole is
at most one for m>=1. At a type-A endpoint ord(phi)=3 and the pole of
Lambda is one; phi^m*v is regular and vanishes for every m>=1. At a
type-B endpoint the respective orders are5 and5, and its possible traced
pole is at most zero for m>=1. These are the complete finite-pole charts
from the accepted construction. The O4 bound dominates all of them and
the O7 bound. This proves the polynomial degree bound after the zero-scale
factor is inserted.

## The top coefficients remain units

At O4 use the same parameter xi and orientation as in the incoming proof.
Put a1=C_d*w/epsilon and L=-K0*h^3. The needed expansions are
\[
\eta=\epsilon\xi^{-16}(1+a1\xi+O(\xi^2)),\qquad
\Lambda=L\xi^{-4}(1+3a1\xi+O(\xi^2)),
\]
and delta(xi)=-xi^(-16)(1+O(xi^3)). The large critical root has leading
term (epsilon/h)*xi^(-14). Its fifth power has no relative linear term,
and Q contributes only in higher relative order. Since y^5 has leading
term xi^(-50) and no relative linear term,
\[
\phi=(\epsilon/h)^5\xi^{-20}(1+O(\xi^2)).
\]
The coefficient of ell^n in a polynomial trace is minus the residue sum
of f*phi^m*v*Lambda^(-n-1)*dLambda over the poles of Lambda. At the
highest claimed degrees only O4 contributes. For f=1 take n=9+5m:
the additional factor relative to the accepted n=9 calculation is
phi^m*Lambda^(-5m). Through relative degree one it equals the constant
\[
(\epsilon/h)^{5m}L^{-5m}=U^m h^{-20m}.
\]
Indeed a power divisible by five has no relative linear term. This
multiplies the accepted leading coefficient C9*w*h^(-24). The f=x
calculation at n=10+5m uses only the leading term and multiplies
C10*h^(-27) by the same factor. Multiplication by ell^(b_m) then shifts
the degrees without changing these coefficients.

## Necessity at a fully ramified nonzero fibre

At every point of such a fibre, W and phi are finite, V0 is regular,
and v=V0(Lambda) vanishes because the ramification index is at least two.
Thus f*phi^m*v is regular and zero throughout the fibre. Specializing
its trace gives the sum of the residue values weighted by local lengths,
so the trace vanishes. The nonzero factor lambda^(b_m) preserves that
vanishing. Nothing in this argument identifies a second actual map or
asserts that the necessary equations have no solution.
