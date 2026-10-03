# A coarse factor unramified at the different point lowers the actual carrier

Version1,3 October2026. [Independent whole-implication review PASS](../../Research/audits/ACTUAL_COARSE_FACTOR_LOWERING_AUDIT_2026_10_03.md).

Let k be algebraically closed. Retain the SAME smooth projective source T and BOTH actual finite étale maps q:T→Y and h:T→X. Assume q is Galois with group G. Let φ:T→Γ be a finite separating G-equivariant map, with faithful G action on Γ, reduced different q⁻¹(P), local index TWO there, and no other ramification. Put B=Γ/G. The induced map β:Y→B satisfies πΓφ=βq.

Suppose β factors through finite separating maps
\[
Y\xrightarrow{u} C\xrightarrow{\rho} B,
\]
and ρ is unramified at u(P). Write e=degρ. Then the actual field Γ′=k(Γ)k(C) is a subfield of k(T), its smooth projective curve satisfies
\[
\deg(\Gamma'\to\Gamma)=e,\qquad \Gamma'\to\Gamma\text{ is finite étale},
\qquad \deg(T\to\Gamma')=\deg\phi/e.
\]
The original G action on Γ′ is faithful, Γ′/G=C, and the induced φ′:T→Γ′ has the SAME different q⁻¹(P) and the SAME local index two. Both original endpoint maps remain on T.

All descending spin data are retained: if L=φ*M, L¹⁶≅ωT and N=M¹⁶ωΓ⁻¹ with φ*N≅O_T(q⁻¹(P)), then M′=M|Γ′ and N′=N|Γ′ satisfy the same identities. In particular N≅ωΓ genuinely implies N′≅ωΓ′ genuinely. Every original descended infinity section pulls back to M′. If the different coefficient a satisfies k(Γ)(a)=k(T), then k(Γ′)(a)=k(T) as well.

This constructs the new target INSIDE the actual source; it does not form or presume a simultaneous Galois closure of the two endpoint maps.

[Proof](../../Proofs/cartier_and_spin/actual_coarse_factor_etale_carrier_lowering.md).
