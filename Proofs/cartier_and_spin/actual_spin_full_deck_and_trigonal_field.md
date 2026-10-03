# Proof: the common theta scalar, full deck group, and exact trigonal field

Version2,3 October2026. [Statement](../../Theorems/cartier_and_spin/actual_spin_full_deck_and_trigonal_field.md). Version1 has [independent whole-proof review PASS](../../Research/audits/ACTUAL_SPIN_FULL_DECK_AND_TRIGONAL_FIELD_AUDIT_2026_10_03.md); the new faithful quadratic-coordinate consequence is a focused root-reviewed reuse. Both actual finite étale maps remain on the SAME T. The only quotient mentioned below is the actual free subgroup quotient T/K.

## Every carrier deck transformation has one common theta scalar

Let σ∈Aut(T/Γ). Because φσ=φ, the pulled line L=φ*M has its canonical σ-identification: σ fixes every pulled section u_i=φ*s_i under this identification. Compare the global spin isomorphism α:L¹⁶→ωT with its σ-transform, using the NATURAL canonical action on ωT. They are two isomorphisms of the same line bundles. Their quotient is a global invertible function on the connected proper T, hence one scalar cσ∈k×. Consequently
\[
\sigma^*\theta_i=c_\sigma\theta_i\quad\text{for ALL }i.
\]
There is no independent choice of multiplier for each u_i or θ_i. The constant comes from comparing the single actual common spin identification. No projective-action assertion about an automorphism outside G is assumed.

The accepted [theta recognition](new_line_comparison_normal_form.md) gives
\[
h_i\sigma=\gamma_\sigma h_i,
\qquad \gamma_\sigma\in\operatorname{Aut}(X)=C_3.
\]
The faithful theta character of C3 makes γσ the SAME automorphism for every i, determined by cσ. In particular cσ belongs to the three-element theta-character image. If cσ=1, σ fixes the actual X_i-field pointwise and fixes Γ. Since their compositum is T, σ is the identity. Thus the scalar character embeds Aut(T/Γ) into C3; this full deck group has order ONE or THREE.

## The full deck group commutes with G before any descent

Fix g∈G. G-equivariance of φ shows gσg⁻¹ is again over Γ. The actual G-conjugate theta forms are permuted by G. Therefore conjugation preserves the common scalar:
\[
(g\sigma g^{-1})^*\theta_i=c_\sigma\theta_i.
\]
Equivalently, compute this using g*θ_i=θ_j for the appropriate actual conjugate j; pulling the constant through g does not change it. Theta recognition gives the same γσ on the actual X_i-map for gσg⁻¹ and σ. Both automorphisms fix Γ. The actual equality Γ·X_i=T therefore makes them equal. Hence σ commutes with EVERY g∈G. This proves centralization; it is not presumed from field composita or simultaneous Galois closure.

Now σ preserves the G-invariant field k(Y) and induces an automorphism of Y of order dividing THREE. Since Aut(Y)=C2, this induced automorphism is the identity. Thus σ fixes Y pointwise. The actual Galois map q has Aut(T/Y)=G, so σ∈G. Since it also fixes Γ, σ∈K. The reverse inclusion K⊂Aut(T/Γ) is immediate. Consequently Aut(T/Γ)=K, of order ONE or THREE. In particular this proof also establishes the order assertion rather than requiring it separately.

## The exact trigonal joint field

Fix i. Write x_i=h_i*x and y_i=h_i*y. Let F_i=k(Γ)(x_i). The required Γ·X_i=T identity gives
\[
k(T)=F_i(y_i),\qquad y_i^3=f(x_i).
\]
Over the algebraically closed constant field, μ3 is present and THREE is invertible. Therefore this extension is either trivial, if f(x_i) is a cube in F_i, or cyclic Galois of degree THREE. In either case its fixed-field description is valid and its deck group is Aut(T/F_i).

This deck group is a subgroup of Aut(T/Γ)=K. Conversely every element of K acts on each actual X_i-map by its recognized automorphism in C3, which fixes x_i. Thus K fixes F_i and lies in Aut(T/F_i). The two groups are equal. Galois fixed-field equality gives
\[
F_i=k(T)^K.
\]
Because K⊂G and q is finite étale, T→T/K is an ACTUAL finite étale quotient. This does not descend the original map to X when k=3; only its coordinate x_i descends. In the faithful case no source quotient occurs and F_i is the entire original source field.

## Faithful recognition from a quadratic coordinate

Assume K=1, so Aut(T/Γ)=1 and k(T)=k(Γ)(x_i). For p(Z)∈k(Γ)[Z] of degree ONE or TWO, let E=k(Γ)(p(x_i)). The equation p(x_i)−p(Z)=0 shows
\[
[k(T):E]\le2.
\]
If the index were TWO, its minimal polynomial would be a separable quadratic: characteristic is FIVE, and a nontrivial quadratic polynomial cannot have identically zero derivative. The resulting quadratic Galois extension would supply a nonidentity deck involution of the smooth projective T over E and hence over Γ. This contradicts the accepted full deck group Aut(T/Γ)=1. Therefore E=k(T). A linear polynomial gives the same conclusion immediately by solving for x_i. Coefficients in Γ cause no difficulty because the intermediate field E contains all of them.

This proves a field identity, not an S10-invariant four-dimensional section space or a new étale endpoint. In the case K=3, applying the quadratic argument to the field T/K could produce a deck involution that does not lift across T→T/K; the proof deliberately makes no such extension.

## Exact second-Cartier ratio formulation

The accepted [second-Cartier recognition proof](actual_spin_cartier_recurrence_rank_bound.md) records C²θ=p1(x)θ, C⁴θ=p2(x)θ, C⁶θ=p3(x)θ and proves that the three degree-five polynomials give a basepoint-free birational map P1→P2. In particular
\[
k(x)=k(p_2(x)/p_1(x),p_3(x)/p_1(x)).
\]
The denominator is not the zero function. Cartier commutes with separating pullback along the original actual h_i. Hence the two ratios of actual pulled Cartier forms generate precisely k(x_i). Joining Γ and applying the preceding exact field identity proves the final assertion of the statement.

This last reconstruction uses no projective normality, arbitrary-section recurrence, canonical surjectivity, rank bound, or small-degree assumption. It is compatible with the primitive different identity φ*ξ_i=aθ_i, but does not impose an unproved recurrence on a. The moving-origin wild degree-ten survivor and the original common-cover gap remain.
