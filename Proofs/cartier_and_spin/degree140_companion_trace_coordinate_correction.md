# Correcting the shorter primitive coordinate globally

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_companion_trace_coordinate_correction.md).
Use the established proper polar residue formula and endpoint-multiplier
theorem. All calculations below compare the actual two coordinate descriptions
of the SAME critical curve and critical-value function.

## Change of coefficient derivative

Write the cubic in a primitive coordinate as S=aW^3+bW^2+cW+e, let
T=t^3, B=delta(phi)=3A^2, and put Sdot=delta(S) with W held fixed.
The old coordinate is W_old=W_new+c0, where c0=(B0-L0)/y. Thus the new
coefficient derivative, expressed in a common coordinate, is the old one
plus delta(c0)*S_W. On the critical curve S_W=0, so the actual differential
Omega_n in the residue formula does not change. Neither does the raw polar
sum after evaluation on that curve. Only its polynomial-part subtraction
can change.

For the companion constant coefficient the raw polar terms are C_j/phi^(5-j),
0<=j<=4. Put N0=delta(T)-BS and d=delta(c0). Changes in the first two C_j
are zero. The remaining changes are
\[
\Delta C_2=-Bd S_W,\qquad
\Delta C_3=dS_W(BS-2N_0)/T,
\]
\[
\Delta C_4=dS_W(-BS^2+2N_0S-2T\dot S)/T^2-d^2S_W^2/T.
\]
Here Delta denotes change of expression, not the critical discriminant.
The first two displayed changes have degree smaller than their respective
denominators. In the last one, only
\[
2Bd S_WS^2/T^2
\]
can contribute a NONCONSTANT polynomial quotient in W. The terms involving
delta(T) and Sdot have degree at most five, so their polynomial quotients
are constants. The S_W^2 term has degree four. Constants disappear after
multiplication by eta and trace to X, because Tr_(C/X)(eta)=0.

## The remaining quadratic trace

Let F(W) be the polynomial quotient of S^3 by phi=W^5+Qbar. Since phi has
zero W-derivative in characteristic five,
\[
\operatorname{polpart}(S_WS^2/\phi)=F'(W)/3.
\]
Its derivative is
\[
F'=4a^3W^3+4a^2bW^2+(a^2c+ab^2)W
       +(3a^2e+abc+b^3).
\]
Modulo 3aW^2+2bW+c, the coefficient of W in this expression is
4a(b^2+2ac). The prescribed orientation is
\[
\eta=-(3aW+b),\qquad \eta^2=\Delta_0=b^2+2ac.
\]
Consequently Tr_(C/X)(eta W)=-4 Delta0/a and
Tr_(C/X)(eta F')=-Delta0^2. The polynomial-part calculation, including
the minus sign with which that part is subtracted, gives
\[
\operatorname{Tr}_{C/X}(\Psi_{new,0}-\Psi_{old,0})
=-B\Delta_0^2T^{-2}\,dc_0.
\]
This identity can first be calculated where a is a unit. Its final expression
does not invert a and hence is the rational identity everywhere.

For scale coefficient n=1, the only derivative-dependent change has
W-degree two and denominator phi of degree five. Its polynomial part is
zero. For n=2 the single polar coefficient does not involve Sdot; for
n>=3 there is no polar replacement. Thus every positive coefficient is
unchanged. This is an identity in all scale degrees, not a numerical fit.

## Fixed finite branch residues

Multiply the last differential identity by t^4 f. Because
A=[13](x-alpha)t, it becomes
\[
-\gamma f(x-\alpha)^2\Delta_0^2\,d(N/y),
\qquad \gamma=3[13]^2,\quad N=B_0-L_0.
\]
The critical discriminant Delta0 is affine regular; translation leaves it
unchanged, and regularity follows from the original integral primitive
coordinate. The coefficient preceding d(N/y) is therefore affine regular.
All finite poles of this comparison differential occur at y=0. In particular
there is no residual pole at t=0, including on an endpoint degeneration.

At a simple cubic branch point x=r, use y as parameter. One has
x-r=O(y^3), so d(N/y)=-N(r)y^-2 dy+O(y)dy. Writing
Delta0=d0+y*d1+y^2*d2, its squared coefficient of y is2d0(r)d1(r).
The residue of the comparison differential is therefore
\[
2\gamma f(r)(r-\alpha)^2N(r)d_0(r)d_1(r).
\]
Summing the ten finite residues and applying the residue theorem on X gives
the asserted NEGATIVE fixed-algebra trace for the difference at infinity.
Both roots of the critical quadratic above O are included by trace. The
rank-ten algebra K[x]/P is fixed and etale. No moving discriminant or endpoint
coefficient is inverted in this calculation.

Adding the already proved fixed-cubic endpoint correction recovers the
actual trace. Equality on the dense regular chart extends through every
admitted primitive normalization stratum by the actual trace construction.
The known degree bound with pole(t^4*x^j)=36+3j gives13,14,14. Cubic
covariance makes Q_f(w*mu) invariant and hence puts its coefficients in
K[H^+-1,q^+-1,Psi^-1].

## Focused implementation evidence

The new
[companion engine](../../scripts/arithmetic/degree140_companion_multiplied_traces_20260930.hpp)
retains precisely this coordinate correction and the fixed-cubic endpoint
correction. At h=2,w=3 its three complete polynomials agree with sixteen
independent evaluations of t^4*x^j*v/phi in the degree140 finite algebra.
Sixteen distinct scales exceed all three degree bounds. The retained receipt
is in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/companion_multiplied_new_check_2_3.json`.
An initial sign mismatch was traced to choosing the opposite quadratic
orientation; the displayed orientation and final source retain the correction.
Precision160 was rejected by the series-precision tracker; the successful
run used220. These are focused checks of the NEW formula, not reruns of
incoming certificates and not an all-ratio exclusion.
