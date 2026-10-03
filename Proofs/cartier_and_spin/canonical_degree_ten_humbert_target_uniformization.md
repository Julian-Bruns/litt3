# Proof: the exact Humbert target atlas and retained ramified source

Version3. [Statement](../../Theorems/cartier_and_spin/canonical_degree_ten_humbert_target_uniformization.md). Version1 passed [root whole-scope review](../../Research/audits/CANONICAL_DEGREE_TEN_HUMBERT_TARGET_UNIFORMIZATION_AUDIT_2026_10_03.md); the full Version3 actual-source packet consequences passed [root whole-scope review](../../Research/audits/CANONICAL_DEGREE_TEN_SYMMETRIC_CLOSURE_AUDIT_2026_10_03.md). No new computation. Use the accepted full completed-field criterion and degree-ten primitive local normal form; do not replace the original two endpoint maps by a one-leg target map.

## An actual order-eighty cover and its exact local fields

The four displayed Kummer classes are independent: their valuations at the four nonzero finite F5 points isolate the four generators. Hence H→P¹x is connected of degree16. Its five finite branch points are x∈F5 and all have index TWO. Infinity is unramified because the ratios have valuation zero and unit leading coefficient one. Riemann–Hurwitz gives
\[
2g(H)-2=-32+5\cdot8=8,
\qquad g(H)=5.
\]

For an explicit lift of translation, adjoin all FIVE roots ri²=x−i. Their full Kummer cover has degree32. Its even-product subfield is exactly k(H). Translation x↦x+1 cyclically permutes these five roots and has order FIVE on the full cover and its even subfield. Therefore H has an actual action C2⁴⋊C5 of order80, with quotient coordinate β0=x⁵−x.

Over β0=0, translation permutes the five finite branch points transitively and the inertia is C2. At infinity H→P¹x is étale, while x→β0 is the exact C5 Artin–Schreier extension x⁵−x=β0. Its break is ONE and different is EIGHT. There are no other branch values.

At infinity write u=1/x. For β=A(x⁵−x), the local expansion is
\[
\beta=A u^{-5}-A u^{-1},\qquad R_H=1/A^4.
\]
The accepted [weak completed-extension invariant](../quotient_geometry/weak_local_completed_extension_invariant.md) says that every degree-five/break-one extension over this same β-base is determined by its nonzero R. Thus choose A with A⁴=RΓ^-1. This matches the ACTUAL wild completed fields of H and Γ. The tame quadratic completed field is unique over its fixed base because the residue field is algebraically closed. After this scaling the actual completed fields agree at both branch values, not merely their inertia orders or different exponents.

The accepted [completed-local orbifold rigidity](../quotient_geometry/local_actions/completed_local_orbifold_rigidity.md) now applies to the effective orbifolds with atlases Γ and H. Equivalently, normalize their actual coarse fiber product. Every component Γ′ has étale projections to BOTH targets: locally the identical completed fields cancel the ramification under normalized base change. This can also be checked directly at the two branch values; elsewhere the maps were already étale. The degree over Γ is at most the order80 of H→B.

## The five ordinary elliptic factors

The characters of C2⁴ correspond to even subsets of the FIVE finite branch points. Ten nontrivial characters have a two-point subset and their double quotient has genus ZERO. Five have a four-point subset and their double quotient has genus ONE. The invariant quotient has genus ZERO. Since16 is invertible in characteristic FIVE, the character idempotents and quotient pullbacks give an isogeny from the product of these FIVE elliptic quotients to J(H): their dimensions sum to g(H)=5.

Translation permutes the five omitted points, so all five elliptic quotients are isomorphic. The quotient omitting zero is
\[
E:\quad v^2=\prod_{i=1}^4(x-i)=x^4-1.
\]
It has j=1728: the order-four automorphism x↦2x fixes the point x=0,v=2, and relative to that elliptic origin acts faithfully with order FOUR. It is ordinary. Indeed the elliptic Cartier coefficient is the coefficient of x⁴ in (x⁴−1)², which is−2≠0 in characteristic FIVE. Thus J(H) is isogenous to E⁵ and H has p-rank FIVE.

## The exact source diagram and the sixteen-torsion spin difference

Take a component of the normalization T′ of T×Γ Γ′. The projection T′→T is finite étale because Γ′→Γ is. Both original endpoint maps compose with it and remain finite étale. The other projection T′→Γ′ is the normalized base change of φ. At every point above the original qP its local index remains TWO: étale base changes on either side preserve that completed ramification extension. The map Γ′→H is étale, so T′→H retains this ramification. The diagram is
\[
T'\longrightarrow T\longrightarrow X,Y,
\qquad
T'\longrightarrow\Gamma'\longrightarrow H,
\qquad
\Gamma'\longrightarrow\Gamma.
\]
Only the first source refinement and the two target projections are étale. No original X field is inferred to lie in Γ′, and no actual common étale cover of X and H is constructed.

Because N=M¹⁶ωΓ^-1≅ωΓ genuinely, M¹⁶≅ωΓ². Pulling to Γ′ and using both target projections étale gives
\[
(M')^{16}\simeq\omega_{\Gamma'}^2
\simeq\pi^*\omega_H^2.
\]
There exists a degree-one line MH with MH⁸=ωH: choose any degree-one line and solve the resulting degree-zero eighth-root equation in Pic⁰(H), where multiplication by EIGHT is surjective. Thus R=M′/π*MH has R¹⁶ trivial. Its exact geometric order r divides16. A chosen trivialization produces its connected cyclic μr torsor Γ″→Γ′, finite étale of degree r≤16, and makes R trivial upstairs. Pulling through the source gives T″→T of degree at most80·16, retaining both actual endpoint maps and the original spin identity by étale pullback. A global scalar in the line isomorphism can be normalized by an appropriate sixteenth root in the algebraically closed field.

Every original spin section on Γ pulls back to Γ″ and becomes a section of π″*MH. This describes its line, not a descent of that section to the degree-one line on H. The number of sections can increase under the target étale refinement.

## Which obstructions survive

The ordinary elliptic factorization is a fact about H. It is not inherited by arbitrary étale targets Γ′ or source refinements T″. The accepted [prime-avoiding section-growth theorem](../../Theorems/jacobians/ordinary_covers/prime_avoiding_section_growth.md) gives cyclic prime-to-five étale refinements of every hyperbolic curve over Fbar5 with arbitrarily large Cartier defect. It applies to this H, so an unrestricted ordinary-refinement claim would be false.

It also applies to MH: the locus of degree-zero twists with a section is the translate of the Abel curve W1(H), which generates the entire Jacobian. Consequently sections of the pullback of MH can grow without bound along such cyclic étale refinements. Thus the fixed genus-five atlas and its degree-one spin line alone give neither a uniform rank bound nor descent of the original X leg. The separate packet theorem for an ACTUAL étale map to H is inapplicable to T″→H, which is ramified.

## A packet obstruction through the retained genus-two endpoint

This clause uses the actual target compositum Γ′=ΓH before the optional line-trivializing refinement. Both Γ/B and H/B are genuinely Galois, so Γ′/B is genuinely Galois. Restriction gives the exact sequence
\[
1\longrightarrow J\longrightarrow G'\longrightarrow Q\longrightarrow1.
\]
The atlas Γ′/B has no branch at the special value β=1: both original target atlases branch only at zero and infinity. Let E/B be the genuine S10 normal closure of Y/B. Its transposition inertia at β=1 normally generates S10. Therefore the Galois intersection E∩Γ′, which is unramified at that value, is exactly B. The [degree-ten symmetric-normal-closure proof](canonical_degree_ten_symmetric_normal_closure.md) establishes this S10 statement from the actual endpoint normal form: a degree-ten intermediate field would give a degree-two hyperelliptic or elliptic quotient, or a quadratic coarse subcover whose two branch fibers cannot have the actual profiles (5,5), (2⁵), (2,1⁸); a primitive permutation group containing a transposition is S10. No simultaneous Galois closure of the original two endpoint maps is assumed.

It follows that Γ′Y/Γ′ has degree TEN and that Γ′Y/Y is Galois with group G′. Thus the normalized target pullback T′ is connected. Since Γ′→Γ is étale, T′→T is étale. Composing with the two ORIGINAL actual endpoint maps gives
\[
T'\longrightarrow Y\quad\text{G′-Galois finite étale},
\qquad T'\longrightarrow X\quad\text{finite étale}.
\]
These are the maps to which the packet theorem applies; the ramified map to H is not used as an étale endpoint.

If J is a TWO-group, then |G′|=80|J| has odd part FIVE and has no factor THREE. A Sylow TWO-subgroup P2 therefore has index FIVE. If P2 is abelian, the accepted [endomorphism-packet theorem](../../Theorems/jacobians/isogeny_sieves/etale_endomorphism_packets.md) excludes this actual cover of the genus-two curve Y dominating the fixed simple genus-nine X: when 3 does not divide the group order, every group with an abelian subgroup of index at most EIGHT is excluded. This yields the stated new group obstruction with no degree bound, no ordinary-cover assumption, and both actual endpoint maps retained on the same source.

## Central kernels: an exact character-degree bound

Suppose J is central, with no restriction yet on its order. Let P be the inverse image of V=C2⁴⊂Q. Then G′/P=C5, P/J=V, and commutators of P lie in the central subgroup J. Fix the central J-character λ of an irreducible complex representation of P. Its λ-isotypic central-idempotent algebra is the twisted group algebra of V, of dimension SIXTEEN. The commutator pairing
\[
b_\lambda:V\times V\longrightarrow\{1,-1\}
\]
is alternating: lifts square into J, and centrality makes each commutator have order at most TWO. Conjugation by a lift of C5 fixes J pointwise, so it preserves bλ. The actual action of C5 on V is irreducible over F2: its generator permutes the FIVE Kummer signs on the even-sign four-dimensional quotient, and the fifth cyclotomic polynomial has degree FOUR over F2. Thus the radical of bλ, being a C5-stable subspace, is either ZERO or all of V.

If the radical is all of V, the twisted group algebra is commutative and all its simple modules have dimension ONE. If the radical is zero, it is a single Mat4(C), so there is a UNIQUE λ-central-character irreducible representation of P, of dimension FOUR. That representation is C5-invariant. A C5-invariant irreducible representation extends across the cyclic quotient G′/P: choose an intertwining operator for a lift, and rescale it so its fifth power matches the representation of that lift's fifth power in P. The five resulting twists all have dimension FOUR. In the linear case Clifford theory gives dimension ONE for fixed constituents and dimension FIVE for orbits of length FIVE. Consequently
\[
\chi(1)\in\{1,4,5\}\qquad\text{for every }\chi\in\operatorname{Irr}(G').
\]
This argument works for arbitrary finite central J; it uses characteristic-zero characters, including when |J| is divisible by FIVE.

If THREE does not divide |J|, it does not divide |G′|. Every character field then has trivial intersection with the fixed endomorphism field K's maximal abelian subfield Q(ζ3). The actual packet theorem therefore requires χ(1)/eK(χ)≥NINE. The displayed character-degree bound contradicts it, excluding this central-kernel family. If THREE does divide |J|, the same accepted bound allows only χ(1)=FIVE with Q(χ) containing Q(ζ3); its inequality 9≤2·5/eK forces eK=ONE. This leaves precisely a necessary character type, not an exclusion of central THREE-torsion kernels.
