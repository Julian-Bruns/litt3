# Nonspecial residual points give complete pair-interpolation charts

Version1,2026-09-08. Author proof with exact certificate replay;
no independent whole-proof audit or Lean verification.

## General mechanism

Let C be a smooth projective curve of genus g>=2, O a point, and
P,Q,T distinct points different from O. Suppose

    div(f)=g(P+Q+T)-3gO.

If h0(gT)=1, evaluation of g jets at P and Q gives an isomorphism

    L((3g-1)O) -> O_P/m_P^g direct-sum O_Q/m_Q^g.

Consequently the section f, normalized to have leading pole coefficient
one at O, is determined uniquely by an invertible2g-by2g system on P,Q.
It suffices to exclude target triples supported entirely in the exceptional
locus h0(gT)>1 in order to cover every possible triple after relabelling.
No generic-invertibility assertion about every pair is made.

## Fixed genus-nine curve

For the fixed X, any residual target
div(f)=9(P+Q+T)-27O with three distinct finite nonbranch support points
at distinct abscissas has AT MOST ONE Weierstrass point. Here a nonbranch
point T is Weierstrass exactly when h0(9T)>1; the curve is classical.
All possible such Weierstrass points belong to the explicitly certified
eighteen-point set over F_(25^6). At each of them h0(9T)=2.

Thus at least two relabellings put the target in an invertible9-by9
interpolation chart. In the notation of the proof, this chart determines
A,B,C, with A monic of degree9, from the ordered pair P,Q alone. Put

    H=N(A+By+Cy^2)/((x-u)(x-v))^9=sum_(i=0)^9 h_i x^i,
    t=h_8, U=B^2-AC, V=C^2 F-AB, R=(x-u)(x-v)(x-t).

The exact remaining test on that chart is

    (h7,h6,h5,h4,h3,h2,h1,h0)
      =(t^2,t^3,t^4,-t^5,-t^6,-t^7,-t^8,-t^9),
    Delta(P,Q) Disc(R) Res(R,F) Res(R,U) !=0.

With B,C nonzero, these conditions are necessary and sufficient for the
residual target divisor, with T=(t,V(t)/U(t)). In particular a norm-only
solution with zeros on different sheets is not accepted. The two-dimensional
open pair locus is NOT proved empty.

Simultaneous cubic deck transformation of P,Q preserves all eight norm
conditions and their nonvanishing tests. They may therefore be expressed
on the quotient surface with coordinates u,v,z and z^3=F(v)/F(u).
This is a coordinate reduction, not a finiteness assertion.

Dependencies: [fixed arithmetic](Thm_fixed_pair_arithmetic.md) and
[low Abel torsion](Thm_cyclic_cubic_low_abel_torsion.md).
[Proof and certificate](../Solutions/Sol_weierstrass_pair_interpolation.md).
