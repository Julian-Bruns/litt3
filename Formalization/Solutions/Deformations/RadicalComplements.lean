import Theorems.Deformations.RadicalComplements
import Solutions.Deformations.HermitianLeadingForms

namespace Litt3.Deformations

open LinearMap

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- Every actual reflexive form has a complementary subspace on
which it is nondegenerate. Neither finite dimension nor an
assumed nonsingular principal minor is needed for existence. -/
theorem reflexive_radical_complement (B : LinearMap.BilinForm k V) (reflexive : B.IsRefl) :
    Specifications.NondegenerateRadicalComplement B := by
  obtain ⟨U, hU⟩ := (LinearMap.ker B).exists_isCompl
  have hcompl : IsCompl U (LinearMap.ker B) := hU.symm
  refine ⟨U, hcompl, ?_⟩
  apply LinearMap.BilinForm.nondegenerate_iff_ker_eq_bot.mpr
  rw [LinearMap.BilinForm.ker_restrict_eq_of_codisjoint hcompl.codisjoint]
  · exact Submodule.disjoint_iff_comap_eq_bot.mp hcompl.disjoint
  · intro x hx y hy
    apply reflexive y x
    have hz : B y = 0 := LinearMap.mem_ker.mp hy
    exact congrArg (fun f : V →ₗ[k] k => f x) hz

/-- Determinant parity gives an even dimension for every actual
nondegenerate alternating form over a field with two nonzero. -/
theorem nondegenerate_alternating_finrank_even [FiniteDimensional k V]
    (two_ne_zero : (2 : k) ≠ 0) (B : LinearMap.BilinForm k V)
    (alternating : B.IsAlt) (nondegenerate : B.Nondegenerate) :
    Even (Module.finrank k V) := by
  classical
  let basis := Module.finBasis k V
  let A := _root_.BilinForm.toMatrix basis B
  have skew : A.transpose = -A := by
    funext i j
    change _root_.BilinForm.toMatrix basis B j i =
      -_root_.BilinForm.toMatrix basis B i j
    rw [_root_.BilinForm.toMatrix_apply, _root_.BilinForm.toMatrix_apply]
    exact (alternating.neg_eq (basis i) (basis j)).symm
  have hdet : A.det ≠ 0 :=
    (LinearMap.BilinForm.nondegenerate_iff_det_ne_zero basis).mp nondegenerate
  have heven := invertible_skew_matrix_even_size two_ne_zero A skew hdet
  simpa using heven

/-- In odd characteristic the nondegenerate part of an actual
alternating leading form has even rank. The radical is retained
as a separate block rather than discarded. -/
theorem alternating_radical_complement_even_dimension [FiniteDimensional k V]
    (two_ne_zero : (2 : k) ≠ 0) (B : LinearMap.BilinForm k V) (alternating : B.IsAlt) :
    ∃ U : Submodule k V, IsCompl U (BilinearRadical B) ∧
      (B.restrict U).Nondegenerate ∧ Even (Module.finrank k U) := by
  obtain ⟨U, hU, hnondeg⟩ := reflexive_radical_complement B alternating.isRefl
  refine ⟨U, hU, hnondeg, ?_⟩
  apply nondegenerate_alternating_finrank_even two_ne_zero (B.restrict U) _ hnondeg
  intro x
  exact alternating x.val

end Litt3.Deformations
