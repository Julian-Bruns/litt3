import Solutions.SharedTensors.SplitPolynomialPoleBounds
import Solutions.CartierAndSpin.LaurentEndpointBounds
import Mathlib.LinearAlgebra.Lagrange

namespace Litt3.SharedTensors

open Polynomial
open Litt3.CartierAndSpin

/-- Uniform root bounds give the exact elementary-symmetric power bound,
also below one; zeros and repeated roots are retained. -/
theorem multiset_esymm_valuation_le_uniform_power
    {K Γ : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ]
    (v : Valuation K Γ) (s : Multiset K) (r : Γ)
    (hs : ∀ a ∈ s, v a ≤ r) (j : ℕ) : v (s.esymm j) ≤ r ^ j := by
  induction s using Multiset.induction_on generalizing j with
  | empty => cases j <;> simp [Multiset.esymm, Multiset.powersetCard_zero_left]
  | @cons a s ih =>
    have ha := hs a (Multiset.mem_cons_self a s)
    have ht : ∀ b ∈ s, v b ≤ r := fun b hb => hs b (Multiset.mem_cons_of_mem hb)
    cases j with
    | zero => simp [multiset_esymm_zero]
    | succ j =>
      rw [multiset_esymm_cons_succ]
      apply v.map_add_le
      · rw [map_mul, pow_succ']
        exact mul_le_mul' ha (ih ht j)
      · exact ih ht (j + 1)

/-- The zero-safe Laurent order bound corresponding to every symmetric
degree, with arbitrary signed lower root order. -/
theorem laurent_multiset_esymm_orderTop_bound
    {k : Type*} [Field k] (s : Multiset (LaurentSeries k)) (m : ℤ)
    (hs : ∀ a ∈ s, (m : WithTop ℤ) ≤ a.orderTop) (j : ℕ) :
    (((j : ℤ) * m : ℤ) : WithTop ℤ) ≤ (s.esymm j).orderTop := by
  induction s using Multiset.induction_on generalizing j with
  | empty => cases j <;> simp [Multiset.esymm, Multiset.powersetCard_zero_left]
  | @cons a s ih =>
    have ha := hs a (Multiset.mem_cons_self a s)
    have ht : ∀ b ∈ s, (m : WithTop ℤ) ≤ b.orderTop :=
      fun b hb => hs b (Multiset.mem_cons_of_mem hb)
    cases j with
    | zero => simp [multiset_esymm_zero]
    | succ j =>
      rw [multiset_esymm_cons_succ]
      apply (le_min ?_ (ih ht (j + 1))).trans HahnSeries.min_orderTop_le_orderTop_add
      simpa only [Nat.cast_add, Nat.cast_one, add_mul, one_mul, add_comm] using
        laurent_orderTop_mul_bound a (s.esymm j) m ((j : ℤ) * m) ha (ih ht j)

/-- Every actual nodal coefficient has the sharp root-order bound. No
injectivity of the nodes or distinctness of their residues is required. -/
theorem laurent_nodal_coeff_orderTop_bound
    {k ι : Type*} [Field k] (s : Finset ι) (node : ι → LaurentSeries k)
    (m : ℤ) (hs : ∀ i ∈ s, (m : WithTop ℤ) ≤ (node i).orderTop)
    (j : ℕ) (hj : j ≤ s.card) :
    ((((s.card - j : ℕ) : ℤ) * m : ℤ) : WithTop ℤ) ≤
      ((Lagrange.nodal s node).coeff j).orderTop := by
  classical
  have hcoeff := (s.val.map node).prod_X_sub_C_coeff (k := j)
    (by simpa only [Multiset.card_map, Finset.card] using hj)
  have hcoeff' : (Lagrange.nodal s node).coeff j =
      (-1) ^ (s.card - j) * (s.val.map node).esymm (s.card - j) := by
    simpa only [Lagrange.nodal, Finset.prod, Multiset.map_map, Function.comp_def,
      Multiset.card_map, Finset.card] using hcoeff
  rw [hcoeff']
  have hb := laurent_multiset_esymm_orderTop_bound (s.val.map node) m
    (by
      intro a ha
      obtain ⟨i, hi, rfl⟩ := Multiset.mem_map.mp ha
      exact hs i hi) (s.card - j)
  simpa using laurent_orderTop_mul_bound
    ((-1 : LaurentSeries k) ^ (s.card - j))
    ((s.val.map node).esymm (s.card - j)) 0 (((s.card - j : ℕ) : ℤ) * m)
    (by
      rw [laurent_orderTop_power]
      have hminus : (-1 : LaurentSeries k).orderTop = 0 := by
        change (HahnSeries.addVal ℤ k) (-1) = 0
        rw [(HahnSeries.addVal ℤ k).map_neg, (HahnSeries.addVal ℤ k).map_one]
      rw [hminus, nsmul_zero]
      exact le_rfl) hb

end Litt3.SharedTensors
