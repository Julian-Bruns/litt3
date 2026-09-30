# Absolute branch support for actual Klein-four comparisons

Version1, 26 September2026. Retain all actual same-source hypotheses of
[simultaneous quotients](klein_four_simultaneous_quotients.md), including
the two endpoint identities, the pole divisors, and the endpoint
ramification indices1 or3 over the eleven fixed branch values. Set
eta=[22], ell=[13], K(x)=P(x)^2 A'(x)^3, and Q=5^56.

For a common-pole value c in mu29 let m_c be its total integer pole
weight. Then epsilon is in F_Q, and the two rational invariant traces
u0=Tr(u)/4, v0=Tr(v)/4 are uniquely determined over F_Q(t) by the weighted
common-pole values and the eight endpoint labels. In particular, the
entire curve need not be fixed in order to determine these traces.

Let E be the squarefree common-pole polynomial, e=deg E<=29, and define
\[
R_0(B,C)=\ell^{-29}\operatorname{Res}_x(A(x)-B,K(x)-C),
\quad R(t,Z)=R_0(\epsilon^{-4}t^{13}A(\epsilon t^{-3}Z),
\epsilon^{-29}t^{87}K(\epsilon t^{-3}Z)).
\]
This R is polynomial. Put W=2t^3Ev0/epsilon and
\[
\Delta(t)=\operatorname{Res}_{Z,(116,116)}
\bigl(R(t,Z),E^{116}R(t,W/E-Z)\bigr).
\]
The resultant uses the indicated fixed degrees, retaining degree drops.
It satisfies Delta(0)!=0 and deg Delta<=87464+13456(e+3).
If D1,D2,D3 are the squarefree, pairwise coprime inertia polynomials of
the actual V4 cover, then
\[
D_1D_2D_3\mid E\Delta.
\]
Consequently, with N=518085 and M=lcm(1,...,N), all three inertia
polynomials have coefficients in F_(5^(56M)). This permits additional
branch points outside mu29; it constrains them by a nonzero polynomial.

The full geometric candidate set is finite in each degree14..87.
In degrees86 and87, the fixed-curve uniqueness theorem also puts the
complete pair u,v over F_(5^(112M)); the reconstructed cubic cover and
both maps can be defined over F_(5^(336M)). The latter bounds are not
asserted for the endpoint functions in every lower degree.

No isolated point, branch assignment, or actual two-map model is
decided by this finiteness theorem. Both original common-cover
questions remain open.

[Proof and evidence](../../Proofs/cartier_and_spin/klein_four_trace_branch_finiteness.md).
