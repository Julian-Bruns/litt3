import Definitions.Deformations.DiagonalScalarQuotient
import Solutions.Deformations.ScalarPowerQuotients
import Mathlib.SetTheory.Cardinal.Finite

namespace Litt3.Deformations

variable {R I : Type*} {M : I → Type*} [CommRing R]
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]

theorem diagonal_coefficient_quotient_kernel (r : I → R) :
    LinearMap.ker (diagonalCoefficientQuotientMap (M := M) r) =
      LinearMap.range (diagonalScalarOperator (M := M) r) := by
  classical
  ext v
  constructor
  · intro zero
    have representatives : ∀ i, ∃ w : M i, r i • w = v i := by
      intro i
      have coordinate : (coefficientScalarRange (K := M i) (r i)).mkQ (v i) = 0 := congrFun zero i
      exact (Submodule.Quotient.mk_eq_zero _).mp coordinate
    choose w same using representatives
    exact ⟨w, funext same⟩
  · rintro ⟨w, rfl⟩
    funext i
    exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨w i, rfl⟩

theorem diagonal_coefficient_quotient_surjective (r : I → R) :
    Function.Surjective (diagonalCoefficientQuotientMap (M := M) r) := by
  intro v
  have representatives : ∀ i, ∃ w : M i, (coefficientScalarRange (K := M i) (r i)).mkQ w = v i :=
    fun i => (coefficientScalarRange (K := M i) (r i)).mkQ_surjective (v i)
  choose w same using representatives
  exact ⟨w, funext same⟩

/-- The full actual diagonal cokernel is the full product of the
actual coefficient scalar quotients, with no rank or field hypothesis. -/
noncomputable def diagonalScalarCokernelEquiv (r : I → R) :
    ((∀ i, M i) ⧸ LinearMap.range (diagonalScalarOperator (M := M) r)) ≃ₗ[R]
      (∀ i, M i ⧸ coefficientScalarRange (K := M i) (r i)) :=
  (Submodule.quotEquivOfEq _ _ (diagonal_coefficient_quotient_kernel (M := M) r).symm).trans
    ((diagonalCoefficientQuotientMap (M := M) r).quotKerEquivOfSurjective
      (diagonal_coefficient_quotient_surjective r))

theorem diagonal_scalar_constant (r : R) :
    diagonalScalarOperator (M := M) (fun _ : I => r) =
      r • (LinearMap.id : Module.End R (∀ i, M i)) := by
  apply LinearMap.ext
  intro v
  rfl

/-- The actual scalar quotient of the entire product is the entire
product of scalar quotients, including arbitrary dependent coefficients. -/
noncomputable def coefficientScalarProductQuotientEquiv (r : R) :
    ((∀ i, M i) ⧸ coefficientScalarRange (K := ∀ i, M i) r) ≃ₗ[R]
      (∀ i, M i ⧸ coefficientScalarRange (K := M i) r) :=
  (Submodule.quotEquivOfEq _ _ (congrArg LinearMap.range (diagonal_scalar_constant (M := M) r)).symm).trans
    (diagonalScalarCokernelEquiv (M := M) (fun _ : I => r))

theorem zmod_diagonal_power_cokernel_card (p N n : ℕ) (positive : 0 < p)
    (e : Fin n → ℕ) (bound : ∀ i, e i ≤ N) :
    Nat.card ((Fin n → ZMod (p ^ N)) ⧸ LinearMap.range
      (diagonalScalarOperator (M := fun _ : Fin n => ZMod (p ^ N))
        (fun i => (p : ZMod (p ^ N)) ^ e i))) = p ^ (∑ i : Fin n, e i) := by
  rw [Nat.card_congr (diagonalScalarCokernelEquiv
    (M := fun _ : Fin n => ZMod (p ^ N)) (fun i => (p : ZMod (p ^ N)) ^ e i)).toEquiv,
    Nat.card_pi]
  simp_rw [zmod_power_quotient_card p N _ positive (bound _)]
  exact Finset.prod_pow_eq_pow_sum _ _ _

end Litt3.Deformations
