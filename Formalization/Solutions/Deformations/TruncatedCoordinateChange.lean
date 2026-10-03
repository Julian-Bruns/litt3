import Theorems.Deformations.TruncatedCoordinateChange
import Solutions.Deformations.TruncatedValuation
import Mathlib.Tactic.Ring

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- All genuine parameter-times-unit changes of coordinate are
actual algebra automorphisms at every quotient length. -/
theorem truncated_coordinate_change_bijective (N : ℕ) :
    Specifications.TruncatedCoordinateChangeBijective (k := k) N := by
  intro φ hφ
  obtain ⟨v, hv⟩ := hφ
  have hzero : ∀ x, φ x = 0 → x = 0 := by
    intro x hx
    by_contra hn
    obtain ⟨j, hj, u, hu⟩ := truncated_scalar_valuation N x hn
    have hprod : truncatedParameter k N ^ j * ((v : TruncatedCoefficientRing k N) ^ j * φ u) =
        0 := by
      calc
        _ = φ (truncatedParameter k N ^ j * u) := by
          rw [map_mul, map_pow, hv, mul_pow]
          ring
        _ = 0 := by rw [← hu, hx]
    have hunit : IsUnit ((v : TruncatedCoefficientRing k N) ^ j * φ u) :=
      (v.isUnit.pow j).mul (u.isUnit.map φ)
    exact truncated_parameter_pow_nonzero N j hj (hunit.mul_left_eq_zero.mp hprod)
  have hinj : Function.Injective φ := by
    intro x y h
    apply sub_eq_zero.mp
    apply hzero
    rw [map_sub, h, sub_self]
  have hsurj : Function.Surjective φ :=
    (LinearMap.injective_iff_surjective (f := φ.toLinearMap)).mp hinj
  exact ⟨hinj, hsurj⟩

noncomputable def truncatedCoordinateChangeEquiv (N : ℕ)
    (φ : TruncatedCoefficientRing k N →ₐ[k] TruncatedCoefficientRing k N)
    (coordinate_change : IsTruncatedCoordinateChange N φ) :
    TruncatedCoefficientRing k N ≃ₐ[k] TruncatedCoefficientRing k N :=
  AlgEquiv.ofBijective φ (truncated_coordinate_change_bijective N φ coordinate_change)

end Litt3.Deformations
