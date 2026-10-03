import Definitions.SharedTensors.DivisorGluing

namespace Litt3.SharedTensors.DivisorGluingSquare

variable {A U V D : Type*} [AddCommGroup A] [AddCommGroup U]
  [AddCommGroup V] [AddCommGroup D] (s : DivisorGluingSquare A U V D)

theorem gluingData_relation (x : s.gluingData) : s.divisor x.1.1 = s.principal x.1.2 :=
  sub_eq_zero.mp x.2

@[simp] theorem endpointGauge_val (v : V) :
    (s.endpointGauge v).1 = (s.endpointPrincipal v, s.endpointUnit v) := rfl

def principalClassMap : s.UnitClasses →+ s.DivisorClasses :=
  QuotientAddGroup.lift s.endpointUnit.range
    ((QuotientAddGroup.mk' s.divisor.range).comp s.principal) (by
      rintro _ ⟨v, rfl⟩
      change QuotientAddGroup.mk' s.divisor.range (s.principal (s.endpointUnit v)) = 0
      rw [s.compatible]
      exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨_, rfl⟩)

def rawUnitClassMap : s.gluingData →+ s.UnitClasses :=
  (QuotientAddGroup.mk' s.endpointUnit.range).comp
    ((AddMonoidHom.snd A U).comp s.gluingData.subtype)

def gluingUnitClass : s.GluingClasses →+ s.UnitClasses :=
  QuotientAddGroup.lift s.endpointGauge.range s.rawUnitClassMap (by
    rintro _ ⟨v, rfl⟩
    change QuotientAddGroup.mk' s.endpointUnit.range (s.endpointUnit v) = 0
    exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨v, rfl⟩)

def invariantDivisorData : s.divisor.ker →+ s.gluingData where
  toFun a := ⟨(a.1, 0), by
    change s.divisor a.1 - s.principal 0 = 0
    rw [map_zero, sub_zero]
    exact a.2⟩
  map_zero' := by ext <;> rfl
  map_add' := by intro a b; ext <;> simp

def invariantDivisorClass : s.divisor.ker →+ s.GluingClasses :=
  (QuotientAddGroup.mk' s.endpointGauge.range).comp s.invariantDivisorData

@[simp] theorem principalClassMap_mk (u : U) :
    s.principalClassMap (QuotientAddGroup.mk' s.endpointUnit.range u) =
      QuotientAddGroup.mk' s.divisor.range (s.principal u) := rfl

@[simp] theorem gluingUnitClass_mk (x : s.gluingData) :
    s.gluingUnitClass (QuotientAddGroup.mk' s.endpointGauge.range x) =
      QuotientAddGroup.mk' s.endpointUnit.range x.1.2 := rfl

@[simp] theorem gluingUnitClass_invariant (a : s.divisor.ker) :
    s.gluingUnitClass (s.invariantDivisorClass a) = 0 := by
  change QuotientAddGroup.mk' s.endpointUnit.range 0 = 0
  exact map_zero _

/-- Every actual unit class whose divisor is an endpoint difference has
an actual divisor pair and rational trivialization representing it. -/
theorem gluingUnitClass_range : s.gluingUnitClass.range = s.principalClassMap.ker := by
  ext q
  constructor
  · rintro ⟨p, rfl⟩
    obtain ⟨x, rfl⟩ := QuotientAddGroup.mk'_surjective s.endpointGauge.range p
    change QuotientAddGroup.mk' s.divisor.range (s.principal x.1.2) = 0
    rw [← s.gluingData_relation x]
    exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨x.1.1, rfl⟩
  · intro hq
    obtain ⟨u, rfl⟩ := QuotientAddGroup.mk'_surjective s.endpointUnit.range q
    change QuotientAddGroup.mk' s.divisor.range (s.principal u) = 0 at hq
    obtain ⟨a, ha⟩ := (QuotientAddGroup.eq_zero_iff _).mp hq
    let x : s.gluingData := ⟨(a, u), by change s.divisor a - s.principal u = 0; rw [ha, sub_self]⟩
    exact ⟨QuotientAddGroup.mk' s.endpointGauge.range x, rfl⟩

/-- The kernel consists precisely of invariant endpoint divisor pairs;
the whole source unit is eliminated only by an actual endpoint gauge. -/
theorem gluingUnitClass_kernel : s.gluingUnitClass.ker = s.invariantDivisorClass.range := by
  ext p
  constructor
  · intro hp
    obtain ⟨x, rfl⟩ := QuotientAddGroup.mk'_surjective s.endpointGauge.range p
    change QuotientAddGroup.mk' s.endpointUnit.range x.1.2 = 0 at hp
    obtain ⟨v, hv⟩ := (QuotientAddGroup.eq_zero_iff _).mp hp
    let a : s.divisor.ker := ⟨x.1.1 - s.endpointPrincipal v, by
      change s.divisor (x.1.1 - s.endpointPrincipal v) = 0
      rw [map_sub, s.gluingData_relation x, ← s.compatible, hv, sub_self]⟩
    refine ⟨a, ?_⟩
    have hx : s.invariantDivisorData a = x - s.endpointGauge v := by
      apply Subtype.ext
      ext <;> simp [a, invariantDivisorData, hv]
    change QuotientAddGroup.mk' s.endpointGauge.range (s.invariantDivisorData a) = _
    rw [hx, map_sub]
    have hg : QuotientAddGroup.mk' s.endpointGauge.range (s.endpointGauge v) = 0 :=
      (QuotientAddGroup.eq_zero_iff _).mpr ⟨v, rfl⟩
    rw [hg, sub_zero]
  · rintro ⟨a, rfl⟩
    exact s.gluingUnitClass_invariant a

/-- Corelessness is needed only for this concrete condition on endpoint
units. It is not needed for exactness or surjectivity above. -/
theorem invariantDivisorClass_injective
    (h : ∀ v, s.endpointUnit v = 0 → s.endpointPrincipal v = 0) :
    Function.Injective s.invariantDivisorClass := by
  apply (AddMonoidHom.ker_eq_bot_iff _).mp
  apply le_antisymm _ bot_le
  intro a ha
  change s.invariantDivisorClass a = 0 at ha
  obtain ⟨v, hv⟩ := (QuotientAddGroup.eq_zero_iff _).mp ha
  have hu : s.endpointUnit v = 0 := congrArg (fun x : s.gluingData => x.1.2) hv
  have hd : s.endpointPrincipal v = a.1 := congrArg (fun x : s.gluingData => x.1.1) hv
  have hz : a = 0 := Subtype.ext (hd.symm.trans (h v hu))
  simp [hz]

/-- The comparison lands in the actual relation subgroup of the original
unit quotient, with no change to the ambient unit classes. -/
def gluingRelationClass : s.GluingClasses →+ s.principalClassMap.ker :=
  s.gluingUnitClass.codRestrict s.principalClassMap.ker (by
    intro p
    rw [← s.gluingUnitClass_range]
    exact ⟨p, rfl⟩)

theorem gluingRelationClass_surjective : Function.Surjective s.gluingRelationClass := by
  intro q
  have hq : q.val ∈ s.gluingUnitClass.range := by
    rw [s.gluingUnitClass_range]
    exact q.property
  obtain ⟨p, hp⟩ := hq
  exact ⟨p, Subtype.ext hp⟩

theorem gluingRelationClass_kernel : s.gluingRelationClass.ker = s.invariantDivisorClass.range := by
  rw [← s.gluingUnitClass_kernel]
  ext p
  change s.gluingRelationClass p = 0 ↔ s.gluingUnitClass p = 0
  exact Subtype.ext_iff

/-- No invariant divisor pairs means the full gluing class group equals
the actual relation subgroup, not merely that their ranks agree. -/
noncomputable def gluingRelationEquivOfNoInvariantDivisors
    (h : ∀ a : s.divisor.ker, a = 0) : s.GluingClasses ≃+ s.principalClassMap.ker :=
  AddEquiv.ofBijective s.gluingRelationClass ⟨by
    apply (AddMonoidHom.ker_eq_bot_iff _).mp
    apply le_antisymm _ bot_le
    intro p hp
    rw [s.gluingRelationClass_kernel] at hp
    obtain ⟨a, rfl⟩ := hp
    rw [h a, map_zero]
    exact (AddSubgroup.mem_bot.mpr rfl), s.gluingRelationClass_surjective⟩

end Litt3.SharedTensors.DivisorGluingSquare
