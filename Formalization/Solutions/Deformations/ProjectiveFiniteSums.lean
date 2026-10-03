import Mathlib.LinearAlgebra.Projectivization.Cardinality
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Fintype.Units

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization BigOperators

variable (F V : Type*) [Field F] [AddCommGroup V] [Module F V]

/-- Actual nonzero vectors parametrized by the chosen actual representative
of their projective line and a nonzero scalar. -/
noncomputable def projectiveRepUnitsEquiv :
    (ℙ F V × Fˣ) ≃ {v : V // v ≠ 0} := by
  classical
  let map : (ℙ F V × Fˣ) → {v : V // v ≠ 0} :=
    fun x => ⟨(x.2 : F) • x.1.rep, smul_ne_zero x.2.ne_zero x.1.rep_nonzero⟩
  apply Equiv.ofBijective map
  constructor
  · intro x y same
    have values : (x.2 : F) • x.1.rep = (y.2 : F) • y.1.rep := congrArg Subtype.val same
    have line (P : ℙ F V) (u : Fˣ) :
        Projectivization.mk F ((u : F) • P.rep) (smul_ne_zero u.ne_zero P.rep_nonzero) = P := by
      calc
        _ = Projectivization.mk F P.rep P.rep_nonzero :=
          (Projectivization.mk_eq_mk_iff F _ _ _ _).mpr ⟨u, rfl⟩
        _ = P := Projectivization.mk_rep P
    have sameLine : x.1 = y.1 := by
      have equal := congrArg (fun v : {v : V // v ≠ 0} => Projectivization.mk F v.val v.property) same
      simpa only [map, line] using equal
    apply Prod.ext sameLine
    apply Units.ext
    apply smul_left_injective F x.1.rep_nonzero
    simpa only [sameLine] using values
  · intro v
    obtain ⟨u, scalar⟩ := Projectivization.exists_smul_eq_mk_rep F v.val v.property
    refine ⟨(Projectivization.mk F v.val v.property, u⁻¹), ?_⟩
    apply Subtype.ext
    change ((u⁻¹ : Fˣ) : F) • (Projectivization.mk F v.val v.property).rep = v.val
    rw [← scalar]
    change u⁻¹ • (u • v.val) = v.val
    simp

variable [Fintype F] [Fintype Fˣ] [Fintype V] [Fintype (ℙ F V)]

/-- Summing a scalar-invariant function over all vectors multiplies its
projective representative sum by the number of nonzero scalars. -/
theorem finite_projective_sum {A : Type*} [AddCommMonoid A] (f : V → A)
    (zero : f 0 = 0) (invariant : ∀ (u : Fˣ) v, f ((u : F) • v) = f v) :
    ∑ v : V, f v = Fintype.card Fˣ • ∑ P : ℙ F V, f P.rep := by
  classical
  have nonzero : ∑ v : {v : V // v ≠ 0}, f v.val = ∑ v : V, f v := by
    have split := Fintype.sum_subtype_add_sum_subtype (fun v : V => v ≠ 0) f
    have other : ∑ v : {v : V // ¬v ≠ 0}, f v.val = 0 := by
      apply Finset.sum_eq_zero
      intro v _
      simpa only [not_not.mp v.property] using zero
    simpa only [other, add_zero] using split
  rw [← nonzero, ← Equiv.sum_comp (projectiveRepUnitsEquiv F V)]
  rw [Fintype.sum_prod_type]
  simp only [projectiveRepUnitsEquiv, Equiv.ofBijective_apply, invariant,
    Finset.sum_const, Finset.card_univ]
  exact Finset.smul_sum.symm

end Litt3.Deformations
