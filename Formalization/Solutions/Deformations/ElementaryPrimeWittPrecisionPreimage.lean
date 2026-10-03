import Solutions.Deformations.ElementaryPrimeWittOperatorInitial
import Solutions.Deformations.ElementaryPrimeGradedPrecisionBounds
import Solutions.Deformations.ElementaryPrimeWeightStructure

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- One original weight advance for a preimage, using the actual finite
precision graded injectivity including its augmented boundary. -/
theorem elementary_prime_witt_precision_preimage_step
    (large : 2 < p) (r a : ℕ) (precisionBound : N ≤ r)
    (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p N k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (d : ℕ) (small : d < (p - 1) * N - a + 1)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r d)
    (vanish : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r (d + a + 1)) :
    x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r (d + 1) := by
  obtain ⟨member, initial⟩ := elementary_prime_witt_operator_initial p N k r d a degreeBound L q reduction x
  have zero : elementaryPrimeWittAssociatedMap p N k r (d + a) ⟨L x.val, member⟩ = 0 :=
    (elementary_prime_witt_associated_map_kernel p N k r (d + a) _).mpr vanish
  let y := elementaryPrimeWittFrobeniusWeight p N k r d x
  obtain ⟨Z, homogeneous, representation⟩ :=
    (elementary_prime_witt_associated_map_full_range p N k r d
      (elementaryPrimeWittAssociatedMap p N k r d y)).mp ⟨y, rfl⟩
  have qZero : weightedRootTruncation k p N (Fact.out : 0 < N) r
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 := by
    rw [map_mul, representation]
    exact initial.symm.trans zero
  have originalZero := elementary_prime_graded_precision_low_kernel p k large r N d a
    (Fact.out : 0 < N) precisionBound principalPositive degreeBound small q reduction.2.1
      anisotropic Z homogeneous qZero
  have yZero : elementaryPrimeWittAssociatedMap p N k r d y = 0 := by
    rw [← representation, originalZero, map_zero]
  have next := (elementary_prime_witt_associated_map_kernel p N k r d y).mp yZero
  have inverse := elementary_prime_witt_inverse_frobenius_weight p N k r (d + 1)
    (elementaryWittFrobenius p N r k x.val) next
  simpa only [RingEquiv.symm_apply_apply] using inverse

/-- A target's known weight yields the exact source threshold up to the
genuine finite-precision kernel threshold; no assumed source model is used. -/
theorem elementary_prime_witt_precision_preimage_bound
    (large : 2 < p) (r a t b : ℕ) (precisionBound : N ≤ r)
    (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (sourceBound : b ≤ (p - 1) * N - a + 1) (imageBound : b + a ≤ t)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p N k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (target : L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r t) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r b := by
  have advance : ∀ d, d ≤ b →
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r d := by
    intro d
    induction d with
    | zero =>
      intro _
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    | succ d induction =>
      intro bound
      apply elementary_prime_witt_precision_preimage_step p N k large r a precisionBound
        principalPositive degreeBound L q reduction anisotropic d (by omega) ⟨x, induction (by omega)⟩
      exact elementary_normal_weight_antitone (R := TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r (by omega) target
  exact advance b le_rfl

end Litt3.Deformations
