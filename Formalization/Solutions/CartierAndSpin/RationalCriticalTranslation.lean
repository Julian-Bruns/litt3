import Solutions.CartierAndSpin.RationalPrimitiveFields

namespace Litt3.CartierAndSpin

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The original five trace invariants in the literal function field
L(z)/K(z), with an independent rational indeterminate z. The full generator
and extension degree are constructed/preserved; no tensor-product-as-field
identification or presumed splitting extension is used. -/
theorem critical_trace_translation_rational_field [CharP K 5]
    (w u : L) (F phi D U : K[X])
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hroot : aeval w F = 0) (hactualdegree : Module.finrank K L = 10)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) (hequation : aeval w U = u * aeval w D) :
    ∃ phiUnit DUnit : (RatFunc L)ˣ,
      (phiUnit : RatFunc L) = aeval (RatFunc.C w) (phi.map (algebraMap K (RatFunc K))) ∧
      (DUnit : RatFunc L) = aeval (RatFunc.C w) (D.map (algebraMap K (RatFunc K))) ∧
      Specifications.AlgebraCriticalTraceTranslationOutcome (K := RatFunc K)
        (RatFunc.C w) (RatFunc.C u) phiUnit := by
  have hF : F ≠ 0 := by
    intro hz
    simp only [hz, natDegree_zero] at hdegree
    omega
  obtain ⟨pb, _hpb, _hdim⟩ := primitive_field_power_basis w F hF hroot hgen
  letI : FiniteDimensional K L := Module.Finite.of_basis pb.basis
  have hactual : Module.finrank (RatFunc K) (RatFunc L) = 10 :=
    (RatFunc.finrank_ratFunc_ratFunc K L).trans hactualdegree
  apply critical_trace_translation_actual_field
    (RatFunc.C w) (RatFunc.C u)
    (F.map (algebraMap K (RatFunc K)))
    (phi.map (algebraMap K (RatFunc K)))
    (D.map (algebraMap K (RatFunc K)))
    (U.map (algebraMap K (RatFunc K)))
    (rational_constant_generator w hgen) ?_ hactual ?_ hsep.map ?_ ?_ ?_ ?_
  · rw [rational_constant_polynomial_aeval, hroot, map_zero]
  · rw [natDegree_map_eq_of_injective (algebraMap K (RatFunc K)).injective, hdegree]
  · rw [derivative_map, hderivative, Polynomial.map_mul]
  · exact natDegree_map_le.trans hDdegree
  · exact natDegree_map_le.trans hUdegree
  · rw [rational_constant_polynomial_aeval, rational_constant_polynomial_aeval,
      hequation, map_mul]

end Litt3.CartierAndSpin
