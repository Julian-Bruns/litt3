import Solutions.CartierAndSpin.TraceEnergy
import Solutions.CartierAndSpin.UnsplitSourceEnergy
import Solutions.CartierAndSpin.LinearMoments

namespace Litt3.CartierAndSpin

open Polynomial Module

variable {R K A : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A]

/-- The complete affine derivative-square expansion for every actual
linear functional and compatible derivation on a commutative algebra. -/
theorem functional_affine_derivative_square (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (linear : A →ₗ[K] K) (weight w : A) (a b : K) :
    linear (E (algebraMap K A a * w + algebraMap K A b) ^ 2 * weight) =
      a ^ 2 * linear (E w ^ 2 * weight) +
      2 * a * D a * linear (w * E w * weight) +
      2 * a * D b * linear (E w * weight) +
      D a ^ 2 * linear (w ^ 2 * weight) +
      2 * D a * D b * linear (w * weight) + D b ^ 2 * linear weight := by
  have hderivative : E (algebraMap K A a * w + algebraMap K A b) =
      a • E w + D a • w + D b • (1 : A) := by
    rw [map_add, E.leibniz, compatible a, compatible b]
    simp only [smul_eq_mul, Algebra.smul_def]
    ring
  rw [hderivative]
  have hexpansion : (a • E w + D a • w + D b • (1 : A)) ^ 2 * weight =
      a ^ 2 • (E w ^ 2 * weight) +
      (2 * a * D a) • (w * E w * weight) +
      (2 * a * D b) • (E w * weight) +
      D a ^ 2 • (w ^ 2 * weight) +
      (2 * D a * D b) • (w * weight) + D b ^ 2 • weight := by
    simp only [Algebra.smul_def, map_mul, map_pow, map_ofNat]
    ring
  rw [hexpansion]
  simp only [map_add, map_smul, smul_eq_mul]

/-- A centered square with its two actual vanishing moments has its
exact affine scaling weight, even when the scaling coefficient varies
under the base derivation. -/
theorem functional_centered_derivative_square_scaling (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (linear : A →ₗ[K] K) (weight z : A) (a : K) (p : ℕ)
    (hcross : linear (z * E z * weight) = 0)
    (hsquare : linear (z ^ 2 * weight) = 0) :
    linear (E (algebraMap K A a * z) ^ 2 * ((a ^ p)⁻¹ • weight)) =
      a ^ 2 / a ^ p * linear (E z ^ 2 * weight) := by
  have hweight : E (algebraMap K A a * z) ^ 2 * ((a ^ p)⁻¹ • weight) =
      (a ^ p)⁻¹ • (E (algebraMap K A a * z) ^ 2 * weight) := by
    simp only [Algebra.smul_def]
    ring
  rw [hweight, map_smul]
  have h := functional_affine_derivative_square D E compatible linear weight z a 0
  simp only [map_zero, add_zero, D.map_zero, mul_zero, zero_mul,
    zero_pow (by decide : 2 ≠ 0), hcross, hsquare] at h
  rw [h]
  simp only [smul_eq_mul, div_eq_mul_inv]
  ring

/-- All centered source moments needed for scaling follow from the
actual first and inverse-square moment families, by actual trace
differentiation. No split-root presentation is assumed. -/
theorem actual_centered_trace_moments {ι : Type*} [Fintype ι]
    (D : Derivation R K K) (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (basis : Basis ι K A) (w : A) (unit : Aˣ) (q tau s c : K)
    (hs : s ≠ 0) (htwo : (2 : K) ≠ 0)
    (hunit : E (unit : A) = algebraMap K A (D q))
    (hfirst : ∀ j, j ≤ 2 → Algebra.trace K A (w ^ j * (↑unit⁻¹ : A)) = 0)
    (hsecond : ∀ j, j ≤ 2 → Algebra.trace K A (w ^ j * (↑unit⁻¹ : A) ^ 2) =
      if j = 0 then 0 else if j = 1 then s / tau else 2 * c / tau) :
    let z := w - algebraMap K A (c / s)
    Algebra.trace K A (z ^ 2 * (↑unit⁻¹ : A)) = 0 ∧
      Algebra.trace K A (z * E z * (↑unit⁻¹ : A)) = 0 := by
  let z := w - algebraMap K A (c / s)
  have hcenter (weight : A) :
      Algebra.trace K A (z ^ 2 * weight) =
      Algebra.trace K A (w ^ 2 * weight) -
        2 * (c / s) * Algebra.trace K A (w * weight) +
        (c / s) ^ 2 * Algebra.trace K A weight := by
    have h := functionalMoment_translate_two (Algebra.trace K A) weight w (-(c / s))
    simpa only [functionalMoment, z, map_neg, sub_eq_add_neg, pow_one, pow_zero,
      one_mul, mul_neg, neg_mul, neg_sq] using h
  have hfirstZ : Algebra.trace K A (z ^ 2 * (↑unit⁻¹ : A)) = 0 := by
    rw [hcenter]
    have hzero := hfirst 0 (by omega)
    have hone := hfirst 1 (by omega)
    simp only [pow_zero, one_mul] at hzero
    simp only [pow_one] at hone
    rw [hfirst 2 (by omega), hone, hzero]
    ring
  have hsecondZ : Algebra.trace K A (z ^ 2 * (↑unit⁻¹ : A) ^ 2) = 0 := by
    rw [hcenter]
    have hzero := hsecond 0 (by omega)
    have hone := hsecond 1 (by omega)
    have htwo' := hsecond 2 (by omega)
    norm_num at hzero hone htwo'
    rw [htwo', hone, hzero]
    field_simp
    ring
  have hcross := trace_first_differential_moment_equation D E compatible basis z unit q
    hunit 2 hfirstZ
  simp only [Nat.reduceSub, pow_one, Nat.cast_ofNat, hsecondZ, mul_zero] at hcross
  exact ⟨hfirstZ, (mul_eq_zero.mp hcross).resolve_left htwo⟩

/-- The centered energy expansion in every actual algebra, using only
the two actual moments. Its denominator boundary is explicit. -/
theorem functional_centered_energy_ratio (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (linear : A →ₗ[K] K) (weight w : A) (q tau s c : K) (hs : s ≠ 0)
    (hzero : linear weight = 0) (hone : linear (E w * weight) = s * D q / tau) :
    linear (E (w - algebraMap K A (c / s)) ^ 2 * weight) =
      linear (E w ^ 2 * weight) - 2 * D q / tau * (D c - c / s * D s) := by
  have h := functional_affine_derivative_square D E compatible linear weight w 1 (-(c / s))
  simp only [map_one, one_mul, map_neg, ← sub_eq_add_neg, D.map_one_eq_zero,
    map_neg, mul_zero, zero_mul, zero_pow (by decide : 2 ≠ 0),
    one_pow, hzero, hone, neg_sq, add_zero] at h
  rw [h, D.leibniz_div]
  simp only [smul_eq_mul]
  field_simp
  ring

/-- The actual source quotient supplies all centered vanishing moments
and the full energy scaling law. Scaling and translation coefficients
may be meromorphic elements with nonzero derivatives. -/
theorem source_quotient_centered_affine_scaling (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0) :
    let center := (H %ₘ (X ^ p + C q)).coeff (p - 2) /
      (H %ₘ (X ^ p + C q)).coeff (p - 1)
    ∃ unit : (AdjoinRoot F)ˣ, ∃ E : Derivation R (AdjoinRoot F) (AdjoinRoot F),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
        algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ a b : K,
        Algebra.trace K (AdjoinRoot F)
          (E (algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F +
            algebraMap K (AdjoinRoot F) b -
            algebraMap K (AdjoinRoot F) (a * center + b)) ^ 2 *
            ((a ^ p)⁻¹ • (↑unit⁻¹ : AdjoinRoot F))) =
        a ^ 2 / a ^ p * Algebra.trace K (AdjoinRoot F)
          (E (AdjoinRoot.root F - algebraMap K (AdjoinRoot F) center) ^ 2 *
            (↑unit⁻¹ : AdjoinRoot F)) := by
  dsimp only
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, natDegree_zero] at hdegree
    omega
  have htwo : (2 : K) ≠ 0 := by
    intro hzero
    have hdvd := (CharP.cast_eq_zero_iff K p 2).mp hzero
    have := Nat.le_of_dvd (by decide : 0 < 2) hdvd
    omega
  obtain ⟨unit, hunit, hmoments⟩ := source_coefficient_moments F H p q tau
    (by omega) hdegree htau hsep hsource
  obtain ⟨E, compatible⟩ := separable_polynomial_quotient_derivation_exists D F hsep
  have hunitD := source_quotient_factor_derivation D F E compatible p q unit hunit
  have hfirst : ∀ j, j ≤ 2 →
      Algebra.trace K (AdjoinRoot F) (AdjoinRoot.root F ^ j *
        (↑unit⁻¹ : AdjoinRoot F)) = 0 := fun j hj => (hmoments j (by omega)).1
  have hsecond : ∀ j, j ≤ 2 →
      Algebra.trace K (AdjoinRoot F) (AdjoinRoot.root F ^ j *
        (↑unit⁻¹ : AdjoinRoot F) ^ 2) =
      if j = 0 then 0 else if j = 1 then (H %ₘ (X ^ p + C q)).coeff (p - 1) / tau
        else 2 * (H %ₘ (X ^ p + C q)).coeff (p - 2) / tau := by
    intro j hj
    have h := (hmoments j (by omega)).2
    interval_cases j <;> simpa using h
  obtain ⟨hsquare, hcross⟩ := actual_centered_trace_moments D E compatible
    (AdjoinRoot.powerBasis hF).basis (AdjoinRoot.root F) unit q tau
    ((H %ₘ (X ^ p + C q)).coeff (p - 1))
    ((H %ₘ (X ^ p + C q)).coeff (p - 2)) hs htwo hunitD hfirst hsecond
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro a b
  have hcoordinate : algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F +
      algebraMap K (AdjoinRoot F) b -
      algebraMap K (AdjoinRoot F) (a *
        ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
          (H %ₘ (X ^ p + C q)).coeff (p - 1)) + b) =
      algebraMap K (AdjoinRoot F) a * (AdjoinRoot.root F -
        algebraMap K (AdjoinRoot F) ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
          (H %ₘ (X ^ p + C q)).coeff (p - 1))) := by
    rw [map_add, map_mul]
    ring
  rw [hcoordinate]
  exact functional_centered_derivative_square_scaling D E compatible
    (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F) _ a p hcross hsquare

end Litt3.CartierAndSpin
