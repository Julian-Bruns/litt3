import Solutions.CartierAndSpin.LaurentSourceEndpoint
import Solutions.CartierAndSpin.LaurentIntegralPolynomials

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

theorem characteristic_five_corrected_energy_identity {R K : Type*}
    [CommRing R] [Field K] [Algebra R K] [CharP K 5]
    (D : Derivation R K K) (energy q c tau : K) (htau : tau ≠ 0) :
    energy - D q * D c / tau - c * D q * D tau / tau ^ 2 =
      (energy - 4 * D q * D (c / tau)) - 2 * D q * D c / tau := by
  rw [D.leibniz_div]
  simp only [smul_eq_mul]
  have hfive : (5 : K) = 0 := CharP.cast_eq_zero K 5
  field_simp
  linear_combination D q * (D c * tau - c * D tau) * hfive

/-- The characteristic-five correction has at most a simple pole
whenever c is integral and q,tau both have exact order three. -/
theorem laurent_corrected_energy_simple_pole [CharP k 5]
    (energy q c tau : LaurentSeries k)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hc : (0 : WithTop ℤ) ≤ c.orderTop)
    (hsharp : (-1 : WithTop ℤ) ≤
      (energy - 4 * laurentDerivation k q * laurentDerivation k (c / tau)).orderTop) :
    (-1 : WithTop ℤ) ≤
      (energy - laurentDerivation k q * laurentDerivation k c / tau -
        c * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop := by
  letI : CharP (LaurentSeries k) 5 :=
    charP_of_injective_algebraMap (algebraMap k (LaurentSeries k)).injective 5
  have htauzero : tau ≠ 0 := by intro h; simp [h] at htau
  rw [characteristic_five_corrected_energy_identity (laurentDerivation k)
    energy q c tau htauzero]
  have hDq : (2 : WithTop ℤ) ≤ (laurentDerivation k q).orderTop :=
    Litt3.QuotientGeometry.laurent_derivative_orderTop_bound q 3 hq.ge
  have hDc : (0 : WithTop ℤ) ≤ (laurentDerivation k c).orderTop :=
    laurent_derivative_integral_order c hc
  have hproduct := laurent_orderTop_mul_bound (laurentDerivation k q)
    (laurentDerivation k c) 2 0 hDq hDc
  simp only [add_zero] at hproduct
  have hquotient := laurent_quotient_orderTop_bound
    (laurentDerivation k q * laurentDerivation k c) tau 2 3 hproduct htau
  norm_num only at hquotient
  have hcorrection := laurent_natCast_mul_order_bound 2
    (laurentDerivation k q * laurentDerivation k c / tau) (-1) hquotient
  have hcorrection' : (-1 : WithTop ℤ) ≤
      (2 * laurentDerivation k q * laurentDerivation k c / tau).orderTop := by
    rw [show 2 * laurentDerivation k q * laurentDerivation k c / tau =
      2 * (laurentDerivation k q * laurentDerivation k c / tau) by ring]
    exact hcorrection
  exact le_trans (le_min hsharp hcorrection') HahnSeries.min_orderTop_le_orderTop_sub

/-- The actual source polynomial supplies the corrected simple-pole
estimate from integral coefficients of H; its leading coefficient need
not be a unit for this bound. -/
theorem split_source_laurent_corrected_endpoint_bound [CharP k 5]
    (s : Finset ι) (node : ι → LaurentSeries k) (hinj : Set.InjOn node s)
    (F H : (LaurentSeries k)[X]) (q tau leading : LaurentSeries k)
    (hdegree : 5 ≤ F.natDegree) (htauzero : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal s node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hnodes : ∀ i ∈ s, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop) :
    let c := (H %ₘ (X ^ 5 + C q)).coeff 3
    (-1 : WithTop ℤ) ≤
      (splitDifferentialEnergy (laurentDerivation k) s node (fun i => node i ^ 5 + q) -
        laurentDerivation k q * laurentDerivation k c / tau -
        c * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop := by
  dsimp only
  apply laurent_corrected_energy_simple_pole _ q _ tau hq htau
  · apply laurent_characteristic_remainder_integral H q 5 (by omega) hH
    exact le_trans (by norm_num) hq.ge
  · exact split_source_laurent_twisted_endpoint_bound s node hinj F H 5 2 q tau leading
      rfl (by omega) hdegree htauzero hleading hFsplit hsource hnodes hq

end Litt3.CartierAndSpin
