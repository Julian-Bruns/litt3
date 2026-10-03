import Solutions.Deformations.NilpotentResidueBasis
import Mathlib.LinearAlgebra.Finsupp.Defs
import Mathlib.LinearAlgebra.Basis.Defs

namespace Litt3.Deformations

variable {R S I M V : Type*} [CommRing R] [CommRing S]
    [AddCommGroup M] [Module R M] [AddCommGroup V] [Module S V]

/-- A lifted residue basis intertwines every actual finite linear
combination, through the literal coefficient residue map. -/
theorem lifted_residue_linear_combination (φ : R →+* S)
    (q : M →ₛₗ[φ] V) (basis : Module.Basis I S V) (lift : I → M)
    (relation : ∀ i, q (lift i) = basis i) (c : I →₀ R) :
    basis.repr (q (Finsupp.linearCombination R lift c)) = c.mapRange φ φ.map_zero := by
  have operator : q.comp (Finsupp.linearCombination R lift) =
      basis.repr.symm.toLinearMap.comp (Finsupp.mapRange.linearMap φ.toSemilinearMap) := by
    apply Finsupp.lhom_ext
    intro i r
    simp [relation]
  have applied := LinearMap.congr_fun operator c
  change q (Finsupp.linearCombination R lift c) = basis.repr.symm (c.mapRange φ φ.map_zero) at applied
  rw [applied]
  exact basis.repr.apply_symm_apply _

theorem lifted_residue_independent (φ : R →+* S)
    (q : M →ₛₗ[φ] V) (basis : Module.Basis I S V) (lift : I → M)
    (relation : ∀ i, q (lift i) = basis i) (c : I →₀ R)
    (zero : q (Finsupp.linearCombination R lift c) = 0) :
    ∀ i, φ (c i) = 0 := by
  have residue := lifted_residue_linear_combination φ q basis lift relation c
  rw [zero, map_zero] at residue
  intro i
  have coordinate := congrArg (fun v : I →₀ S => v i) residue
  simpa using coordinate.symm

theorem lifted_residue_spanning (φ : R →+* S) (surjective : Function.Surjective φ)
    (q : M →ₛₗ[φ] V) (basis : Module.Basis I S V) (lift : I → M)
    (relation : ∀ i, q (lift i) = basis i) (x : M) :
    ∃ c : I →₀ R, q (Finsupp.linearCombination R lift c) = q x := by
  obtain ⟨c, reduction⟩ := Finsupp.mapRange_surjective φ φ.map_zero surjective (basis.repr (q x))
  refine ⟨c, ?_⟩
  apply basis.repr.injective
  rw [lifted_residue_linear_combination φ q basis lift relation c, reduction]

end Litt3.Deformations
