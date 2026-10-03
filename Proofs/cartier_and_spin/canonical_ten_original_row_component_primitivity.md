# Proof: the quadratic original marking already generates the degree-ten extension

Version2,3 October2026. The original-component argument passed [focused root review](../../Research/audits/CANONICAL_TEN_ROW_IDENTITY_AND_KERNEL_AUDIT_2026_10_03.md). The all-constant-projection extension below is pending review; see the [actual-source statement](../../Theorems/cartier_and_spin/canonical_ten_original_row_component_primitivity.md). No computation is required.

Put K=k(Γ), F=k(T), and a_i=q₀(x_i). Since [k(X):k(q₀(x))]=SIX, the actual equality F=Kk(X_i) implies that a_i cannot belong to K: otherwise [F:K] would be at mostSIX, contrary toTEN.

The accepted [full S10 normal closure](../../Theorems/cartier_and_spin/canonical_degree_ten_symmetric_normal_closure.md) makes F/K have NO proper intermediate field: its point stabilizer S9 is maximal in S10. The nontrivial intermediate K(a_i) must therefore be F. This is a statement about the actual embedded X_i-field, not an arbitrary degree-SIX map or a simultaneous normal closure of the X-maps.

Choose any nonzero rational frame m for M on Γ. Since u_i descends, u_i=f_iφ*m with f_i∈K nonzero. The component b_i in the induced M⁶ frame is a_i f_i⁶. Multiplication by f_i⁶ does not alter the generated field, so K(a_i f_i⁶)=F. In particular it cannot be a descended section of M⁶.

For Version2 let V0 consist of the constant directions v∈V^[5] whose row section b_v descends to Γ. This is a k-linear subspace, stable under the actual projective G-action, since φ, M and the full adjoint row are equivariant. If a row coefficient in a Γ rational frame belongs to K, it is a genuine descended global section: regularity is detected by its finite surjective pullback to T. Irreducibility of V^[5] makes V0 either ZERO or ALL. The proved original primitive component rules out ALL. Thus EVERY nonzero v has b_v outside K, and maximality of S9 again gives K(b_v)=F. None of this promotes constant linear independence to independence over K.

The actual positive inclusion L²⊗V4→B1T has Frobenius-adjoint row F_T*(L²)⊗V4^[5]→ωT. The original direction indexed by i evaluates to b_i after identifying ωT=L¹⁶, so it is a section of L⁶=φ*M⁶. The established primitivity rules out descent of this row as a row of M⁶ sections on Γ.

A genuine descent of the embedded inclusion into B1Γ is impossible for an additional direct reason. Since B1Γ⊂F_{Γ*}ωΓ and M⁸=ωΓ, Frobenius adjunction gives
\[
\operatorname{Hom}_\Gamma(M^2,B1\Gamma)
\subseteq H^0(\Gamma,\omega_\Gamma\otimes M^{-10})
=H^0(\Gamma,M^{-2})=0.
\]
Here degM>ZERO. Thus no nonzero map M²⊗V4→B1Γ can pull back to the given inclusion. One must not identify ωT with φ*ωΓ in this argument: the actual identity is ωT=φ*ωΓ², with its nonzero different. The line L² may nevertheless descend, and a particular local completion may have a separate descent property. Neither fact replaces descent of the original embedded map.
