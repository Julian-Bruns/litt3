import Solutions.Deformations.ElementaryAugmentationBasis
import Mathlib.Algebra.CharP.Algebra
import Mathlib.Algebra.BigOperators.Fin

namespace Litt3.Deformations

open scoped BigOperators

/-- The exact prime-five norm polynomial in arbitrary characteristic-five
commutative rings, established as a literal ring identity. -/
theorem five_norm_polynomial {A : Type*} [CommRing A] (fiveZero : (5 : A) = 0) (s : A) :
    (s - 1) ^ 4 = ∑ j : Fin 5, s ^ j.val := by
  have formula : (s - 1) ^ 4 =
      (1 + s + s ^ 2 + s ^ 3 + s ^ 4) + 5 * (-s ^ 3 + s ^ 2 - s) := by ring
  rw [formula, fiveZero, zero_mul, add_zero]
  simp only [Fin.sum_univ_succ, Fin.sum_univ_zero, add_zero, Fin.val_zero, Fin.val_succ]
  ring

variable {R : Type*} [CommRing R] [Nontrivial R] [CharP R 5]

/-- The highest original augmentation monomial is literally the full
group norm, uniformly in the number of original generators. -/
theorem elementary_top_monomial_is_norm (r : ℕ) :
    (∏ i : Fin r, elementaryAugmentationParameter (R := R) 5 r i ^ 4) =
      ∑ g : Fin r → ZMod 5, AddMonoidAlgebra.single g (1 : R) := by
  classical
  have scalar : (5 : R) = 0 := by exact_mod_cast CharP.cast_eq_zero R 5
  have mapped := congrArg (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod 5))) scalar
  have characteristic : (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) = 0 := by
    simpa only [map_ofNat, map_zero] using mapped
  simp_rw [elementaryAugmentationParameter, five_norm_polynomial characteristic]
  rw [Fintype.prod_sum (fun i (j : Fin 5) =>
    (AddMonoidAlgebra.single (Pi.single i (1 : ZMod 5)) (1 : R)) ^ j.val)]
  have term (alpha : Fin r → Fin 5) :
      (∏ i : Fin r, (AddMonoidAlgebra.single (Pi.single i (1 : ZMod 5)) (1 : R)) ^
        (alpha i).val) =
      AddMonoidAlgebra.single (fun i => ZMod.finEquiv 5 (alpha i)) (1 : R) := by
    simp only [AddMonoidAlgebra.single_pow, one_pow]
    rw [AddMonoidAlgebra.prod_single]
    have index : (∑ i : Fin r, (alpha i).val • (Pi.single i (1 : ZMod 5) : Fin r → ZMod 5)) =
        fun i => ZMod.finEquiv 5 (alpha i) := by
      ext j
      simp [Pi.single_apply, nsmul_eq_mul]
      exact ZMod.natCast_zmod_val (ZMod.finEquiv 5 (alpha j))
    rw [index]
    simp
  simp_rw [term]
  exact Equiv.sum_comp (Equiv.piCongrRight (fun _ : Fin r => (ZMod.finEquiv 5).toEquiv))
    (fun g => AddMonoidAlgebra.single g (1 : R))

end Litt3.Deformations
