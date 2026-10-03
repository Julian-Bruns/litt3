import Theorems.CartierAndSpin.ActualCriticalTranslationPackage

namespace Litt3.CartierAndSpin

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The whole actual algebraic source package, constructed from its
literal primitive-field presentation and degree equations, with no
desired trace, compatible basis or source quotient equivalence supplied. -/
theorem actual_critical_translation_package [CharP K 5]
    (w u : L) (F phi D U : K[X])
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hroot : aeval w F = 0) (hactualdegree : Module.finrank K L = 10)
    (hdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D) (hDdegree : D.natDegree ≤ 3)
    (hUdegree : U.natDegree ≤ 5) (hequation : aeval w U = u * aeval w D) :
    Specifications.ActualCriticalTranslationPackage w u F phi D U := by
  obtain ⟨phiUnit, DUnit, hphi, hD, houtcome⟩ := critical_trace_translation_actual_field
    w u F phi D U hgen hroot hactualdegree hdegree hsep hderivative hDdegree hUdegree hequation
  obtain ⟨phiZ, DZ, hphiZ, _hDZ, houtcomeZ⟩ := critical_trace_translation_rational_field
    w u F phi D U hgen hroot hactualdegree hdegree hsep hderivative hDdegree hUdegree hequation
  have hphiZeq : phiZ = Units.map (RatFunc.C : L →+* RatFunc L).toMonoidHom phiUnit := by
    apply Units.ext
    change (phiZ : RatFunc L) = RatFunc.C (phiUnit : L)
    rw [hphiZ, rational_constant_polynomial_aeval, hphi]
  rw [hphiZeq] at houtcomeZ
  have hF : F ≠ 0 := by
    intro hz
    simp only [hz, natDegree_zero] at hdegree
    omega
  refine ⟨phiUnit, DUnit, hphi, hD, houtcome, ?_, houtcomeZ, ?_⟩
  · intro z
    have hQ := algebra_critical_quadratic_translation F.leadingCoeff D w u phiUnit houtcome z
    refine ⟨?_, hQ, criticalResultantTranslationInvariant D U 3 5 hDdegree (by omega) z, ?_, ?_⟩
    · simp only [map_sub, map_mul, aeval_C, hequation]
      ring
    · rw [hQ]
    · intro V2 hidentity
      exact criticalSquareTranslation F (criticalQuadraticTrace F.leadingCoeff D w u phiUnit)
        D U V2 hidentity (C z)
  · exact rational_critical_quadratic_constant_extension w u F D hF hroot hgen
      (hdegree.trans hactualdegree.symm) F.leadingCoeff phiUnit

end Litt3.CartierAndSpin
