# Proof: weak linearized normal form and comparison over a fixed base

Version1. [Statement](../../Theorems/quotient_geometry/weak_local_completed_extension_invariant.md). [Independent review PASS](../../Research/audits/WEAK_LOCAL_COMPLETED_EXTENSION_INVARIANT_AUDIT_2026_10_03.md). Both actual maps are retained in its global corollary; there is no replacement of a source by a hypothetical atlas.

Since h is prime to p and constants are algebraically closed, the unit and valuation of β admit an hth root in L. Put M=k((ψ⁻¹)). The ramification degrees in L/M/K are p and h. The tame tower gives
\[
\delta(L/M)=\delta(L/K)-p(h-1)=2p-2.
\]
For the rational differential dψ on L, its order is δ(L/M)−2p=−2. The only negative Laurent powers permitted in ψ are therefore −p and −1: every other negative exponent has a nonzero derivative, whereas the term of exponent −p differentiates to zero. The pole order p gives α≠0, and the differential order −2 gives γ≠0.

The equation αw^p+γw=r(t) has a solution w in k[[t]]. First solve its constant equation over k, then use Hensel lifting with derivative γ≠0. Set u=t⁻¹+w. It is a pole-one coordinate and
\[
\psi=\alpha u^p+\gamma u,\qquad
\beta=(\alpha u^p+\gamma u)^h.
\]
Translations u↦u+b, with αb^p+γb=0, give p automorphisms. Multiplication u↦a u, with a in μ_h⊂F_p^×, gives h more. They preserve β, form C_p⋊C_h, and exhaust the degree ph. Their action on the inverse coordinate shows that the translations have lower break one.

Choose λ with λ^(p−1)=−γ/α and write u=λU. Then
\[
\psi=A(U^p-U),\qquad A=\alpha\lambda^p=-\gamma\lambda,
\qquad A^{p-1}=-\gamma^p/\alpha.
\]
Thus over the UNIQUE tame degree-h extension M/K, the degree-p extension is the Artin–Schreier class aψ, where a=A⁻¹ and
\[
a^{p-1}=-\alpha/\gamma^p.
\]
Different choices of λ change a by F_p^×. Distinct nonzero constant multiples of ψ have identical Artin–Schreier lines precisely when their constants differ by F_p^×: no nonzero scalar multiple of the pole-one parameter ψ is a coboundary v^p−v, since a pole of a coboundary has order divisible by p. All regular constant-field tails are coboundaries by Hensel lifting and algebraic closedness.

Changing ψ to ζψ, ζ in μ_h, does not change a^(p−1), because ζ lies in F_p^×. This also proves that conjugating the identification of the unique tame field over K does not change the degree-p field. The equality criterion over K is therefore exactly equality of −α/γ^p. The same classification shows independence of the source uniformizer; alternatively the Laurent leading coefficients transform with factors c^p and c under a coordinate rescaling, which cancel in the quotient. Higher coordinate terms change only a removable regular tail after the linearized normalization.

For the actual-source corollary, étaleness of T→Y identifies the completed fields at a point of T and its Y image. Unramifiedness of T→Γ and algebraically closed residue fields identify those completed fields with the corresponding completed Γ field. The actual Galois group of Γ/B identifies the completions over all points of its branch fiber OVER the SAME completed B field. The local scalars must consequently agree. This is stronger than knowing that all completions are abstractly Galois or have equal numerical ramification profiles.

For the differential specialization, use t=F at a simple wild zero. The exact differential identity gives
\[
G=G(R)-c\sigma_R t^{p-1}+O(t^p).
\]
The hth root ψ=G^(m/h)t⁻p therefore has α=G(R)^(m/h) and γ=−(m/h)cσ_R G(R)^(m/h−1). Substitution in −α/γ^p gives the formula in the statement; its exponent is an integer since h divides p−1. For p=5,h=4,m=7, the coefficient −m/h equals2 in F5 and the exponent is−2. Multiplying by the common constant (2c)^5 gives the claimed seven-point comparison. In the genuine rational function field, normalize d/dz by (d/dz)(z)=1 and write F_z=(d/dz)(F). The identity σ=dz/y gives yF_z=(σ/dF)⁻¹. Since F is a local uniformizer and σ is an original differential unit, σ/dF and therefore yF_z are units of the ORIGINAL stalk. Thus the residue of the PRODUCT yF_z is valid at every selected point, including Weierstrass points where its rational factors need not have separate residues. This product residue is the coordinate expression in the statement.

No numerical certificate is needed. The missing global existence or incompatibility remains a separate question.
