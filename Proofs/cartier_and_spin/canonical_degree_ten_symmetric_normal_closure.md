# Proof: primitive endpoint monodromy and the actual commuting normal closure

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_ten_symmetric_normal_closure.md). The complete scoped implication passed [root whole-scope review](../../Research/audits/CANONICAL_DEGREE_TEN_SYMMETRIC_CLOSURE_AUDIT_2026_10_03.md). Both actual endpoint maps remain onT throughout; Z→X is explicitly ramified.

Use the accepted [degree-ten normal form](canonical_degree_ten_wild_spin_carrier_exclusion.md). Its exact branch fibers are
\[
\infty:(5,5),\quad0:(2,2,2,2,2),\quad1:(2,1,1,1,1,1,1,1,1).
\]
The pole-five points have different EIGHT, the FIVE reduced zeros ofF give tame index TWO, and the only remaining ramification is the distinguished simple index-two pointP. The value atP is one, by the leading terms F²/z⁵. There is no other branch value.

## No intermediate field

A proper intermediate normalizationC would have degree split2·5. Its two maps are separating. If Y→C has degree TWO, Hurwitz gives genusC≤ONE. Genus zero makes its deck involution the hyperelliptic involution, but β changes by4by/z⁵ under that involution and is not invariant. Genus one gives an actual separating elliptic map of degree TWO, excluded on BOTH selected endpoints.

If Y→C has degree FIVE, C→B has degree TWO and again genusC≤ONE. In genus one that double cover has FOUR distinct tame branch values, all inherited byY→B, contrary to the THREE-value list. In genus zero its two branch values cannot include infinity, since every index ofY there is the odd number FIVE. They must be zero and one. But above one the local composite indices would then all be even, contradicting its EIGHT index-one sheets.

Consequently the geometric permutation monodromy on the TEN sheets is primitive. Inertia atP is a single transposition. Form the graph with an edge for every conjugate of this transposition. Its connected components are blocks. It has a nontrivial edge, so primitivity makes it connected; the edge transpositions generate S10. This proves the full symmetric monodromy without a finite-group classification.

## Exact completed fields and the commuting product

Let E be the actual Galois closure. At infinity each local Y/B field is the same Galois C5 break-one extension, by the accepted full local comparison. Therefore E/B has precisely this same wild inertia field, with different EIGHT. At zero the local field is the unique tame quadratic extension. At one the inertia is a transposition, again tame quadratic. Hurwitz gives
\[
g(E)-1=\frac{10!}{2}\left(-2+\frac85+\frac12+\frac12\right)=1088640.
\]

The intersection E∩Γ is Galois overB. Because Γ/B is unramified at one, its quotient of S10 kills a transposition. The normal closure of a transposition is S10 itself, hence E∩Γ=B. Thus Z=ΓE has actual commuting G×S10 action. It is the Galois closure overΓ of the actual base-changed degree-ten extension T=ΓY. Its S9 stabilizer quotient is T.

At zero and infinity, Γ/B has the very same completed extension just described forE/B. Normalized base change cancels the local ramification, so Z→E is étale there. At one Γ/B is unramified, and elsewhere both covers are unramified. Hence Z→E is an actual connected finite étale Galois cover with groupG.

The other projection Z→T is different. OverP at one, Y/B already has the quadratic inertia field and E→Y is unramified. But over the other EIGHT unramified Y sheets, E→Y has index TWO. These indices persist after the étale Γ base change. Therefore Z→T, and its composition with the actual T→X étale leg, are ramified. No presumed simultaneous étale Galois closure has been used.

## Every étale target refinement retains degree ten

For a connected finite étale Γ′→Γ take the B-Galois closure Γ″ of its field. Since Γ/B is Galois, Γ″ is the compositum of finitely many conjugate covers that are étale overΓ. It is therefore still étale overΓ, and Γ″/B is branched only at zero and infinity. Its intersection withE is B by the same transposition argument. Thus Γ″ andY are linearly disjoint. The same holds forΓ′. Consequently T×Γ Γ′ is connected of degree TEN overΓ′. An original rational-frame different coefficient a generating T/Γ still generates its refined field overΓ′.

This applies, in particular, to the Humbert target refinement and its sixteen-torsion spin refinement. Restoring a B-Galois action may require taking Γ″ and can increase the refinement degree; no new numerical bound for that further closure is asserted.

## The exact characteristic-zero permutation sector

The actual pullback v:JX→JZ is fixed by S9, since its map toX factors throughT=Z/S9. In Hom⁰(JX,JZ), with the right action of K=End⁰(JX), its S10 orbit is therefore a quotient of K[S10/S9]. This permutation module splits in characteristic ZERO as the trivial line plus the absolutely irreducible standard module of dimension NINE. These are its only possible constituents. Averaging is the actual trace correspondence throughΓ. The accepted vanishing of traced distinguished differentials does not prove that this Jacobian correspondence is zero, so no such conclusion is imported.

Reduction modulo characteristic FIVE is not semisimple: the standard augmentation lattice has a constant submodule and an eight-dimensional quotient, while its dual reverses that extension. A rational permutation-sector calculation alone cannot choose the geometric lattice or force the S9-fixed actual X forms to be S10-invariant. In particular it does not prove that they descend toΓ, and it imposes no unsupported divisibility by NINE on dim(JT/JΓ).
