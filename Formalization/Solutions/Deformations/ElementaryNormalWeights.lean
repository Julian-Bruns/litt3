import Definitions.Deformations.ElementaryNormalWeights
import Solutions.Deformations.ElementaryWeightedNormal

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem elementary_normal_weights_eq (q : ℕ) (positive : 0 < q) (r d : ℕ) :
    elementaryNormalWeightFiltration R q positive r d =
      normalGeneratorFiltration R q (q : AddMonoidAlgebra R (Fin r → ZMod q))
        (elementaryAugmentationParameter (R := R) q r) d := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro x ⟨j, alpha, bound, rfl⟩
    have literal : (q : R) ^ j • elementaryAugmentationBasis q positive r alpha =
        (q : AddMonoidAlgebra R (Fin r → ZMod q)) ^ j *
          generatorMonomial (elementaryAugmentationParameter (R := R) q r)
            (fun i => (alpha i).val) := by
      simp only [elementary_augmentation_basis_apply, Algebra.smul_def, map_pow,
        map_natCast, generatorMonomial]
    rw [literal]
    exact Submodule.subset_span ⟨j, (fun i => (alpha i).val),
      (fun i => (alpha i).isLt), bound, rfl⟩
  · apply Submodule.span_le.mpr
    rintro x ⟨j, alpha, normal, bound, rfl⟩
    let beta : Fin r → Fin q := fun i => ⟨alpha i, normal i⟩
    have literal : (q : AddMonoidAlgebra R (Fin r → ZMod q)) ^ j *
        generatorMonomial (elementaryAugmentationParameter (R := R) q r) alpha =
          (q : R) ^ j • elementaryAugmentationBasis q positive r beta := by
      simp only [elementary_augmentation_basis_apply, Algebra.smul_def, map_pow,
        map_natCast, generatorMonomial, beta]
    rw [literal]
    exact Submodule.subset_span ⟨j, beta, bound, rfl⟩

/-- The actual original normal-basis weights agree with the multiplicative
generator filtration in mixed characteristic, including the integral
five-cycle corrections. -/
theorem elementary_five_normal_weights_eq (r d : ℕ) :
    elementaryNormalWeightFiltration R 5 (by omega) r d =
      weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r) d := by
  rw [elementary_normal_weights_eq, elementary_five_weighted_normal_form]
  norm_num

end Litt3.Deformations
