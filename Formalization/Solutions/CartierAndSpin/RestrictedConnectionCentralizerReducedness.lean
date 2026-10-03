import Solutions.CartierAndSpin.RestrictedConnectionCentralizerAlgebra
import Solutions.CartierAndSpin.PrimePowerQuotientNilpotency

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The ENTIRE actual Kp-linear connection commutant is reduced exactly
when the negative curvature has no pth root in the ORIGINAL Kp field.
Nonzero curvature alone is deliberately not used as a field criterion. -/
theorem actual_normalized_connection_centralizer_isReduced_iff
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    IsReduced (Subalgebra.centralizer (frobeniusSubfield K p)
      ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K))) ↔
      ∀ a : frobeniusSubfield K p, a ^ p ≠ -actualConnectionCurvature b D hDt f := by
  let e := actualConnectionCentralizerAlgebraEquiv b D hDt f
  constructor
  · intro h
    letI := h
    haveI := isReduced_of_injective e e.injective
    exact (actual_prime_power_quotient_isReduced_iff
      (actualConnectionCurvature b D hDt f)).mp inferInstance
  · intro h
    letI := (actual_prime_power_quotient_isReduced_iff
      (actualConnectionCurvature b D hDt f)).mpr h
    exact isReduced_of_injective e.symm e.symm.injective

/-- In this actual pure-power commutant, reducedness and absence of
zero divisors have the SAME exact scalar-root criterion. -/
theorem actual_normalized_connection_centralizer_isDomain_iff
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    IsDomain (Subalgebra.centralizer (frobeniusSubfield K p)
      ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K))) ↔
      ∀ a : frobeniusSubfield K p, a ^ p ≠ -actualConnectionCurvature b D hDt f := by
  constructor
  · intro h
    letI := h
    exact (actual_normalized_connection_centralizer_isReduced_iff b D hDt f).mp
      (@isReduced_of_noZeroDivisors _ _ (@IsDomain.to_noZeroDivisors _ _ h))
  · intro h
    let c := actualConnectionCurvature b D hDt f
    have hirr := (actual_prime_power_polynomial_irreducible_iff c).mpr h
    letI : IsDomain (AdjoinRoot ((X : (frobeniusSubfield K p)[X]) ^ p + C c)) :=
      AdjoinRoot.isDomain_of_prime hirr.prime
    exact (actualConnectionCentralizerAlgebraEquiv b D hDt f).toMulEquiv.isDomain_iff.mp
      inferInstance

/-- Every nonzero actual commuting operator is a unit of the WHOLE
Kp-linear commutant when the scalar-root obstruction is absent. The
actual irreducible quotient supplies its inverse. -/
theorem actual_normalized_connection_centralizer_nonzero_isUnit
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (hroot : ∀ a : frobeniusSubfield K p, a ^ p ≠ -actualConnectionCurvature b D hDt f)
    (E : Subalgebra.centralizer (frobeniusSubfield K p)
      ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K)))
    (hE : E ≠ 0) : IsUnit E := by
  let c := actualConnectionCurvature b D hDt f
  letI : Fact (Irreducible ((X : (frobeniusSubfield K p)[X]) ^ p + C c)) :=
    ⟨(actual_prime_power_polynomial_irreducible_iff c).mpr hroot⟩
  let e := actualConnectionCentralizerAlgebraEquiv b D hDt f
  have hnonzero : e.symm E ≠ 0 := by
    intro hzero
    apply hE
    have h := congrArg e hzero
    simpa only [e.apply_symm_apply, map_zero] using h
  have hu : IsUnit (e.symm E) := isUnit_iff_ne_zero.mpr hnonzero
  have hmap := hu.map e.toMonoidHom
  change IsUnit (e (e.symm E)) at hmap
  rwa [e.apply_symm_apply] at hmap

/-- If the negative curvature has a genuine ORIGINAL Kp scalar root,
the whole connection commutant contains the literal shifted connection
as a nilpotent of EXACT exponent p. ALL smaller powers are nonzero. -/
theorem actual_normalized_connection_centralizer_scalar_root_exact_nilpotent
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (a : frobeniusSubfield K p) (ha : a ^ p = -actualConnectionCurvature b D hDt f) :
    ∃ x : Subalgebra.centralizer (frobeniusSubfield K p)
      ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K)),
      x.val = scalarDerivationConnection D f -
        algebraMap (frobeniusSubfield K p) (Module.End (frobeniusSubfield K p) K) a ∧
      x ^ p = 0 ∧ ∀ n : ℕ, n < p → x ^ n ≠ 0 := by
  let c := actualConnectionCurvature b D hDt f
  let P := (X : (frobeniusSubfield K p)[X]) ^ p + C c
  let e := actualConnectionCentralizerAlgebraEquiv b D hDt f
  let z := AdjoinRoot.root P - AdjoinRoot.of P a
  refine ⟨e z, ?_, ?_, ?_⟩
  · change (e (AdjoinRoot.root P - AdjoinRoot.of P a)).val = _
    rw [map_sub]
    change (e (AdjoinRoot.root P)).val -
      (e (algebraMap (frobeniusSubfield K p) (AdjoinRoot P) a)).val = _
    rw [e.commutes]
    exact congrArg (fun T : Module.End (frobeniusSubfield K p) K =>
      T - algebraMap (frobeniusSubfield K p) (Module.End (frobeniusSubfield K p) K) a)
        (actual_connection_centralizer_algebra_equiv_root b D hDt f)
  · rw [← map_pow]
    have hz : z ^ p = 0 := actual_prime_power_quotient_root_difference_power_zero c a ha
    rw [hz, map_zero]
  · intro n hn hzero
    have h : e (z ^ n) = e 0 := by simpa only [map_pow, map_zero] using hzero
    exact actual_prime_power_quotient_root_difference_power_ne_zero c a n hn
      (e.injective h)

end Litt3.CartierAndSpin
