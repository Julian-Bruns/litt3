import Solutions.SharedTensors.SeparatingPBasisGeneration
import Solutions.SharedTensors.NormalizedSeparatingCoordinates
import Solutions.SharedTensors.PBasisDerivation
import Mathlib.FieldTheory.KummerPolynomial

namespace Litt3.SharedTensors

open Polynomial IntermediateField Module

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectRing k p]

/-- An actual separating function is not a p-th power. Its nonzero
universal differential is constructed from the rational subfield. -/
theorem separating_element_not_in_frobenius_field
    (t : K) (ht : Transcendental k t)
    [Algebra.IsSeparable (IntermediateField.adjoin k {t}) K] :
    t ∉ frobeniusSubfield K p := by
  obtain ⟨e, he⟩ := normalized_separating_element_coordinate_exists t ht
  rintro ⟨r, hr⟩
  change r ^ p = t at hr
  let D := universalCoordinateDerivation e
  have hzero : D (r ^ p) = 0 := by
    rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero K p, zero_mul]
  have hone : D t = 1 := he
  rw [hr, hone] at hzero
  exact one_ne_zero hzero

/-- A literal separating parameter generates the whole field over its
literal p-th powers, and the minimal polynomial is exactly X^p-t^p. -/
theorem separating_element_frobenius_minpoly
    (t : K) (ht : Transcendental k t)
    [Algebra.IsSeparable (IntermediateField.adjoin k {t}) K] :
    minpoly (frobeniusSubfield K p) t =
      X ^ p - C (frobeniusImageEquiv K p t) := by
  have hnot := separating_element_not_in_frobenius_field (p := p) t ht
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

/-- The actual p-th-power basis for the original separating parameter.
Neither a basis, a finite p-degree, nor a normalized derivation is input. -/
theorem separating_element_power_p_basis_exists
    (t : K) (ht : Transcendental k t)
    [Algebra.IsSeparable (IntermediateField.adjoin k {t}) K] :
    ∃ b : PowerPBasis K p, b.parameter = t := by
  let S := frobeniusConstantField (k := k) (K := K) (p := p)
  have htop : IntermediateField.adjoin S {t} = ⊤ := by
    apply IntermediateField.restrictScalars_injective k
    rw [IntermediateField.restrictScalars_top,
      IntermediateField.restrictScalars_adjoin_eq_sup, sup_comm]
    exact separating_function_and_pth_powers_generate (p := p) t
  let a : S := ⟨t ^ p, ⟨t, rfl⟩⟩
  have hmin : minpoly S t = X ^ p - C a :=
    separating_element_frobenius_minpoly (p := p) t ht
  have hint : IsIntegral S t := by
    refine ⟨X ^ p - C a,
      monic_X_pow_sub_C _ (Fact.out : p.Prime).ne_zero, ?_⟩
    rw [← hmin]
    exact minpoly.aeval S t
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

/-- Every genuine one-variable function field over perfect constants has
an actual one-parameter p-basis. The separating parameter is constructed. -/
theorem one_variable_power_p_basis_exists [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    Nonempty (PowerPBasis K p) := by
  obtain ⟨t, ht, hsep⟩ := one_variable_separating_element_exists hfg htrdeg
  letI := hsep
  obtain ⟨b, _⟩ := separating_element_power_p_basis_exists (p := p) t ht
  exact ⟨b⟩

end Litt3.SharedTensors
