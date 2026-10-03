import Mathlib.Algebra.Field.Subfield.Basic
import Mathlib.Algebra.CharP.Frobenius
import Mathlib.LinearAlgebra.Basis.Basic

namespace Litt3.SharedTensors

open Module

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The actual subfield of p-th powers, with its inherited inclusion. -/
def frobeniusSubfield : Subfield K := (frobenius K p).fieldRange

/-- Frobenius identifies the field with its actual image, without assuming
the field itself perfect. -/
noncomputable def frobeniusImageEquiv : K ≃+* frobeniusSubfield K p :=
  (frobenius K p).rangeRestrictFieldEquiv

/-- A literal one-parameter p-basis of the actual field over its actual
p-th-power subfield. Its existence is separate from coefficient extraction. -/
structure PowerPBasis where
  parameter : K
  basis : Basis (Fin p) (frobeniusSubfield K p) K
  basis_eq_power : ∀ i, basis i = parameter ^ i.val

/-- Unique p-th roots of the coefficients in a full actual p-basis. -/
noncomputable def pRootCoefficient (b : PowerPBasis K p) (a : K) (i : Fin p) : K :=
  (frobeniusImageEquiv K p).symm (b.basis.repr a i)

/-- Coefficient extraction for a differential written as a dt. This is
the rational Cartier coordinate; parameter independence is proved separately. -/
noncomputable def rationalCartierCoefficient (b : PowerPBasis K p) (a : K) : K :=
  pRootCoefficient K p b a ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩

end Litt3.SharedTensors
