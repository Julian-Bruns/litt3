import Solutions.Deformations.ActualAdditiveGroupAugmentation
import Solutions.Deformations.ElementaryPrimeNormMonomial

namespace Litt3.Deformations

open scoped BigOperators

variable (p : ℕ) [Fact p.Prime]
variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The literal sum of every original elementary group element. -/
noncomputable def elementaryOriginalNorm (r : ℕ) :
    AddMonoidAlgebra R (Fin r → ZMod p) :=
  ∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g 1

/-- The literal original coordinate-cycle norm, before any coefficient reduction. -/
noncomputable def elementaryOriginalCoordinateNorm (r : ℕ) (i : Fin r) :
    AddMonoidAlgebra R (Fin r → ZMod p) :=
  ∑ j : Fin p, (AddMonoidAlgebra.single (Pi.single i (1 : ZMod p)) (1 : R)) ^ j.val

theorem elementary_original_norm_product (r : ℕ) :
    (∏ i : Fin r, elementaryOriginalCoordinateNorm (R := R) p r i) =
      elementaryOriginalNorm (R := R) p r := by
  classical
  unfold elementaryOriginalCoordinateNorm elementaryOriginalNorm
  rw [Fintype.prod_sum (fun i (j : Fin p) =>
    (AddMonoidAlgebra.single (Pi.single i (1 : ZMod p)) (1 : R)) ^ j.val)]
  have term (alpha : Fin r → Fin p) :
      (∏ i : Fin r, (AddMonoidAlgebra.single (Pi.single i (1 : ZMod p)) (1 : R)) ^
        (alpha i).val) =
      AddMonoidAlgebra.single (fun i => ZMod.finEquiv p (alpha i)) (1 : R) := by
    simp only [AddMonoidAlgebra.single_pow, one_pow]
    rw [AddMonoidAlgebra.prod_single]
    have index : (∑ i : Fin r, (alpha i).val • (Pi.single i (1 : ZMod p) : Fin r → ZMod p)) =
        fun i => ZMod.finEquiv p (alpha i) := by
      ext j
      simp [Pi.single_apply, nsmul_eq_mul]
      have originalVal : (ZMod.finEquiv p (alpha j)).val = (alpha j).val := by
        cases p with
        | zero => exact ((Fact.out : Nat.Prime 0).ne_zero rfl).elim
        | succ n => rfl
      simpa only [originalVal] using ZMod.natCast_zmod_val (ZMod.finEquiv p (alpha j))
    rw [index]
    simp
  simp_rw [term]
  exact Equiv.sum_comp (Equiv.piCongrRight (fun _ : Fin r => (ZMod.finEquiv p).toEquiv))
    (fun g => AddMonoidAlgebra.single g (1 : R))

@[simp] theorem elementary_original_norm_coefficient (r : ℕ) (g : Fin r → ZMod p) :
    elementaryOriginalNorm (R := R) p r g = 1 := by
  classical
  change (∑ h : Fin r → ZMod p, Finsupp.single h (1 : R)) g = 1
  simp [Finsupp.finset_sum_apply, Finsupp.single_apply]

@[simp] theorem elementary_original_norm_aug (r : ℕ) :
    additiveGroupAlgebraAugmentation (elementaryOriginalNorm (R := R) p r) = (p : R) ^ r := by
  classical
  simp [elementaryOriginalNorm, Fintype.card_fun, ZMod.card, Nat.cast_pow]

theorem elementary_original_norm_mul_single (r : ℕ) (g : Fin r → ZMod p) (c : R) :
    elementaryOriginalNorm (R := R) p r * AddMonoidAlgebra.single g c =
      c • elementaryOriginalNorm (R := R) p r := by
  classical
  unfold elementaryOriginalNorm
  rw [Finset.sum_mul]
  simp only [AddMonoidAlgebra.single_mul_single, one_mul,
    Finset.smul_sum, AddMonoidAlgebra.smul_single, smul_eq_mul, mul_one]
  exact Equiv.sum_comp (Equiv.addRight g) (fun h => AddMonoidAlgebra.single h c)

theorem elementary_original_norm_mul (r : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod p)) :
    elementaryOriginalNorm (R := R) p r * x =
      additiveGroupAlgebraAugmentation x • elementaryOriginalNorm (R := R) p r := by
  apply AddMonoidAlgebra.induction_on x
  · intro g
    simpa using elementary_original_norm_mul_single (R := R) p r g (1 : R)
  · intro x y hx hy
    rw [mul_add, hx, hy, map_add, add_smul]
  · intro c x hx
    rw [mul_smul_comm, hx, map_smul, smul_smul]
    rfl

/-- Actual deck equivariance maps every integral norm target to another
literal norm target; its coefficient is the augmented constant action. -/
theorem elementary_deck_operator_norm (r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod p) →+ AddMonoidAlgebra R (Fin r → ZMod p))
    (equivariant : ElementaryDeckEquivariant p r L) (eta : R) :
    L (eta • elementaryOriginalNorm (R := R) p r) =
      additiveGroupAlgebraAugmentation
        (L (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p)) eta)) •
          elementaryOriginalNorm (R := R) p r := by
  classical
  have source : eta • elementaryOriginalNorm (R := R) p r =
      ∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g 1 *
        algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p)) eta := by
    simp only [elementaryOriginalNorm, Algebra.smul_def, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro g _
    exact mul_comm _ _
  calc
    _ = ∑ g : Fin r → ZMod p, L (AddMonoidAlgebra.single g 1 *
        algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p)) eta) := by rw [source, map_sum]
    _ = ∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g 1 *
        L (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p)) eta) := by
      apply Finset.sum_congr rfl
      intro g _
      exact equivariant g _
    _ = elementaryOriginalNorm (R := R) p r *
        L (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p)) eta) := by
      rw [elementaryOriginalNorm, Finset.sum_mul]
    _ = _ := elementary_original_norm_mul p r _

end Litt3.Deformations
