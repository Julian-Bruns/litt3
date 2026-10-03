import Theorems.CurveArithmetic.EmbeddedFields

namespace Litt3.CurveArithmetic

theorem joint_field_index_dvd_first
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (F E : IntermediateField K L) :
    Module.finrank (F ⊔ E : IntermediateField K L) L ∣ Module.finrank F L :=
  IntermediateField.finrank_dvd_of_le_left le_sup_left

theorem joint_field_index_dvd_second
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (F E : IntermediateField K L) :
    Module.finrank (F ⊔ E : IntermediateField K L) L ∣ Module.finrank E L :=
  IntermediateField.finrank_dvd_of_le_left le_sup_right

theorem joint_field_index_dvd_gcd
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (F E : IntermediateField K L) :
    Module.finrank (F ⊔ E : IntermediateField K L) L ∣
      Nat.gcd (Module.finrank F L) (Module.finrank E L) :=
  Nat.dvd_gcd (joint_field_index_dvd_first F E) (joint_field_index_dvd_second F E)

theorem joint_field_index_target : Targets.JointFieldIndexDivisibility := by
  intro K L instK instL instAlgebra F E
  exact joint_field_index_dvd_gcd F E

/-- No simultaneous Galois closure is used: both subfields live in the
same ambient field and the conclusion concerns their actual supremum. -/
theorem coprime_embedded_fields_generate
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (F E : IntermediateField K L)
    (hcoprime : Nat.Coprime (Module.finrank F L) (Module.finrank E L)) :
    F ⊔ E = ⊤ := by
  apply IntermediateField.finrank_eq_one_iff_eq_top.mp
  exact Nat.eq_one_of_dvd_coprimes hcoprime
    (joint_field_index_dvd_first F E) (joint_field_index_dvd_second F E)

theorem coprime_embedded_fields_target : Targets.CoprimeEmbeddedFieldsGenerate := by
  intro K L instK instL instAlgebra F E hcoprime
  exact coprime_embedded_fields_generate F E hcoprime

/-- Prime field index leaves no proper nontrivial intermediate field.
This includes the inseparable characteristic-prime case. -/
theorem prime_index_intermediate_eq_top
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (hprime : Nat.Prime (Module.finrank K L))
    (E : IntermediateField K L) (hne : E ≠ ⊥) : E = ⊤ := by
  letI := IntermediateField.isSimpleOrder_of_finrank_prime K L hprime
  exact (eq_bot_or_eq_top E).resolve_left hne

/-- A function outside the base field generates a prime-index extension.
Only the field index is used, not separability or a characteristic bound. -/
theorem prime_index_outside_element_generates
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    (hprime : Nat.Prime (Module.finrank K L)) (element : L)
    (houtside : element ∉ (⊥ : IntermediateField K L)) :
    IntermediateField.adjoin K {element} = ⊤ := by
  apply prime_index_intermediate_eq_top hprime
  intro hbot
  have hmem : element ∈ IntermediateField.adjoin K {element} :=
    IntermediateField.subset_adjoin K {element} (Set.mem_singleton element)
  exact houtside (hbot ▸ hmem)

end Litt3.CurveArithmetic
