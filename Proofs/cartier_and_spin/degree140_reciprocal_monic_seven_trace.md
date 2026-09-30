# A pole-order reduction using the reciprocal primitive

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_reciprocal_monic_seven_trace.md).
The proof uses the incoming normalized trace theorem and its two
infinity expansions, without replaying its certificates.

The affine function f=x*t has pole12 at O. The reciprocal trace bound is
therefore
\[
\deg J\le\max\left(5,\left\lfloor29/4\right\rfloor,
\left\lfloor45/7\right\rfloor\right)=7.
\]
The first entry includes all finite poles of Lambda, including the wild
type-B endpoints. The O7 branch contributes degree at most six.
Consequently ONLY O4 can contribute to the degree-seven coefficient.
Necessity at a nonzero fully ramified fibre follows from regularity of
the vector field eta*delta/phi on that fibre, as in the incoming theorem.

Use the parameter xi from that theorem. Put
\[
a_1=C_d w/\epsilon,\quad L=-K_0 h^3,\quad
\kappa=(\epsilon/h)^5.
\]
The established expansions are
\[
\eta=\epsilon\xi^{-16}(1+a_1\xi+O(\xi^2)),\quad
\Lambda=L\xi^{-4}(1+3a_1\xi+O(\xi^2)),
\]
\[
\delta(\xi)=-\xi^{-16}(1+O(\xi^3)),\quad
\phi=\kappa\xi^{-20}(1+O(\xi^2)),\quad
x t=\xi^{-12}(1+O(\xi^3)).
\]
Set b_1=3a_1. The coefficient in question is minus the residue
\[
\operatorname{Res}_{O_4}
\left(x t\,\eta\,\delta(\xi)\,
       (\Lambda')^2\phi^{-1}\Lambda^{-8}\,d\xi\right).
\]
The leading exponent is -2. Differentiating Lambda gives
Lambda'=L xi^-5(1+2 b_1 xi+O(xi^2)) in characteristic five.
The relative linear coefficient of the displayed product is
\[
a_1+4b_1-8b_1=a_1+b_1=4a_1.
\]
The leading scalar of its differential is -epsilon*kappa^-1*L^-6.
Taking the negative residue therefore gives
\[
4 C_d\epsilon^{-5}K_0^{-6}\,w h^{-13}.
\]
The supplied degree-nine constant is C9=3*C_d*K0^-8. Thus the new
constant is 3*C9*K0^2*epsilon^-5. In the prescribed field coding
epsilon=<359499>, K0=<246025>, C9=<103636>, giving <154370>, nonzero.
No varying endpoint coefficient enters this leading calculation.

The new source
[small_monic_trace_leading](../../scripts/arithmetic/degree140_small_monic_trace_leading_20260930.cpp)
checks the leading formula against its independently reconstructed
infinity residues at nine pairs h in{2,5,17}, w in{3,7,11}. The result is
in [the small receipt](../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/small_monic_leading.json).
These fixtures concern this new formula; the proof itself is the
two-term residue calculation above, not a finite parameter search.

An exploratory shortcut to a monic quintic was NOT valid. At a finite
type-A pole write phi=t^3 J and T+S phi=t^5 K. Then
Lambda=-K J^-2 t^-1. Its degree-five reciprocal-trace coefficient
contains K^-4. Omitting that factor gives a misleading small expression.
The full local residue calculation exposed the omission; no quintic
unit or global coefficient claim is made here. The degree-seven result
is independent of that failed shortcut because those finite points
contribute only through degree five.
