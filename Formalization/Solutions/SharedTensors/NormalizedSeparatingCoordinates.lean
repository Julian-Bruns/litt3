import Solutions.SharedTensors.OneVariableKaehler

namespace Litt3.SharedTensors

open Polynomial IntermediateField
open scoped IntermediateField.algebraAdjoinAdjoin

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- A coordinate normalized at the original actual separating element.
The polynomial presentation and normalization are both constructed. -/
theorem normalized_separating_element_coordinate_exists
    (x : K) (hx : Transcendental k x)
    [Algebra.IsSeparable (IntermediateField.adjoin k {x}) K] :
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      e (KaehlerDifferential.D k K x) = 1 := by
  let A := Algebra.adjoin k {x}
  let F := IntermediateField.adjoin k {x}
  let eA := transcendentalPolynomialSubalgebraEquiv x hx
  let f : k[X] →ₐ[k] F := (IsScalarTower.toAlgHom k A F).comp eA.toAlgHom
  letI : Algebra k[X] F := f.toRingHom.toAlgebra
  letI : IsScalarTower k k[X] F :=
    IsScalarTower.of_algebraMap_eq (fun c => (f.commutes c).symm)
  letI : IsFractionRing k[X] F :=
    (IsFractionRing.isFractionRing_iff_of_base_ringEquiv
      (S := F) eA.symm.toRingEquiv).mp inferInstance
  let e := separatingFunctionKaehlerCoordinate (k := k) (K := F) (E := K)
  refine ⟨e, ?_⟩
  have hparameter : algebraMap F K (algebraMap k[X] F X) = x := by
    change algebraMap F K (algebraMap A F (eA X)) = x
    rw [← IsScalarTower.algebraMap_apply A F K]
    change (eA X : K) = x
    change (aeval x X) = x
    simp
  rw [← hparameter]
  exact separatingFunctionKaehlerCoordinate_parameter

/-- The actual separating parameter in a finitely generated one-variable
field has nonzero universal differential; no p-basis is presumed. -/
theorem one_variable_normalized_coordinate_exists [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    ∃ (x : K) (e : KaehlerDifferential k K ≃ₗ[K] K),
      Transcendental k x ∧
      Algebra.IsSeparable (IntermediateField.adjoin k {x}) K ∧
      e (KaehlerDifferential.D k K x) = 1 := by
  obtain ⟨x, hx, hsep⟩ := one_variable_separating_element_exists hfg htrdeg
  letI := hsep
  obtain ⟨e, he⟩ := normalized_separating_element_coordinate_exists x hx
  exact ⟨x, e, hx, hsep, he⟩

end Litt3.SharedTensors
