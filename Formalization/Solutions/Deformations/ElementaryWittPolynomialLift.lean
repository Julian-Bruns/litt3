import Solutions.Deformations.PolynomialCoefficientLift
import Solutions.Deformations.ElementaryWittInitialCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- Literal unchanged-generator polynomial lifting by actual
Teichmüller coefficients, with no coefficient ring section. -/
noncomputable def elementaryWittPolynomialLift (r : ℕ) (f : MvPolynomial (Fin r) k) :
    AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) :=
  polynomialCoefficientLift (fun c => WittVector.truncate N (WittVector.teichmuller 5 c))
    (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r) f

theorem elementary_witt_polynomial_lift_reduction (r : ℕ) (f : MvPolynomial (Fin r) k) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
      (truncatedWittResidue 5 N (Fact.out : 0 < N) k) (elementaryWittPolynomialLift N k r f) =
      f.eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod 5)))
        (elementaryAugmentationParameter (R := k) 5 r) := by
  apply polynomial_coefficient_lift_group_reduction
  intro c
  rw [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]

theorem elementary_witt_polynomial_lift_weight (r d : ℕ) (f : MvPolynomial (Fin r) k)
    (degrees : ∀ m, f.coeff m ≠ 0 → d ≤ ∑ i, m i) :
    elementaryWittPolynomialLift N k r f ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d := by
  rw [elementary_five_normal_weights_eq]
  exact polynomial_coefficient_lift_weight _ _ _ _ f d degrees

theorem elementary_witt_homogeneous_polynomial_lift_weight (r d : ℕ)
    (f : MvPolynomial (Fin r) k) (homogeneous : f.IsHomogeneous d) :
    elementaryWittPolynomialLift N k r f ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d := by
  apply elementary_witt_polynomial_lift_weight
  intro m nonzero
  have weight := homogeneous nonzero
  change (Finsupp.weight (fun _ : Fin r => (1 : ℕ))) m = d at weight
  rw [← Finsupp.degree_eq_weight_one, Finsupp.degree_eq_sum] at weight
  exact weight.ge

end Litt3.Deformations
