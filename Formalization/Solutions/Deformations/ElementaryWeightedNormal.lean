import Solutions.Deformations.WeightedNormalReduction
import Solutions.Deformations.ElementaryMixedRelation
import Solutions.Deformations.ElementaryWeightedInitial
import Mathlib.Data.Fin.VecNotation

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The exact integral relation coefficients of the original five-cycle,
viewed as a finite list of positive augmentation powers. -/
def originalFiveRelationCoefficients : Fin 4 → R := ![-1, -2, -2, -1]

theorem elementary_original_five_relation_sum (r : ℕ) (i : Fin r) :
    elementaryAugmentationParameter (R := R) 5 r i ^ 5 =
      (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) *
        ∑ l : Fin 4, originalFiveRelationCoefficients (R := R) l •
          elementaryAugmentationParameter (R := R) 5 r i ^ (l.val + 1) := by
  have relation := elementary_five_coordinate_relation (R := R) r i
  dsimp only at relation
  rw [relation]
  simp only [Fin.sum_univ_succ, Fin.sum_univ_zero, add_zero]
  let e := elementaryAugmentationParameter (R := R) 5 r i
  simp only [originalFiveRelationCoefficients, Matrix.cons_val_zero, Matrix.cons_val_succ,
    Fin.val_zero, Fin.val_succ]
  simp only [Algebra.smul_def, map_neg, map_one, map_ofNat, pow_one]
  ring

/-- The literal generated weight filtration equals the actual normal
monomial filtration under the original mixed-characteristic relations. -/
theorem elementary_five_weighted_normal_form (r d : ℕ) :
    weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
      (elementaryAugmentationParameter (R := R) 5 r) d =
    normalGeneratorFiltration R 5 (5 : AddMonoidAlgebra R (Fin r → ZMod 5))
      (elementaryAugmentationParameter (R := R) 5 r) d :=
  weighted_generator_normal_form 5 (by omega) _ _
    (fun _ => originalFiveRelationCoefficients (R := R))
    (elementary_original_five_relation_sum (R := R) r) d

/-- Original elementary normal monomials and coefficient precision
give the exact maximum weight 4(N-1)+4r, over any such coefficient ring. -/
theorem elementary_five_weighted_cutoff (r N : ℕ) (positive : 0 < N)
    (nilpotent : (5 : R) ^ N = 0) (d : ℕ) (high : 4 * (N - 1) + 4 * r < d) :
    weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
      (elementaryAugmentationParameter (R := R) 5 r) d = ⊥ := by
  have mapped := congrArg (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod 5))) nilpotent
  have vanish : (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) ^ N = 0 := by
    simpa only [map_pow, map_ofNat, map_zero] using mapped
  rw [elementary_five_weighted_normal_form]
  apply normal_generator_filtration_cutoff 5 N (by omega) positive _ vanish _ d
  simpa using high

/-- The source's actual length-(r+1) Witt elementary group algebra
has no nonzero original normal weight above 8r. -/
theorem elementary_witt_weighted_cutoff [Fact (Nat.Prime 5)] (r : ℕ) (k : Type*)
    [Field k] [CharP k 5] (d : ℕ) (high : 8 * r < d) :
    weightedGeneratorFiltration (TruncatedWittVector 5 (r + 1) k)
      (5 : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5)) 4
      (elementaryAugmentationParameter (R := TruncatedWittVector 5 (r + 1) k) 5 r) d = ⊥ := by
  letI : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
    truncated_witt_nontrivial 5 (r + 1) (by omega) k
  apply elementary_five_weighted_cutoff r (r + 1) (by omega)
    (truncated_witt_top_power_zero 5 (r + 1) k) d
  omega

end Litt3.Deformations
