import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Algebra.Polynomial.Degree.Operations
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R ι : Type*} [CommRing R] [IsDomain R]

theorem source_leading_coefficient (F H : R[X]) (p : ℕ) (q tau : R)
    (hp : 0 < p) (hH : H ≠ 0) (hsource : F = (X ^ p + C q) * H + C tau) :
    F.leadingCoeff = H.leadingCoeff := by
  have hphi : (X ^ p + C q : R[X]).Monic := monic_X_pow_add_C q (by omega)
  have hprod : (X ^ p + C q) * H ≠ 0 := mul_ne_zero hphi.ne_zero hH
  have hn : ((X ^ p + C q) * H).natDegree = p + H.natDegree := by
    rw [natDegree_mul hphi.ne_zero hH, natDegree_X_pow_add_C]
  have hd : (C tau : R[X]).degree < ((X ^ p + C q) * H).degree := by
    apply degree_C_le.trans_lt
    rw [degree_eq_natDegree hprod, hn]
    exact WithBot.coe_lt_coe.mpr (by omega : 0 < p + H.natDegree)
  rw [hsource, leadingCoeff_add_of_degree_lt' hd, leadingCoeff_mul, hphi.leadingCoeff, one_mul]

theorem full_split_source_leading_coefficient (s : Finset ι) (node : ι → R)
    (F H : R[X]) (p : ℕ) (q tau leading : R)
    (hp : 0 < p) (hH : H ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    leading = H.leadingCoeff := by
  have h := congrArg Polynomial.leadingCoeff hfactor
  rw [leadingCoeff_mul, leadingCoeff_C, (Lagrange.nodal_monic).leadingCoeff, mul_one] at h
  exact h.symm.trans (source_leading_coefficient F H p q tau hp hH hsource)

end Litt3.CartierAndSpin
