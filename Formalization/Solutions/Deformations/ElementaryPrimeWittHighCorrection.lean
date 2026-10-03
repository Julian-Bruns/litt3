import Solutions.Deformations.ElementaryPrimeWittOperatorInitial
import Solutions.Deformations.ElementaryPrimeGradedHighImage

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by have := (Fact.out : p.Prime).two_le; omega) k

/-- Every actual high-weight target has an actual additive correction
the principal degree lower, obtained from proved literal principal surjectivity
and the actual inverse coefficient Frobenius. -/
theorem elementary_prime_witt_high_correction
    (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ a : Fin r → ZMod p, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (a i)) ≠ 0)
    (d : ℕ) (high : (p - 1) * r + a ≤ d)
    (z : elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    ∃ x : elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r (d - a),
      z.val - L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1) := by
  let N := r + 1
  let e := d - a
  obtain ⟨Z, homogeneous, zRepresentation⟩ :=
    (elementary_prime_witt_associated_map_full_range p N k r d
      (elementaryPrimeWittAssociatedMap p N k r d z)).mp ⟨z, rfl⟩
  obtain ⟨T, tHomogeneous, image⟩ := elementary_prime_graded_high_image p k r d a principalPositive high q reduction.2.1
    anisotropic Z homogeneous
  obtain ⟨y, yRepresentation⟩ :=
    (elementary_prime_witt_associated_map_full_range p N k r e
      (weightedRootTruncation k p N (Fact.out : 0 < N) r T)).mpr ⟨T, tHomogeneous, rfl⟩
  let x := (elementaryPrimeWittFrobeniusWeight p N k r e).symm y
  obtain ⟨lxMember, lxInitial⟩ := elementary_prime_witt_operator_initial p N k r e a degreeBound L q reduction x
  have index : e + a = d := by dsimp only [e]; omega
  have member : L x.val ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d := by
    simpa only [index] using lxMember
  have initialAtD := (elementary_prime_witt_associated_map_reindex p N k r d (e + a)
    index.symm (L x.val) member lxMember).trans lxInitial
  have frobenius : elementaryPrimeWittFrobeniusWeight p N k r e x = y :=
    (elementaryPrimeWittFrobeniusWeight p N k r e).apply_symm_apply y
  rw [frobenius, yRepresentation, ← map_mul] at initialAtD
  have exactClass : elementaryPrimeWittAssociatedMap p N k r d ⟨L x.val, member⟩ =
      elementaryPrimeWittAssociatedMap p N k r d z := by
    rw [initialAtD, image, zRepresentation]
  refine ⟨x, ?_⟩
  exact (elementary_prime_witt_associated_map_equal_iff p N k r d z ⟨L x.val, member⟩).mp exactClass.symm

end Litt3.Deformations
