import Mathlib.GroupTheory.QuotientGroup.Basic

namespace Litt3.SharedTensors

variable {A B U V : Type*} [AddCommGroup A] [AddCommGroup B]
  [AddCommGroup U] [AddCommGroup V]

def productPrincipalQuotientMap (c : U →+ A) (d : V →+ B) :
    (A × B) ⧸ (c.prodMap d).range →+ (A ⧸ c.range) × (B ⧸ d.range) :=
  QuotientAddGroup.lift (c.prodMap d).range
    ((QuotientAddGroup.mk' c.range).prodMap (QuotientAddGroup.mk' d.range)) (by
      rintro _ ⟨⟨u, v⟩, rfl⟩
      apply Prod.ext
      · exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨u, rfl⟩
      · exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨v, rfl⟩)

theorem productPrincipalQuotientMap_surjective (c : U →+ A) (d : V →+ B) :
    Function.Surjective (productPrincipalQuotientMap c d) := by
  rintro ⟨q, r⟩
  obtain ⟨a, rfl⟩ := QuotientAddGroup.mk'_surjective c.range q
  obtain ⟨b, rfl⟩ := QuotientAddGroup.mk'_surjective d.range r
  exact ⟨QuotientAddGroup.mk' (c.prodMap d).range (a, b), rfl⟩

theorem productPrincipalQuotientMap_injective (c : U →+ A) (d : V →+ B) :
    Function.Injective (productPrincipalQuotientMap c d) := by
  apply (AddMonoidHom.ker_eq_bot_iff _).mp
  apply le_antisymm _ bot_le
  intro q hq
  obtain ⟨⟨a, b⟩, rfl⟩ := QuotientAddGroup.mk'_surjective (c.prodMap d).range q
  have hA := congrArg Prod.fst hq
  have hB := congrArg Prod.snd hq
  change QuotientAddGroup.mk' c.range a = 0 at hA
  change QuotientAddGroup.mk' d.range b = 0 at hB
  obtain ⟨u, hu⟩ := (QuotientAddGroup.eq_zero_iff _).mp hA
  obtain ⟨v, hv⟩ := (QuotientAddGroup.eq_zero_iff _).mp hB
  apply AddSubgroup.mem_bot.mpr
  exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨(u, v), Prod.ext hu hv⟩

/-- The actual quotient by the two endpoint principal-divisor groups
is the product of the actual two divisor-class groups. -/
noncomputable def productPrincipalQuotientsEquiv (c : U →+ A) (d : V →+ B) :
    (A × B) ⧸ (c.prodMap d).range ≃+ (A ⧸ c.range) × (B ⧸ d.range) :=
  AddEquiv.ofBijective (productPrincipalQuotientMap c d)
    ⟨productPrincipalQuotientMap_injective c d, productPrincipalQuotientMap_surjective c d⟩

@[simp] theorem productPrincipalQuotientsEquiv_mk (c : U →+ A) (d : V →+ B) (a : A) (b : B) :
    productPrincipalQuotientsEquiv c d (QuotientAddGroup.mk' (c.prodMap d).range (a, b)) =
      (QuotientAddGroup.mk' c.range a, QuotientAddGroup.mk' d.range b) := rfl

end Litt3.SharedTensors
