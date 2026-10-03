# Proof: retaining the quarter-canonical lattice on the actual cyclic refinement

Version1,3 October2026. [Independent whole-scope review PASS](../../Research/audits/POSITIVE_COEFFICIENT_ROW_CYCLIC_NORMALIZATION_BOUND_AUDIT_2026_10_03.md). See the [statement and original-source scope](../../Theorems/cartier_and_spin/positive_coefficient_row_cyclic_normalization_bound.md). No calculation or new source search is used.

## The coefficient target and its actual discrepancy root

Use the accepted [row geometry Version5](positive_finite_coefficient_row_geometry.md). The curve C is the actual entire coefficient quotient of the original T, and C→Y is R-Galois étale. Its row normalization φ:C→D is étale, R acts faithfully on D, and the actual embedded Cartier bundle descends:
\[
q_C^*J=P\otimes V=\varphi_1^*(Q\otimes V),
\qquad J_D=Q\otimes V\hookrightarrow B_D.
\tag{1}
\]
The adjoint evaluation is everywhere surjective. Faithfulness on D gives the embedded-field equality
\[
k(C)=k(Y)k(D).
\tag{2}
\]
Indeed C/Y is actually Galois, and the subgroup fixing D is trivial.

All line formulas below are on the first relative Frobenius twists, unless a Frobenius pullback is displayed. Put
\[
N_D=Q^8\omega_{D^{(1)}}^{-1}.
\]
On the original T this pulls back to L¹⁶ω_T⁻¹=O. An order-FIVE line cannot be killed by separable pullback, by the accepted logarithmic-differential argument; consequently N_D is finite prime-to-FIVE torsion. Let b be its exact order. The connected cyclic trivializer D′→D selected by its ACTUAL trivialization in T is étale of degree b and is an embedded intermediate target of T. Its pulled line Q′ satisfies
\[
(Q')^8=\omega_{D'^{(1)}}.
\tag{3}
\]
The original action preserves N_D and the selected root field: conjugate trivializations on the proper connected T differ by constants. Hence D′ is stable under the original source group. Set C′=C D′=Y D′ INSIDE T. Then C′→Y is actual G′-Galois étale, C′→D′ is étale, and G′ acts faithfully on D′ by the last field equality. The original X-map is retained on T; no downward X-map is used.

On C′ the pulled original embedding, its evaluation, and (1) remain exact. The finite coefficient image is still R. Choose determinant-one coefficient lifts A_g. The paired line lifts B_g on Q′ are specified by the genuine action on q_{C′}*J, and
\[
B_g^4=\text{native action on }q_{C'}^*\det J.
\tag{4}
\]
Faithful pullback to C′ transports these lifts from D′; properness removes only constant discrepancies. Thus (4), its eighth power, and the actual embedding are retained, rather than an arbitrarily chosen spin linearization.

## The precise half-spin carrier lemma used here

We use the following retained-data version of the accepted étale carrier arguments. Let S→Y be a finite Galois étale cover with group A, S→Z an A-equivariant finite étale map, A faithful on Z, and S=YZ as embedded fields. Suppose on Z₁ there is an A-invariant line Q_Z with Q_Z⁸=ω_Z₁ and an actual embedded rank-four bundle Q_Z⊗V⊂B_Z whose pullback is q_S*J. Require its adjoint evaluation surjective, its native fourth-power line action to be exactly q_S*detJ, and its finite projective coefficient kernel to act freely on Z. Then
\[
\deg(S\longrightarrow Z)=1.
\tag{5}
\]
This formulation requires no X-map on S or Z. The verification of every input removed from the original-spin formulation follows.

Write e=deg(S→Z), n=g(Z)−ONE. Étale Hurwitz gives |A|=en and degQ_Z=n/FOUR. The paired determinant-one lifts on V and line lifts on Q_Z compare their eighth tensor power with the genuine canonical action on ω_Z₁. This gives the same character χ as in the accepted [determinant-character proof](etale_spin_determinant_character_and_even_degree.md). Its local proof uses Q_Z⁸, B_g⁴ and B_g^m=c⁻¹, not a sixteenth root of Q_Z. Therefore χ₂ detects every even target stabilizer faithfully, e₂ divides |χ₂(A)|, and e>ONE implies Z/A=P¹ and |χ₂(A)|=e₂. The elliptic alternative is an actual Y→Z/A map of degree at mostFOUR, excluded by the selected endpoint inputs. If χ₂ is trivial, the actual odd-uniform atlas theorem on Y gives e=ONE.

Every stabilizer acts freely on the complete étale S→Z fiber, so its order divides e. The genuinely linearized Q_Z⁴ has degree n; Hilbert90 invariant rational sections give the same stabilizer identity
\[
\operatorname{lcm}(|A_z|)=e.
\tag{6}
\]
Neither step needs any original infinity section: its role in the original proofs was to construct Q_Z and the native fourth-power action, supplied here explicitly.

The complete tame [signature proof](tame_etale_positive_full_spin_signature_reduction.md) now applies literally from its first section onward. Its two special four-value deletions use only actual Y-maps: signature2244 contradicts Aut(Y)=C₂; signature2226 uses a sign double of Y and the accepted absence of Y→elliptic maps of degree at mostTWELVE, followed by the genus-three bielliptic geometry. Signature2233 is deleted by the accepted universal quadrangular genus-two theorem. The MAIN triangle deletion uses only the bounded endpoint three-branch theorem; BACKUP uses only its complete tame uniform-atlas theorem. Thus a nonidentity tame carrier has e=TWO. The [embedded quadratic-field proof](etale_spin_quadratic_determinant_character_exclusion.md) then applies because S=YZ is an explicit hypothesis: Z/kerχ₂ and Y are the SAME quadratic field over the SAME rational base with the SAME six branch values. It forces Y⊂Z and contradicts e=TWO.

For wild carriers, every local proof in the accepted [whole wild exclusion Version3](etale_positive_full_wild_inertia_reduction.md) uses only the data above. We spell out the two places where the original spin/source inputs occurred. First, its actual J_Z embedding and evaluation are supplied here, so the total Cartier defect is THREE n; faithful coefficient inertia follows from the explicitly required free kernel. This gives the depth bound I₂₀=ONE exactly as there. The doubled-area, equal TWO-parts, single-jump, abelian Hasse–Arf and nonabelian residue arguments then use only (6), χ₂, that lattice budget and the local ramification constraints.

Second, the cyclic-FIVE terminal row uses H=kerχ₂, |H|=FIVE n, and inertia onlyC₅ on Z→Z/H=P¹. A genuinely H-linearized line has degree divisible by n. Since degQ_Z=n/FOUR and Q_Z⁴ has the genuine action (4), its obstruction has EXACT orderFOUR. Thus every invariant subspace of V has dimension divisible byFOUR, and V|_H is irreducible. This replaces precisely the original proof's order-EIGHT obstruction for M and its squaring; it does not require M to exist. The prescribed cyclic local lifting, Scott inequality, field-FIVE normalizer, central involution, exact length-TWO lattice and defect≥FOUR n contradiction of the [cyclic-FIVE proof](wild_cyclic_five_etale_positive_full_exclusion.md) are consequently unchanged. Its h=TWO/FOUR preliminary rows use the actual cyclic étale covers of Y and the accepted selected ordinarity inputs; they do not use a map to X. This verifies the complete wild deletion with the retained half-spin data.

Hence no wild or nonidentity tame case remains, proving (5). This is a hypothesis-by-hypothesis reuse of the established proofs; an arbitrary positive bundle without these line, embedding, free-kernel and embedded-field data is outside the lemma.

## Application to the actual discrepancy refinement

Apply the lemma with S=C′, Z=D′ and Q_Z=Q′. The finite coefficient kernel is free on D′: it fixes the original row D, while D′→D is étale, so a kernel element fixing a point is an identity deck transformation. Faithfulness of G′ on D′ then makes that element trivial. All other data were established in (1)–(4). Therefore
\[
C'=D'.
\tag{7}
\]
The cyclic deck group μ_b of D′/D is central in the group of lifts of R: an automorphism of a cyclic root line cover preserves its character and commutes with scalar root multiplication. In particular μ_b commutes with G′ on C′. Put J′=Gal(C′/C). Because C′=C D′, J′=μ_b∩G′. The residual group μ_b/J′ acts faithfully on
\[
Y=C'/G'.
\]
Its order is b/|J′|=deg(C→D). The accepted Aut(Y)=C₂ therefore gives degree ONE orTWO, and C→D is the corresponding cyclic étale cover. This is a bound on the actual coefficient row; it neither replaces T nor supplies an X-map on C′.

## The genuine double and the theta determinant

In the double case its deck involution σ is induced by the central μ_b action. It commutes with R and induces the unique nontrivial automorphism ι_Y of Y. The equality J_C=φ₁*J_D of actual embedded bundles gives a canonical σ-pullback identification preserving the Cartier embedding. Its R-equivariance descends through C→Y to an actual identification
\[
\iota_Y^*J\simeq J.
\]
Taking determinants gives ι_Y*detJ=detJ. For a degree-ONE line H on a genus-two curve, the hyperelliptic relation is ι_Y*H=ω_Y⊗H⁻¹. Thus (detJ)²=ω_Y, with the Frobenius targets as stated. No invariance of the original spin isomorphism, character averaging, or descent of the original X-map has been assumed.
