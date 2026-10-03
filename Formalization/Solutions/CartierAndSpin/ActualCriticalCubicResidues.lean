import Solutions.CartierAndSpin.CriticalCubicResidueIncidence
import Solutions.CartierAndSpin.ActualDegreeTenCriticalIncidence

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The original actual source yields the three critical residue
equations, with both quotient denominator units and the critical
representative constructed. Only the original source/numerator data are
inputs; no trace identity, root splitting or critical incidence is assumed. -/
theorem actual_degree_ten_critical_cubic_residues (F phi D U : K[X])
    (hFdegree : F.natDegree = 10) (hsep : F.Separable)
    (hderivative : F.derivative = phi * D)
    (hUdegree : U.natDegree ≤ 5) (hDdegree : D.natDegree = 3)
    (u : AdjoinRoot F) (hequation : AdjoinRoot.mk F U = u * AdjoinRoot.mk F D) :
    ∃ (phiUnit : (AdjoinRoot F)ˣ) (criticalUnit : (AdjoinRoot D)ˣ) (P : K[X]),
      (phiUnit : AdjoinRoot F) = AdjoinRoot.mk F phi ∧
      (criticalUnit : AdjoinRoot D) = AdjoinRoot.mk D F ∧
      P.degree < D.degree ∧
      AdjoinRoot.mk D P = AdjoinRoot.mk D (U ^ 2) * (↑criticalUnit⁻¹ : AdjoinRoot D) ∧
      (∀ j : ℕ, j < 3 → polynomialResidueMoment D P j =
        (if j = 2 then F.leadingCoeff *
          (Algebra.trace K (AdjoinRoot F)
            (u * AdjoinRoot.root F ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F))) ^ 2 /
              D.coeff 3 else 0) -
        Algebra.trace K (AdjoinRoot F)
          (u ^ 2 * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F))) := by
  obtain ⟨phiUnit, DUnit, V2, hphi, _hDunit, _hVdegree, _hVvalue, hidentity⟩ :=
    actual_degree_ten_critical_incidence F phi D U hFdegree hsep hderivative
      hUdegree hDdegree.le u hequation
  have hcoprime : IsCoprime F D := by
    obtain ⟨a, b, hab⟩ := hsep
    refine ⟨a, b * phi, ?_⟩
    rw [hderivative] at hab
    simpa only [mul_assoc] using hab
  obtain ⟨criticalUnit, P, hcritical, hP, hvalue, hequivalence⟩ :=
    critical_cubic_residue_representative_exists F D U hDdegree hcoprime
  let rho := Algebra.trace K (AdjoinRoot F)
    (u * AdjoinRoot.root F ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F))
  let mu := fun j => Algebra.trace K (AdjoinRoot F)
    (u ^ 2 * AdjoinRoot.root F ^ j * (↑phiUnit⁻¹ : AdjoinRoot F))
  have hdiv : D ∣ U ^ 2 - F * criticalQuadraticFromMoments F.leadingCoeff D rho mu :=
    ⟨V2, hidentity⟩
  have hmoments := (hequivalence F.leadingCoeff rho mu).mp hdiv
  refine ⟨phiUnit, criticalUnit, P, hphi, hcritical, hP, hvalue, ?_⟩
  intro j hj
  have h := hmoments j hj
  by_cases hj2 : j = 2
  · simpa only [rho, mu, if_pos hj2] using h
  · simpa only [rho, mu, if_neg hj2, zero_sub] using h

end Litt3.CartierAndSpin
