import Definitions.CartierAndSpin.DifferentialEnergy
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination
import Solutions.CartierAndSpin.InverseSquareMoments
import Solutions.CartierAndSpin.WeightedMoments
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.CartierAndSpin

open Finset

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]

theorem derivation_inverseSquare_term (D : Derivation R K K) (w phi : K) (hphi : phi ≠ 0) :
    D (w ^ 2 / phi ^ 2) = 2 * w * D w / phi ^ 2 - 2 * w ^ 2 * D phi / phi ^ 3 := by
  simp only [D.leibniz_div, D.leibniz_pow, nsmul_eq_mul, smul_eq_mul,
    Nat.reduceSub, pow_one]
  field_simp
  ring

theorem derivation_source_moment_term (D : Derivation R K K)
    (w phi : K) (hphi : phi ≠ 0) (n : ℕ) :
    D (w ^ n / phi) = (n : K) * w ^ (n - 1) * D w / phi -
      w ^ n * D phi / phi ^ 2 := by
  simp only [D.leibniz_div, D.leibniz_pow, nsmul_eq_mul, smul_eq_mul]
  field_simp

/-- Differentiating any vanishing source moment gives its first
differential moment, with no division by the moment order. -/
theorem differential_first_moment_equation (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) (q : K)
    (hphi : ∀ i ∈ s, phi i ≠ 0) (hDphi : ∀ i ∈ s, D (phi i) = D q)
    (n : ℕ) (hmoment : (∑ i ∈ s, node i ^ n / phi i) = 0) :
    (n : K) * (∑ i ∈ s, node i ^ (n - 1) * D (node i) / phi i) =
      D q * (∑ i ∈ s, node i ^ n / phi i ^ 2) := by
  classical
  have hd := congrArg D hmoment
  simp only [map_sum, map_zero] at hd
  have hsum : (∑ i ∈ s, D (node i ^ n / phi i)) =
      (n : K) * (∑ i ∈ s, node i ^ (n - 1) * D (node i) / phi i) -
        D q * (∑ i ∈ s, node i ^ n / phi i ^ 2) := by
    calc
      _ = ∑ i ∈ s, ((n : K) * (node i ^ (n - 1) * D (node i) / phi i) -
          D q * (node i ^ n / phi i ^ 2)) := by
        apply sum_congr rfl
        intro i hi
        rw [derivation_source_moment_term D (node i) (phi i) (hphi i hi), hDphi i hi]
        ring
      _ = _ := by simp only [sum_sub_distrib, mul_sum]
  rw [hsum] at hd
  exact sub_eq_zero.mp hd

/-- Differentiation of the actual inverse-square moment gives the exact
cross term. Only invertibility of two is used in passing to c/tau. -/
theorem differential_inverseSquare_moment (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) (q c tau : K)
    (htwo : (2 : K) ≠ 0) (hphi : ∀ i ∈ s, phi i ≠ 0)
    (hDphi : ∀ i ∈ s, D (phi i) = D q)
    (hmoment : (∑ i ∈ s, node i ^ 2 / phi i ^ 2) = 2 * c / tau) :
    D (c / tau) = (∑ i ∈ s, node i * D (node i) / phi i ^ 2) -
      D q * (∑ i ∈ s, node i ^ 2 / phi i ^ 3) := by
  classical
  have hd := congrArg D hmoment
  rw [show 2 * c / tau = 2 * (c / tau) by ring] at hd
  have hDtwo : D (2 : K) = 0 := by simpa using D.map_natCast 2
  simp only [map_sum, D.leibniz, hDtwo, smul_eq_mul, mul_zero, add_zero] at hd
  have hsum : (∑ i ∈ s, D (node i ^ 2 / phi i ^ 2)) =
      2 * ((∑ i ∈ s, node i * D (node i) / phi i ^ 2) -
        D q * (∑ i ∈ s, node i ^ 2 / phi i ^ 3)) := by
    calc
      _ = ∑ i ∈ s, 2 * (node i * D (node i) / phi i ^ 2 -
          D q * (node i ^ 2 / phi i ^ 3)) := by
        apply sum_congr rfl
        intro i hi
        rw [derivation_inverseSquare_term D (node i) (phi i) (hphi i hi), hDphi i hi]
        ring
      _ = _ := by simp only [mul_sub, sum_sub_distrib, mul_sum]
  rw [hsum] at hd
  exact (mul_left_cancel₀ htwo hd).symm

/-- The twisted correction is an actual sum of squares whenever the
inverse-square coefficient moment holds. Characteristic and degree are
handled separately by the source moment theorem. -/
theorem twisted_differential_energy_square (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) (q c tau : K)
    (htwo : (2 : K) ≠ 0) (hphi : ∀ i ∈ s, phi i ≠ 0)
    (hDphi : ∀ i ∈ s, D (phi i) = D q)
    (hmoment : (∑ i ∈ s, node i ^ 2 / phi i ^ 2) = 2 * c / tau) :
    splitDifferentialEnergy D s node phi - 4 * D q * D (c / tau) =
      splitTwistedDifferentialEnergy D s node phi q := by
  rw [differential_inverseSquare_moment D s node phi q c tau htwo hphi hDphi hmoment]
  unfold splitDifferentialEnergy splitTwistedDifferentialEnergy
  calc
    _ = ∑ i ∈ s, (D (node i) ^ 2 / phi i -
        4 * D q * (node i * D (node i) / phi i ^ 2 -
          D q * (node i ^ 2 / phi i ^ 3))) := by
      simp only [mul_sub, sum_sub_distrib, mul_sum]
    _ = _ := by
      apply sum_congr rfl
      intro i hi
      have hi' := hphi i hi
      field_simp
      ring

open Polynomial

theorem characteristic_source_factor_derivation (D : Derivation R K K)
    (p : ℕ) [CharP K p] (w q : K) : D (w ^ p + q) = D q := by
  simp only [map_add, D.leibniz_pow, nsmul_eq_mul, smul_eq_mul,
    CharP.cast_eq_zero, zero_mul, zero_add]

/-- The characteristic-p twist is an actual differentiated power, for
every nonzero phi satisfying Dphi=Dq. -/
theorem characteristic_twisted_power_derivative (D : Derivation R K K)
    (p : ℕ) [CharP K p] (w phi q : K) (hp : 3 ≤ p) (hphi : phi ≠ 0)
    (hDphi : D phi = D q) :
    D (w * phi ^ (p - 2)) =
      phi ^ (p - 2) * (D w - 2 * w * D q / phi) := by
  have hcast : ((p - 2 : ℕ) : K) = -(2 : K) := by
    rw [Nat.cast_sub (by omega), CharP.cast_eq_zero, Nat.cast_two, zero_sub]
  have hexponent : p - 2 - 1 = p - 3 := by omega
  have hpower : phi ^ (p - 2) = phi ^ (p - 3) * phi := by
    rw [show p - 2 = (p - 3) + 1 by omega, pow_succ]
  simp only [D.leibniz, D.leibniz_pow, nsmul_eq_mul, smul_eq_mul,
    hcast, hexponent, hDphi]
  rw [hpower]
  field_simp
  ring

theorem characteristic_twisted_power_square (D : Derivation R K K)
    (p : ℕ) [CharP K p] (w phi q : K) (hp : 3 ≤ p) (hphi : phi ≠ 0)
    (hDphi : D phi = D q) :
    (D w - 2 * w * D q / phi) ^ 2 / phi =
      (D (w * phi ^ (p - 2))) ^ 2 / phi ^ (2 * p - 3) := by
  have hpower : phi ^ (2 * p - 3) = (phi ^ (p - 2)) ^ 2 * phi := by
    rw [show 2 * p - 3 = (p - 2) * 2 + 1 by omega, pow_add, pow_mul, pow_one]
  rw [characteristic_twisted_power_derivative D p w phi q hp hphi hDphi, mul_pow, hpower]
  exact (mul_div_mul_left _ _ (pow_ne_zero 2 (pow_ne_zero (p - 2) hphi))).symm

/-- The source equation itself certifies every split-root denominator. -/
theorem split_source_factor_ne_zero (s : Finset ι) (node : ι → K)
    (F H : K[X]) (p : ℕ) (q tau c : K) (htau : tau ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) (i : ι) (hi : i ∈ s) :
    node i ^ p + q ≠ 0 := by
  have hFzero : F.eval (node i) = 0 := by
    rw [hFsplit, Polynomial.eval_mul, Polynomial.eval_C,
      Lagrange.eval_nodal_at_node hi, mul_zero]
  have h := congrArg (fun P : K[X] => P.eval (node i)) hsource
  simp only [Polynomial.eval_add, Polynomial.eval_mul, Polynomial.eval_pow,
    Polynomial.eval_X, Polynomial.eval_C, hFzero] at h
  intro hzero
  rw [hzero, zero_mul, zero_add] at h
  exact htau h.symm

/-- The actual characteristic-p split source supplies the inverse-square
moment internally, so the corrected source energy is an actual sum of
twisted squares, in every degree and every odd characteristic. -/
theorem split_source_twisted_differential_square (D : Derivation R K K)
    (s : Finset ι) (node : ι → K) (hinj : Set.InjOn node s)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau c : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    splitDifferentialEnergy D s node (fun i => node i ^ p + q) -
      4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) =
      splitTwistedDifferentialEnergy D s node (fun i => node i ^ p + q) q := by
  have hH : H ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := by
      rw [hsource, hzero, mul_zero, zero_add, Polynomial.natDegree_C]
    omega
  have htwo : (2 : K) ≠ 0 := by
    intro hzero
    have hdivides : p ∣ 2 := (CharP.cast_eq_zero_iff K p 2).mp hzero
    have hle := Nat.le_of_dvd (by decide : 0 < 2) hdivides
    omega
  apply twisted_differential_energy_square D s node (fun i => node i ^ p + q)
    q ((H %ₘ (X ^ p + C q)).coeff (p - 2)) tau htwo
  · exact split_source_factor_ne_zero s node F H p q tau c htau hFsplit hsource
  · intro i hi
    exact characteristic_source_factor_derivation D p (node i) q
  · exact split_inseparable_source_inverseSquare_moment s node hinj F H p q tau c
      (by omega) hH htau hc hFsplit hsource 2 (by omega)

/-- The second canonical square presentation is proved for the same
actual source, with the characteristic-p exponent cancellation explicit. -/
theorem split_source_twisted_power_square (D : Derivation R K K)
    (s : Finset ι) (node : ι → K) (hinj : Set.InjOn node s)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau c : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    splitDifferentialEnergy D s node (fun i => node i ^ p + q) -
      4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) =
      ∑ i ∈ s, (D (node i * (node i ^ p + q) ^ (p - 2))) ^ 2 /
        (node i ^ p + q) ^ (2 * p - 3) := by
  rw [split_source_twisted_differential_square D s node hinj F H p q tau c hp
    hdegree htau hc hFsplit hsource]
  unfold splitTwistedDifferentialEnergy
  apply sum_congr rfl
  intro i hi
  exact characteristic_twisted_power_square D p (node i) (node i ^ p + q) q hp
    (split_source_factor_ne_zero s node F H p q tau c htau hFsplit hsource i hi)
    (characteristic_source_factor_derivation D p (node i) q)

/-- Every first differential moment below characteristic p is supplied
by the actual source coefficient. The proof divides only by j, whose
nonvanishing follows from 0<j<p. -/
theorem split_source_differential_moment (D : Derivation R K K)
    (s : Finset ι) (node : ι → K) (hinj : Set.InjOn node s)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau c : K)
    (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) (j : ℕ) (hjzero : 0 < j) (hj : j < p) :
    (∑ i ∈ s, node i ^ (j - 1) * D (node i) / (node i ^ p + q)) =
      (H %ₘ (X ^ p + C q)).coeff (p - j) * D q / tau := by
  have hH : H ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := by
      rw [hsource, hzero, mul_zero, zero_add, Polynomial.natDegree_C]
    omega
  have hjcast : (j : K) ≠ 0 := by
    intro hzero
    have hdivides : p ∣ j := (CharP.cast_eq_zero_iff K p j).mp hzero
    have hle := Nat.le_of_dvd hjzero hdivides
    omega
  have hfirst := split_inseparable_source_moment_zero s node hinj F H p q tau c
    (by omega) hH hc hFsplit hsource j hj
  have hsecond := split_inseparable_source_inverseSquare_moment s node hinj F H p
    q tau c hp hH htau hc hFsplit hsource j hj
  have hd := differential_first_moment_equation D s node (fun i => node i ^ p + q) q
    (split_source_factor_ne_zero s node F H p q tau c htau hFsplit hsource)
    (fun i _hi => characteristic_source_factor_derivation D p (node i) q) j hfirst
  rw [hsecond] at hd
  apply mul_left_cancel₀ hjcast
  exact hd.trans (by ring)

/-- Derivatives of translated roots obey the complete moment law. The
weights are arbitrary and the derivation has no characteristic restriction. -/
theorem differential_weightedMoment_translate (D : Derivation R K K)
    (s : Finset ι) (weight node : ι → K) (b : K) (n : ℕ) :
    weightedMoment s weight (fun i => D (node i + b)) n =
      ∑ j ∈ range (n + 1), (n.choose j : K) * D b ^ (n - j) *
        weightedMoment s weight (fun i => D (node i)) j := by
  simp only [map_add]
  exact weightedMoment_translate s weight (fun i => D (node i)) (D b) n

theorem splitDifferentialEnergy_eq_weightedMoment (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) :
    splitDifferentialEnergy D s node phi =
      weightedMoment s (fun i => (phi i)⁻¹) (fun i => D (node i)) 2 := by
  unfold splitDifferentialEnergy weightedMoment
  apply sum_congr rfl
  intro i hi
  ring

/-- Source translation preserves its denominator, in every positive
characteristic. No polynomial roots are assumed here. -/
theorem characteristic_source_denominator_translation (p : ℕ) [CharP K p]
    (hp : 2 ≤ p) (w q b : K) :
    (w + b) ^ p + (q - b ^ p) = w ^ p + q := by
  letI : Fact p.Prime := ⟨CharP.char_is_prime_of_two_le K p hp⟩
  rw [add_pow_char]
  ring

/-- The actual trace-zero source supplies both vanishing moments of the
derivative values; they are consequences rather than extra assumptions. -/
theorem split_source_derivative_moments_zero (D : Derivation R K K)
    (s : Finset ι) (node : ι → K) (hinj : Set.InjOn node s)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau c : K)
    (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (htraceZero : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0) :
    weightedMoment s (fun i => (node i ^ p + q)⁻¹) (fun i => D (node i)) 0 = 0 ∧
    weightedMoment s (fun i => (node i ^ p + q)⁻¹) (fun i => D (node i)) 1 = 0 := by
  have hH : H ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := by
      rw [hsource, hzero, mul_zero, zero_add, Polynomial.natDegree_C]
    omega
  constructor
  · have hzero := split_inseparable_source_moment_zero s node hinj F H p q tau c
      (by omega) hH hc hFsplit hsource 0 (by omega)
    simpa only [weightedMoment, pow_zero, mul_one, one_div] using hzero
  · have hone := split_source_differential_moment D s node hinj F H p q tau c
      hp hdegree htau hc hFsplit hsource 1 (by omega) (by omega)
    rw [htraceZero, zero_mul, zero_div] at hone
    simpa only [weightedMoment, pow_one, Nat.reduceSub, pow_zero, one_mul,
      div_eq_mul_inv, mul_comm] using hone

/-- The entire translated derivative-moment family of the same actual
source has the stated binomial law with the transformed q. -/
theorem split_source_derivativeMoment_translation (D : Derivation R K K)
    (s : Finset ι) (node : ι → K) (p : ℕ) [CharP K p] (q b : K)
    (hp : 2 ≤ p) (n : ℕ) :
    weightedMoment s (fun i => ((node i + b) ^ p + (q - b ^ p))⁻¹)
      (fun i => D (node i + b)) n =
      ∑ j ∈ range (n + 1), (n.choose j : K) * D b ^ (n - j) *
        weightedMoment s (fun i => (node i ^ p + q)⁻¹) (fun i => D (node i)) j := by
  simp only [characteristic_source_denominator_translation p hp]
  exact differential_weightedMoment_translate D s (fun i => (node i ^ p + q)⁻¹)
    node b n

/-- Quadratic energy and the cubic/quartic discriminant are invariant
under every base translation on the actual trace-zero source. The result
already holds in characteristic two when the source hypotheses hold. -/
theorem split_source_traceZero_translation_invariant (D : Derivation R K K)
    (s : Finset ι) (node : ι → K) (hinj : Set.InjOn node s)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau c : K)
    (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (htraceZero : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0) (b : K) :
    splitDifferentialEnergy D s (fun i => node i + b)
        (fun i => (node i + b) ^ p + (q - b ^ p)) =
      splitDifferentialEnergy D s node (fun i => node i ^ p + q) ∧
    momentDiscriminant s (fun i => ((node i + b) ^ p + (q - b ^ p))⁻¹)
        (fun i => D (node i + b)) =
      momentDiscriminant s (fun i => (node i ^ p + q)⁻¹) (fun i => D (node i)) := by
  obtain ⟨hzero, hone⟩ := split_source_derivative_moments_zero D s node hinj F H p
    q tau c hp hdegree htau hc hFsplit hsource htraceZero
  simp only [splitDifferentialEnergy_eq_weightedMoment, map_add,
    characteristic_source_denominator_translation p hp]
  exact ⟨weightedMoment_two_translation_invariant s _ _ (D b) hzero hone,
    momentDiscriminant_translation_invariant s _ _ (D b) hzero hone⟩

end Litt3.CartierAndSpin
