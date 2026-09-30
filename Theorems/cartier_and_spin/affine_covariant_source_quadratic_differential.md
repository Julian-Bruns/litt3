# An affine-covariant source quadratic differential

Version1,30 September2026. Let K be the function field of a smooth curve
over a perfect field of characteristic p>=5. All differentials are
relative to that field. Let
\[
\phi=W^p+q,\qquad F=\kappa\phi^2+\phi S+\tau,
\]
where kappa,tau are nonzero, deg(S)<=p-2, and F is separable. Write
gamma for the coefficient of W^(p-2) in S, possibly zero. In the finite
etale K-algebra B=K[W]/(F), define the quadratic differential
\[
\mathcal Q_F=
\operatorname{Tr}_{B/K}\left(\frac{dw\,dw}{\phi(w)}\right)
-\frac{dq\,d\gamma}{\tau}.
\]
Products here are symmetric products of one-forms on the base curve;
the identification of differentials on B uses its separability.

Under ANY affine source-coordinate change w'=a w+b, with a in K^*
and b in K, use the exact presentation
\[
q'=a^p q-b^p,\quad
S'(W')=a^p S((W'-b)/a),\quad
\tau'=a^{2p}\tau,\quad \kappa'=\kappa.
\]
Here S' denotes the transformed polynomial, not its derivative. Then
\[
\mathcal Q_{F'}=a^{2-p}\mathcal Q_F.
\]
In particular the correction has no denominator gamma, and the assertion
includes gamma=0, arbitrary parameter specializations preserving the
stated source hypotheses, and meromorphic a,b. It is a tensorial
transformation law; no regularity across poles of a or tau is presumed.

If a source-coordinate atlas has transition w_i=a_ij w_j+b_ij, these
local expressions glue with the displayed weight a_ij^(2-p). Where
the actual split roots, q and gamma are integral, the derivation is
integral, and phi(w) and tau are units, this quadratic differential
is integral. Global regularity or vanishing needs further pole analysis.

This supplies a coordinate-independent correction to the source energy.
It does not exclude another degree140 stratum or decide the unmarked
common-cover problem.

[Proof](../../Proofs/cartier_and_spin/affine_covariant_source_quadratic_differential.md).
