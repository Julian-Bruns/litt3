import Solutions.SharedTensors.SeparatingParameterExistence
import Solutions.SharedTensors.RationalFunctionKaehler
import Mathlib.FieldTheory.IntermediateField.Adjoin.Algebra
import Mathlib.RingTheory.Adjoin.Polynomial

namespace Litt3.SharedTensors

open Polynomial IntermediateField
open scoped IntermediateField.algebraAdjoinAdjoin

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The genuine polynomial algebra on an actual transcendental function,
including its literal embedding into the ambient field. -/
noncomputable def transcendentalPolynomialSubalgebraEquiv
    (x : K) (hx : Transcendental k x) :
    k[X] ≃ₐ[k] Algebra.adjoin k {x} :=
  (AlgEquiv.ofInjective (aeval x) (transcendental_iff_injective.mp hx)).trans
    (Subalgebra.equivOfEq _ _ (Algebra.adjoin_singleton_eq_range_aeval k x).symm)

/-- A separating actual intermediate field supplies a coordinate on the
actual full Ω_k(K). Its polynomial/fraction-field presentation is
constructed from the actual transcendental function, not supplied. -/
theorem actual_separating_element_kaehler_coordinate_exists
    (x : K) (hx : Transcendental k x)
    [Algebra.IsSeparable (IntermediateField.adjoin k {x}) K] :
    Nonempty (KaehlerDifferential k K ≃ₗ[K] K) := by
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
  exact ⟨separatingFunctionKaehlerCoordinate (k := k) (K := F) (E := K)⟩

/-- Every genuine one-variable function field over a perfect field has
its actual rank-one universal differential module. The separating
parameter and its polynomial/fraction presentation are conclusions. -/
theorem one_variable_kaehler_coordinate_exists [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    Nonempty (KaehlerDifferential k K ≃ₗ[K] K) := by
  obtain ⟨x, hx, hsep⟩ := one_variable_separating_element_exists hfg htrdeg
  letI := hsep
  exact actual_separating_element_kaehler_coordinate_exists x hx

end Litt3.SharedTensors
