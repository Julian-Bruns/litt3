import Solutions.Jacobians.DedekindAffineDivisorSheaves
import Solutions.Jacobians.DedekindIdealOrderComparison
import Solutions.Jacobians.ActualTildeInvertibleSheaves
import Solutions.SharedTensors.DivisorSectionOrders

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry
open scoped nonZeroDivisors WithZero
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable (R : Type u) [CommRing R] [IsDedekindDomain R]

/-- The actual O(D) convention on Spec R uses the ideal for -D. -/
noncomputable def dedekindAffineSectionModule (D : Divisor (HeightOneSpectrum R)) :
    ModuleCat.{u} R := dedekindAffineDivisorModule R (-D)

noncomputable instance dedekindAffineSectionModule_invertible
    (D : Divisor (HeightOneSpectrum R)) :
    Module.Invertible R (dedekindAffineSectionModule R D) :=
  dedekindAffineDivisorModule_invertible R (-D)

noncomputable def dedekindAffineSectionSheaf (D : Divisor (HeightOneSpectrum R)) :
    (Spec (.of R)).Modules := (dedekindAffineSectionModule R D).tilde

/-- The literal ideal representing O(D) consists EXACTLY of the original
rational functions satisfying all original normalized valuation pole bounds. -/
theorem dedekind_affine_section_module_mem_iff
    (D : Divisor (HeightOneSpectrum R)) (f : FractionRing R) :
    f ∈ (dedekindDivisorIdealMap R (FractionRing R) (-D)).toMul.val ↔
      ∀ v : HeightOneSpectrum R, v.valuation (FractionRing R) f ≤ WithZero.exp (D v) := by
  by_cases hf : f = 0
  · subst f
    constructor
    · intro h v
      simp only [map_zero]
      exact bot_le
    · intro h
      exact FractionalIdeal.zero_mem _
  · let u : (FractionRing R)ˣ := Units.mk0 f hf
    change u.val ∈ (dedekindDivisorIdealMap R (FractionRing R) (-D)).toMul.val ↔ _
    rw [dedekind_divisor_ideal_mem_iff_orders]
    apply forall_congr'
    intro v
    rw [Finsupp.neg_apply, principal_divisor_coefficient]
    change -D v ≤ valuationOrder (v.valuation (FractionRing R)) (Additive.ofMul u) ↔
      v.valuation (FractionRing R) u.val ≤ WithZero.exp (D v)
    have hvalue := Litt3.SharedTensors.valuation_value_eq_exp_neg_order
      (v.valuation (FractionRing R)) (Additive.ofMul u)
    change v.valuation (FractionRing R) u.val =
      WithZero.exp (-valuationOrder (v.valuation (FractionRing R)) (Additive.ofMul u)) at hvalue
    rw [hvalue, WithZero.exp_le_exp]
    omega

/-- True finite-projective affine global-section recovery for the actual
valuation-bounded divisor ideal, with no supplied section-surjectivity. -/
noncomputable def actualDedekindAffineDivisorGlobalSectionsEquiv
    (D : Divisor (HeightOneSpectrum R)) :
    (dedekindAffineSectionModule R D).tildeInModuleCat.obj (op ⊤) ≃ₗ[R]
      dedekindAffineSectionModule R D :=
  (actualTildeProjectiveGlobalSectionsEquiv (dedekindAffineSectionModule R D)).symm

/-- These are actual locally free rank-one SHEAVES on the entire original
restricted basic-open sites, not only one-dimensional stalk modules. -/
theorem actual_dedekind_divisor_sheaf_locally_trivial
    (D : Divisor (HeightOneSpectrum R)) (x : PrimeSpectrum R) :
    ∃ r : R, x ∈ PrimeSpectrum.basicOpen r ∧ Nonempty
      ((dedekindAffineSectionSheaf R D).over (PrimeSpectrum.basicOpen r) ≅
        (SheafOfModules.unit (Spec (.of R)).ringCatSheaf).over
          (PrimeSpectrum.basicOpen r)) :=
  actual_invertible_module_sheaf_locally_trivial (dedekindAffineSectionModule R D) x

end Litt3.Jacobians
