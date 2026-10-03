import Solutions.Deformations.ElementaryPrimeWittIntegralNormWeight

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- A residue-zero coefficient raises the weight of the literal original
norm by the full prime weight, at arbitrary positive Witt precision. -/
theorem elementary_prime_witt_divisible_norm_weight (r : ℕ)
    (eta : TruncatedWittVector p N k)
    (divisible : truncatedWittResidue p N (Fact.out : 0 < N) k eta = 0) :
    eta • elementaryOriginalNorm (R := TruncatedWittVector p N k) p r ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r ((p - 1) * r + (p - 1)) := by
  let R := TruncatedWittVector p N k
  let A := AddMonoidAlgebra R (Fin r → ZMod p)
  obtain ⟨z, relation⟩ := (truncated_witt_residue_kernel p N (Fact.out : 0 < N) k eta).mp divisible
  have scalar := truncated_witt_scalar_power_smul p N 1 k z
  simp only [pow_one] at scalar
  have etaEquality : eta = (p : R) * z := (scalar.symm.trans relation).symm
  have member : z • elementaryOriginalNorm (R := R) p r ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r ((p - 1) * r) :=
    Submodule.smul_mem _ z (elementary_prime_witt_integral_norm_weight p N k r)
  have product : (p : A) * (z • elementaryOriginalNorm (R := R) p r) ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r
        ((p - 1) + (p - 1) * r) := by
    rw [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)] at member ⊢
    exact weighted_generator_prime_mul _ (p - 1) _ _ _ member
  simpa only [etaEquality, Algebra.smul_def, map_mul, map_natCast, mul_assoc,
    Nat.add_comm] using product

end Litt3.Deformations
