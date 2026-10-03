import Mathlib.FieldTheory.SeparableDegree
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.QuotientGeometry

/-- Finite separating field extensions survive genuine simultaneous
RingEquivs of the actual downstairs and upstairs fields. Only the
literal field-inclusion square is required. -/
theorem finite_separable_extension_of_field_equivalences
    {K K' L L' : Type*} [Field K] [Field K'] [Field L] [Field L']
    [Algebra K L] [Algebra K' L']
    [FiniteDimensional K L] [Algebra.IsSeparable K L]
    (eK : K ≃+* K') (eL : L ≃+* L')
    (hcomm : ∀ a : K, eL (algebraMap K L a) = algebraMap K' L' (eK a)) :
    FiniteDimensional K' L' ∧ Algebra.IsSeparable K' L' := by
  letI : Algebra K' K := eK.symm.toRingHom.toAlgebra
  letI : Algebra K' L := ((algebraMap K L).comp eK.symm.toRingHom).toAlgebra
  letI : IsScalarTower K' K L := IsScalarTower.of_algebraMap_eq' rfl
  let eb : K' ≃ₐ[K'] K := { eK.symm with commutes' := fun _ => rfl }
  letI : FiniteDimensional K' K := eb.toLinearEquiv.finiteDimensional
  letI : Algebra.IsSeparable K' K := AlgEquiv.Algebra.isSeparable eb
  letI : FiniteDimensional K' L := Module.Finite.trans K L
  letI : Algebra.IsSeparable K' L := Algebra.IsSeparable.trans K' K L
  let e : L ≃ₐ[K'] L' := { eL with
    commutes' := fun a => by simpa using hcomm (eK.symm a) }
  exact ⟨e.toLinearEquiv.finiteDimensional, AlgEquiv.Algebra.isSeparable e⟩

end Litt3.QuotientGeometry
