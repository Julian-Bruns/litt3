import Solutions.Deformations.ArtinSchreierChartDerivation
import Solutions.Deformations.ArtinSchreierChartMap
import Solutions.Deformations.ArtinSchreierDigits

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

variable {R : Type*} [CommRing R]

/-- The actual original chart is the zero algebra over a zero base. -/
theorem artin_schreier_chart_subsingleton [Subsingleton R] (p r : ℕ)
    (a b : Fin r → R) : Subsingleton (artinSchreierChart R p r a b) :=
  Module.subsingleton R _

/-- Full literal carry identity also covers the zero coefficient ring. -/
theorem artin_schreier_carry_eq_normal_general (p : ℕ) (prime : p.Prime)
    (r : ℕ) (a b : Fin r → R) (d : ℤ) :
    artinSchreierCarry R p r a b d =
      normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
        (artinSchreierChartCoordinate R p r a b) d := by
  cases subsingleton_or_nontrivial R with
  | inl trivial =>
    letI := trivial
    letI := artin_schreier_chart_subsingleton p r a b
    exact Subsingleton.elim _ _
  | inr nontrivial =>
    letI := nontrivial
    exact artin_schreier_carry_eq_normal p prime r a b d

/-- Actual unique root lifting at full commutative-ring generality,
including the degenerate zero base ring. -/
theorem artin_schreier_chart_root_lift_general (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) (u : Rˣ) (v : R)
    (seed : artinSchreierChart R p r a b)
    (seedMember : seed ∈ artinSchreierCarry R p r a b 1)
    (initial : seed ^ p ≡ u.val • seed + v • (1 : artinSchreierChart R p r a b)
      [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})]) :
    ∃ x : artinSchreierChart R p r a b,
      x ^ p = u.val • x + v • (1 : artinSchreierChart R p r a b) ∧
      x ∈ artinSchreierCarry R p r a b 1 ∧
      x ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] ∧
      ∀ y : artinSchreierChart R p r a b,
        y ^ p = u.val • y + v • (1 : artinSchreierChart R p r a b) →
        y ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] → y = x := by
  cases subsingleton_or_nontrivial R with
  | inl trivial =>
    letI := trivial
    letI := artin_schreier_chart_subsingleton p r a b
    refine ⟨0, Subsingleton.elim _ _, Submodule.zero_mem _, ?_, ?_⟩
    · rw [Subsingleton.elim seed 0]
    · intro y _ _
      exact Subsingleton.elim _ _
  | inr nontrivial =>
    letI := nontrivial
    exact artin_schreier_chart_root_lift p prime r a b u v seed seedMember initial

/-- The full actual derivation clause includes the zero base ring. -/
theorem artin_schreier_chart_derivation_general (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) (units : Fin r → Rˣ)
    (coefficientUnits : ∀ i, (units i).val = a i) (D : Derivation ℤ R R) :
    ∃ E : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
      (∀ c, E (algebraMap R _ c) = algebraMap R _ (D c)) ∧
      (∀ (d : ℤ) (x : artinSchreierChart R p r a b),
        x ∈ artinSchreierCarry R p r a b d → E x ∈ artinSchreierCarry R p r a b d) ∧
      ∀ F : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
        (∀ c, F (algebraMap R _ c) = algebraMap R _ (D c)) → F = E := by
  cases subsingleton_or_nontrivial R with
  | inl trivial =>
    letI := trivial
    letI := artin_schreier_chart_subsingleton p r a b
    refine ⟨0, fun _ => Subsingleton.elim _ _, ?_, ?_⟩
    · intro d x _
      exact Submodule.zero_mem _
    · intro F _
      apply Derivation.ext
      intro x
      exact Subsingleton.elim _ _
  | inr nontrivial =>
    letI := nontrivial
    exact artin_schreier_chart_derivation p prime r a b units coefficientUnits D

/-- Literal finite original residue digits also cover the zero ring. -/
theorem artin_schreier_original_residue_digits_general (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) (lift : R ⧸ Ideal.span {(p : R)} → R)
    (residue : ∀ c, Ideal.Quotient.mk (Ideal.span {(p : R)}) (lift c) = c)
    (zero : lift 0 = 0) (m : ℕ) (x : artinSchreierChart R p r a b)
    (member : x ∈ artinSchreierCarry R p r a b d) :
    ∃ digits : Fin m → (Fin r → Fin p) → R ⧸ Ideal.span {(p : R)},
      x ≡ (∑ j : Fin m, (p : artinSchreierChart R p r a b) ^ j.val *
        artinSchreierNormalDigit p prime.one_lt r a b lift (digits j))
        [SMOD ((Ideal.span {(p : artinSchreierChart R p r a b)}) ^ m)] ∧
      ∀ (j : Fin m) (alpha : Fin r → Fin p),
        d + ((p - 1 : ℕ) : ℤ) * j.val < (∑ i, (alpha i).val : ℕ) → digits j alpha = 0 := by
  cases subsingleton_or_nontrivial R with
  | inl trivial =>
    letI := trivial
    letI := artin_schreier_chart_subsingleton p r a b
    refine ⟨fun _ _ => 0, ?_, fun _ _ _ => rfl⟩
    have same : x = ∑ j : Fin m, (p : artinSchreierChart R p r a b) ^ j.val *
        artinSchreierNormalDigit p prime.one_lt r a b lift (fun _ => 0) := Subsingleton.elim _ _
    rw [same]
  | inr nontrivial =>
    letI := nontrivial
    exact artin_schreier_original_residue_digits p prime r a b d lift residue zero m x member

end Litt3.Deformations
