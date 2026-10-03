import Theorems.SharedTensors.DivisorRelations
import Mathlib.Tactic.Ring

namespace Litt3.SharedTensors

theorem divide_integral_difference (a b n d : ℤ) (hn : n ≠ 0)
    (h : a - b = n * d) : a / n - b / n = d := by
  have hdvd : n ∣ a - b := ⟨d, h⟩
  rw [← Int.sub_ediv_of_dvd_sub hdvd, h, Int.mul_ediv_cancel_left _ hn]

/-- Coefficientwise integer division explicitly reconstructs an integral
relation from any nonzero integral multiple, on arbitrary finite-fiber maps.
No corelessness, graph enumeration, curve genus or field hypothesis is needed. -/
theorem divisor_relations_saturated {X Y Z : Type*} (f : Z → X) (g : Z → Y)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite) :
    DivisorRelationsSaturated f g hf hg := by
  classical
  intro n hn D hD
  obtain ⟨⟨A, B⟩, hAB⟩ := hD
  let A' := A.mapRange (fun a : ℤ => a / n) (Int.zero_ediv n)
  let B' := B.mapRange (fun b : ℤ => b / n) (Int.zero_ediv n)
  refine ⟨(A', B'), ?_⟩
  ext z
  have hz : A (f z) - B (g z) = n * D z := by
    have h := congrArg (fun E : Litt3.Jacobians.Divisor Z => E z) hAB
    simpa [divisorRelationMap, zsmul_eq_mul] using h
  exact divide_integral_difference (A (f z)) (B (g z)) n (D z) hn hz

/-- Every positive multiple of a class vanishes only when the class itself
vanishes. Thus the quotient retains no hidden integral torsion. -/
theorem divisor_relation_quotient_nsmul_eq_zero
    {X Y Z : Type*} (f : Z → X) (g : Z → Y)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite)
    (n : ℕ) (hn : n ≠ 0) (q : DivisorRelationQuotient f g hf hg)
    (h : n • q = 0) : q = 0 := by
  induction q using QuotientAddGroup.induction_on with
  | H D =>
    have hD : n • D ∈ (divisorRelationMap f g hf hg).range := by
      exact (QuotientAddGroup.eq_zero_iff _).mp (by simpa using h)
    have hmem := divisor_relations_saturated f g hf hg (n : ℤ)
      (by exact_mod_cast hn) D (by simpa using hD)
    exact (QuotientAddGroup.eq_zero_iff _).mpr hmem

instance divisor_relation_quotient_torsionFree
    {X Y Z : Type*} (f : Z → X) (g : Z → Y)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite) :
    IsAddTorsionFree (DivisorRelationQuotient f g hf hg) where
  nsmul_right_injective := by
    intro n hn a b hab
    change n • a = n • b at hab
    have hzero : n • (a - b) = 0 := by rw [nsmul_sub, hab, sub_self]
    exact sub_eq_zero.mp (divisor_relation_quotient_nsmul_eq_zero f g hf hg n hn _ hzero)

end Litt3.SharedTensors
