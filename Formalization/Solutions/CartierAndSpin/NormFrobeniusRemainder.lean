import Solutions.CartierAndSpin.SeparableSourceNorm
import Solutions.CartierAndSpin.InseparableRemainders
import Mathlib.FieldTheory.AlgebraicClosure

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- A nonzero p-th-power norm forces the literal constant Frobenius
remainder. This part also includes constant source polynomials. -/
theorem source_norm_frobenius_remainder (p : ℕ) [CharP K p] (hp : p.Prime)
    (f : K) (hnot : ∀ a : K, a ^ p ≠ f) (F : K[X])
    (hmonic : F.Monic) (hsep : F.Separable)
    (hnorm : ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p) :
    ∃ H : K[X], ∃ tau : K, tau ≠ 0 ∧
      F = (X ^ p + C f) * H + C tau := by
  classical
  letI : Fact p.Prime := ⟨hp⟩
  let L := AlgebraicClosure K
  let cmap : K →+* L := algebraMap K L
  letI : CharP L p := charP_of_injective_algebraMap cmap.injective p
  obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq (-cmap f) hp.pos
  obtain ⟨a, ha, hnorm⟩ := hnorm
  have hformula := separable_source_norm_inseparable_root F hmonic hsep
    (IsAlgClosed.splits (F.map cmap)) p f c hc
  rw [hnorm, map_pow] at hformula
  have hvalue : (-1 : L) ^ F.natDegree * (F.map cmap).eval c = cmap a := by
    apply frobenius_inj L p
    exact hformula.symm
  let tau : K := ((-1 : K) ^ F.natDegree)⁻¹ * a
  have hsign : (-1 : L) ^ F.natDegree ≠ 0 := pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero)
  have htau : tau ≠ 0 := mul_ne_zero
    (inv_ne_zero (pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero))) ha
  have heval : aeval c F = cmap tau := by
    have heval' : (F.map cmap).eval c = ((-1 : L) ^ F.natDegree)⁻¹ * cmap a := by
      apply (eq_inv_mul_iff_mul_eq₀ hsign).2
      exact hvalue
    simpa only [tau, map_mul, map_inv₀, map_pow, map_neg, map_one,
      eval_map, aeval_def] using heval'
  obtain ⟨H, hH⟩ := polynomial_constant_inseparable_remainder p hp f hnot c hc F tau heval
  exact ⟨H, tau, htau, hH⟩

/-- The converse uses the same actual norm calculation and needs neither
irreducibility of the source nor a connected source algebra. -/
theorem source_frobenius_remainder_norm (p : ℕ) [CharP K p] (hp : p.Prime)
    (f : K) (F H : K[X]) (tau : K) (htau : tau ≠ 0)
    (hmonic : F.Monic) (hsep : F.Separable)
    (hsource : F = (X ^ p + C f) * H + C tau) :
    ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p := by
  classical
  letI : Fact p.Prime := ⟨hp⟩
  let L := AlgebraicClosure K
  let cmap : K →+* L := algebraMap K L
  letI : CharP L p := charP_of_injective_algebraMap cmap.injective p
  obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq (-cmap f) hp.pos
  refine ⟨(-1 : K) ^ F.natDegree * tau,
    mul_ne_zero (pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero)) htau, ?_⟩
  apply cmap.injective
  rw [separable_source_norm_inseparable_root F hmonic hsep
    (IsAlgClosed.splits (F.map cmap)) p f c hc]
  have hvalue : (F.map cmap).eval c = cmap tau := by
    rw [hsource, Polynomial.map_add, Polynomial.map_mul, Polynomial.map_add,
      Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C, Polynomial.map_C,
      eval_add, eval_mul, eval_add, eval_pow, eval_X, eval_C, eval_C,
      hc, neg_add_cancel, zero_mul, zero_add]
  rw [hvalue, map_pow, map_mul, map_pow, map_neg, map_one]

/-- The positive-degree hypothesis is the exact extra condition needed
to infer the lower bound on source degree. -/
theorem frobenius_remainder_positive_degree_bound (p : ℕ) (hp : 0 < p)
    (f : K) (F H : K[X]) (tau : K) (hdegree : 0 < F.natDegree)
    (hsource : F = (X ^ p + C f) * H + C tau) : p ≤ F.natDegree := by
  have hH : H ≠ 0 := by
    intro hzero
    rw [hsource, hzero, mul_zero, zero_add, natDegree_C] at hdegree
    exact (lt_irrefl 0) hdegree
  have hprod : ((X ^ p + C f) * H).natDegree = p + H.natDegree := by
    rw [natDegree_mul (monic_X_pow_add_C f hp.ne').ne_zero hH,
      natDegree_X_pow_add_C]
  rw [hsource, natDegree_add_eq_left_of_natDegree_lt]
  · rw [hprod]
    omega
  · rw [natDegree_C, hprod]
    omega

end Litt3.CartierAndSpin
