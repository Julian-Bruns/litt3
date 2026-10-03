# Proof: the actual tensor fixes the sixth-power lift and excludes the first quotient

Version1,3 October2026. Independently reviewed PASS in [the actual spin tower audit](../../Research/audits/ACTUAL_SPIN_CUBIC_TOWER_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/canonical_ten_exact_tensor_stabilizer_index_bound.md).

The original τ has SIX simple q0-zero points, each of order EIGHT. Its actual étale pullback to T therefore has reduced zero divisor of degree SIX d. The exact stabilizer S0 preserves that divisor and acts freely because S0⊂G and T→Y is étale. Since |G|=EIGHT d, its reduced quotient degree is THREE m0/FOUR, an integer. Thus FOUR divides m0. This concerns the actual free action, not an assumed quotient map from X.

The actual quotient V=Γ/S0 has a degree-m0 map to the rational Γ/G. Let a be the number of FIVE-cycles of the wild inertia on G/S0 and b the number of transpositions of the tame inertia. A ramified degree-FIVE completed local extension is the entire cyclic-FIVE extension of lower break ONE, so it contributes different EIGHT. A degree-TWO tame extension contributes ONE. There are no other branch values. Therefore
\[
2g(V)-2=-2m_0+8a+b,\quad a\le\lfloor m_0/5\rfloor,\quad b\le\lfloor m_0/2\rfloor.
\]
For m0=FOUR orEIGHT even the largest right side is smaller than minusTWO. At m0=TWELVE its largest value is minusTWO, so necessarily g(V)=ZERO,a=TWO,b=SIX. The wild coset profile is (FIVE,FIVE,ONE,ONE), and the tame profile is SIX transpositions with no fixed coset. Consequently the actual S0-action on Γ has precisely TWO possible wild stabilizer orbits of order FIVE, over the TWO fixed wild cosets, and NO tame stabilizer. At every other point its stabilizer is trivial. This uses the inertia intersections in the actual tower Γ→V→Γ/G.

We now supply a genuine S0-line that rules out this profile. Write u=φ*s for the original infinity section and B=q0(x)u⁶, a nonzero meromorphic section of L⁶. The common canonical identification α:L¹⁶→ωT gives τ=α³(B⁸). For g∈S0 choose ANY individual isomorphism g*M→M, possible because the inherited M is G-stable. Its pullback identifies g*L with L. Comparing α and its g-transform under this identification gives ONE nonzero global scalar c_g, since both are isomorphisms of line bundles on the proper connected T. Exact equality g*τ=τ then says
\[
(g*B/B)^8=c_g^{-3}.
\]
The ratio is a constant: every root of this constant polynomial belongs to the algebraically closed constant field. Thus the induced isomorphism g*M⁶→M⁶ can be rescaled uniquely to fix B after pullback to T. Such an isomorphism is unique because TWO line isomorphisms differ by a global unit on the proper Γ, hence a constant; the nonzero pulled section B determines that constant. Composition also fixes B, so these unique isomorphisms satisfy the group cocycle EXACTLY. They define a genuine S0-linearization of M⁶, without claiming that M itself was genuinely linearized or that B descends to Γ.

Combine it with the retained native genuine linearization of M¹⁶. The actual line
\[
A=(M^6)^3\otimes(M^{16})^{-1}\simeq M^2
\]
is then genuinely S0-linearized. Its normalized degree is
\[
\deg A/|S_0|=\frac{2(d/10)}{8d/m_0}=m_0/40.
\]
Here deg L=d follows from L¹⁶≅ωT and g(T)=EIGHT d+ONE, so deg M=d/TEN.

For a genuine equivariant line under a finite group action, Hilbert90 supplies a nonzero invariant GENERIC meromorphic section: the generic semilinear cocycle over the actual Galois function-field extension is a coboundary. Its divisor is invariant. If all point stabilizers have order ONE orFIVE, every orbit has degree |S0| or|S0|/FIVE; consequently the degree of that line divided by |S0| belongs to (ONE/FIVE)Z. This argument uses the actual wild quotient action, and does not identify it with a tame root stack.

At m0=TWELVE the forced inertia profile has exactly these stabilizers, but deg A/|S0|=THREE/TEN does not lie in (ONE/FIVE)Z. This contradiction excludes m0=TWELVE. Together with the multiple-FOUR condition and the FOUR/EIGHT exclusions, it proves m0≥SIXTEEN.

The rational maps realizing the numerical TWELVE profile without the inherited spin line are not being excluded. The contradiction uses its actual sixth-power tensor lift and the genuine sixteenth-power spin linearization. Both original endpoint maps remain on T throughout; no common core or replacement source is inferred.
