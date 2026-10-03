import Solutions.SharedTensors.DivisorGluing

namespace Litt3.SharedTensors.DivisorGluingSquare

variable {A U V D : Type*} [AddCommGroup A] [AddCommGroup U]
  [AddCommGroup V] [AddCommGroup D] (s : DivisorGluingSquare A U V D)

abbrev EndpointDivisorClasses := A ⧸ s.endpointPrincipal.range
abbrev SourceDivisorClasses := D ⧸ s.principal.range

/-- The actual two-leg divisor-class map, before any Picard identification. -/
def endpointDivisorClassMap : s.EndpointDivisorClasses →+ s.SourceDivisorClasses :=
  QuotientAddGroup.lift s.endpointPrincipal.range
    ((QuotientAddGroup.mk' s.principal.range).comp s.divisor) (by
      rintro _ ⟨v, rfl⟩
      change QuotientAddGroup.mk' s.principal.range (s.divisor (s.endpointPrincipal v)) = 0
      rw [← s.compatible]
      exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨_, rfl⟩)

def gluingEndpointClass : s.GluingClasses →+ s.EndpointDivisorClasses :=
  QuotientAddGroup.lift s.endpointGauge.range
    ((QuotientAddGroup.mk' s.endpointPrincipal.range).comp
      ((AddMonoidHom.fst A U).comp s.gluingData.subtype)) (by
      rintro _ ⟨v, rfl⟩
      change QuotientAddGroup.mk' s.endpointPrincipal.range (s.endpointPrincipal v) = 0
      exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨_, rfl⟩)

/-- Actual rational trivializations surject onto the actual two-leg
divisor-class kernel, for every commuting square of these groups. -/
theorem gluingEndpointClass_range : s.gluingEndpointClass.range = s.endpointDivisorClassMap.ker := by
  ext q
  constructor
  · rintro ⟨p, rfl⟩
    obtain ⟨x, rfl⟩ := QuotientAddGroup.mk'_surjective s.endpointGauge.range p
    change QuotientAddGroup.mk' s.principal.range (s.divisor x.val.1) = 0
    rw [s.gluingData_relation x]
    exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨x.val.2, rfl⟩
  · intro hq
    obtain ⟨a, rfl⟩ := QuotientAddGroup.mk'_surjective s.endpointPrincipal.range q
    change QuotientAddGroup.mk' s.principal.range (s.divisor a) = 0 at hq
    obtain ⟨u, hu⟩ := (QuotientAddGroup.eq_zero_iff _).mp hq
    let x : s.gluingData := ⟨(a, u), by change s.divisor a - s.principal u = 0; rw [hu, sub_self]⟩
    exact ⟨QuotientAddGroup.mk' s.endpointGauge.range x, rfl⟩

/-- Every source unit of zero principal divisor can be absorbed by actual
endpoint units of zero endpoint divisors. On proper connected curves this
is supplied by the constant-global-function theorem, not by a Picard goal. -/
def AbsorbsPrincipalUnits : Prop :=
  ∀ u, s.principal u = 0 → ∃ v, s.endpointPrincipal v = 0 ∧ s.endpointUnit v = u

theorem gluingEndpointClass_injective (h : s.AbsorbsPrincipalUnits) :
    Function.Injective s.gluingEndpointClass := by
  apply (AddMonoidHom.ker_eq_bot_iff _).mp
  apply le_antisymm _ bot_le
  intro p hp
  obtain ⟨x, rfl⟩ := QuotientAddGroup.mk'_surjective s.endpointGauge.range p
  change QuotientAddGroup.mk' s.endpointPrincipal.range x.val.1 = 0 at hp
  obtain ⟨v, hv⟩ := (QuotientAddGroup.eq_zero_iff _).mp hp
  have hprincipal : s.principal (x.val.2 - s.endpointUnit v) = 0 := by
    rw [map_sub, s.compatible, hv, s.gluingData_relation x, sub_self]
  obtain ⟨w, hwc, hwr⟩ := h _ hprincipal
  have hg : s.endpointGauge (v + w) = x := by
    apply Subtype.ext
    apply Prod.ext
    · change s.endpointPrincipal (v + w) = x.val.1
      rw [map_add, hv, hwc, add_zero]
    · change s.endpointUnit (v + w) = x.val.2
      rw [map_add, hwr, add_comm, sub_add_cancel]
  apply AddSubgroup.mem_bot.mpr
  exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨v + w, hg⟩

def gluingDivisorClassKernel : s.GluingClasses →+ s.endpointDivisorClassMap.ker :=
  s.gluingEndpointClass.codRestrict _ (by
    intro p
    rw [← s.gluingEndpointClass_range]
    exact ⟨p, rfl⟩)

theorem gluingDivisorClassKernel_surjective : Function.Surjective s.gluingDivisorClassKernel := by
  intro q
  have hq : q.val ∈ s.gluingEndpointClass.range := by
    rw [s.gluingEndpointClass_range]
    exact q.property
  obtain ⟨p, hp⟩ := hq
  exact ⟨p, Subtype.ext hp⟩

/-- Under the actual source-unit absorption condition, the full gluing
class group is the actual joint divisor-class kernel. -/
noncomputable def gluingDivisorClassKernelEquiv (h : s.AbsorbsPrincipalUnits) :
    s.GluingClasses ≃+ s.endpointDivisorClassMap.ker :=
  AddEquiv.ofBijective s.gluingDivisorClassKernel ⟨by
    intro p q hpq
    exact s.gluingEndpointClass_injective h (congrArg Subtype.val hpq),
    s.gluingDivisorClassKernel_surjective⟩

end Litt3.SharedTensors.DivisorGluingSquare
