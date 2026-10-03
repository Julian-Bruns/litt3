import Mathlib.Algebra.Group.Subgroup.Ker
import Mathlib.Algebra.GroupWithZero.WithZero
import Mathlib.Algebra.Order.GroupWithZero.WithZero
import Mathlib.Algebra.Group.TypeTags.Hom
import Mathlib.Data.Finsupp.Basic
import Mathlib.GroupTheory.QuotientGroup.Defs
import Mathlib.RingTheory.Valuation.Basic

/-!
Divisors built from actual integer-valued field valuations. Finite support is
an explicit input; constructing normalized valuations from a smooth proper
curve and proving finite support and the product formula remain geometric
obligations. No project theorem or torsion criterion is an axiom here.
-/

namespace Litt3.Jacobians

open scoped WithZero
noncomputable section

abbrev Divisor (Points : Type*) := Points →₀ ℤ

/-- The usual order convention is minus the multiplicative valuation's
integer logarithm: a local uniformizer valued at `exp(-1)` has order one. -/
def valuationOrder {K : Type*} [Field K]
    (v : Valuation K ℤᵐ⁰) : Additive Kˣ →+ ℤ :=
  -((WithZero.unitsWithZeroEquiv : (ℤᵐ⁰)ˣ ≃* Multiplicative ℤ).toMonoidHom.comp
    (Units.map v.toMonoidWithZeroHom.toMonoidHom)).toAdditive

/-- A family of genuine field valuations whose nonzero orders have finite
support on every rational function. This does not assert the curve bridge
or that all degree-zero divisors are principal. -/
structure ValuationDivisorSystem (K Points : Type*) [Field K] where
  valuation : Points → Valuation K ℤᵐ⁰
  finite_support : ∀ f : Additive Kˣ,
    (Function.support (fun p => valuationOrder (valuation p) f)).Finite

noncomputable def principalDivisorMap {K Points : Type*} [Field K]
    (system : ValuationDivisorSystem K Points) : Additive Kˣ →+ Divisor Points where
  toFun f := Finsupp.ofSupportFinite
    (fun p => valuationOrder (system.valuation p) f) (system.finite_support f)
  map_zero' := by
    ext p
    change valuationOrder (system.valuation p) 0 = 0
    exact map_zero _
  map_add' := by
    intro f g
    ext p
    change valuationOrder (system.valuation p) (f + g) =
      valuationOrder (system.valuation p) f + valuationOrder (system.valuation p) g
    exact map_add _ f g

def principalDivisors {K Points : Type*} [Field K]
    (system : ValuationDivisorSystem K Points) : AddSubgroup (Divisor Points) :=
  (principalDivisorMap system).range

abbrev DivisorClassGroup {K Points : Type*} [Field K]
    (system : ValuationDivisorSystem K Points) :=
  Divisor Points ⧸ principalDivisors system

def divisorClassMap {K Points : Type*} [Field K]
    (system : ValuationDivisorSystem K Points) :
    Divisor Points →+ DivisorClassGroup system :=
  QuotientAddGroup.mk' (principalDivisors system)

noncomputable def pointDivisor {Points : Type*} (p : Points) : Divisor Points :=
  Finsupp.single p 1

def EffectiveDivisor {Points : Type*} (D : Divisor Points) : Prop :=
  ∀ p : Points, 0 ≤ D p

def divisorDegree {Points : Type*} : Divisor Points →+ ℤ :=
  Finsupp.liftAddHom fun _p => AddMonoidHom.id ℤ

end
end Litt3.Jacobians
