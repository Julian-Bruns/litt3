import Solutions.Deformations.ToricHypersurfaceNormalization
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.RingTheory.MvPolynomial.Basic

namespace Litt3.Deformations

variable (K : Type*) [CommRing K] (Q R s : ℕ)

noncomputable def toricHypersurfaceNormalVector (a : Fin 3 →₀ ℕ) :
    ToricHypersurfaceNormalIndex Q R s →₀ K := by
  classical
  exact if h : toricHypersurfaceSurvives Q R s (toricHypersurfaceNormalize s a)
    then Finsupp.single ⟨toricHypersurfaceNormalize s a,h⟩ 1 else 0

noncomputable def toricHypersurfaceProjection :
    MvPolynomial (Fin 3) K →ₗ[K] (ToricHypersurfaceNormalIndex Q R s →₀ K) :=
  (MvPolynomial.basisMonomials (Fin 3) K).constr K (toricHypersurfaceNormalVector K Q R s)

theorem toric_hypersurface_projection_monomial (a : Fin 3 →₀ ℕ) (c : K) :
    toricHypersurfaceProjection K Q R s (MvPolynomial.monomial a c) =
      c • toricHypersurfaceNormalVector K Q R s a := by
  have mono : MvPolynomial.monomial a c = c • MvPolynomial.monomial a (1 : K) := by
    rw [MvPolynomial.smul_monomial,smul_eq_mul,mul_one]
  rw [mono,map_smul]
  congr 1
  exact (MvPolynomial.basisMonomials (Fin 3) K).constr_basis K _ a

theorem toric_hypersurface_normal_vector_relation (a : Fin 3 →₀ ℕ) :
    toricHypersurfaceNormalVector K Q R s
      (a+Finsupp.single 0 1+Finsupp.single 1 1) =
    toricHypersurfaceNormalVector K Q R s (a+Finsupp.single 2 s) := by
  unfold toricHypersurfaceNormalVector
  rw [toric_hypersurface_normalize_relation]

theorem toric_hypersurface_normal_vector_cutoff (positive : 0 < s)
    (a : Fin 3 →₀ ℕ) (i : Fin 3) :
    toricHypersurfaceNormalVector K Q R s
      (a+Finsupp.single i (if i=2 then R else Q)) = 0 := by
  classical
  have bad : ¬ toricHypersurfaceSurvives Q R s
      (toricHypersurfaceNormalize s (a+Finsupp.single i (if i=2 then R else Q))) := by
    intro h
    have bounds := toric_hypersurface_surviving_original_bounds Q R s positive _ h
    fin_cases i <;> simp_all
  unfold toricHypersurfaceNormalVector
  exact dif_neg bad

end Litt3.Deformations
