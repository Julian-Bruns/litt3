# A scalar classifies weak cyclic-wild completed extensions

Version1,3 October2026. The local classification and actual-source comparison passed [independent review](../../Research/audits/WEAK_LOCAL_COMPLETED_EXTENSION_INVARIANT_AUDIT_2026_10_03.md). The explicit differential specialization below is a direct algebraic corollary.

Let k be algebraically closed of characteristic p>2 and h divide p−1. Fix a downstairs pole parameter β, so K=k((β⁻¹)). Let L=k((t)) be a finite separating extension with β of pole order ph and different exponent ph+p−2. Choose ψ in L with ψ^h=β. Its Laurent expansion has the form
\[
\psi=\alpha t^{-p}+\gamma t^{-1}+r(t),
\qquad\alpha\gamma\ne0,\quad r\in k[[t]].
\]
Then L/K is automatically Galois with inertia C_p⋊C_h and lower wild break one. The scalar
\[
\mathcal I(L/K;\beta)=-\alpha/\gamma^p\in k^\times
\]
is independent of the uniformizer t and the chosen hth root ψ. Two such completed extensions over the SAME fixed K are isomorphic over K if and only if their scalars are equal.

Consequently, in an actual common-source diagram T→Y, T→Γ, Γ→B, suppose T→Y is étale, Γ→B is Galois, and T→Γ is unramified above a complete wild branch fiber of Y→B. If all those local degrees are ph and their differents are ph+p−2, the scalars at all points of that fiber must be equal. Equality of inertia orders and differents alone does not supply this conclusion.

In particular suppose β=G^m/F^(ph), m prime to p, F has simple zeros in that wild fiber, G is a unit there, and dG=cF^(p−2)σ with c nonzero and σ a differential unit. Put σ_R=(σ/dF)(R). The same scalar is
\[
\mathcal I_R=-\frac{G(R)^{p-(p-1)m/h}}{(-(m/h)c\sigma_R)^p}.
\]
For p=5,h=4,m=7, it becomes
\[
\mathcal I_R=-\frac{1}{(2c)^5G(R)^2\sigma_R^5}.
\]
Thus the actual canonical degree140 profile with β=G^7/F^20 and dG=cF^3σ forces G(R)^2σ_R^5 to be the SAME nonzero constant at all seven wild points. In a hyperelliptic coordinate σ=dz/y, this is equivalently constancy of (y(R)F_z(R))^5/G(R)^2. The assumption that all local completions identify through the actual common source is essential.

[Proof](../../Proofs/quotient_geometry/weak_local_completed_extension_invariant.md). This local result does not construct or exclude either global common-cover map.
