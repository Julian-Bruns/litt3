import Solutions.Jacobians.DedekindPrincipalIdeals

open scoped nonZeroDivisors Classical
open IsDedekindDomain

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- Positive prime divisors map to their ORIGINAL prime-ideal modules.
Thus the geometric convention, when separately realized, is O(-D). -/
noncomputable def dedekindDivisorPicardMap :
    Divisor (HeightOneSpectrum R) →+ Additive (CommRing.Pic R) :=
  (fractionalIdealPicardHom (R := R) (K := K)).toAdditive.comp
    (dedekindDivisorIdealMap R K)

theorem dedekindDivisorPicardMap_zero_iff (D : Divisor (HeightOneSpectrum R)) :
    dedekindDivisorPicardMap R K D = 0 ↔
      ∃ f : Additive Kˣ, principalDivisorMap (dedekindValuationDivisorSystem R K) f = D := by
  change fractionalIdealPicardClass (dedekindDivisorIdealMap R K D).toMul = 1 ↔ _
  rw [fractionalIdealPicardClass_eq_one_iff]
  constructor
  · rintro ⟨f, hf⟩
    refine ⟨Additive.ofMul f, ?_⟩
    apply (actualDedekindDivisorIdealEquiv R K).injective
    change dedekindDivisorIdealMap R K _ = dedekindDivisorIdealMap R K D
    rw [dedekindDivisorIdealMap_principal]
    exact congrArg Additive.ofMul hf
  · rintro ⟨f, hf⟩
    rw [← hf, dedekindDivisorIdealMap_principal]
    exact ⟨f.toMul, rfl⟩

theorem dedekindDivisorPicardMap_ker :
    (dedekindDivisorPicardMap R K).ker =
      principalDivisors (dedekindValuationDivisorSystem R K) := by
  ext D
  exact dedekindDivisorPicardMap_zero_iff R K D

theorem dedekindDivisorPicardMap_surjective :
    Function.Surjective (dedekindDivisorPicardMap R K) := by
  intro M
  let I := actualInvertibleModuleFractionalIdealUnit R K M.toMul
  refine ⟨dedekindIdealDivisorMap R K (Additive.ofMul I), ?_⟩
  change Additive.ofMul (fractionalIdealPicardClass
    (dedekindDivisorIdealMap R K (dedekindIdealDivisorMap R K (Additive.ofMul I))).toMul) = M
  rw [dedekindDivisorIdealMap_idealDivisor]
  apply Additive.toMul.injective
  change fractionalIdealPicardClass I = M.toMul
  rw [actualInvertibleModuleFractionalIdealUnit_picard, CommRing.Pic.mk_eq_self]

/-- The genuine normalized-adic AFFINE divisor-class quotient is the genuine
ring Picard group, with no supplied principal-kernel or Picard realization. -/
noncomputable def actualDedekindAffineDivisorPicardEquiv :
    DivisorClassGroup (dedekindValuationDivisorSystem R K) ≃+ Additive (CommRing.Pic R) :=
  (QuotientAddGroup.quotientAddEquivOfEq (dedekindDivisorPicardMap_ker R K).symm).trans
    (QuotientAddGroup.quotientKerEquivOfSurjective (dedekindDivisorPicardMap R K)
      (dedekindDivisorPicardMap_surjective R K))

theorem dedekind_affine_picard_torsion_iff_principal_multiple
    (D : Divisor (HeightOneSpectrum R)) (n : ℕ) :
    n • dedekindDivisorPicardMap R K D = 0 ↔
      ∃ f : Additive Kˣ, principalDivisorMap (dedekindValuationDivisorSystem R K) f = n • D := by
  rw [← map_nsmul]
  exact dedekindDivisorPicardMap_zero_iff R K (n • D)

end Litt3.Jacobians
