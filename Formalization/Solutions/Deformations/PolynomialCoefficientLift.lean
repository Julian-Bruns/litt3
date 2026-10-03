import Definitions.Deformations.PolynomialCoefficientLift
import Solutions.Deformations.WeightedGeneratorFiltration
import Solutions.Deformations.GroupCoefficientMaps
import Solutions.Deformations.TruncatedWittResidue
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.RingTheory.MvPolynomial.Homogeneous

namespace Litt3.Deformations

open scoped BigOperators

variable {k R A I : Type*} [CommRing k] [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

/-- Any chosen coefficient lift of terms of the required original
degree belongs to the genuine generated source weight. -/
theorem polynomial_coefficient_lift_weight (lift : k → R) (p : A) (w : ℕ) (e : I → A)
    (f : MvPolynomial I k) (d : ℕ)
    (degrees : ∀ m, f.coeff m ≠ 0 → d ≤ ∑ i, m i) :
    polynomialCoefficientLift lift e f ∈ weightedGeneratorFiltration R p w e d := by
  classical
  apply Submodule.sum_mem
  intro m hm
  apply Submodule.smul_mem
  have normal : generatorMonomial e (fun i => m i) ∈ weightedGeneratorFiltration R p w e d := by
    simpa only [pow_zero, one_mul, Nat.mul_zero, Nat.zero_add, generatorMonomialWeight] using
      weighted_generator_member (R := R) p w e d 0 (fun i => m i)
        (by simpa only [Nat.mul_zero, Nat.zero_add, generatorMonomialWeight] using
          degrees m (MvPolynomial.mem_support_iff.mp hm))
  exact normal

variable [Nontrivial R] [Nontrivial k]

/-- Literal original polynomial coefficient lifts reduce to their
actual polynomial evaluation in the unchanged group algebra. -/
theorem polynomial_coefficient_lift_group_reduction (φ : R →+* k) (lift : k → R)
    (residue : ∀ c, φ (lift c) = c) (q r : ℕ) (f : MvPolynomial (Fin r) k) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) φ
      (polynomialCoefficientLift lift (elementaryAugmentationParameter (R := R) q r) f) =
      f.eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod q)))
        (elementaryAugmentationParameter (R := k) q r) := by
  classical
  let map := groupCoefficientLinear (G := Fin r → ZMod q) φ
  change map (polynomialCoefficientLift lift _ f) = _
  rw [polynomialCoefficientLift, map_sum, MvPolynomial.eval₂_eq']
  apply Finset.sum_congr rfl
  intro m _
  rw [map_smulₛₗ, residue, group_coefficient_linear_apply]
  simp only [generatorMonomial, map_prod, map_pow, group_coefficient_map_parameter, Algebra.smul_def]

end Litt3.Deformations
