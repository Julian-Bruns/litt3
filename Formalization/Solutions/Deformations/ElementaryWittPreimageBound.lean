import Solutions.Deformations.ElementaryWittOperatorInitial
import Solutions.Deformations.ElementaryGradedPrecisionBounds

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (r : ℕ) (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
  truncated_witt_nontrivial 5 (r + 1) (by omega) k

theorem elementary_witt_preimage_step
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryWittQuadraticReduction (r + 1) k r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (d : ℕ) (small : d < 4 * r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r d)
    (vanish : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (d + 3)) :
    x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r (d + 1) := by
  let N := r + 1
  obtain ⟨member, initial⟩ := elementary_witt_operator_initial N k r d L q reduction x
  have zero : elementaryWittAssociatedMap N k r (d + 2) ⟨L x.val, member⟩ = 0 :=
    (elementary_witt_associated_map_kernel N k r (d + 2) _).mpr
      (by simpa only [Nat.add_assoc] using vanish)
  let y := elementaryWittFrobeniusWeight N k r d x
  obtain ⟨Z, homogeneous, representation⟩ :=
    (elementary_witt_associated_map_full_range N k r d
      (elementaryWittAssociatedMap N k r d y)).mp ⟨y, rfl⟩
  have qZero : weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 := by
    rw [map_mul, representation]
    exact initial.symm.trans zero
  have originalZero := elementary_graded_final_precision_low_kernel k r d small q reduction.2.1
    anisotropic Z homogeneous qZero
  have yZero : elementaryWittAssociatedMap N k r d y = 0 := by
    rw [← representation, originalZero, map_zero]
  have next := (elementary_witt_associated_map_kernel N k r d y).mp yZero
  have inverse := elementary_witt_inverse_frobenius_normal_weight N k r (d + 1)
    (elementaryWittFrobenius 5 N r k x.val) next
  simpa only [RingEquiv.symm_apply_apply] using inverse

/-- Any actual preimage of a critical target must begin in the actual
critical input weight; arbitrary lower-weight cancellations are excluded. -/
theorem elementary_witt_critical_preimage_bound
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryWittQuadraticReduction (r + 1) k r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (critical : L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (4 * r + 1)) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r (4 * r - 1) := by
  have advance : ∀ d, d ≤ 4 * r - 1 →
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r d := by
    intro d
    induction d with
    | zero =>
      intro _
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    | succ d induction =>
      intro bound
      apply elementary_witt_preimage_step r k L q reduction anisotropic d (by omega)
        ⟨x, induction (by omega)⟩
      exact elementary_normal_weight_antitone (R := TruncatedWittVector 5 (r + 1) k)
        5 (by omega) r (by omega) critical
  exact advance (4 * r - 1) le_rfl

end Litt3.Deformations
