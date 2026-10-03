import Theorems.CartierAndSpin.PurePowerQuotient
import Solutions.CartierAndSpin.PurePowerPolynomialBridge
import Mathlib.Tactic.FinCases

namespace Litt3.CartierAndSpin

variable {K : Type*} [Field K]

theorem purePowerPairQuotientBounds (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K)
    (hR : R.totalDegree < m) (hS : S.totalDegree < m) (hdet : a * d - b * c ≠ 0) :
    let I := purePowerPairIdeal m a b c d R S
    let q := Ideal.Quotient.mkₐ K I
    Module.Finite K (MvPolynomial (Fin 2) K ⧸ I) ∧
      Module.finrank K (MvPolynomial (Fin 2) K ⧸ I) ≤ m ^ 2 ∧
      rectangularMonomialSpan (K := K) (q (MvPolynomial.X 0)) (q (MvPolynomial.X 1)) m = ⊤ := by
  let I := purePowerPairIdeal m a b c d R S
  let q := Ideal.Quotient.mkₐ K I
  let x := q (MvPolynomial.X 0)
  let y := q (MvPolynomial.X 1)
  have hq : MvPolynomial.aeval ![x, y] = q := by
    apply MvPolynomial.algHom_ext
    intro i
    fin_cases i <;> simp [x, y]
  have hrange : Set.range (![x, y] : Fin 2 → _) = ({x, y} : Set _) := by
    ext z
    constructor
    · rintro ⟨i, rfl⟩
      fin_cases i <;> simp
    · intro hz
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hz
      rcases hz with rfl | rfl
      · exact ⟨0, rfl⟩
      · exact ⟨1, rfl⟩
  have hgen : Algebra.adjoin K ({x, y} : Set _) = ⊤ := by
    rw [← hrange, Algebra.adjoin_range_eq_range_aeval, hq]
    exact (AlgHom.range_eq_top q).mpr (Ideal.Quotient.mkₐ_surjective K I)
  have hFzero : q (purePowerPolynomial m a b R) = 0 := by
    apply Ideal.Quotient.eq_zero_iff_mem.mpr
    apply Ideal.subset_span
    simp
  have hGzero : q (purePowerPolynomial m c d S) = 0 := by
    apply Ideal.Quotient.eq_zero_iff_mem.mpr
    apply Ideal.subset_span
    simp
  have hF : a • x ^ m + b • y ^ m + MvPolynomial.aeval ![x, y] R = 0 := by
    rw [← hq] at hFzero
    simpa [purePowerPolynomial, Algebra.smul_def] using hFzero
  have hG : c • x ^ m + d • y ^ m + MvPolynomial.aeval ![x, y] S = 0 := by
    rw [← hq] at hGzero
    simpa [purePowerPolynomial, Algebra.smul_def] using hGzero
  have hred := purePowerReductions_of_independent_leading_forms
    x y m a b c d R S hR hS hdet hF hG
  exact ⟨moduleFinite_of_purePowerReductions x y m hred hgen,
    finrank_le_square_of_purePowerReductions x y m hred hgen,
    purePowerRectangularSpan x y m hred hgen⟩

theorem purePowerPairFiniteQuotient (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K) :
    Specifications.PurePowerPairFiniteQuotient m a b c d R S := by
  intro hR hS hdet
  have h := purePowerPairQuotientBounds m a b c d R S hR hS hdet
  exact ⟨h.1, h.2.1⟩

end Litt3.CartierAndSpin
