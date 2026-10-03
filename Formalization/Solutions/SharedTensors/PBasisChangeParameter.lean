import Solutions.SharedTensors.PBasisDerivation
import Mathlib.FieldTheory.KummerPolynomial
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic

namespace Litt3.SharedTensors

open Polynomial IntermediateField Module

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

theorem nonpth_element_frobenius_minpoly (t : K)
    (hnot : t ∉ frobeniusSubfield K p) :
    minpoly (frobeniusSubfield K p) t =
      X ^ p - C (frobeniusImageEquiv K p t) := by
  apply Eq.symm
  refine minpoly.eq_of_irreducible_of_monic
    (X_pow_sub_C_irreducible_of_prime (Fact.out : p.Prime) ?_) ?_
    (monic_X_pow_sub_C _ (Fact.out : p.Prime).ne_zero)
  · intro a ha
    have heq : (a : K) = t := (frobenius K p).injective (by
      change (a : K) ^ p = t ^ p
      simpa only [frobeniusImageEquiv_coe] using congrArg Subtype.val ha)
    exact hnot (heq ▸ a.property)
  · simp only [map_sub, map_pow, aeval_X, aeval_C]
    change t ^ p - (frobeniusImageEquiv K p t : K) = 0
    rw [frobeniusImageEquiv_coe, sub_self]

/-- Every non-p-th-power element is an actual full p-basis parameter in
a field whose actual p-degree is p. The new basis is constructed. -/
theorem power_p_basis_change_parameter_exists (b : PowerPBasis K p)
    (t : K) (hnot : t ∉ frobeniusSubfield K p) :
    ∃ b' : PowerPBasis K p, b'.parameter = t := by
  let S := frobeniusSubfield K p
  letI : FiniteDimensional S K := b.toPowerBasis.finite
  have hmin : minpoly S t = X ^ p - C (frobeniusImageEquiv K p t) :=
    nonpth_element_frobenius_minpoly t hnot
  have hint : IsIntegral S t := by
    refine ⟨X ^ p - C (frobeniusImageEquiv K p t),
      monic_X_pow_sub_C _ (Fact.out : p.Prime).ne_zero, ?_⟩
    rw [← hmin]
    exact minpoly.aeval S t
  have htop : IntermediateField.adjoin S {t} = ⊤ := by
    apply IntermediateField.eq_of_le_of_finrank_le le_top
    rw [IntermediateField.finrank_top', b.toPowerBasis.finrank,
      IntermediateField.adjoin.finrank hint, hmin, natDegree_X_pow_sub_C]
    exact le_rfl
  let eqv : (IntermediateField.adjoin S {t}) ≃ₐ[S] K :=
    (IntermediateField.equivOfEq htop).trans IntermediateField.topEquiv
  let pb := (IntermediateField.adjoin.powerBasis hint).map eqv
  have hgen : pb.gen = t := rfl
  have hdim : pb.dim = p := by
    change (minpoly S t).natDegree = p
    rw [hmin]
    exact natDegree_X_pow_sub_C
  refine ⟨{
    parameter := t
    basis := pb.basis.reindex (finCongr hdim)
    basis_eq_power := ?_ }, rfl⟩
  intro i
  rw [Basis.reindex_apply, pb.basis_eq_pow, hgen]
  rfl

end Litt3.SharedTensors
