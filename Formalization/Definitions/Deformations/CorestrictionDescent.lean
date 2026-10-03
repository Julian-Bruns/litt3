import Mathlib.Algebra.Group.Hom.Basic
import Mathlib.Algebra.Group.Equiv.Defs
import Mathlib.Algebra.Group.Subgroup.Ker

namespace Litt3.Deformations

variable {V W : Type*} [AddCommGroup V] [AddCommGroup W]

/-- Multiplication by the actual finite cover degree, as an additive
map. No coefficient-field linearity is imposed. -/
def degreeMultiple (degree : ℕ) : V →+ V where
  toFun x := degree • x
  map_zero' := nsmul_zero degree
  map_add' := by
    intro x y
    exact nsmul_add x y degree

/-- Divide the actual corestriction by the actual invertible degree. -/
noncomputable def normalizedCorestriction (trace : W →+ V) (degree : ℕ)
    (invertible_degree : Function.Bijective (degreeMultiple (V := V) degree)) :
    W →+ V :=
  (AddEquiv.ofBijective (degreeMultiple degree) invertible_degree).symm.toAddMonoidHom.comp
    trace

/-- Exact trace-free component of a specified upstairs extension
difference. A vanishing scalar projection is not substituted here. -/
def traceFreePart (pullback : V →+ W) (retraction : W →+ V) (w : W) : W :=
  w - pullback (retraction w)

end Litt3.Deformations
