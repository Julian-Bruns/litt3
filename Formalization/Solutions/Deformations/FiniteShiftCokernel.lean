import Definitions.Deformations.FiniteShiftCokernel
import Solutions.Deformations.PreparedFiniteShift

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem finite_coefficient_shift_zero (n : ℕ) (v : Fin (n + 1) → K) :
    finiteCoefficientShift (R := R) (n + 1) v 0 = 0 := by
  simp [finiteCoefficientShift, coefficientSeriesPrefix, coefficientSeriesShift]

@[simp] theorem finite_coefficient_shift_succ (n : ℕ) (v : Fin (n + 1) → K)
    (i : Fin n) :
    finiteCoefficientShift (R := R) (n + 1) v i.succ = v i.castSucc := by
  simp [finiteCoefficientShift, coefficientSeriesPrefix, coefficientSeriesShift,
    coefficientSeriesPrefixSection, Nat.lt_succ_of_lt i.2]
  rfl

theorem finite_shift_cokernel_kernel (n : ℕ) (scalar : R) :
    LinearMap.ker (finiteShiftCokernelMap (K := K) n scalar) =
      LinearMap.range (scalar • finiteCoefficientShift (R := R) (K := K) (n + 1)) := by
  classical
  ext v
  constructor
  · intro zero
    have head : v 0 = 0 := congrArg Prod.fst zero
    have entries : ∀ i : Fin n, v i.succ ∈ coefficientScalarRange scalar := by
      intro i
      apply (Submodule.Quotient.mk_eq_zero _).mp
      exact congrArg (fun w => w.2 i) zero
    choose w preimage using entries
    refine ⟨Fin.snoc w 0, ?_⟩
    funext i
    refine Fin.cases ?_ (fun j => ?_) i
    · simp [head]
    · simpa only [LinearMap.smul_apply, Pi.smul_apply, finite_coefficient_shift_succ,
        Fin.snoc_castSucc, coefficientScalarRange, LinearMap.id_apply] using preimage j
  · rintro ⟨v, rfl⟩
    apply Prod.ext
    · simp [finiteShiftCokernelMap]
    · funext i
      apply (Submodule.Quotient.mk_eq_zero _).mpr
      exact ⟨v i.castSucc, by simp⟩

theorem finite_shift_cokernel_map_surjective (n : ℕ) (scalar : R) :
    Function.Surjective (finiteShiftCokernelMap (K := K) n scalar) := by
  classical
  rintro ⟨head, tail⟩
  choose w preimage using fun i => (coefficientScalarRange scalar).mkQ_surjective (tail i)
  refine ⟨Fin.cons head w, ?_⟩
  apply Prod.ext
  · simp [finiteShiftCokernelMap]
  · funext i
    simpa only [finiteShiftCokernelMap, Fin.cons_succ] using preimage i

/-- The full actual cokernel of scalar times the truncated shift has
one unquotiented constant coordinate and every positive coordinate
quotiented by the literal scalar image, at arbitrary coefficient rank. -/
noncomputable def finiteShiftCokernelEquiv (n : ℕ) (scalar : R) :
    ((Fin (n + 1) → K) ⧸ LinearMap.range
      (scalar • finiteCoefficientShift (R := R) (K := K) (n + 1))) ≃ₗ[R]
      K × (Fin n → K ⧸ coefficientScalarRange scalar) :=
  (Submodule.quotEquivOfEq _ _ (finite_shift_cokernel_kernel n scalar).symm).trans
    ((finiteShiftCokernelMap n scalar).quotKerEquivOfSurjective
      (finite_shift_cokernel_map_surjective n scalar))

@[simp] theorem finite_shift_cokernel_equiv_mk (n : ℕ) (scalar : R)
    (v : Fin (n + 1) → K) :
    finiteShiftCokernelEquiv (K := K) n scalar
        ((LinearMap.range (scalar • finiteCoefficientShift (R := R) (K := K) (n + 1))).mkQ v) =
      (v 0, fun i : Fin n => (coefficientScalarRange scalar).mkQ (v i.succ)) := by
  rfl

end Litt3.Deformations
