import Definitions.Deformations.FiniteShiftCokernel
import Mathlib.SetTheory.Cardinal.Finite
import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations

variable {R M N : Type*} [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]

def scalarPairQuotientMap (r : R) :
    (M × N) →ₗ[R] ((M ⧸ coefficientScalarRange (K := M) r) ×
      (N ⧸ coefficientScalarRange (K := N) r)) :=
  LinearMap.prodMap (coefficientScalarRange (K := M) r).mkQ (coefficientScalarRange (K := N) r).mkQ

theorem scalar_pair_quotient_kernel (r : R) :
    LinearMap.ker (scalarPairQuotientMap (M := M) (N := N) r) =
      coefficientScalarRange (K := M × N) r := by
  ext v
  constructor
  · intro zero
    have first : (coefficientScalarRange (K := M) r).mkQ v.1 = 0 := congrArg Prod.fst zero
    have second : (coefficientScalarRange (K := N) r).mkQ v.2 = 0 := congrArg Prod.snd zero
    obtain ⟨x, sameX⟩ := (Submodule.Quotient.mk_eq_zero _).mp first
    obtain ⟨y, sameY⟩ := (Submodule.Quotient.mk_eq_zero _).mp second
    exact ⟨(x, y), Prod.ext sameX sameY⟩
  · rintro ⟨v, rfl⟩
    apply Prod.ext
    · exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨v.1, rfl⟩
    · exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨v.2, rfl⟩

theorem scalar_pair_quotient_surjective (r : R) :
    Function.Surjective (scalarPairQuotientMap (M := M) (N := N) r) := by
  rintro ⟨first, second⟩
  obtain ⟨x, sameX⟩ := (coefficientScalarRange (K := M) r).mkQ_surjective first
  obtain ⟨y, sameY⟩ := (coefficientScalarRange (K := N) r).mkQ_surjective second
  exact ⟨(x, y), Prod.ext sameX sameY⟩

/-- The literal scalar quotient retains both original product factors. -/
noncomputable def scalarPairQuotientEquiv (r : R) :
    ((M × N) ⧸ coefficientScalarRange (K := M × N) r) ≃ₗ[R]
      ((M ⧸ coefficientScalarRange (K := M) r) × (N ⧸ coefficientScalarRange (K := N) r)) :=
  (Submodule.quotEquivOfEq _ _ (scalar_pair_quotient_kernel (M := M) (N := N) r).symm).trans
    ((scalarPairQuotientMap (M := M) (N := N) r).quotKerEquivOfSurjective
      (scalar_pair_quotient_surjective r))

end Litt3.Deformations
