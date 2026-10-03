import Definitions.CartierAndSpin.NormalizedDVRBoundary
import Solutions.CartierAndSpin.ReciprocalBoundaryConclusion

namespace Litt3.CartierAndSpin

open scoped WithZero
open Finset IsLocalRing Classical

theorem integerFieldOrder_eq_valuationOrder {K : Type*} [Field K]
    (v : Valuation K ℤᵐ⁰) (x : Kˣ) :
    integerFieldOrder v x.val = Litt3.Jacobians.valuationOrder v (Additive.ofMul x) := by
  exact (Litt3.Jacobians.valuation_order_of_value_exp v (Additive.ofMul x)
    (WithZero.log (v x.val)) (WithZero.exp_log (by simpa using x.ne_zero)).symm).symm

theorem integerFieldOrder_eq_iff {K : Type*} [Field K]
    (v : Valuation K ℤᵐ⁰) (x y : K) (hx : x ≠ 0) (hy : y ≠ 0) :
    integerFieldOrder v x = integerFieldOrder v y ↔ v x = v y := by
  constructor
  · intro h
    have hlog : WithZero.log (v x) = WithZero.log (v y) := neg_injective h
    have hexp := congrArg (WithZero.exp : ℤ → ℤᵐ⁰) hlog
    simpa only [WithZero.exp_log ((Valuation.ne_zero_iff v).mpr hx),
      WithZero.exp_log ((Valuation.ne_zero_iff v).mpr hy)] using hexp
  · intro h
    simp only [integerFieldOrder, h]

variable {R K ι : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
  [Field K] [Algebra R K] [IsFractionRing R K] [Fintype ι]

/-- The actual maximal-ideal height-one valuation of a DVR has precisely
the original DVR as its integer ring inside its actual fraction field. -/
theorem dvr_height_one_valuation_integers :
    ((Litt3.Jacobians.discreteValuationPlace R).valuation K).Integers R where
  hom_inj := IsFractionRing.injective R K
  map_le_one a := (Litt3.Jacobians.discreteValuationPlace R).valuation_le_one a
  exists_of_le_one := by
    intro x hx
    apply IsDedekindDomain.HeightOneSpectrum.mem_integers_of_valuation_le_one
    intro q
    have hq : q = Litt3.Jacobians.discreteValuationPlace R := by
      apply IsDedekindDomain.HeightOneSpectrum.ext
      exact IsLocalRing.eq_maximalIdeal (q.isPrime.isMaximal q.ne_bot)
    simpa only [hq] using hx

theorem dvr_uniformizer_integer_order (π : R) (hπ : Irreducible π) :
    integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K)
      (algebraMap R K π) = 1 := by
  rw [integerFieldOrder, IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    (Litt3.Jacobians.discreteValuationPlace R).intValuation_singleton hπ.ne_zero
      ((IsDiscreteValuationRing.irreducible_iff_uniformizer π).mp hπ),
    WithZero.log_exp]
  norm_num

/-- Literal integer-order version of the complete reciprocal boundary.
The two cohorts have the same positive integer pole/zero order M; the
carry has exact order -p*M. The normalized height-one valuation and its
integer-ring property are constructed from the actual DVR. -/
theorem dvr_normalized_reciprocal_boundary (p : ℕ) [CharP (ResidueField R) p]
    (hp : 0 < p) (u : ι → K) (hdegree : Fintype.card ι ≤ 2 * p)
    (hnorm : ∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.NormalizedDVRBoundaryOutcome (R := R) u p := by
  let v := (Litt3.Jacobians.discreteValuationPlace R).valuation K
  have hv : v.Integers R := dvr_height_one_valuation_integers
  have hnormv : v (∏ i, u i) = 1 := by
    obtain ⟨b, hbunit, hb⟩ := hnorm
    rw [← hb]
    exact hv.one_of_isUnit hbunit
  have hvalues : ∀ i, u i ≠ 0 := by
    intro i hzero
    have hproductzero : (∏ i, u i) = 0 := prod_eq_zero (mem_univ i) hzero
    simpa only [hproductzero, map_zero, zero_ne_one] using hnormv
  have houtcome := reciprocalTraceBoundaryOutcome v hv p hp u hdegree hnormv
    (fun k hk hkp => by
      obtain ⟨b, hb⟩ := hforward k hk hkp
      rw [← hb]
      exact hv.map_le_one b)
    (fun k hk hkp => by
      obtain ⟨b, hb⟩ := hreciprocal k hk hkp
      rw [← hb]
      exact hv.map_le_one b)
  rcases houtcome with hunits |
    ⟨hcard, i₀, j₀, hipole, hjpole, hpcard, hzcard, hpartition,
      hprod, hpoleleading, hzeroleading, hcarry, hcarrypole⟩
  · exact Or.inl hunits
  let M : ℤ := WithZero.log (v (u i₀))
  have hM : 0 < M := by
    have h := (WithZero.log_lt_log one_ne_zero
      ((Valuation.ne_zero_iff v).mpr (hvalues i₀))).mpr hipole
    simpa only [WithZero.log_one] using h
  have hiorder : integerFieldOrder v (u i₀) = -M := rfl
  have hjorder : integerFieldOrder v (u j₀) = M := by
    have h := congrArg WithZero.log hprod
    rw [WithZero.log_mul ((Valuation.ne_zero_iff v).mpr (hvalues i₀))
      ((Valuation.ne_zero_iff v).mpr (hvalues j₀)), WithZero.log_one] at h
    change -WithZero.log (v (u j₀)) = WithZero.log (v (u i₀))
    omega
  have hpoleiff (i : ι) : integerFieldOrder v (u i) = -M ↔ v (u i) = v (u i₀) := by
    rw [← hiorder]
    exact integerFieldOrder_eq_iff v _ _ (hvalues i) (hvalues i₀)
  have hzeroiff (i : ι) : integerFieldOrder v (u i) = M ↔
      v ((u i)⁻¹) = v ((u j₀)⁻¹) := by
    rw [← hjorder, integerFieldOrder_eq_iff v _ _ (hvalues i) (hvalues j₀)]
    simp only [map_inv₀, inv_inj]
  have hpolefilter : (univ.filter fun i => integerFieldOrder v (u i) = -M) =
      (univ.filter fun i => v (u i) = v (u i₀)) := by
    apply filter_congr
    intro i _
    exact hpoleiff i
  have hzerofilter : (univ.filter fun i => integerFieldOrder v (u i) = M) =
      (univ.filter fun i => v ((u i)⁻¹) = v ((u j₀)⁻¹)) := by
    apply filter_congr
    intro i _
    exact hzeroiff i
  have hezero : finiteElementarySymmetric u p ≠ 0 := by
    intro he
    rw [he, map_zero] at hcarrypole
    exact zero_le_one.not_gt hcarrypole
  refine Or.inr ⟨⟨hcard, hvalues⟩, M, hM, i₀, j₀, hiorder, hjorder, ?_, ?_, ?_, ?_, ?_,
    hezero, ?_⟩
  · change (univ.filter fun i => integerFieldOrder v (u i) = -M).card = p
    rw [hpolefilter]
    exact hpcard
  · change (univ.filter fun i => integerFieldOrder v (u i) = M).card = p
    rw [hzerofilter]
    exact hzcard
  · intro i
    rcases hpartition i with hi | hj
    · exact Or.inl ((hpoleiff i).mpr hi)
    · exact Or.inr (by
        rw [← hjorder]
        exact (integerFieldOrder_eq_iff v _ _ (hvalues i) (hvalues j₀)).mpr hj)
  · obtain ⟨b, hb, hres⟩ := hpoleleading
    refine ⟨b, hb, ?_⟩
    intro i
    change residue R (b i) = if integerFieldOrder v (u i) = -M then 1 else 0
    simpa only [hpoleiff i] using hres i
  · obtain ⟨b, hb, hres⟩ := hzeroleading
    refine ⟨b, hb, ?_⟩
    intro i
    change residue R (b i) = if integerFieldOrder v (u i) = M then 1 else 0
    simpa only [hzeroiff i] using hres i
  · change -WithZero.log (v (finiteElementarySymmetric u p)) = -(p : ℤ) * M
    rw [hcarry, WithZero.log_pow]
    simp only [smul_eq_mul, M]
    ring

end Litt3.CartierAndSpin
