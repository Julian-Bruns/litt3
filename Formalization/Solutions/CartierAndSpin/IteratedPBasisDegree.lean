import Solutions.CartierAndSpin.IteratedPBasisGeneration
import Solutions.SharedTensors.PBasisDerivation
import Mathlib.FieldTheory.PurelyInseparable.Basic
import Mathlib.FieldTheory.IntermediateField.Adjoin.Algebra

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial IntermediateField Module

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

theorem iterated_frobenius_image_equiv_coe (e : ℕ) (a : L) :
    (iteratedFrobeniusImageEquiv L p e a : L) = a ^ (p ^ e) := rfl

/-- A genuine full p-basis parameter is not an actual p-th power. -/
theorem p_basis_parameter_has_no_pth_root (b : PowerPBasis L p) :
    ¬ ∃ r : L, r ^ p = b.parameter := by
  obtain ⟨D, ht⟩ := p_basis_normalized_derivation_exists b
  rintro ⟨r, hr⟩
  have hzero : D (r ^ p) = 0 := by
    rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero, zero_mul]
  rw [hr, ht] at hzero
  exact one_ne_zero hzero

/-- Exact minimal polynomial over the actual p^e-th-power subfield.
No p^e-degree or irreducibility assumption is supplied. -/
theorem iterated_p_basis_minpoly (b : PowerPBasis L p) (e : ℕ) :
    minpoly (iteratedFrobeniusSubfield L p e) b.parameter =
      X ^ (p ^ e) - C (iteratedFrobeniusImageEquiv L p e b.parameter) := by
  let S := iteratedFrobeniusSubfield L p e
  letI : IsPurelyInseparable S L := (isPurelyInseparable_iff_pow_mem S p).mpr (by
    intro a
    refine ⟨e, ⟨a ^ (p ^ e), ⟨a, rfl⟩⟩, rfl⟩)
  obtain ⟨j, c, hmin⟩ := IsPurelyInseparable.minpoly_eq_X_pow_sub_C S p b.parameter
  have hroot : b.parameter ^ (p ^ j) = c.val := by
    have h := minpoly.aeval S b.parameter
    rw [hmin] at h
    simpa only [map_sub, map_pow, aeval_X, aeval_C, sub_eq_zero] using h
  have hjge : e ≤ j := by
    by_contra h
    have hjlt : j < e := by omega
    obtain ⟨r, hr⟩ := c.property
    change r ^ (p ^ e) = c.val at hr
    have heq : b.parameter = r ^ (p ^ (e - j)) := by
      apply (iterateFrobenius L p j).injective
      change b.parameter ^ (p ^ j) = (r ^ (p ^ (e - j))) ^ (p ^ j)
      rw [hroot, ← hr, ← pow_mul, ← pow_add, Nat.sub_add_cancel hjlt.le]
    obtain ⟨m, hm⟩ : ∃ m : ℕ, e - j = m + 1 :=
      Nat.exists_eq_succ_of_ne_zero (by omega)
    apply p_basis_parameter_has_no_pth_root b
    refine ⟨r ^ (p ^ m), ?_⟩
    rw [← pow_mul, ← pow_succ, ← hm, ← heq]
  let P : S[X] := X ^ (p ^ e) - C (iteratedFrobeniusImageEquiv L p e b.parameter)
  have hP : P.Monic := monic_X_pow_sub_C _ (pow_ne_zero _ (Fact.out : p.Prime).ne_zero)
  have hPeval : aeval b.parameter P = 0 := by
    change (aeval b.parameter : S[X] →ₐ[S] L)
      (X ^ (p ^ e) - C (iteratedFrobeniusImageEquiv L p e b.parameter)) = 0
    rw [map_sub, map_pow, aeval_X, aeval_C]
    change b.parameter ^ (p ^ e) - (iteratedFrobeniusImageEquiv L p e b.parameter : L) = 0
    rw [iterated_frobenius_image_equiv_coe, sub_self]
  have hdegree := natDegree_le_of_dvd (minpoly.dvd S b.parameter hPeval) hP.ne_zero
  rw [hmin, natDegree_X_pow_sub_C] at hdegree
  change p ^ j ≤ P.natDegree at hdegree
  have hPdegree : P.natDegree = p ^ e := natDegree_X_pow_sub_C
  rw [hPdegree] at hdegree
  have hjle : j ≤ e := (Nat.pow_le_pow_iff_right (Fact.out : p.Prime).one_lt).mp hdegree
  have hje : j = e := le_antisymm hjle hjge
  have hc : c = iteratedFrobeniusImageEquiv L p e b.parameter := by
    apply Subtype.ext
    rw [iterated_frobenius_image_equiv_coe, ← hroot, hje]
  rw [hmin, hje, hc]

/-- The literal full power basis at every iterated Frobenius depth is
constructed from the actual generated subfield and actual minimal polynomial. -/
theorem iterated_p_basis_power_basis_exists (b : PowerPBasis L p) (e : ℕ) :
    ∃ pb : PowerBasis (iteratedFrobeniusSubfield L p e) L,
      pb.gen = b.parameter ∧ pb.dim = p ^ e := by
  let S := iteratedFrobeniusSubfield L p e
  have hmin := iterated_p_basis_minpoly b e
  have hint : IsIntegral S b.parameter := by
    refine ⟨X ^ (p ^ e) - C (iteratedFrobeniusImageEquiv L p e b.parameter),
      monic_X_pow_sub_C _ (pow_ne_zero _ (Fact.out : p.Prime).ne_zero), ?_⟩
    rw [← hmin]
    exact minpoly.aeval S b.parameter
  let eqv : (IntermediateField.adjoin S {b.parameter}) ≃ₐ[S] L :=
    (IntermediateField.equivOfEq (p_basis_generates_over_iterated_frobenius b e)).trans
      IntermediateField.topEquiv
  let pb := (IntermediateField.adjoin.powerBasis hint).map eqv
  refine ⟨pb, rfl, ?_⟩
  change (minpoly S b.parameter).natDegree = p ^ e
  rw [hmin]
  exact natDegree_X_pow_sub_C

end Litt3.CartierAndSpin
