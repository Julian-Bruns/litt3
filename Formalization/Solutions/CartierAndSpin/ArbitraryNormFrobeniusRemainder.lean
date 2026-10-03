import Solutions.CartierAndSpin.ArbitrarySourceNormFormula
import Solutions.CartierAndSpin.NormFrobeniusRemainder
import Theorems.CartierAndSpin.NormFrobeniusRemainder

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The norm/remainder implication needs no separability of the source
polynomial: the actual algebra may be nonreduced. -/
theorem arbitrary_source_norm_frobenius_remainder (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f)
    (F : K[X]) (hF : F ≠ 0)
    (hnorm : ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p) :
    ∃ H : K[X], ∃ tau : K, tau ≠ 0 ∧
      F = (X ^ p + C f) * H + C tau := by
  classical
  letI : Fact p.Prime := ⟨hp⟩
  let L := AlgebraicClosure K
  let cmap : K →+* L := algebraMap K L
  letI : CharP L p := charP_of_injective_algebraMap cmap.injective p
  let scale : K := (-1 : K) ^ F.natDegree * F.leadingCoeff⁻¹
  have hscale : scale ≠ 0 := mul_ne_zero
    (pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero))
    (inv_ne_zero (leadingCoeff_ne_zero.mpr hF))
  obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq (-cmap f) hp.pos
  obtain ⟨a, ha, hnorm⟩ := hnorm
  have hformula := arbitrary_source_norm_inseparable_root F hF p f c hc
  rw [hnorm, map_pow] at hformula
  have hvalue : cmap scale * (F.map cmap).eval c = cmap a :=
    frobenius_inj L p hformula.symm
  let tau : K := scale⁻¹ * a
  have htau : tau ≠ 0 := mul_ne_zero (inv_ne_zero hscale) ha
  have heval : aeval c F = cmap tau := by
    have hs : cmap scale ≠ 0 := by
      intro hzero
      exact hscale (cmap.injective (hzero.trans cmap.map_zero.symm))
    have heval' : (F.map cmap).eval c = (cmap scale)⁻¹ * cmap a :=
      (eq_inv_mul_iff_mul_eq₀ hs).mpr hvalue
    simpa only [tau, map_mul, map_inv₀, eval_map, aeval_def] using heval'
  obtain ⟨H, hH⟩ := polynomial_constant_inseparable_remainder p hp f hnot c hc F tau heval
  exact ⟨H, tau, htau, hH⟩

/-- The converse also holds in every nonzero polynomial source algebra,
including nilpotents; its actual determinant norm is used. -/
theorem arbitrary_source_frobenius_remainder_norm (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (F H : K[X]) (tau : K) (htau : tau ≠ 0)
    (hF : F ≠ 0) (hsource : F = (X ^ p + C f) * H + C tau) :
    ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p := by
  classical
  letI : Fact p.Prime := ⟨hp⟩
  let L := AlgebraicClosure K
  let cmap : K →+* L := algebraMap K L
  letI : CharP L p := charP_of_injective_algebraMap cmap.injective p
  obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq (-cmap f) hp.pos
  refine ⟨(-1 : K) ^ F.natDegree * F.leadingCoeff⁻¹ * tau,
    mul_ne_zero (mul_ne_zero (pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero))
      (inv_ne_zero (leadingCoeff_ne_zero.mpr hF))) htau, ?_⟩
  apply cmap.injective
  rw [arbitrary_source_norm_inseparable_root F hF p f c hc]
  have hvalue : (F.map cmap).eval c = cmap tau := by
    rw [hsource, Polynomial.map_add, Polynomial.map_mul, Polynomial.map_add,
      Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C, Polynomial.map_C,
      eval_add, eval_mul, eval_add, eval_pow, eval_X, eval_C, eval_C,
      hc, neg_add_cancel, zero_mul, zero_add]
  rw [hvalue]
  simp only [map_pow, map_mul]
  rfl

/-- The full norm/remainder equivalence, uniqueness and degree bound for
every positive-degree polynomial, with source separability removed. -/
theorem arbitrary_source_norm_frobenius_remainder_package (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f)
    (F : K[X]) (hpositive : 0 < F.natDegree) :
    Specifications.SourceNormFrobeniusRemainder p f F := by
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, natDegree_zero] at hpositive
    exact (lt_irrefl 0) hpositive
  constructor
  · constructor
    · intro hnorm
      obtain ⟨H, tau, htau, hsource⟩ :=
        arbitrary_source_norm_frobenius_remainder p hp f hnot F hF hnorm
      refine ⟨(H, tau), ⟨htau, hsource⟩, ?_⟩
      intro other hother
      let L := AlgebraicClosure K
      obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq
        (-(algebraMap K L) f) hp.pos
      have h := inseparable_remainder_presentation_unique p hp f c hc F
        other.1 H other.2 tau hother.2 hsource
      exact Prod.ext h.1 h.2
    · rintro ⟨remainder, hsource, _⟩
      exact arbitrary_source_frobenius_remainder_norm p hp f F remainder.1 remainder.2
        hsource.1 hF hsource.2
  · intro hnorm
    obtain ⟨H, tau, _htau, hsource⟩ :=
      arbitrary_source_norm_frobenius_remainder p hp f hnot F hF hnorm
    exact frobenius_remainder_positive_degree_bound p hp.pos f F H tau hpositive hsource

end Litt3.CartierAndSpin
