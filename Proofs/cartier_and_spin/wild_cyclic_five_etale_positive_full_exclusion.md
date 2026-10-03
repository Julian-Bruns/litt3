# Proof: a conductor-two tuple forces excessive wild Cartier defect

Version1,3 October2026. [Independent whole-branch review PASS](../../Research/audits/WILD_CYCLIC_FIVE_ETALE_POSITIVE_FULL_EXCLUSION_AUDIT_2026_10_03.md). See the [statement and original-source scope](../../Theorems/cartier_and_spin/wild_cyclic_five_etale_positive_full_exclusion.md). No computation is used. Both actual endpoint maps from the SAME original T are retained throughout.

## The surviving row and the actual descended Cartier embedding

Use the [finite local reduction](wild_cyclic_five_etale_positive_full_reduction.md). Its cyclic TWO/FOUR rows are excluded by the named selected ordinarity input. In the remaining row e=FORTY, put H=kerχ₂, so [G:H]=EIGHT. The faithful G-cover Z→P¹ has one wild inertia C₅⋊C₈ of break TWO and different FORTY-SEVEN, and one tame inertia C₈. The quotient Z/H is rational. The H-cover Z→Z/H has just ONE branch value, inertia C₅ of break TWO. Write n=g(Z)−ONE. Then
\[
|G|=40n,
\qquad |H|=5n,
\qquad \deg M=n/8.
\tag{1}
\]
There are exactly n wild points on Z.

The original full trace J contains every original three-section net I_i. Its adjoint evaluation F* q₁*J→ω_T is everywhere surjective. Indeed the original infinity divisor has degree d while q has degree EIGHT d, so every q-fiber has a non-infinity sheet. The original net evaluates onto ω at every finite source point; taking its conjugate sheets proves the assertion. This is the same actual-sheet argument as in [the contact proof](first_section_contact_strictness.md), and does not depend on that proof's degree-ZERO specialization.

Put J_Z=M₁²⊗V on the first Frobenius twist Z₁. The adjoint row coefficients of q₁*J are constant combinations of the ORIGINAL b_i=q₀(x_i)u_i⁶. Every x_i and u_i descends to Z, so these coefficients descend to sections of M⁶=ω_Z⊗M⁻¹⁰. They give an actual adjoint map F_Z*J_Z→ω_Z. Its Cartier vanishing is tested after the finite étale pullback φ, where it is the original map; Cartier commutes with étale pullback, which is injective on rational differentials. Adjunction therefore gives an embedding
\[
J_Z\hookrightarrow B_Z,
\qquad \varphi_1^*J_Z=q_1^*J.
\tag{2}
\]
Injectivity and surjectivity of its adjoint evaluation descend faithfully from φ. In particular
\[
\deg J_Z=n,
\qquad \deg B_Z=4n,
\qquad \operatorname{length}(B_Z/J_Z)=3n.
\tag{3}
\]
The G-action in (2) is the ORIGINAL genuine action transported from q₁*J. It is not an arbitrarily chosen linearization of M₁².

## Restriction to H is irreducible and has only two possible wild Jordan types

The class of M is H-invariant. A genuinely H-linearized line on Z has an invariant rational section by Hilbert90; its divisor is H-invariant. Since the H-cover has only inertia FIVE, its degree is divisible by |H|/FIVE=n. Thus Mʳ can be H-linearized only if EIGHT divides r. Conversely M₁⁸ has the genuine native determinant linearization already constructed in the [determinant-character proof](etale_spin_determinant_character_and_even_degree.md). Frobenius twists preserve this order because FIVE is coprime to EIGHT. Consequently the scalar obstruction of M₁ has exact order EIGHT, and that of M₁² has exact order FOUR.

The paired projective coefficient action of H on V has the inverse obstruction, of exact order FOUR. Every invariant subspace has dimension divisible by FOUR, by taking its determinant. Since dimV=FOUR, the H-action is irreducible, without a semisimplicity assumption.

Lift the actual H-cover with its prescribed local C₅ disc. In a reduced Artin–Schreier base coordinate its germ is y⁵−y=A/t²+B/t, A≠ZERO. With ε=ζ₅−ONE, lift that specific disc by
\[
Z^5=1+\varepsilon^5(A/T^2+B/T).
\tag{4}
\]
The generic Kummer function has TWO simple zeros and a pole of order TWO. After a finite base extension its normalization is a smooth local lift: its THREE generic order-FIVE branch points contribute total different TWELVE, equal to the special different. This is the same explicit cyclic order-p construction and different criterion as [Obus–Wewers, Annals180(2014), §4](https://annals.math.princeton.edu/wp-content/uploads/annals-v180-n1-p05-p.pdf). The prescribed-disc local-global principle, [Pop, Fact4.13(1)](https://annals.math.princeton.edu/wp-content/uploads/annals-v180-n1-p06-p.pdf), gives a smooth characteristic-zero H-cover with exactly these THREE branch values. Equivalently one may use the formal-patching preservation of supplied local lifts in [Obus, Theorem3.1](https://arxiv.org/abs/1105.1530). This preserves the SAME special H and the conjugacy classes from its C₅ inertia.

Complex branch cycles therefore generate H by three order-FIVE elements a₁,a₂,a₃ with product ONE. Each is conjugate to a nonzero power of the SAME wild generator. Choose the unique unipotent determinant-ONE lifts U_i of their projective images. Their product is ζI for ζ∈μ₄. All THREE have the same Jordan partition as the original wild U. The induced tuple on End(V) has product ONE. Irreducibility gives invariant and coinvariant dimensions ONE. Scott's inequality therefore gives
\[
3\bigl(16-\dim\operatorname{Cent}(U)\bigr)\ge30.
\tag{5}
\]
Thus dimCent(U)≤SIX. The only partitions in dimension FOUR are J₄, with centralizer dimension FOUR, and J₃⊕J₁, with centralizer dimension SIX. In particular J₂⊕J₂ is impossible.

## The central wild involution is projectively trivial on V

Let τ be a generator of the wild tame quotient of order EIGHT, and let κ=τ⁴. Its conjugation on C₅ has order FOUR, so τUτ⁻¹=Uᵃ, where a∈F₅× has order FOUR. The element κ is the central tame involution.

If U=J₄, let N=logU. Then τNτ⁻¹=aN. The FOUR graded eigenvalues along its single Jordan chain differ by successive factors a. Their FOURTH powers agree. Since τ is semisimple projectively, τ⁴ is projectively scalar.

If U=J₃⊕J₁, equality holds in (5). Compare the THREE-matrix tuple with its entrywise FIFTH-power twist. The scalar product ζ is unchanged because μ₄⊂F₅. All local conjugacy classes are unchanged. Scott on Hom gives a nonzero intertwiner: its THREE fixed dimensions are SIX, so the sum of codimensions THIRTY forces the invariant or dual-invariant space to be nonzero. Irreducibility makes this an isomorphism. Lang descent then realizes the generating tuple in SL₄(F₅).

The F₅-span of that absolutely irreducible finite matrix group is M₄(F₅): after extending scalars this is Burnside's matrix-algebra theorem, so its F₅ dimension is SIXTEEN. Any actual G-lift normalizes this algebra, because it preserves the unique unipotent lifts of all order-FIVE elements of H. The matrix-algebra normalizer, by Skolem–Noether, is k×GL₄(F₅). Thus τ has a representative over F₅. Its preserved line N²V has an F₅ eigenvalue λ. The three-chain graded eigenvalues are λ,aλ,a²λ, all in F₅; the remaining eigenvalue also belongs to F₅, by its characteristic polynomial. Semisimplicity gives τ⁴ scalar, again.

In either case κ acts projectively trivially on V. This assertion concerns ONLY the wild central involution; the tame branch's order-EIGHT generator need not have projective order FOUR.

## A wild point needs defect at least FOUR

Fix any wild z∈Z. The involution κ fixes z and has tangent character MINUS ONE. In the genuine action on J_Z, its fiber action is scalar because its coefficient action is projectively scalar. The adjoint F*J_Z→ω_Z is surjective. Its fiber must therefore have scalar MINUS ONE: the FIFTH power of that scalar is the cotangent character MINUS ONE. Consequently κ acts by −I on (J_Z)_z.

The fiber of B_Z in a κ-odd local parameter t is spanned by dt,t dt,t²dt,t³dt; its κ-signs are respectively MINUS,PLUS,MINUS,PLUS. The fiber image of J_Z therefore has dimension at mostTWO, giving local colength at leastTWO. Comparing determinants shows the colength is EVEN: both determinant fiber characters are PLUS, and a local determinant zero of order a contributes (−ONE)ᵃ on Z₁. It remains to exclude colength exactlyTWO.

If that length is TWO, the Smith partition is (ONE,ONE,ZERO,ZERO); its image is the full negative eigenspace. The integral lattice is uniquely the inverse image of that eigenspace modulo the maximal ideal. Put w=t⁵, the Z₁ parameter. It is
\[
\mathcal L=\langle dt,\ t^2dt,\ w tdt,\ w t^3dt\rangle.
\tag{6}
\]
Choose an Artin–Schreier generator y for the local wild action σ with σy=y+ONE and pole order TWO. Average y with κy. Its pole remains TWO, since κ has tangent MINUS ONE, and averaging retains σy=y+ONE because κ commutes with σ. Hence y is κ-invariant. Set t=y⁻¹/²; then κt=−t and
\[
\sigma t=t(1+t^2)^{-1/2}.
\tag{7}
\]
The power-series half-root with constant ONE is unique. In characteristicFIVE,
\[
\sigma(dt)=(1+t^2)(1+t^{10})^{-1/2}dt,
\qquad \sigma(t^2dt)=t^2(1+t^{10})^{-1/2}dt.
\tag{8}
\]
Modulo w𝓛 these give dt↦dt+t²dt and t²dt↦t²dt. Also σw=w+terms of order at leastTHREE in w, and direct differentiation of (7) gives
\[
wt dt\longmapsto wt dt+3wt^3dt,
\qquad wt^3dt\longmapsto wt^3dt
\pmod{w\mathcal L}.
\tag{9}
\]
For example t·σ(dt)=(t+3t³+terms of order at leastFIVE)dt; the omitted terms after multiplication by w lie in w𝓛. Therefore the wild fiber action in (6) is EXACTLY J₂⊕J₂. A wild element has scalar ONE on the M₁² fiber, since k× has no order-FIVE torsion; its fiber action on J_Z has the SAME Jordan type as U. This contradicts (5).

Thus every wild point has even local colength at leastFOUR. There are n such points by (1). They require total Cartier defect at leastFOUR n, contradicting the exact THREE n budget (3).

This deletes the FORTY row and hence, with the selected cyclic TWO/FOUR input, the whole first-wild-group-FIVE positive-full étale branch. Identity carriers, other positive traces, and larger wild first ramification groups remain outside the conclusion.
