import Theorems.CartierAndSpin.PurePowerReduction
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.RingTheory.Finiteness.Basic
import Mathlib.Algebra.Group.Submonoid.Membership
import Mathlib.Tactic.Ring

/-!
# Finite spanning from pure-power leading relations

The argument of `pure_power_pair_finite_algebra` is formalized by total-degree
induction, without Gröbner computations. The relation-to-polynomial-quotient
bridge and the geometric point/constant-field counts remain separate targets.
-/

namespace Litt3.CartierAndSpin

section Semiring

variable {K A : Type*} [CommSemiring K] [CommSemiring A] [Algebra K A]

theorem monomial_mem_rectangularSpan (x y : A) (m : ℕ)
    (hred : PurePowerReductions (K := K) x y m) (i j : ℕ) :
    x ^ i * y ^ j ∈ rectangularMonomialSpan (K := K) x y m := by
  suffices h : ∀ n : ℕ, ∀ i j : ℕ, i + j = n →
      x ^ i * y ^ j ∈ rectangularMonomialSpan (K := K) x y m from
    h (i + j) i j rfl
  intro n
  induction n using Nat.strong_induction_on with
  | h n ih =>
    intro i j hij
    by_cases hi : i < m
    · by_cases hj : j < m
      · exact Submodule.subset_span ⟨(⟨i, hi⟩, ⟨j, hj⟩), rfl⟩
      · have hmul : y ^ m * (x ^ i * y ^ (j - m)) ∈
            rectangularMonomialSpan (K := K) x y m := by
          have hy := hred.y_reduction
          unfold lowerMonomialSpan at hy
          generalize hpower : y ^ m = z at hy ⊢
          clear hpower
          induction hy using Submodule.span_induction with
          | mem z hz =>
            rcases hz with ⟨a, b, hab, rfl⟩
            have hlt : (a + i) + (b + (j - m)) < n := by omega
            have heq : (x ^ a * y ^ b) * (x ^ i * y ^ (j - m)) =
                x ^ (a + i) * y ^ (b + (j - m)) := by
              simp only [pow_add]
              ring
            rw [heq]
            exact ih _ hlt _ _ rfl
          | zero => simp
          | add u v hu hv ihu ihv =>
            simpa only [add_mul] using
              (rectangularMonomialSpan (K := K) x y m).add_mem ihu ihv
          | smul c u hu ihu =>
            simpa only [Algebra.smul_mul_assoc] using
              (rectangularMonomialSpan (K := K) x y m).smul_mem c ihu
        have heq : y ^ m * (x ^ i * y ^ (j - m)) = x ^ i * y ^ j := by
          calc
            _ = x ^ i * y ^ (m + (j - m)) := by rw [pow_add]; ring
            _ = _ := by congr 2; omega
        rwa [heq] at hmul
    · have hmul : x ^ m * (x ^ (i - m) * y ^ j) ∈
          rectangularMonomialSpan (K := K) x y m := by
        have hx := hred.x_reduction
        unfold lowerMonomialSpan at hx
        generalize hpower : x ^ m = z at hx ⊢
        clear hpower
        induction hx using Submodule.span_induction with
        | mem z hz =>
          rcases hz with ⟨a, b, hab, rfl⟩
          have hlt : (a + (i - m)) + (b + j) < n := by omega
          have heq : (x ^ a * y ^ b) * (x ^ (i - m) * y ^ j) =
              x ^ (a + (i - m)) * y ^ (b + j) := by
            simp only [pow_add]
            ring
          rw [heq]
          exact ih _ hlt _ _ rfl
        | zero => simp
        | add u v hu hv ihu ihv =>
          simpa only [add_mul] using
            (rectangularMonomialSpan (K := K) x y m).add_mem ihu ihv
        | smul c u hu ihu =>
          simpa only [Algebra.smul_mul_assoc] using
            (rectangularMonomialSpan (K := K) x y m).smul_mem c ihu
      have heq : x ^ m * (x ^ (i - m) * y ^ j) = x ^ i * y ^ j := by
        calc
          _ = x ^ (m + (i - m)) * y ^ j := by rw [pow_add]; ring
          _ = _ := by congr 2; omega
      rwa [heq] at hmul

theorem purePowerRectangularSpan (x y : A) (m : ℕ) :
    Specifications.PurePowerRectangularSpan (K := K) x y m := by
  intro hred hgen
  apply top_le_iff.mp
  intro z hz
  have hle : (Algebra.adjoin K ({x, y} : Set A)).toSubmodule ≤
      rectangularMonomialSpan (K := K) x y m := by
    apply (Algebra.adjoin_toSubmodule_le K).mpr
    intro v hv
    obtain ⟨i, j, rfl⟩ := (Submonoid.mem_closure_pair x y v).mp hv
    exact monomial_mem_rectangularSpan x y m hred i j
  have hz' : z ∈ (Algebra.adjoin K ({x, y} : Set A)).toSubmodule := by
    rw [hgen]
    trivial
  exact hle hz'

theorem moduleFinite_of_purePowerReductions (x y : A) (m : ℕ)
    (hred : PurePowerReductions (K := K) x y m)
    (hgen : Algebra.adjoin K ({x, y} : Set A) = ⊤) : Module.Finite K A := by
  apply Module.finite_def.mpr
  apply Submodule.fg_def.mpr
  refine ⟨Set.range (fun ij : Fin m × Fin m => x ^ (ij.1 : ℕ) * y ^ (ij.2 : ℕ)),
    Set.finite_range _, ?_⟩
  exact purePowerRectangularSpan x y m hred hgen

end Semiring

section Field

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

/-- The exact `m²` vector-space bound follows from the rectangular generators.
The quotient may be the zero ring; nonemptiness and reducedness are not assumed. -/
theorem finrank_le_square_of_purePowerReductions (x y : A) (m : ℕ)
    (hred : PurePowerReductions (K := K) x y m)
    (hgen : Algebra.adjoin K ({x, y} : Set A) = ⊤) : Module.finrank K A ≤ m ^ 2 := by
  have hspan := purePowerRectangularSpan x y m hred hgen
  have h := finrank_le_of_span_eq_top hspan
  simpa only [Fintype.card_prod, Fintype.card_fin, pow_two] using h

end Field

end Litt3.CartierAndSpin
