import Solutions.CartierAndSpin.PrimitiveFieldPresentations
import Mathlib.FieldTheory.RatFunc.AsPolynomial
import Mathlib.RingTheory.Polynomial.Tower

namespace Litt3.CartierAndSpin

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

theorem rational_coefficient_inclusion_X :
    algebraMap (RatFunc K) (RatFunc L) (RatFunc.X : RatFunc K) = RatFunc.X := by
  change algebraMap (RatFunc K) (RatFunc L)
    (algebraMap K[X] (RatFunc K) X) = algebraMap L[X] (RatFunc L) X
  rw [← IsScalarTower.algebraMap_apply K[X] (RatFunc K) (RatFunc L)]
  change algebraMap L[X] (RatFunc L) ((algebraMap K[X] L[X]) X) = _
  change algebraMap L[X] (RatFunc L) (Polynomial.map (algebraMap K L) X) = _
  rw [Polynomial.map_X]

theorem rational_coefficient_inclusion_C (a : K) :
    algebraMap (RatFunc K) (RatFunc L) (RatFunc.C a) = RatFunc.C (algebraMap K L a) := by
  change algebraMap (RatFunc K) (RatFunc L) (algebraMap K (RatFunc K) a) =
    algebraMap L (RatFunc L) (algebraMap K L a)
  rw [← IsScalarTower.algebraMap_apply K (RatFunc K) (RatFunc L),
    ← IsScalarTower.algebraMap_apply K L (RatFunc L)]

/-- Passing to a genuine independent rational parameter preserves a
literal primitive field generator. All polynomials and denominator
inverses are handled, not merely the scalar extension's polynomial part. -/
theorem rational_constant_generator (w : L)
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤) :
    IntermediateField.adjoin (RatFunc K) ({RatFunc.C w} : Set (RatFunc L)) = ⊤ := by
  let E := IntermediateField.adjoin (RatFunc K) ({RatFunc.C w} : Set (RatFunc L))
  have hcoeff : ∀ a : L, RatFunc.C a ∈ E := by
    intro a
    have ha : a ∈ IntermediateField.adjoin K ({w} : Set L) := by rw [hgen]; trivial
    induction ha using IntermediateField.adjoin_induction with
    | mem a ha =>
      obtain rfl := Set.mem_singleton_iff.mp ha
      exact IntermediateField.subset_adjoin _ _ (Set.mem_singleton _)
    | algebraMap a =>
      rw [← rational_coefficient_inclusion_C]
      exact E.algebraMap_mem (RatFunc.C a)
    | add a b ha hb hca hcb =>
      rw [map_add]
      exact E.add_mem hca hcb
    | inv a ha hca =>
      rw [map_inv₀]
      exact E.inv_mem hca
    | mul a b ha hb hca hcb =>
      rw [map_mul]
      exact E.mul_mem hca hcb
  have hX : (RatFunc.X : RatFunc L) ∈ E := by
    rw [← rational_coefficient_inclusion_X (K := K)]
    exact E.algebraMap_mem RatFunc.X
  have hpoly : ∀ P : L[X], algebraMap L[X] (RatFunc L) P ∈ E := by
    intro P
    induction P using Polynomial.induction_on' with
    | add P Q hP hQ => rw [map_add]; exact E.add_mem hP hQ
    | monomial n a =>
      rw [RatFunc.algebraMap_monomial]
      exact E.mul_mem (hcoeff a) (E.pow_mem hX n)
  apply top_unique
  intro f _
  induction f using RatFunc.induction_on with
  | f P Q hQ => exact E.div_mem (hpoly P) (hpoly Q)

theorem rational_constant_polynomial_aeval (w : L) (P : K[X]) :
    aeval (RatFunc.C w) (P.map (algebraMap K (RatFunc K))) =
      RatFunc.C (aeval w P) := by
  rw [aeval_map_algebraMap]
  exact aeval_algebraMap_apply (RatFunc L) w P

end Litt3.CartierAndSpin
