import Solutions.QuotientGeometry.PolynomialParameterCompletion
import Mathlib.RingTheory.LocalRing.ResidueField.Basic
import Mathlib.Algebra.Polynomial.Eval.Coeff
import Mathlib.RingTheory.PowerSeries.Trunc

namespace Litt3.QuotientGeometry

open Polynomial IsLocalRing

variable {k R : Type*} [Field k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Algebra k R]

def dvrPolynomialParameterMap (t : R) : k[X] →+* R :=
  Polynomial.eval₂RingHom (algebraMap k R) t

theorem dvr_polynomial_parameter_residue_conditions
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    dvrPolynomialParameterMap (k := k) t Polynomial.X ≠ 0 ∧
      (∀ P : k[X], dvrPolynomialParameterMap (k := k) t Polynomial.X ∣
        dvrPolynomialParameterMap (k := k) t P → Polynomial.X ∣ P) ∧
      (∀ r : R, ∃ P : k[X], dvrPolynomialParameterMap (k := k) t Polynomial.X ∣
        r - dvrPolynomialParameterMap (k := k) t P) := by
  have htzero : residue R t = 0 := by
    apply (residue_eq_zero_iff t).mpr
    rw [ht.maximalIdeal_eq]
    exact Ideal.mem_span_singleton_self t
  have heval : ∀ P : k[X],
      residue R (dvrPolynomialParameterMap (k := k) t P) = algebraMap k (ResidueField R) (P.coeff 0) := by
    intro P
    change residue R (Polynomial.eval₂ (algebraMap k R) t P) = _
    rw [Polynomial.hom_eval₂, htzero, Polynomial.eval₂_at_zero]
    rfl
  simp only [dvrPolynomialParameterMap, Polynomial.coe_eval₂RingHom, Polynomial.eval₂_X]
  refine ⟨ht.ne_zero, ?_, ?_⟩
  · intro P hP
    apply Polynomial.X_dvd_iff.mpr
    apply (algebraMap k (ResidueField R)).injective
    rw [map_zero, ← heval]
    apply (residue_eq_zero_iff _).mpr
    rw [ht.maximalIdeal_eq, Ideal.mem_span_singleton]
    exact hP
  · intro r
    obtain ⟨c, hc⟩ := hres (residue R r)
    refine ⟨Polynomial.C c, ?_⟩
    rw [Polynomial.eval₂_C, ← Ideal.mem_span_singleton, ← ht.maximalIdeal_eq,
      ← residue_eq_zero_iff, map_sub, sub_eq_zero]
    exact hc.symm

theorem dvr_polynomial_parameter_ideal_map
    (t : R) (ht : Irreducible t) :
    (Ideal.span {(Polynomial.X : k[X])}).map (dvrPolynomialParameterMap t) = maximalIdeal R := by
  rw [Ideal.map_span, Set.image_singleton, ht.maximalIdeal_eq]
  simp [dvrPolynomialParameterMap]

theorem dvr_polynomial_parameter_quotients_bijective
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) (n : ℕ) :
    Function.Bijective (Ideal.quotientMap ((maximalIdeal R) ^ n)
      (dvrPolynomialParameterMap t)
      (ideal_power_le_comap_of_map_le (Ideal.span {(Polynomial.X : k[X])}) (maximalIdeal R)
        (dvrPolynomialParameterMap t) (dvr_polynomial_parameter_ideal_map t ht).le n)) := by
  obtain ⟨hne, hinj, hsurj⟩ := dvr_polynomial_parameter_residue_conditions t ht hres
  let φ := dvrPolynomialParameterMap (k := k) t
  have hJ : maximalIdeal R = Ideal.span {φ Polynomial.X} := by
    simpa [φ, dvrPolynomialParameterMap] using ht.maximalIdeal_eq
  refine ⟨Ideal.quotientMap_injective' ?_, ?_⟩
  · intro P hP
    rw [Ideal.mem_comap, hJ, Ideal.span_singleton_pow, Ideal.mem_span_singleton] at hP
    rw [Ideal.span_singleton_pow, Ideal.mem_span_singleton]
    exact principal_power_divisibility_reflects φ Polynomial.X hne hinj n P hP
  · intro r
    obtain ⟨r, rfl⟩ := Ideal.Quotient.mk_surjective r
    obtain ⟨P, hP⟩ := principal_power_residue_surjectivity φ Polynomial.X hsurj n r
    refine ⟨Ideal.Quotient.mk _ P, ?_⟩
    rw [Ideal.quotientMap_mk, Ideal.Quotient.eq, hJ,
      Ideal.span_singleton_pow, Ideal.mem_span_singleton]
    exact dvd_neg.mp (by simpa only [neg_sub] using hP)

noncomputable def dvrPolynomialCompletionEquiv
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    AdicCompletion (Ideal.span {(Polynomial.X : k[X])}) (k[X]) ≃+*
      AdicCompletion (maximalIdeal R) R :=
  adicRingEquiv _ _ (dvrPolynomialParameterMap t)
    (dvr_polynomial_parameter_ideal_map t ht).le
    (dvr_polynomial_parameter_quotients_bijective t ht hres)

/-- An equicharacteristic DVR with its actual coefficient field mapping
onto the residue field has an actual formal-power-series completion chart.
The chart is constructed, not supplied as a hypothesis. -/
noncomputable def dvrPowerSeriesChart
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    PowerSeries k ≃+* AdicCompletion (maximalIdeal R) R :=
  (polynomialParameterCompletionEquiv k).trans (dvrPolynomialCompletionEquiv t ht hres)

@[simp] theorem dvrPowerSeriesChart_coe
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) (P : k[X]) :
    dvrPowerSeriesChart t ht hres (P : PowerSeries k) =
      AdicCompletion.of (maximalIdeal R) R (Polynomial.eval₂ (algebraMap k R) t P) := by
  rw [dvrPowerSeriesChart, RingEquiv.trans_apply, polynomialParameterCompletionEquiv_coe]
  exact adicRingEquiv_of _ _ (dvrPolynomialParameterMap t)
    (dvr_polynomial_parameter_ideal_map t ht).le
    (dvr_polynomial_parameter_quotients_bijective t ht hres) P

@[simp] theorem dvrPowerSeriesChart_X
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    dvrPowerSeriesChart t ht hres PowerSeries.X = AdicCompletion.of (maximalIdeal R) R t := by
  simpa using dvrPowerSeriesChart_coe t ht hres (Polynomial.X : k[X])

@[simp] theorem dvrPowerSeriesChart_C
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) (c : k) :
    dvrPowerSeriesChart t ht hres (PowerSeries.C c) =
      AdicCompletion.of (maximalIdeal R) R (algebraMap k R c) := by
  simpa using dvrPowerSeriesChart_coe t ht hres (Polynomial.C c)

noncomputable def dvrPowerSeriesAlgChart
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    PowerSeries k ≃ₐ[k] AdicCompletion (maximalIdeal R) R :=
  { dvrPowerSeriesChart t ht hres with
    commutes' := by
      intro c
      change dvrPowerSeriesChart t ht hres (PowerSeries.C c) =
        algebraMap k (AdicCompletion (maximalIdeal R) R) c
      rw [dvrPowerSeriesChart_C]
      rfl }

@[simp] theorem dvrPowerSeriesAlgChart_X
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    dvrPowerSeriesAlgChart t ht hres PowerSeries.X =
      AdicCompletion.of (maximalIdeal R) R t := dvrPowerSeriesChart_X t ht hres

theorem dvrPowerSeriesChart_residue
    (t : R) (ht : Irreducible t)
    (hres : Function.Surjective (algebraMap k (ResidueField R))) (f : PowerSeries k) :
    AdicCompletion.evalOneₐ (maximalIdeal R) (dvrPowerSeriesChart t ht hres f) =
      algebraMap k (ResidueField R) (PowerSeries.constantCoeff f) := by
  have htzero : residue R t = 0 := by
    apply (residue_eq_zero_iff t).mpr
    rw [ht.maximalIdeal_eq]
    exact Ideal.mem_span_singleton_self t
  have hf := PowerSeries.eq_X_pow_mul_shift_add_trunc 1 f
  rw [pow_one, PowerSeries.trunc_one_left, Polynomial.coe_C,
    PowerSeries.coeff_zero_eq_constantCoeff] at hf
  conv_lhs => rw [hf]
  rw [map_add, map_mul, dvrPowerSeriesChart_X, dvrPowerSeriesChart_C, map_add, map_mul,
    AdicCompletion.evalOneₐ_of, AdicCompletion.evalOneₐ_of]
  change residue R t * _ + residue R (algebraMap k R (PowerSeries.constantCoeff f)) = _
  rw [htzero, zero_mul, zero_add]
  rfl

end Litt3.QuotientGeometry
