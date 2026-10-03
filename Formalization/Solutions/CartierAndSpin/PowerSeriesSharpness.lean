import Solutions.CartierAndSpin.TraceOmissionCounterexample
import Solutions.CartierAndSpin.CarryOmissionCounterexample
import Solutions.CartierAndSpin.EqualPoleCounterexample
import Solutions.CartierAndSpin.ValuationRingIntegrality
import Mathlib.RingTheory.LaurentSeries
import Mathlib.RingTheory.RootsOfUnity.AlgebraicallyClosed

namespace Litt3.CartierAndSpin

open IsLocalRing

variable (k : Type*) [Field k]

/-- An actual pole in the actual Laurent fraction field of the actual
power-series DVR. Its integer-ring hypothesis is constructed, not assumed. -/
theorem powerSeries_uniformizer_inverse_pole :
    1 < (ValuationRing.valuation (PowerSeries k) (LaurentSeries k))
      ((algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X)⁻¹) := by
  let valuation := ValuationRing.valuation (PowerSeries k) (LaurentSeries k)
  have hv : valuation.Integers (PowerSeries k) := valuationRing_valuation_integers
  have hX_not_unit : ¬IsUnit (PowerSeries.X : PowerSeries k) := by
    intro hunit
    have hconstant := PowerSeries.isUnit_constantCoeff PowerSeries.X hunit
    simpa only [PowerSeries.constantCoeff_X, not_isUnit_zero] using hconstant
  have hXne : algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X ≠ 0 := by
    intro hz
    apply PowerSeries.X_ne_zero (R := k)
    apply hv.hom_inj
    simpa only [map_zero] using hz
  have hpositive := valuation.pos_iff.mpr hXne
  have hstrict : valuation (algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X) < 1 := by
    apply lt_of_le_of_ne (hv.map_le_one PowerSeries.X)
    intro heq
    exact hX_not_unit (hv.isUnit_of_one' heq)
  rw [valuation.map_inv]
  exact (one_lt_inv₀ hpositive).mpr hstrict

/-- The p-entry trace-only obstruction is realized in k[[X]] itself. -/
theorem powerSeries_equal_pole_counterexample (p : ℕ) [CharP k p] (hp : 0 < p)
    (a : PowerSeries k) :
    let t := (algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X)⁻¹
    (∀ j l, ∃ b : PowerSeries k, algebraMap (PowerSeries k) (LaurentSeries k) b =
      finiteWeightedPowerSum (fun _ : Fin p => algebraMap (PowerSeries k) (LaurentSeries k) a)
        (fun _ => t) j l) ∧
    (∃ i : Fin p, ¬∃ b : PowerSeries k,
      algebraMap (PowerSeries k) (LaurentSeries k) b = (fun _ : Fin p => t) i) := by
  letI : CharP (LaurentSeries k) p :=
    charP_of_injective_algebraMap (algebraMap k (LaurentSeries k)).injective p
  exact equal_pole_cohort_integrality_counterexample
    (ValuationRing.valuation (PowerSeries k) (LaurentSeries k)) valuationRing_valuation_integers
    p hp a _ (powerSeries_uniformizer_inverse_pole k)

/-- The carry omission example is realized in the actual split Laurent
algebra over the power-series DVR, with all power traces retained. -/
theorem powerSeries_carry_omission_counterexample (p r : ℕ) [CharP k p] (hp : 0 < p) :
    let t := (algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X)⁻¹
    (∏ i, carryOmissionTuple p r t i = 1) ∧
    (∀ l, finitePowerSum (carryOmissionTuple p r t) l ∈
      (algebraMap (PowerSeries k) (LaurentSeries k)).range) ∧
    (∀ l, finitePowerSum (fun i => (carryOmissionTuple p r t i)⁻¹) l ∈
      (algebraMap (PowerSeries k) (LaurentSeries k)).range) ∧
    finiteElementarySymmetric (carryOmissionTuple p r t) p ∉
      (algebraMap (PowerSeries k) (LaurentSeries k)).range := by
  letI : CharP (LaurentSeries k) p :=
    charP_of_injective_algebraMap (algebraMap k (LaurentSeries k)).injective p
  exact carry_omission_integrality_counterexample
    (ValuationRing.valuation (PowerSeries k) (LaurentSeries k)) valuationRing_valuation_integers
    p r hp _ (powerSeries_uniformizer_inverse_pole k)

/-- Every single extra trace can be omitted independently over the actual
power-series DVR of every algebraically closed characteristic-p field.
Primitive-root existence and the actual pole are both proved here. -/
theorem powerSeries_higher_trace_omission_counterexample [IsAlgClosed k] (p r i : ℕ)
    [CharP k p] (hp : 0 < p) (hrp : r < p) (hi : 0 < i) (hir : i ≤ r) :
    ∃ u : Fin (p + i) ⊕ (Fin p ⊕ Fin (r - i)) → LaurentSeries k,
      Specifications.OmittedHigherTraceWitness (R := PowerSeries k) u p r i := by
  letI : CharP (PowerSeries k) p :=
    charP_of_injective_algebraMap (algebraMap k (PowerSeries k)).injective p
  letI : CharP (LaurentSeries k) p :=
    charP_of_injective_algebraMap (algebraMap k (LaurentSeries k)).injective p
  letI : CharP (ResidueField (PowerSeries k)) p :=
    CharP.of_ringHom_of_ne_zero (residue (PowerSeries k)) p hp.ne'
  have hnotdiv : ¬p ∣ p + i := by
    intro hdiv
    exact Nat.not_dvd_of_pos_of_lt hi (hir.trans_lt hrp)
      ((Nat.dvd_add_iff_right (dvd_refl p)).mpr hdiv)
  letI : NeZero ((p + i : ℕ) : k) := ⟨by
    rw [Ne, CharP.cast_eq_zero_iff k p]
    exact hnotdiv⟩
  obtain ⟨zeta, hzeta⟩ := HasEnoughRootsOfUnity.exists_primitiveRoot k (p + i)
  let zetaL := algebraMap k (LaurentSeries k) zeta
  have hzetaL : IsPrimitiveRoot zetaL (p + i) :=
    hzeta.map_of_injective (algebraMap k (LaurentSeries k)).injective
  let t := (algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X)⁻¹
  refine ⟨traceOmissionTuple p (p + i) (r - i) zetaL t, ?_⟩
  exact higher_trace_omission_integrality_counterexample
    (ValuationRing.valuation (PowerSeries k) (LaurentSeries k)) valuationRing_valuation_integers
    p r i hp hrp hi hir zetaL t hzetaL (powerSeries_uniformizer_inverse_pole k)

end Litt3.CartierAndSpin
