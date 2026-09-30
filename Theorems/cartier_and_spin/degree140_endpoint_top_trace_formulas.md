# Closed endpoint formulas for the small normalized traces

Version2,30 September2026. Retain the primitive constant degree140
family, its normalized trace functions T_f,Q_f, and the local content
factor R from degree140_endpoint_content_jet_factor. Put t=A/([13](x-alpha)).
At a sheet over t=0 write b=b_0, u=u_0 and t'=dt/dx. The symbols y,b,u,R
in the following formulas denote their values in the fixed nine-sheet
endpoint algebra. Its trace sums all nine geometric sheets.

For affine regular f and g, the finite endpoint contributions are
\[
[\ell^2]T_f\big|_{\rm end}
=2\operatorname{Tr}_{\rm end}\frac{f\,t'b^6u^2}{yR},
\]
\[
[\ell^5]Q_f\big|_{\rm end}
=3\operatorname{Tr}_{\rm end}\frac{f\,y^4t'b^{21}u^7}{R^4},
\]
\[
[\ell^4]Q_{tg}\big|_{\rm end}
=2\operatorname{Tr}_{\rm end}\frac{g\,y^4t'b^{16}u^5}{R^3}.
\]
These are identities of rational parameter functions, with denominators
only on the already excluded endpoint-content locus. They retain the
specified sign of the critical square root. They do not license replacing
other lower coefficients by type-A formulas with uncancelled b-denominators.

More generally, on a type-A parameter neighborhood, let k>=0 and
m in{0,-1}. In EVERY scale coefficient of Tr(t^k*f*phi^m*v), the
moving content factor R occurs to pole order at most
\[
\max(0,1-k-3m).
\]
The Lambda-pole residue is zero for n>2-k-3m. This bound is independent
of the scale coefficient index n; when positive it is sharp if the
highest residue has a nonzero multiplier value. It concerns the R-pole: cancellation
of other apparent type-A coordinate denominators is a separate matter.
In particular, t for T and t^4 for Q are the first vanishing powers that
remove this moving denominator uniformly.

For Q_1, the degree-five infinity contribution is zero, so the second
formula is its COMPLETE degree-five coefficient. For Q_x and Q_(x^2),
the additional infinity terms use at most five short series coefficients.
Writing their three normalized infinity terms as I_j(H,q),0<=j<=2,
and the three cubic endpoint traces as A_i(H,q), the simultaneous
degree-five degeneration is exactly
\[
A_i=-\sum_{j=0}^2(V^{-1})_{ij}I_j,
\qquad V_{ji}=r_i^j,
\]
where r_i are the three distinct roots of t. Thus its equations can be
formed with ONE fourth-power cubic norm per equation, rather than the
fourth power of the entire nine-sheet norm. The exact constructed
equations have bidegree(86,425) before removal of chart-unit factors.

This is a new closed coefficient calculation and a smaller presentation
of a leading-degeneration locus. That locus has not yet been decided.
Vanishing of leading coefficients is not the same as vanishing of the
trace polynomials at a candidate scale. No common-cover conclusion follows.

[Proof and sources](../../Proofs/cartier_and_spin/degree140_endpoint_top_trace_formulas.md).
