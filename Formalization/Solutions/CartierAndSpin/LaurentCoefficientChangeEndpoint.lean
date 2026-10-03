import Solutions.CartierAndSpin.LaurentCorrectedEndpoint

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

theorem corrected_energy_coefficient_change {R K : Type*} [CommRing R] [Field K]
    [Algebra R K] (D : Derivation R K K) (energy q c delta tau : K) :
    energy - D q * D (c + delta) / tau - (c + delta) * D q * D tau / tau ^ 2 =
      (energy - D q * D c / tau - c * D q * D tau / tau ^ 2) -
        D q * D delta / tau - delta * D q * D tau / tau ^ 2 := by
  rw [map_add]
  ring

/-- A coefficient change divisible by the parameter's third power
does not worsen the corrected-energy simple-pole bound. -/
theorem laurent_corrected_energy_coefficient_change_bound
    (energy q c delta tau : LaurentSeries k)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hdelta : (3 : WithTop ℤ) ≤ delta.orderTop)
    (henergy : (-1 : WithTop ℤ) ≤
      (energy - laurentDerivation k q * laurentDerivation k c / tau -
        c * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop) :
    (-1 : WithTop ℤ) ≤
      (energy - laurentDerivation k q * laurentDerivation k (c + delta) / tau -
        (c + delta) * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop := by
  rw [corrected_energy_coefficient_change]
  have hDq : (2 : WithTop ℤ) ≤ (laurentDerivation k q).orderTop :=
    Litt3.QuotientGeometry.laurent_derivative_orderTop_bound q 3 hq.ge
  have hDtau : (2 : WithTop ℤ) ≤ (laurentDerivation k tau).orderTop :=
    Litt3.QuotientGeometry.laurent_derivative_orderTop_bound tau 3 htau.ge
  have hDdelta : (2 : WithTop ℤ) ≤ (laurentDerivation k delta).orderTop :=
    Litt3.QuotientGeometry.laurent_derivative_orderTop_bound delta 3 hdelta
  have hproductA := laurent_orderTop_mul_bound (laurentDerivation k q)
    (laurentDerivation k delta) 2 2 hDq hDdelta
  norm_num only at hproductA
  have hA := laurent_quotient_orderTop_bound
    (laurentDerivation k q * laurentDerivation k delta) tau 4 3 hproductA htau
  norm_num only at hA
  have hproductB := laurent_orderTop_mul_bound delta (laurentDerivation k q) 3 2 hdelta hDq
  norm_num only at hproductB
  have hproductB' := laurent_orderTop_mul_bound
    (delta * laurentDerivation k q) (laurentDerivation k tau) 5 2 hproductB hDtau
  norm_num only at hproductB'
  have htauPower : (tau ^ 2).orderTop = (6 : WithTop ℤ) := by
    rw [laurent_orderTop_power, htau]
    change 2 • ((3 : ℤ) : WithTop ℤ) = ((6 : ℤ) : WithTop ℤ)
    rw [← WithTop.coe_nsmul]
    rfl
  have hB := laurent_quotient_orderTop_bound
    (delta * laurentDerivation k q * laurentDerivation k tau) (tau ^ 2) 7 6
    hproductB' htauPower
  norm_num only at hB
  have hA' : (-1 : WithTop ℤ) ≤
      (laurentDerivation k q * laurentDerivation k delta / tau).orderTop :=
    le_trans (WithTop.coe_le_coe.mpr (by norm_num : (-1 : ℤ) ≤ 1)) hA
  have hB' : (-1 : WithTop ℤ) ≤
      (delta * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop :=
    le_trans (WithTop.coe_le_coe.mpr (by norm_num : (-1 : ℤ) ≤ 1)) hB
  exact le_trans (le_min
    (le_trans (le_min henergy hA') HahnSeries.min_orderTop_le_orderTop_sub) hB')
    HahnSeries.min_orderTop_le_orderTop_sub

/-- Reading c as the actual W^3 coefficient of H gives the same
simple-pole bound, even for H of arbitrary degree. -/
theorem split_source_laurent_coefficient_corrected_endpoint_bound [CharP k 5]
    (s : Finset ι) (node : ι → LaurentSeries k) (hinj : Set.InjOn node s)
    (F H : (LaurentSeries k)[X]) (q tau leading : LaurentSeries k)
    (hdegree : 5 ≤ F.natDegree) (htauzero : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal s node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hnodes : ∀ i ∈ s, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop) :
    (-1 : WithTop ℤ) ≤
      (splitDifferentialEnergy (laurentDerivation k) s node (fun i => node i ^ 5 + q) -
        laurentDerivation k q * laurentDerivation k (H.coeff 3) / tau -
        H.coeff 3 * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop := by
  let c := (H %ₘ (X ^ 5 + C q)).coeff 3
  let delta := H.coeff 3 - c
  have hchange : H.coeff 3 = c + delta := by dsimp [delta]; ring
  rw [hchange]
  apply laurent_corrected_energy_coefficient_change_bound _ q c delta tau hq htau
  · exact laurent_low_coefficient_difference_order H q 5 3 (by omega) (by omega)
      hH (le_trans (by norm_num) hq.ge) 3 hq.ge
  · exact split_source_laurent_corrected_endpoint_bound s node hinj F H q tau leading
      hdegree htauzero hleading hFsplit hsource hnodes hq htau hH

end Litt3.CartierAndSpin
