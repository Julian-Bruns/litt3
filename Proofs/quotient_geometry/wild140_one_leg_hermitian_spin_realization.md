# Proof: the auxiliary Hermitian realization of the four coarse pairs

Version1, 3 October2026. Independent review pending. [Statement](../../Theorems/quotient_geometry/wild140_one_leg_hermitian_spin_realization.md).

The accepted [single-jump A7/Hermitian theorem](../../Theorems/quotient_geometry/local_actions/single_jump_a7_hermitian_reduction.md) supplies the ACTUAL Galois map H→B≅P¹ with just two branch values: wild inertia20, different23 and break one, and tame inertia7. Put these values at ∞ and0. Its completed wild extension has a nonzero scalar 𝓘_H over the fixed pole coordinate of B.

The [moving-family theorem](../../Theorems/quotient_geometry/wild140_moving_coarse_map_family.md) supplies β with the same two local numerical types, plus just the index-two point P above a finite nonzero ordinary value. More importantly, its seven wild completed extensions have one common scalar 𝓘_β. For β_new=aβ, the [weak invariant](../../Theorems/quotient_geometry/weak_local_completed_extension_invariant.md) transforms as 𝓘_new=a⁻¹𝓘_β: an hth root with h=4 multiplies both Laurent coefficients by a fourth root of a. Taking a=𝓘_β/𝓘_H makes the seven wild completions ISOMORPHIC OVER THE SAME base to those of H→B. At0 the tame degree-seven completed extension is unique over the algebraically closed constant field.

Normalize the fiber product H×_B Y. At each wild or tame branch point the Y completed extension equals the inertia extension in H. Tensoring a finite Galois completed extension with itself splits it into copies of the upstairs field. Consequently the normalized pullback U→Y is unramified there. Away from these branch values H→B is already étale, so its normalized pullback is étale as well. The morphism is finite, and smooth curves over an algebraically closed field have no further residue extensions. Thus U→Y is finite étale everywhere. Its inherited A₇ action is free and makes it an A₇ torsor, including if the total space is disconnected. Its equivariant projection to H gives the actual map Y→[H/A₇]. It is finite and representable because its pullback along the scheme atlas H is the finite map U→H.

At the wild and tame fibers U→H is unramified, since the completed fields were equal. At every other point except those above P both maps to B are unramified. At P, Y→B has index two and H→B is unramified, so U→H has index two. Therefore on each connected component U₀ the different is exactly q₀P, with coefficient one. Riemann--Hurwitz and the étale Y leg give
\[
q_0^*\omega_Y=\omega_{U_0}
\simeq\varphi_0^*\omega_H\otimes q_0^*\mathcal O_Y(P).
\]
Since P is Weierstrass on the genus-two curve, ω_Y≅O_Y(2P). Cancellation proves φ₀*ω_H≅q₀*O_Y(P). This line identity follows from actual maps and actual different; it constructs no original X leg.

For the stronger abstract root identities choose a line of exact order four on H and its connected cyclic degree-four étale cover π:H′→H. Such a line exists because multiplication by four on the genus-ten Jacobian is étale with full nonzero four-torsion. The genus of H′ is37, so degω_H′=72. Over the algebraically closed field, multiplication by eight on Pic⁰(H′) is surjective. Since72 is divisible by eight, there is a degree-nine line M with M⁸≅ω_H′.

Take any connected component T′ of U₀×_H H′. Its projection to U₀ is étale and its map φ′ to H′ is nonconstant and separating. Pulling back the actual different and the preceding line identity yields
\[
\varphi'^*\omega_{H'}\simeq q'^*\mathcal O_Y(P),
\quad\operatorname{Diff}(\varphi')=q'P.
\]
Set L=φ′*M. Then L⁸=q′*O_Y(P), and squaring gives L¹⁶=q′*ω_Y=ω_T′. If a Galois Y leg is wanted, take the Galois closure of this ONE étale cover T′→Y. It is still étale and retains the composed map to H′ and all pulled line identities; it does not invoke or construct a simultaneous closure with X.

The theorem makes no assertion that M has the required sections or projective action, or that its pullback realizes an infinity theta form of X. Those are essential missing data for the original problem and for an actual minimal faithful spin carrier.
