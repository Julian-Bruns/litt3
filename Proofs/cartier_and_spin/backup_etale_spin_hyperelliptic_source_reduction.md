# Proof: the hyperelliptic atlas and its actual base change

Version1,3 October2026. [Independent whole review PASS](../../Research/audits/BACKUP_ETALE_SPIN_HYPERELLIPTIC_SOURCE_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/backup_etale_spin_hyperelliptic_source_reduction.md).

The accepted [étale spin factorization](../../Theorems/cartier_and_spin/actual_spin_image_etale_factorization.md) supplies the ACTUAL representable finite étale atlas Y→[Γ/H], of degree κ/k. The [BACKUP tame uniform-atlas theorem](../../Theorems/quotient_geometry/endpoint_exclusions/backup_tame_uniform_atlases.md), applied to its genus-zero coarse map, says that this atlas is the degree-two hyperelliptic atlas. The stack structure is determined by its actual tame completed local extensions: it has six order-two points, at the hyperelliptic branch values. Thus κ/k=2 and [Γ/H] is identified with [Y/⟨ι⟩], where ι is the hyperelliptic involution.

The accepted [canonical-different extraction](../../Theorems/cartier_and_spin/actual_spin_different_etale_extraction.md) gives E⊂T, an étale upper map T→E, a faithful G action on E, and all original X-subfields in E. In the étale φ branch, E→Γ is the cyclic trivializer of the degree-zero discrepancy, of degree b∈{1,3}. In particular b divides κ. If k=1, then κ=2 forces b=1. If k=3, then κ=6; b=1 would give E=Γ, contradicting the faithful G action on E because Γ has projective kernel of order three. Therefore b=3. In both cases b=k and the tower gives deg(T/E)=κ/b=2.

When k=3, the kernel K acts trivially on Γ and faithfully on E. The cyclic étale map E→Γ has degree three, so K is its full deck group. Thus Γ=E/K as an ACTUAL quotient, and the standard quotient identity [E/G]≅[(E/K)/(G/K)] gives [E/G]≅[Γ/H]. The same identity is immediate for k=b=1.

The original equivariant étale map T→E fits the actual Cartesian square
\[
T=E\times_{[E/G]}Y,
\]
from canonical-different extraction. The hyperelliptic atlas Y→[Y/⟨ι⟩] is a torsor under the constant group C₂, even at its stacky fibers. Its base change is therefore the ACTUAL C₂-torsor T→E. Its nonidentity deck transformation j fixes E pointwise and covers ι on Y.

Every original X-field and every spin ratio belongs to E. Hence j fixes them pointwise, and every original conjugate X-map factors through E with degree d/2. Commutation can be checked directly on the Cartesian square: G acts on the E factor and trivially on the Y factor, while j is the base-changed torsor action on the Y factor. Alternatively, conjugating the unique nonidentity deck transformation of T→E by a G element gives that same transformation. An element of G∩⟨j⟩ would fix E pointwise; the faithful G action on E makes this intersection trivial.

No step here refines the X-map Galoisly. The finite group G×⟨j⟩ controls the displayed quotient stack and the Y-leg, while the degree-d/2 map E→X need not be the quotient by any subgroup of that finite group. This is exactly the missing bridge, and the two original endpoint maps have remained actual throughout.
