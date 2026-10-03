import Mathlib.GroupTheory.QuotientGroup.Basic

namespace Litt3.SharedTensors

variable (A U V D : Type*) [AddCommGroup A] [AddCommGroup U]
  [AddCommGroup V] [AddCommGroup D]

/-- An actual commuting square of divisor and rational-function groups.
The two endpoint groups can be products; no finiteness is imposed. -/
structure DivisorGluingSquare where
  divisor : A →+ D
  principal : U →+ D
  endpointPrincipal : V →+ A
  endpointUnit : V →+ U
  compatible : ∀ v, principal (endpointUnit v) = divisor (endpointPrincipal v)

namespace DivisorGluingSquare

variable {A U V D} (s : DivisorGluingSquare A U V D)

/-- Divisor pairs with an actual rational trivialization of their difference. -/
def gluingData : AddSubgroup (A × U) :=
  (s.divisor.comp (AddMonoidHom.fst _ _) -
    s.principal.comp (AddMonoidHom.snd _ _)).ker

def endpointGauge : V →+ s.gluingData :=
  (s.endpointPrincipal.prod s.endpointUnit).codRestrict s.gluingData (by
    intro v
    change s.divisor (s.endpointPrincipal v) - s.principal (s.endpointUnit v) = 0
    rw [s.compatible, sub_self])

/-- Changing endpoint rational sections, rather than discarding the actual
source unit, defines the invariant-divisor model of the Picard group. -/
abbrev GluingClasses := s.gluingData ⧸ s.endpointGauge.range

abbrev UnitClasses := U ⧸ s.endpointUnit.range

abbrev DivisorClasses := D ⧸ s.divisor.range

end DivisorGluingSquare
end Litt3.SharedTensors
