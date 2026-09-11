# Riemann--Roch makes the actual norm parametrization unique

2026-09-11. Author prose. This elementary corollary is not presented as an
additional independent audit of the constant-Q theorem or fixed arithmetic.

The established fixed-curve data are g=9, div(dx/y^2)=16O, and pole orders
3 and10 for x,y. The audited
[constant-Q theorem](../Theorems/Thm_trigonal_constant_norm_obstruction.md)
excludes rational P^3+FQ^3=R^2 whenever Q is a nonzero constant.

## Vanishing and uniqueness

If a nonzero two-torsion L had a section of L(7O), its divisor D of degree7
would give a rational function f with div(f)=2D-14O. The exact monomial
basis of L(14O) writes f=P+Qy with degP<=4,degQ<=1.

Its cubic norm is a square. If degQ=1, the norm has uniquely highest
degree13, because deg(P^3)<=12, and cannot be a square. A nonzero constant
Q is excluded by the cited theorem. If Q=0, the square norm P^3 makes P
a square in k(x); f is then a square on X, implying L=0. This proves
h0(L(7O))=0.

Evaluation at O gives h0(L(8O))<=1. Riemann--Roch and K=16O,L=L^-1 give

    h0(L(9O))=1+h0(L(7O))=1.

Thus the effective degree9 representative is unique, and any two
functions with divisor2D-18O differ by a constant. The sign ambiguity
of R is harmless but is not silently counted as two geometric covers.
In the normalization Q monic there is one (P,Q) and two R choices.

## Parity and the complete pole split

kappa=8O is a theta characteristic and h0(kappa)=3, with basis1,x,x^2.
For nonzero L, the preceding bound forces h0(kappa L) to be1 in the odd
case and0 in the even case. Theta parity and its counts hold over any
algebraically closed field of characteristic different from2; see
[Gross--Harris, Section4 and Proposition1.11](https://people.math.harvard.edu/~gross/preprints/theta.pdf).

There are2^8(2^9-1)=130816 odd theta characteristics, one of which is
kappa itself, and2^8(2^9+1)=131328 even ones. The nonzero label counts
are therefore130815 and131328.

In the odd case, the unique section of L(8O) does not vanish at O,
otherwise L(7O) would have a section. The degree9 divisor is O plus
that degree8 divisor. Hence f has pole EXACTLY16. In the semigroup
basis this means degQ=2 and degP<=5. In the even case the degree9
section does not vanish at O, so f has pole EXACTLY18: degP=6 and,
since constantQ is excluded, degQ=1 or2.

The rational point O is fixed by Frobenius25 and by the trigonal
order3 automorphism. Both preserve kappa and parity. The established
binary irreducibility/order171 calculation makes every nonzero label
orbit have length171, with the order3 action equal to Frobenius^57 or
its inverse. Dividing the two counts by171 gives765 and768 carrier
label orbits. Their sum1533 agrees with the earlier complete orbit count.

This controls actual geometric representatives. Ramified norm solutions
and nilpotent structure in the polynomial system have not been classified;
an unchecked affine chart is not automatically a finite reduced scheme.
