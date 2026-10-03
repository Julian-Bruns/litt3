import Solutions.CurveArithmetic.AffineInvariantDegree
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

/-- Reciprocal translation preserves the actual smallest embedded
parameter field. This has no finite-field or characteristic hypothesis. -/
theorem reciprocal_translate_adjoin_eq
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (t : L) (c : K) :
    IntermediateField.adjoin K {(t - algebraMap K L c)⁻¹} =
      IntermediateField.adjoin K {t} := by
  apply le_antisymm
  · apply IntermediateField.adjoin_le_iff.mpr
    intro x hx
    have hx' : x = (t - algebraMap K L c)⁻¹ := Set.mem_singleton_iff.mp hx
    rw [hx']
    exact IntermediateField.inv_mem _
      (IntermediateField.sub_mem _
        (IntermediateField.subset_adjoin K {t} (Set.mem_singleton t))
        (IntermediateField.algebraMap_mem _ c))
  · apply IntermediateField.adjoin_le_iff.mpr
    intro x hx
    have hx' : x = t := Set.mem_singleton_iff.mp hx
    rw [hx']
    have hgenerator := IntermediateField.subset_adjoin K
      {(t - algebraMap K L c)⁻¹} (Set.mem_singleton (t - algebraMap K L c)⁻¹)
    have hrecovered : ((t - algebraMap K L c)⁻¹)⁻¹ + algebraMap K L c = t := by
      rw [inv_inv, sub_add_cancel]
    have hmem := IntermediateField.add_mem _ (IntermediateField.inv_mem _ hgenerator)
      (IntermediateField.algebraMap_mem _ c)
    rwa [hrecovered] at hmem

theorem reciprocal_translate_degree_eq
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (t : L) (c : K) :
    Module.finrank K (IntermediateField.adjoin K {(t - algebraMap K L c)⁻¹}) =
      Module.finrank K (IntermediateField.adjoin K {t}) := by
  rw [reciprocal_translate_adjoin_eq t c]

theorem reciprocal_translate_nonbase
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (t : L) (c : K) (ht : t ∉ Set.range (algebraMap K L)) :
    (t - algebraMap K L c)⁻¹ ∉ Set.range (algebraMap K L) := by
  rintro ⟨a, ha⟩
  apply ht
  refine ⟨a⁻¹ + c, ?_⟩
  rw [map_add, map_inv₀, ha, inv_inv, sub_add_cancel]

theorem finite_affine_invariant_of_quadratic_period
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L))
    (hperiod : a ^ (Fintype.card K ^ 2) = a) :
    finiteAffineInvariant K a = -1 := by
  let delta := a ^ Fintype.card K - a
  have hdelta : delta ≠ 0 := by
    intro hzero
    exact ha ((finite_field_power_fixed_iff_in_base a).mp (sub_eq_zero.mp hzero))
  have hdeltaPower : delta ^ Fintype.card K = -delta := by
    let frob := FiniteField.frobeniusAlgHom K L
    change frob (a ^ Fintype.card K - a) = -delta
    rw [map_sub, map_pow]
    change (a ^ Fintype.card K) ^ Fintype.card K - a ^ Fintype.card K = -delta
    rw [← pow_mul, ← pow_two, hperiod]
    simp only [delta, neg_sub]
  change delta ^ (Fintype.card K - 1) = -1
  apply mul_right_cancel₀ hdelta
  calc
    delta ^ (Fintype.card K - 1) * delta = delta ^ Fintype.card K := by
      rw [← pow_succ, Nat.sub_add_cancel Fintype.one_lt_card.le]
    _ = -delta := hdeltaPower
    _ = -1 * delta := by ring

theorem finite_affine_invariant_of_degree_two
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L))
    (hdegree : Module.finrank K (IntermediateField.adjoin K {a}) = 2) :
    finiteAffineInvariant K a = -1 := by
  apply finite_affine_invariant_of_quadratic_period a ha
  apply (single_element_frobenius_period_iff a 2).mpr
  rw [hdegree]

/-- Every quadratic non-base parameter belongs to the same actual
affine orbit. This is the arithmetic part of the geometric quadratic
class statement, before the branch-projectivity bridge. -/
theorem quadratic_parameters_affine_equivalent
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L]
    (a b : L) (ha : a ∉ Set.range (algebraMap K L))
    (hb : b ∉ Set.range (algebraMap K L))
    (hdegreeA : Module.finrank K (IntermediateField.adjoin K {a}) = 2)
    (hdegreeB : Module.finrank K (IntermediateField.adjoin K {b}) = 2) :
    ∃ (u : Kˣ) (v : K), b = finiteAffineTransform u v a := by
  apply (finite_affine_invariant_complete a b ha hb).mp
  rw [finite_affine_invariant_of_degree_two a ha hdegreeA,
    finite_affine_invariant_of_degree_two b hb hdegreeB]

end Litt3.CurveArithmetic
