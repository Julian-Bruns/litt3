import Solutions.CartierAndSpin.ActualCriticalTranslationPackage

namespace Litt3.CartierAndSpin

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The full literal translation package in the independent rational
field extension L(z)/K(z). In particular its resultants and square identity
are invariant for the actual indeterminate z, not merely for z∈K. -/
theorem independent_rational_critical_translation_package [CharP K 5]
    (w u : L) (F phi D U : K[X])
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hroot : aeval w F = 0) (hactualdegree : Module.finrank K L = 10)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) (hequation : aeval w U = u * aeval w D) :
    Specifications.ActualCriticalTranslationPackage
      (K := RatFunc K) (RatFunc.C w) (RatFunc.C u)
      (F.map (algebraMap K (RatFunc K)))
      (phi.map (algebraMap K (RatFunc K)))
      (D.map (algebraMap K (RatFunc K)))
      (U.map (algebraMap K (RatFunc K))) := by
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, natDegree_zero] at hdegree
    omega
  obtain ⟨pb, _hpb, _hdim⟩ := primitive_field_power_basis w F hF hroot hgen
  letI : FiniteDimensional K L := Module.Finite.of_basis pb.basis
  letI : CharP (RatFunc K) 5 :=
    charP_of_injective_algebraMap (algebraMap K (RatFunc K)).injective 5
  apply actual_critical_translation_package
    (RatFunc.C w) (RatFunc.C u)
    (F.map (algebraMap K (RatFunc K)))
    (phi.map (algebraMap K (RatFunc K)))
    (D.map (algebraMap K (RatFunc K)))
    (U.map (algebraMap K (RatFunc K)))
    (rational_constant_generator w hgen)
  · rw [rational_constant_polynomial_aeval, hroot, map_zero]
  · rw [RatFunc.finrank_ratFunc_ratFunc, hactualdegree]
  · rw [natDegree_map_eq_of_injective (algebraMap K (RatFunc K)).injective, hdegree]
  · exact hsep.map
  · rw [derivative_map, hderivative, Polynomial.map_mul]
  · rw [natDegree_map_eq_of_injective (algebraMap K (RatFunc K)).injective]
    exact hDdegree
  · rw [natDegree_map_eq_of_injective (algebraMap K (RatFunc K)).injective]
    exact hUdegree
  · rw [rational_constant_polynomial_aeval, rational_constant_polynomial_aeval,
      hequation, map_mul]

end Litt3.CartierAndSpin
