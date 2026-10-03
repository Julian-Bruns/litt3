import Solutions.Deformations.ElementaryPrimeWittOperatorInitial
import Solutions.Deformations.ElementaryPrimeGradedPrecisionBounds

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by have := (Fact.out : p.Prime).two_le; omega) k

theorem elementary_prime_witt_preimage_step
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ a : Fin r → ZMod p, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (a i)) ≠ 0)
    (d : ℕ) (small : d < (p - 1) * r)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (vanish : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r (d + (a + 1))) :
    x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1) := by
  let N := r + 1
  obtain ⟨member, initial⟩ := elementary_prime_witt_operator_initial p N k r d a degreeBound L q reduction x
  have zero : elementaryPrimeWittAssociatedMap p N k r (d + a) ⟨L x.val, member⟩ = 0 :=
    (elementary_prime_witt_associated_map_kernel p N k r (d + a) _).mpr
      (by simpa only [Nat.add_assoc] using vanish)
  let y := elementaryPrimeWittFrobeniusWeight p N k r d x
  obtain ⟨Z, homogeneous, representation⟩ :=
    (elementary_prime_witt_associated_map_full_range p N k r d
      (elementaryPrimeWittAssociatedMap p N k r d y)).mp ⟨y, rfl⟩
  have qZero : weightedRootTruncation k p N (Fact.out : 0 < N) r
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 := by
    rw [map_mul, representation]
    exact initial.symm.trans zero
  have originalZero := elementary_prime_graded_final_precision_low_kernel p k large r d a principalPositive degreeBound small q reduction.2.1
    anisotropic Z homogeneous qZero
  have yZero : elementaryPrimeWittAssociatedMap p N k r d y = 0 := by
    rw [← representation, originalZero, map_zero]
  have next := (elementary_prime_witt_associated_map_kernel p N k r d y).mp yZero
  have inverse := elementary_prime_witt_inverse_frobenius_weight p N k r (d + 1)
    (elementaryWittFrobenius p N r k x.val) next
  simpa only [RingEquiv.symm_apply_apply] using inverse

/-- Any actual preimage of a critical target must begin in the actual
critical input weight; arbitrary lower-weight cancellations are excluded. -/
theorem elementary_prime_witt_critical_preimage_bound
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ a : Fin r → ZMod p, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (a i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (critical : L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r + a - 1)) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k) p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r - 1) := by
  have advance : ∀ d, d ≤ (p - 1) * r - 1 →
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k) p (by have := (Fact.out : p.Prime).two_le; omega) r d := by
    intro d
    induction d with
    | zero =>
      intro _
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    | succ d induction =>
      intro bound
      apply elementary_prime_witt_preimage_step p r a k large principalPositive degreeBound L q reduction anisotropic d (by have := (Fact.out : p.Prime).two_le; omega)
        ⟨x, induction (by have := (Fact.out : p.Prime).two_le; omega)⟩
      exact elementary_normal_weight_antitone (R := TruncatedWittVector p (r + 1) k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r (by have := (Fact.out : p.Prime).two_le; omega) critical
  exact advance ((p - 1) * r - 1) le_rfl

end Litt3.Deformations
