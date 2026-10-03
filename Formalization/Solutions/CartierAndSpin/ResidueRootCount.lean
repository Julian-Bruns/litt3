import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Algebra.Polynomial.RingDivision
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k] [DecidableEq k]

/-- Multiplicity in a full linear-factor product counts indices, without
requiring distinct residues. -/
theorem nodal_rootMultiplicity (s : Finset ι) (node : ι → k) (a : k) :
    (nodal s node).rootMultiplicity a = (s.filter (fun i => node i = a)).card := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [nodal_empty]
  | @insert i s hi ih =>
    rw [nodal_insert_eq_nodal hi,
      rootMultiplicity_mul (mul_ne_zero (X_sub_C_ne_zero _) (nodal_ne_zero (s := s) (v := node))),
      rootMultiplicity_X_sub_C, ih]
    by_cases h : node i = a
    · simp [h, hi, eq_comm, Finset.filter_insert, Nat.add_comm]
    · simp [h, hi, Ne.symm h, Finset.filter_insert]

theorem scaled_nodal_rootMultiplicity (s : Finset ι) (node : ι → k) (a leading : k)
    (hleading : leading ≠ 0) :
    (C leading * nodal s node).rootMultiplicity a =
      (s.filter (fun i => node i = a)).card := by
  rw [rootMultiplicity_mul (mul_ne_zero (C_ne_zero.mpr hleading) (nodal_ne_zero (s := s) (v := node))),
    rootMultiplicity_C, zero_add, nodal_rootMultiplicity]

/-- A reduced source `X^p H` with unit constant term in H has exactly p
zero-residue indices in every complete linear-factor presentation. -/
theorem reduced_source_zero_root_count (s : Finset ι) (node : ι → k)
    (H : k[X]) (p : ℕ) (leading : k) (hleading : leading ≠ 0)
    (hH : H.eval 0 ≠ 0)
    (hfactor : X ^ p * H = C leading * nodal s node) :
    (s.filter (fun i => node i = 0)).card = p := by
  have hH0 : H ≠ 0 := by intro h; simp [h] at hH
  have hm : (X ^ p * H).rootMultiplicity (0 : k) = p := by
    have h := rootMultiplicity_mul_X_sub_C_pow (a := (0 : k)) (n := p) hH0
    simpa only [map_zero, sub_zero, mul_comm, rootMultiplicity_eq_zero hH, zero_add] using h
  rw [hfactor, scaled_nodal_rootMultiplicity s node 0 leading hleading] at hm
  exact hm

end Litt3.CartierAndSpin
