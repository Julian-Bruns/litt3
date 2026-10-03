import Solutions.Deformations.ToricHypersurfaceOriginalClasses
import Solutions.Deformations.ToricHypersurfaceProjectionKernel
import Mathlib.LinearAlgebra.Quotient.Basic
import Mathlib.LinearAlgebra.Finsupp.VectorSpace

set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [CommRing K] (Q R s : ℕ)

noncomputable def toricHypersurfaceSection :
    (ToricHypersurfaceNormalIndex Q R s →₀ K) →ₗ[K] ToricHypersurfaceAlgebra K Q R s :=
  Finsupp.linearCombination K (fun i =>
    Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
      (MvPolynomial.monomial (toricHypersurfaceExponent i.val) 1))

theorem toric_hypersurface_section_normal_vector (a : Fin 3 →₀ ℕ) :
    toricHypersurfaceSection K Q R s (toricHypersurfaceNormalVector K Q R s a) =
      Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s) (MvPolynomial.monomial a 1) := by
  classical
  unfold toricHypersurfaceNormalVector
  split_ifs with h
  · simp only [toricHypersurfaceSection,Finsupp.linearCombination_single,one_smul]
    exact (toric_hypersurface_original_monomial_normalization K Q R s a).symm
  · rw [map_zero]
    symm
    rw [toric_hypersurface_original_monomial_normalization K Q R s a]
    apply toric_hypersurface_removed_original_class K Q R s _ _ h
    simp only [toricHypersurfaceNormalize]
    omega

theorem toric_hypersurface_section_projection (f : MvPolynomial (Fin 3) K) :
    toricHypersurfaceSection K Q R s (toricHypersurfaceProjection K Q R s f) =
      Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s) f := by
  classical
  induction f using MvPolynomial.induction_on' with
  | monomial a c =>
      rw [toric_hypersurface_projection_monomial,map_smul,
        toric_hypersurface_section_normal_vector]
      change c • (Ideal.Quotient.mkₐ K (toricHypersurfaceIdeal K Q R s))
        (MvPolynomial.monomial a 1) = _
      rw [← map_smul,MvPolynomial.smul_monomial,smul_eq_mul,mul_one]
      rfl
  | add f g hf hg => simp only [map_add,hf,hg]

theorem toric_hypersurface_projection_normal_monomial
    (i : ToricHypersurfaceNormalIndex Q R s) :
    toricHypersurfaceProjection K Q R s
      (MvPolynomial.monomial (toricHypersurfaceExponent i.val) 1) = Finsupp.single i 1 := by
  classical
  rw [toric_hypersurface_projection_monomial,one_smul]
  unfold toricHypersurfaceNormalVector
  rw [toric_hypersurface_normalize_axis s i.val i.property.1]
  simp only [dif_pos i.property]

noncomputable def toricHypersurfaceQuotientProjection (positive : 0 < s) :
    ToricHypersurfaceAlgebra K Q R s →ₗ[K] (ToricHypersurfaceNormalIndex Q R s →₀ K) :=
  ((toricHypersurfaceIdeal K Q R s).restrictScalars K).liftQ
    (toricHypersurfaceProjection K Q R s)
    (toric_hypersurface_ideal_le_projection_kernel K Q R s positive) |>.comp
      (Submodule.Quotient.restrictScalarsEquiv K (toricHypersurfaceIdeal K Q R s)).symm.toLinearMap

theorem toric_hypersurface_quotient_projection_mk (positive : 0 < s)
    (f : MvPolynomial (Fin 3) K) :
    toricHypersurfaceQuotientProjection K Q R s positive
      (Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s) f) =
      toricHypersurfaceProjection K Q R s f := rfl

noncomputable def toricHypersurfaceQuotientLinearEquiv (positive : 0 < s) :
    ToricHypersurfaceAlgebra K Q R s ≃ₗ[K] (ToricHypersurfaceNormalIndex Q R s →₀ K) := by
  apply LinearEquiv.ofLinear (toricHypersurfaceQuotientProjection K Q R s positive)
    (toricHypersurfaceSection K Q R s)
  · apply (Finsupp.basisSingleOne : Module.Basis (ToricHypersurfaceNormalIndex Q R s)
      K (ToricHypersurfaceNormalIndex Q R s →₀ K)).ext
    intro i
    change toricHypersurfaceQuotientProjection K Q R s positive
      (toricHypersurfaceSection K Q R s (Finsupp.single i 1)) = Finsupp.single i 1
    simp only [toricHypersurfaceSection,Finsupp.linearCombination_single,one_smul]
    rw [toric_hypersurface_quotient_projection_mk,toric_hypersurface_projection_normal_monomial]
  · apply LinearMap.ext
    intro f
    refine Quotient.inductionOn' f ?_
    intro p
    change toricHypersurfaceSection K Q R s
      (toricHypersurfaceQuotientProjection K Q R s positive
        (Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s) p)) = _
    rw [toric_hypersurface_quotient_projection_mk]
    exact toric_hypersurface_section_projection K Q R s p

/-- Constructed basis of the ACTUAL original toric quotient. -/
noncomputable def toricHypersurfaceBasis (positive : 0 < s) :
    Module.Basis (ToricHypersurfaceNormalIndex Q R s) K (ToricHypersurfaceAlgebra K Q R s) :=
  (Finsupp.basisSingleOne).map (toricHypersurfaceQuotientLinearEquiv K Q R s positive).symm

theorem toric_hypersurface_basis_original_class (positive : 0 < s)
    (i : ToricHypersurfaceNormalIndex Q R s) :
    toricHypersurfaceBasis K Q R s positive i =
      Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
        (MvPolynomial.monomial (toricHypersurfaceExponent i.val) 1) := by
  change toricHypersurfaceSection K Q R s (Finsupp.single i 1) = _
  simp [toricHypersurfaceSection]

end Litt3.Deformations
