import Solutions.SharedTensors.PBasisChangeParameter

namespace Litt3.SharedTensors

open Polynomial IntermediateField Module

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Actual generation by a non-p-th-power parameter constructs the full
literal p-basis. No finite p-degree or basis is supplied. -/
theorem generated_nonpth_power_p_basis_exists (t : K)
    (hnot : t ∉ frobeniusSubfield K p)
    (htop : IntermediateField.adjoin (frobeniusSubfield K p) {t} = ⊤) :
    ∃ b : PowerPBasis K p, b.parameter = t := by
  let S := frobeniusSubfield K p
  have hmin : minpoly S t = X ^ p - C (frobeniusImageEquiv K p t) :=
    nonpth_element_frobenius_minpoly t hnot
  have hint : IsIntegral S t := by
    refine ⟨X ^ p - C (frobeniusImageEquiv K p t),
      monic_X_pow_sub_C _ (Fact.out : p.Prime).ne_zero, ?_⟩
    rw [← hmin]
    exact minpoly.aeval S t
  let e : (IntermediateField.adjoin S {t}) ≃ₐ[S] K :=
    (IntermediateField.equivOfEq htop).trans IntermediateField.topEquiv
  let pb := (IntermediateField.adjoin.powerBasis hint).map e
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
