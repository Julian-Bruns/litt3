import Solutions.CartierAndSpin.TraceZeroProjection
import Mathlib.RingTheory.Adjoin.PowerBasis

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

theorem quartic_power_basis_repr (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (i : Fin 4) :
    basis.repr (t ^ (i : ℕ)) = Finsupp.single i 1 := by
  rw [← hbasis i, basis.repr_self]

theorem quartic_power_basis_trace_nonconstant (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (k : Fin 4) (hk : k ≠ 0) :
    Algebra.trace K L (t ^ (k : ℕ)) = 0 := by
  have hp0 : basis.repr (t ^ 0) = Finsupp.single (0 : Fin 4) 1 :=
    quartic_power_basis_repr basis t hbasis (0 : Fin 4)
  have hp1 : basis.repr (t ^ 1) = Finsupp.single (1 : Fin 4) 1 :=
    quartic_power_basis_repr basis t hbasis (1 : Fin 4)
  have hp2 : basis.repr (t ^ 2) = Finsupp.single (2 : Fin 4) 1 :=
    quartic_power_basis_repr basis t hbasis (2 : Fin 4)
  have hp3 : basis.repr (t ^ 3) = Finsupp.single (3 : Fin 4) 1 :=
    quartic_power_basis_repr basis t hbasis (3 : Fin 4)
  simp only [pow_zero] at hp0
  simp only [pow_one] at hp1
  have ht4 : t ^ 4 = m • t ^ 0 := by simp [ht, Algebra.smul_def]
  have ht5 : t ^ 5 = m • t ^ 1 := by
    rw [show 5 = 4 + 1 from rfl, pow_add, ht, Algebra.smul_def]
  have ht6 : t ^ 6 = m • t ^ 2 := by
    rw [show 6 = 4 + 2 from rfl, pow_add, ht, Algebra.smul_def]
  have hdiag (j : Fin 4) : basis.repr (t ^ (k : ℕ) * basis j) j = 0 := by
    rw [hbasis, ← pow_add]
    fin_cases k
    · exact (hk rfl).elim
    all_goals fin_cases j
    all_goals norm_num only [Nat.reduceAdd]
    all_goals simp [ht4, ht5, ht6, map_smul, hp0, hp1, hp2, hp3]
  rw [Algebra.trace_eq_matrix_trace basis, Matrix.trace]
  apply Finset.sum_eq_zero
  intro i _
  change Algebra.leftMulMatrix basis (t ^ (k : ℕ)) i i = 0
  rw [Algebra.leftMulMatrix_eq_repr_mul]
  exact hdiag i

theorem quartic_power_basis_exists [FiniteDimensional K L] (t : L)
    (hgen : Algebra.adjoin K ({t} : Set L) = ⊤) (hdim : finrank K L = 4) :
    ∃ basis : Basis (Fin 4) K L, ∀ i : Fin 4, basis i = t ^ (i : ℕ) := by
  let pb := PowerBasis.ofAdjoinEqTop (Algebra.IsIntegral.isIntegral t) hgen
  have hpbdim : pb.dim = 4 := pb.finrank.symm.trans hdim
  refine ⟨pb.basis.reindex (finCongr hpbdim), ?_⟩
  intro i
  rw [Basis.reindex_apply, pb.basis_eq_pow]
  rfl

end Litt3.CartierAndSpin
