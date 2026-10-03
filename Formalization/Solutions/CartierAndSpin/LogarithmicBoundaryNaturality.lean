import Definitions.CartierAndSpin.TwoLegQuotientMaps
import Solutions.CartierAndSpin.LogarithmicBoundaryMap

namespace Litt3.CartierAndSpin

variable {A B C X A' B' C' X' : Type*}
  [AddCommGroup A] [AddCommGroup B] [AddCommGroup C] [AddCommGroup X]
  [AddCommGroup A'] [AddCommGroup B'] [AddCommGroup C'] [AddCommGroup X']

/-- Naturality of the CONSTRUCTED canonical torsion boundary under
a genuine diagram of BOTH endpoint maps, ambient quotient maps and
logarithmic target maps. No boundary compatibility is assumed: an
actual power-relation lift is transported and computes both sides. -/
theorem actual_logarithmic_boundary_naturality
    (phi : B →+ A) (psi : C →+ A) (phi' : B' →+ A') (psi' : C' →+ A')
    (ell : A →+ X) (ell' : A' →+ X')
    (a : A →+ A') (b : B →+ B') (c : C →+ C') (w : X →+ X')
    (hphi : ∀ x, a (phi x) = phi' (b x))
    (hpsi : ∀ x, a (psi x) = psi' (c x))
    (hell : ∀ x, w (ell x) = ell' (a x)) (p : ℕ)
    (hker : ∀ x : A, ell x = 0 ↔ ∃ r : A, p • r = x)
    (hinter : ∀ y : B, ∀ z : C, phi y = psi z → ell (phi y) = 0)
    (hker' : ∀ x : A', ell' x = 0 ↔ ∃ r : A', p • r = x)
    (hinter' : ∀ y : B', ∀ z : C', phi' y = psi' z → ell' (phi' y) = 0)
    (q : powerTorsionSubgroup (TwoLegRelationQuotient phi psi) p) :
    sharedLogarithmicImageMap phi psi phi' psi' ell ell' a b c w hphi hpsi hell
      (logarithmicBoundaryHom phi psi p ell hker hinter q) =
    logarithmicBoundaryHom phi' psi' p ell' hker' hinter'
      (twoLegRelationPowerTorsionMap phi psi phi' psi' a b c hphi hpsi p q) := by
  let L := chosenPowerRelationLift phi psi p q
  have hrep : QuotientAddGroup.mk' (twoLegRelationHom phi' psi').range
      (a L.representative) =
      (twoLegRelationPowerTorsionMap phi psi phi' psi' a b c hphi hpsi p q).val := by
    change QuotientAddGroup.mk' (twoLegRelationHom phi' psi').range (a L.representative) =
      twoLegRelationQuotientMap phi psi phi' psi' a b c hphi hpsi q.val
    rw [← L.quotient_eq]
    rfl
  have hrel : p • a L.representative = phi' (b L.left) - psi' (c L.right) := by
    rw [← map_nsmul, L.relation, map_sub, hphi, hpsi]
  have ht := logarithmicBoundaryHom_compute phi' psi' p ell' hker' hinter'
    (twoLegRelationPowerTorsionMap phi psi phi' psi' a b c hphi hpsi p q) hrep hrel
  apply Subtype.ext
  change w (ell (phi L.left)) =
    (logarithmicBoundaryHom phi' psi' p ell' hker' hinter'
      (twoLegRelationPowerTorsionMap phi psi phi' psi' a b c hphi hpsi p q)).val
  rw [ht, hell, hphi]

end Litt3.CartierAndSpin
