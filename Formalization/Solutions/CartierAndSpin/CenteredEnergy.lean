import Definitions.CartierAndSpin.CenteredEnergy
import Solutions.CartierAndSpin.DifferentialEnergy

namespace Litt3.CartierAndSpin

open Finset Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]

/-- The center-energy expansion uses only the two stated actual moments. -/
theorem split_centered_energy_expansion (D : Derivation R K K)
    (indices : Finset ι) (node phi : ι → K) (q tau s center : K)
    (hzero : (∑ i ∈ indices, 1 / phi i) = 0)
    (hone : (∑ i ∈ indices, D (node i) / phi i) = s * D q / tau) :
    splitCenteredDifferentialEnergy D indices node phi center =
      splitDifferentialEnergy D indices node phi - 2 * D center * s * D q / tau := by
  unfold splitCenteredDifferentialEnergy splitDifferentialEnergy
  calc
    _ = ∑ i ∈ indices, (D (node i) ^ 2 / phi i -
        2 * D center * (D (node i) / phi i) + D center ^ 2 * (1 / phi i)) := by
      apply sum_congr rfl
      intro i hi
      ring
    _ = (∑ i ∈ indices, D (node i) ^ 2 / phi i) -
        2 * D center * (∑ i ∈ indices, D (node i) / phi i) +
        D center ^ 2 * (∑ i ∈ indices, 1 / phi i) := by
      simp only [mul_sum, sum_sub_distrib, sum_add_distrib]
    _ = _ := by rw [hzero, hone]; ring

/-- The canonical affine center c/s gives the stated correction. The
only excluded boundary is the explicitly used coefficient s=0. -/
theorem split_centered_energy_ratio (D : Derivation R K K)
    (indices : Finset ι) (node phi : ι → K) (q tau s c : K) (hs : s ≠ 0)
    (hzero : (∑ i ∈ indices, 1 / phi i) = 0)
    (hone : (∑ i ∈ indices, D (node i) / phi i) = s * D q / tau) :
    splitCenteredDifferentialEnergy D indices node phi (c / s) =
      splitDifferentialEnergy D indices node phi -
        2 * D q / tau * (D c - c / s * D s) := by
  rw [split_centered_energy_expansion D indices node phi q tau s (c / s) hzero hone,
    D.leibniz_div]
  simp only [smul_eq_mul]
  field_simp

/-- Clearing s gives a formula that is defined on the entire coefficient
space. Its identification with s times centered energy needs s nonzero. -/
theorem split_cleared_centered_energy_eq (D : Derivation R K K)
    (indices : Finset ι) (node phi : ι → K) (q tau s c : K) (hs : s ≠ 0)
    (hzero : (∑ i ∈ indices, 1 / phi i) = 0)
    (hone : (∑ i ∈ indices, D (node i) / phi i) = s * D q / tau) :
    splitClearedCenteredEnergy D indices node phi q tau s c =
      s * splitCenteredDifferentialEnergy D indices node phi (c / s) := by
  rw [split_centered_energy_ratio D indices node phi q tau s c hs hzero hone]
  unfold splitClearedCenteredEnergy
  field_simp

theorem split_cleared_centered_energy_zero (D : Derivation R K K)
    (indices : Finset ι) (node phi : ι → K) (q tau c : K) :
    splitClearedCenteredEnergy D indices node phi q tau 0 c = 0 := by
  simp [splitClearedCenteredEnergy]

/-- Both moments needed by the affine center follow from the actual
source equation. This statement allows any source degree at least p. -/
theorem split_source_centered_energy_ratio (D : Derivation R K K)
    (indices : Finset ι) (node : ι → K) (hinj : Set.InjOn node indices)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau leading : K)
    (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hleading : leading ≠ 0) (hFsplit : F = C leading * Lagrange.nodal indices node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0) :
    splitCenteredDifferentialEnergy D indices node (fun i => node i ^ p + q)
        ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
          (H %ₘ (X ^ p + C q)).coeff (p - 1)) =
      splitDifferentialEnergy D indices node (fun i => node i ^ p + q) -
        2 * D q / tau * (D ((H %ₘ (X ^ p + C q)).coeff (p - 2)) -
          (H %ₘ (X ^ p + C q)).coeff (p - 2) /
            (H %ₘ (X ^ p + C q)).coeff (p - 1) *
              D ((H %ₘ (X ^ p + C q)).coeff (p - 1))) := by
  have hH : H ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := by
      rw [hsource, hzero, mul_zero, zero_add, Polynomial.natDegree_C]
    omega
  apply split_centered_energy_ratio D indices node (fun i => node i ^ p + q)
    q tau _ _ hs
  · simpa only [pow_zero] using
      split_inseparable_source_moment_zero indices node hinj F H p q tau leading
        (by omega) hH hleading hFsplit hsource 0 (by omega)
  · simpa only [Nat.reduceSub, pow_zero, one_mul] using
      split_source_differential_moment D indices node hinj F H p q tau leading hp
        hdegree htau hleading hFsplit hsource 1 (by omega) (by omega)

end Litt3.CartierAndSpin
