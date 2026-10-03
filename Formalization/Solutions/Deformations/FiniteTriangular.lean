import Theorems.Deformations.FiniteTriangular

namespace Litt3.Deformations

variable {K O : ℕ → Type*} [∀ n, AddCommGroup (O n)]

/-- The exact recursive coordinate formula retains arbitrary tails. -/
theorem finiteTriangularEquiv_snoc (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) (n : ℕ)
    (x : BlockPrefix K (n + 1)) :
    finiteTriangularEquiv diagonal tail (n + 1) x =
      Fin.snoc (α := fun i : Fin (n + 1) => O i.val)
        (finiteTriangularEquiv diagonal tail n (Fin.init x))
        (diagonal n (x (Fin.last n)) + tail n (Fin.init x)) := rfl

theorem finiteTriangularEquiv_last (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) (n : ℕ)
    (x : BlockPrefix K (n + 1)) :
    finiteTriangularEquiv diagonal tail (n + 1) x (Fin.last n) =
      diagonal n (x (Fin.last n)) + tail n (Fin.init x) := by
  rw [finiteTriangularEquiv_snoc, Fin.snoc_last]

theorem finiteTriangularEquiv_initial (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) (n : ℕ)
    (x : BlockPrefix K (n + 1)) (i : Fin n) :
    finiteTriangularEquiv diagonal tail (n + 1) x i.castSucc =
      finiteTriangularEquiv diagonal tail n (Fin.init x) i := by
  rw [finiteTriangularEquiv_snoc, Fin.snoc_castSucc]

/-- Every finite size is solved symbolically, without a dimension
bound, coefficient enumeration, or additive-tail assumption. -/
theorem finite_triangular_bijective (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) :
    FiniteTriangularBijective diagonal tail :=
  fun n => (finiteTriangularEquiv diagonal tail n).bijective

section Pointed

variable [∀ n, Zero (K n)]

/-- Pointed diagonal maps and pointed tails force every solved
coordinate of the zero target to be zero. -/
theorem finiteTriangularEquiv_zero (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n)
    (diagonal_zero : ∀ n, diagonal n 0 = 0)
    (tail_zero : ∀ n, tail n 0 = 0) (n : ℕ) :
    finiteTriangularEquiv diagonal tail n 0 = 0 := by
  induction n with
  | zero => exact funext (fun i => i.elim0)
  | succ n ih =>
    rw [finiteTriangularEquiv_snoc]
    have hinit : Fin.init (0 : BlockPrefix K (n + 1)) = 0 := rfl
    rw [hinit, ih]
    simp only [Pi.zero_apply, diagonal_zero, tail_zero, zero_add]
    funext i
    refine Fin.lastCases ?_ ?_ i
    · exact Fin.snoc_last _ _
    · intro j
      exact Fin.snoc_castSucc _ _ _

/-- The entire zero fiber is the free absent variable, with no
condition on that variable or on nonlinear tails beyond pointedness. -/
theorem finite_triangular_zero_fiber {Z : Type*}
    (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n)
    (diagonal_zero : ∀ n, diagonal n 0 = 0)
    (tail_zero : ∀ n, tail n 0 = 0) (n : ℕ)
    (x : BlockPrefix K n × Z) :
    finiteTriangularEquiv diagonal tail n x.1 = 0 ↔ x.1 = 0 := by
  have hz := finiteTriangularEquiv_zero diagonal tail diagonal_zero tail_zero n
  constructor
  · intro h
    exact (finiteTriangularEquiv diagonal tail n).injective (h.trans hz.symm)
  · intro h
    rw [h, hz]

end Pointed

end Litt3.Deformations
