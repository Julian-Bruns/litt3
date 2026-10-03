import Definitions.CartierAndSpin.LogarithmicQuotientBoundary

namespace Litt3.CartierAndSpin

variable {A B C A' B' C' : Type*}
  [AddCommGroup A] [AddCommGroup B] [AddCommGroup C]
  [AddCommGroup A'] [AddCommGroup B'] [AddCommGroup C']

/-- The map on the ORIGINAL two-leg relation quotients induced by
a genuine commuting diagram of all three actual group maps. -/
def twoLegRelationQuotientMap
    (phi : B →+ A) (psi : C →+ A) (phi' : B' →+ A') (psi' : C' →+ A')
    (a : A →+ A') (b : B →+ B') (c : C →+ C')
    (hphi : ∀ x, a (phi x) = phi' (b x))
    (hpsi : ∀ x, a (psi x) = psi' (c x)) :
    TwoLegRelationQuotient phi psi →+ TwoLegRelationQuotient phi' psi' :=
  QuotientAddGroup.map (twoLegRelationHom phi psi).range
    (twoLegRelationHom phi' psi').range a (by
      rintro x ⟨⟨y, z⟩, rfl⟩
      refine ⟨(b y, c z), ?_⟩
      change phi' (b y) - psi' (c z) = a (phi y - psi z)
      rw [map_sub, hphi, hpsi])

/-- Actual quotient-map restriction to the literal p-kernels. -/
def twoLegRelationPowerTorsionMap
    (phi : B →+ A) (psi : C →+ A) (phi' : B' →+ A') (psi' : C' →+ A')
    (a : A →+ A') (b : B →+ B') (c : C →+ C')
    (hphi : ∀ x, a (phi x) = phi' (b x))
    (hpsi : ∀ x, a (psi x) = psi' (c x)) (p : ℕ) :
    powerTorsionSubgroup (TwoLegRelationQuotient phi psi) p →+
      powerTorsionSubgroup (TwoLegRelationQuotient phi' psi') p where
  toFun q := ⟨twoLegRelationQuotientMap phi psi phi' psi' a b c hphi hpsi q.val, by
    change p • twoLegRelationQuotientMap phi psi phi' psi' a b c hphi hpsi q.val = 0
    rw [← map_nsmul, q.property, map_zero]⟩
  map_zero' := by apply Subtype.ext; exact map_zero _
  map_add' q r := by apply Subtype.ext; exact map_add _ _ _

variable {X X' : Type*} [AddCommGroup X] [AddCommGroup X']

/-- The actual target-map restriction to the shared logarithmic
images of BOTH original endpoints of a commuting diagram. -/
def sharedLogarithmicImageMap
    (phi : B →+ A) (psi : C →+ A) (phi' : B' →+ A') (psi' : C' →+ A')
    (ell : A →+ X) (ell' : A' →+ X')
    (a : A →+ A') (b : B →+ B') (c : C →+ C') (w : X →+ X')
    (hphi : ∀ x, a (phi x) = phi' (b x))
    (hpsi : ∀ x, a (psi x) = psi' (c x))
    (hell : ∀ x, w (ell x) = ell' (a x)) :
    sharedLogarithmicImage ell phi psi →+ sharedLogarithmicImage ell' phi' psi' where
  toFun omega := ⟨w omega.val, by
    obtain ⟨y, hy⟩ := omega.property.1
    obtain ⟨z, hz⟩ := omega.property.2
    refine ⟨⟨b y, ?_⟩, ⟨c z, ?_⟩⟩
    · change ell' (phi' (b y)) = w omega.val
      rw [← hphi, ← hell]
      exact congrArg w hy
    · change ell' (psi' (c z)) = w omega.val
      rw [← hpsi, ← hell]
      exact congrArg w hz⟩
  map_zero' := by apply Subtype.ext; exact map_zero w
  map_add' omega eta := by apply Subtype.ext; exact map_add w _ _

end Litt3.CartierAndSpin
