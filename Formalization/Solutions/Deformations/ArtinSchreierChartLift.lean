import Solutions.Deformations.ArtinSchreierChart
import Mathlib.RingTheory.TensorProduct.Maps

namespace Litt3.Deformations

open scoped TensorProduct BigOperators
open Polynomial

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- The universal map from the literal original integral chart is
constructed from the actual defining equations, with no etaleness input. -/
noncomputable def artinSchreierChartLift (p : ℕ) :
    (r : ℕ) → (a b : Fin r → R) → (e : Fin r → A) →
    (∀ i, e i ^ p = algebraMap R A (a i) * e i + algebraMap R A (b i)) →
      artinSchreierChart R p r a b →ₐ[R] A
  | 0, _, _, _, _ => Algebra.ofId R A
  | r + 1, a, b, e, relations => Algebra.TensorProduct.lift
      (AdjoinRoot.liftAlgHom (artinSchreierRelation p (a 0) (b 0))
        (Algebra.ofId R A) (e 0) (by
          simp only [artinSchreierRelation, eval₂_sub, eval₂_add, eval₂_pow,
            eval₂_X, eval₂_mul, eval₂_C]
          exact sub_eq_zero.mpr (relations 0)))
      (artinSchreierChartLift p r (fun i => a i.succ) (fun i => b i.succ)
        (fun i => e i.succ) (fun i => relations i.succ))
      (fun _ _ => Commute.all _ _)

@[simp] theorem artin_schreier_chart_lift_coordinate (p r : ℕ)
    (a b : Fin r → R) (e : Fin r → A)
    (relations : ∀ i, e i ^ p = algebraMap R A (a i) * e i + algebraMap R A (b i))
    (i : Fin r) :
    artinSchreierChartLift p r a b e relations
      (artinSchreierChartCoordinate R p r a b i) = e i := by
  induction r with
  | zero => exact Fin.elim0 i
  | succ r induction =>
    refine Fin.cases ?_ (fun j => ?_) i
    · change Algebra.TensorProduct.lift _ _ _
        (AdjoinRoot.root (artinSchreierRelation p (a 0) (b 0)) ⊗ₜ[R] 1) = _
      rw [Algebra.TensorProduct.lift_tmul, map_one, mul_one, AdjoinRoot.liftAlgHom_root]
    · change Algebra.TensorProduct.lift _ _ _
        (1 ⊗ₜ[R] artinSchreierChartCoordinate R p r
          (fun j => a j.succ) (fun j => b j.succ) j) = _
      rw [Algebra.TensorProduct.lift_tmul, map_one, one_mul]
      exact induction _ _ _ _ j

/-- Agreement on every original coefficient and coordinate determines
an actual ring homomorphism on the entire chart. -/
theorem artin_schreier_chart_ringHom_ext [Nontrivial R] (p : ℕ) (large : 1 < p)
    (r : ℕ) (a b : Fin r → R) (f g : artinSchreierChart R p r a b →+* A)
    (coefficients : ∀ c, f (algebraMap R _ c) = g (algebraMap R _ c))
    (coordinates : ∀ i, f (artinSchreierChartCoordinate R p r a b i) =
      g (artinSchreierChartCoordinate R p r a b i)) : f = g := by
  classical
  ext x
  let basis := artinSchreierChartBasis (R := R) p large r a b
  rw [← basis.sum_repr x, map_sum, map_sum]
  apply Finset.sum_congr rfl
  intro alpha _
  simp only [Algebra.smul_def, map_mul, coefficients]
  congr 1
  simp only [basis, artin_schreier_chart_basis_apply, map_prod, map_pow, coordinates]

end Litt3.Deformations
