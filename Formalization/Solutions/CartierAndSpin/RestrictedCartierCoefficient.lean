import Solutions.CartierAndSpin.RestrictedNormalizedDerivations
import Solutions.CartierAndSpin.RestrictedConnectionDichotomy

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The literal p-basis Cartier coefficient satisfies the ORIGINAL
normalized derivative formula. No perfectness or curvature premise
is used. The pth root remains in the actual imperfect original field. -/
theorem actual_cartier_coefficient_derivative_relation
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    (rationalCartierCoefficient K p b f) ^ p = -(D^[p - 1] f) := by
  obtain ⟨D', hDt'⟩ := p_basis_normalized_derivation_exists b
  have hfun : (D : K → K) = (D' : K → K) :=
    funext (normalized_p_basis_derivations_apply_eq b D D' hDt hDt')
  rw [hfun]
  calc
    _ = (b.basis.repr f
        ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩ : K) :=
      pRootCoefficient_pow b f _
    _ = (pBasisTaylorPolynomial b f).coeff (p - 1) :=
      (pBasisTaylorPolynomial_top b f).symm
    _ = _ := p_basis_taylor_top_eq_neg_derivative b D' hDt' f

/-- Actual Cartier fixedness is EXACTLY vanishing of the literal
restricted curvature coefficient, for any normalized constant ring. -/
theorem actual_cartier_coefficient_fixed_iff_curvature_zero
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    rationalCartierCoefficient K p b f = f ↔ D^[p - 1] f + f ^ p = 0 := by
  have hrel := actual_cartier_coefficient_derivative_relation b D hDt f
  constructor
  · intro hfixed
    rw [hfixed] at hrel
    linear_combination hrel
  · intro hcurv
    apply (frobenius K p).injective
    change rationalCartierCoefficient K p b f ^ p = f ^ p
    rw [hrel]
    linear_combination -hcurv

/-- A nonzero solution of the actual ORIGINAL connection exists iff
the literal Cartier coefficient is fixed. This direct restricted-
operator proof assumes neither a logarithm nor a curvature identity. -/
theorem actual_normalized_connection_kernel_iff_cartier_fixed
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    (∃ u : K, u ≠ 0 ∧ D u = f * u) ↔ rationalCartierCoefficient K p b f = f :=
  (actual_normalized_connection_kernel_iff b D hDt f).trans
    (actual_cartier_coefficient_fixed_iff_curvature_zero b D hDt f).symm

/-- The ENTIRE original connection has zero pth iterate iff the actual
Cartier coefficient is fixed; nilpotence is a conclusion. -/
theorem actual_normalized_connection_prime_iterate_zero_iff_cartier_fixed
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    (∀ a : K, (scalarDerivationConnection D f)^[p] a = 0) ↔
      rationalCartierCoefficient K p b f = f := by
  rw [actual_cartier_coefficient_fixed_iff_curvature_zero b D hDt f]
  constructor
  · intro hzero
    have h := hzero 1
    rw [actual_normalized_derivation_restricted_connection_identity b D hDt f,
      mul_one] at h
    exact neg_eq_zero.mp h
  · intro hcurv a
    rw [actual_normalized_derivation_restricted_connection_identity b D hDt f,
      hcurv, neg_zero, zero_mul]

end Litt3.CartierAndSpin
