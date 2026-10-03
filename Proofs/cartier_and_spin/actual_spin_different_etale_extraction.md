# Proof: simple different zeros, exact differential ratios and odd local stabilizers

[Statement](../../Theorems/cartier_and_spin/actual_spin_different_etale_extraction.md). [Independent whole-implication review: PASS](../../Research/audits/ACTUAL_SPIN_DIFFERENT_ETALE_EXTRACTION_AUDIT_2026_10_02.md). The only source replacement is the already constructed ACTUAL minimal one-leg Galois spin source T. Both original endpoint maps remain actual and finite étale. The accepted full elliptic-image exclusion and critical-divisor table leave either an étale φ or a tame index-two φ whose different is exactly one reduced q-fiber qP.

## The canonical section and its field

Let α:φ*M¹⁶→ωT be the actual common spin identification. The canonical differential map φ*ωΓ→ωT, interpreted through α, is a section s ofφ*N, N=M¹⁶ωΓ^-1, with zero divisor precisely the different R_φ. It has the genuine G-invariance from canonical-linearization transport: correct each projective M¹⁶ lift by the global scalar comparing its pullback with the canonical G action on the proper connected T. Faithful pullback checks the cocycle downstairs, and naturality of the differential map makes s invariant.

A rational nonzero N-frame v defines a=s/φ*v. Changing v multiplies a by a nonzero rational Γ-function and therefore leaves k(Γ)(a) unchanged. This field is G-stable: s is G-invariant, while a frame is changed by a rational function ofΓ. Let E be its smooth projective normalization, with factorization T→E→Γ.

## The upper actual map is étale

Away from R_φ the composite φ is étale, hence its upper factor ψ:T→E is étale by local ramification multiplicativity. At a point t∈R_φ choose v a unit at its target. The zero order of a at t is ONE, because R_φ is reduced. In the tower T→E, the order formula is ord_t(a)=e_ψ(t)·ord_(ψt)(a). Both integers are positive, so e_ψ(t)=1. Thus ψ is unramified at every point. Finite maps of smooth projective curves are flat, and ψ is separating as an intermediate in a separating extension. Therefore it is finite étale.

In the étale φ case this conclusion is immediate at every point, with no ramified support needed. No Galois closure overΓ is assumed.

## Every actual theta form descends directly

For an original infinity section u_i descended fromM, put ξ_i=u_i¹⁶/v. This is a rational DIFFERENTIAL onΓ, since M¹⁶/N=ωΓ. The definitions of α and s give the exact identity of actual rational differentials onT:
\[
\varphi^*\xi_i=a\,\theta_i.
\]
Indeed the canonical pullback ofξ_i multiplies the corresponding pulled line section by the different section s=aφ*v. Consequently θ_i is the pullback throughψ of χ*ξ_i/a, where χ:E→Γ is the lower factor. This is a rational differential onE. It is REGULAR: any pole downstairs would remain a pole under the actual finite étale ψ, whereas θ_i is regular onT.

The accepted differential field reconstruction for fixed X applies to this descended θ_i in the separating intermediate E. Explicitly C(θ)/θ and d(C(θ)/θ)/θ have coprime function degrees13 and30 onX, so their common field is the entire actual X field. Cartier commutes with separating pullback. Therefore every h_i*k(X) lies in k(E). Each original h_i factors through E→X. Since ψ and its composite h_i are actual finite étale, the lower factor is finite étale as well. Its degree is d/e.

The common canonical identification also descends EXACTLY. The section s descends as a rational section s_E ofχ*N, and its zero divisor is R_χ because ψ is étale. The canonical different section forχ is a section ofωE⊗χ*ωΓ^-1 with the SAME zero divisor. Sending s_E to that canonical section gives an actual nowhere-degenerate isomorphism χ*N≅ωE⊗χ*ωΓ^-1, hence χ*M¹⁶≅ωE. Its pullback is the original α because both send the same canonical different section to the same actual differential map. Thus the descended θ_i have the original common normalization; no new cyclic correction onE is needed.

## Exact identity with one original X field

Fix i and form the actual compositum F_i=k(Γ)·h_i*k(X) inside k(T). Its upper map T→normalization(F_i) is finite étale because F_i contains the actual X field and lies in its finite étale source extension. Both ξ_i, coming fromΓ, and θ_i, coming fromX_i, are nonzero rational differentials in Ω_(F_i). Their ratio belongs to F_i. The exact identity above therefore gives a∈F_i, so k(E)⊂F_i.

Conversely E containsΓ and every original X_i field by reconstruction, so F_i⊂k(E). Hence k(E)=F_i for EVERYi. This is an equality of actual embedded source fields, not an abstract isogeny identification.

It also proves G-stability independently of the rational-frame argument: gF_i=F_(gi)=k(E). On the minimal spin source, an element fixing E pointwise fixes all actual X fields and the image fieldΓ containing every u_i/u_0 ratio. Together with the Y field these are exactly the defining minimal source generators. Thus such an element is the identity; the G action onE is faithful.

Passing to quotient stacks in the actual equivariant finite étale map ψ gives Y=[T/G]→[E/G], representable finite étale of degreee. Its base change along the E atlas is precisely the ORIGINAL ψ:T→E. The faithful field action gives k(T)=k(Y)k(E) and the actual common pullback over[E/G]. E→X is actual étale, but this does not descend X to that stack or put k(Y) inside k(E).

## In the ramified branch the upper degree is odd

Suppose R_φ=qP, with tame index two there. At a target point z under qP, let r be the number of its ramified source points. Since s descendsE and ψ is étale, its zero points in this fiber occur in FULL ψ-fibers of sizee. Hence e divides r.

Choose one such zero point w∈E and a t∈T over it. All e points in ψ^-1(w) lie in the single actual q-fiber qP. Since qP is a G-torsor and ψ is equivariant, the stabilizer G_w acts freely and transitively on that ψ-fiber. Thus |G_w|=e.

If e were even, choose an involution g∈G_w. Its action onE is nontrivial by faithfulness, and its action onΓ is also nontrivial because the projective kernel onΓ has order one or three. It fixes w and z=χw. Both actual involutions have tangent multiplier−1, as the characteristic is five. But χ has local index TWO atw, since ψ is étale andφ has that index. Equivariance makes the target multiplier the square of the source multiplier, namely+1. This contradicts−1. Therefore e is ODD.

In particular r=1 forces e=1. The field E is then the entire actual source field, so no proper étale upper factor can hide the different generator. In all cases this extraction preserves the actual maps, but no bound on the odd e or on the original source degree is proved.

The shared stack is an ACTUAL endpoint-Y atlas and has an actual étale X carrier E. X itself is not shown to be an atlas of it, so the original unmarked common-cover problem remains UNSOLVED.
