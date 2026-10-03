import Solutions.SharedTensors.DivisorSections

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry
universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
  [ClosedPointDVRStalks X] [FinitePrincipalSupport X]
  (sX : X ⟶ Spec (.of k))

omit [FinitePrincipalSupport X] in
/-- Every actual constant has value at most one at every actual closed point.
The nonzero case uses its actual unit in the stalk, not properness. -/
theorem scheme_constant_valuation_le_one (c : k) (x : ClosedPoint X) :
    closedPointValuation X x (genericBaseFieldHom sX c) ≤ 1 := by
  by_cases hc : c = 0
  · subst c
    simp only [map_zero]
    exact bot_le
  · exact le_of_eq (scheme_constant_valuation_one sX x (Units.mk0 c hc))

/-- The actual bounded rational-function space on an actual scheme over k.
Its algebra structure is the actual map at the generic stalk. -/
noncomputable def schemeDivisorSectionSpace (D : Divisor (ClosedPoint X)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    Submodule k X.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact divisorSectionSpace (schemeDivisorSystem X) (scheme_constant_valuation_le_one sX) D

theorem mem_schemeDivisorSectionSpace_iff (D : Divisor (ClosedPoint X))
    (f : X.functionField) :
    f ∈ schemeDivisorSectionSpace sX D ↔
      ∀ x, closedPointValuation X x f ≤ WithZero.exp (D x) := Iff.rfl

theorem actual_scheme_divisor_sections_multiply
    {D E : Divisor (ClosedPoint X)} {f g : X.functionField}
    (hf : f ∈ schemeDivisorSectionSpace sX D)
    (hg : g ∈ schemeDivisorSectionSpace sX E) :
    f * g ∈ schemeDivisorSectionSpace sX (D + E) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact divisorSectionSpace_mul (schemeDivisorSystem X)
    (scheme_constant_valuation_le_one sX) hf hg

theorem actual_scheme_divisor_sections_power
    {D : Divisor (ClosedPoint X)} {f : X.functionField}
    (hf : f ∈ schemeDivisorSectionSpace sX D) (n : ℕ) :
    f ^ n ∈ schemeDivisorSectionSpace sX (n • D) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact divisorSectionSpace_pow (schemeDivisorSystem X)
    (scheme_constant_valuation_le_one sX) hf n

end Litt3.SharedTensors
