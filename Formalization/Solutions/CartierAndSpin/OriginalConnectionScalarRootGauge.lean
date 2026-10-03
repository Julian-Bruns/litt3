import Solutions.CartierAndSpin.RestrictedCurvatureGaugeClassification
import Solutions.CartierAndSpin.FrobeniusLinearDerivations

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- A genuine root of negative curvature in the ACTUAL pth-power
subfield constructs an ORIGINAL field unit carrying the ENTIRE original
connection to D+a. No matrix normal form, perfectness of K, finite degree
over R, supplied unit or scalar-extension solution is used. -/
theorem actual_original_connection_scalar_root_unit_gauge
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) (a : frobeniusSubfield K p)
    (ha : (a : K) ^ p = -(D^[p - 1] f + f ^ p)) :
    ∃ u : Kˣ, ∀ x : K,
      scalarDerivationConnection D f ((u : K) * x) =
        (u : K) * (D x + (a : K) * x) := by
  have hexp : p - 1 = (p - 2) + 1 := by
    have hp := (Fact.out : p.Prime).two_le
    omega
  have hiter : D^[p - 1] (-(a : K)) = 0 := by
    rw [hexp, Function.iterate_succ_apply, D.map_neg,
      actual_derivation_kills_frobenius_subfield D a, neg_zero]
    exact iterate_map_zero D (p - 2)
  have hnegpow : (-(a : K)) ^ p = -(a : K) ^ p :=
    (frobenius K p).map_neg (a : K)
  have hcurv : D^[p - 1] f + f ^ p =
      D^[p - 1] (-(a : K)) + (-(a : K)) ^ p := by
    rw [hiter, zero_add, hnegpow, ha, neg_neg]
  obtain ⟨u, hu⟩ :=
    (actual_normalized_curvature_eq_iff_connection_unit_intertwiner
      b D hDt f (-(a : K))).mp hcurv
  refine ⟨u, ?_⟩
  intro x
  have hx := hu x
  change scalarDerivationConnection D f ((u : K) * x) =
    (u : K) * (D x - (-(a : K)) * x) at hx
  simpa only [neg_mul, sub_neg_eq_add] using hx

end Litt3.CartierAndSpin
