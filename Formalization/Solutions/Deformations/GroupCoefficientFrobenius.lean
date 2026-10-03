import Solutions.Deformations.ElementaryAugmentationBasis
import Solutions.Deformations.TruncatedWittMaps

namespace Litt3.Deformations

variable {R S G : Type*} [CommRing R] [CommRing S] [AddMonoid G]

/-- Actual coefficient-ring equivalence on the genuine group algebra,
fixing every original deck-group label. -/
noncomputable def groupCoefficientEquiv (φ : R ≃+* S) :
    AddMonoidAlgebra R G ≃+* AddMonoidAlgebra S G where
  __ := AddMonoidAlgebra.mapRangeRingHom G φ.toRingHom
  invFun := AddMonoidAlgebra.mapRangeRingHom G φ.symm.toRingHom
  left_inv x := by ext g; simp
  right_inv x := by ext g; simp

@[simp] theorem group_coefficient_equiv_apply (φ : R ≃+* S)
    (x : AddMonoidAlgebra R G) (g : G) :
    groupCoefficientEquiv (G := G) φ x g = φ (x g) :=
  AddMonoidAlgebra.mapRangeRingHom_apply _ _ _

@[simp] theorem group_coefficient_equiv_single (φ : R ≃+* S) (g : G) (r : R) :
    groupCoefficientEquiv (G := G) φ (AddMonoidAlgebra.single g r) =
      AddMonoidAlgebra.single g (φ r) :=
  AddMonoidAlgebra.mapRangeRingHom_single _ _ _

/-- Every original augmentation coordinate is fixed by the actual
coefficient automorphism. -/
@[simp] theorem group_coefficient_equiv_augmentation (φ : R ≃+* R) (q r : ℕ) (i : Fin r) :
    groupCoefficientEquiv (G := Fin r → ZMod q) φ
      (elementaryAugmentationParameter (R := R) q r i) =
        elementaryAugmentationParameter (R := R) q r i := by
  simp [elementaryAugmentationParameter]

/-- Actual Witt Frobenius on the actual elementary group algebra,
including arbitrary prime, Witt precision, and number of generators. -/
noncomputable def elementaryWittFrobenius (p N r : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p] :
    AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) ≃+*
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) :=
  groupCoefficientEquiv (truncatedWittEquiv p N (_root_.frobeniusEquiv k p))

@[simp] theorem elementary_witt_frobenius_coefficient (p N r : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p]
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (g : Fin r → ZMod p) (j : Fin N) :
    ((elementaryWittFrobenius p N r k x) g).coeff j = ((x g).coeff j) ^ p := by
  rw [elementaryWittFrobenius, group_coefficient_equiv_apply]
  simpa only [_root_.frobeniusEquiv_apply] using
    truncated_witt_map_coeff p N (_root_.frobeniusEquiv k p).toRingHom (x g) j

@[simp] theorem elementary_witt_frobenius_parameter (p N r : ℕ) [Fact p.Prime]
    (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p] (i : Fin r) :
    elementaryWittFrobenius p N r k
      (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r i) =
        elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r i :=
  group_coefficient_equiv_augmentation _ p r i

end Litt3.Deformations
