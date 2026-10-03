import Solutions.Deformations.LinearEndomorphismRanges
import Definitions.Deformations.FiniteShiftCokernel
import Mathlib.SetTheory.Cardinal.Finite

namespace Litt3.Deformations

variable {R M N : Type*} [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]

/-- Every actual linear equivalence retains the literal scalar-power
filtration, with no chosen dimensions or invariant-factor assumptions. -/
noncomputable def linearEquivScalarQuotient (e : M ≃ₗ[R] N) (r : R) :
    (M ⧸ coefficientScalarRange (K := M) r) ≃ₗ[R]
      (N ⧸ coefficientScalarRange (K := N) r) :=
  Submodule.Quotient.equiv _ _ e
    ((linear_equiv_map_range_conjugate e (r • (LinearMap.id : Module.End R M))).trans
      (congrArg LinearMap.range (by rw [map_smul, LinearEquiv.conj_id])))

theorem linear_equiv_scalar_quotient_card (e : M ≃ₗ[R] N) (r : R) :
    Nat.card (M ⧸ coefficientScalarRange (K := M) r) =
      Nat.card (N ⧸ coefficientScalarRange (K := N) r) :=
  Nat.card_congr (linearEquivScalarQuotient e r).toEquiv

end Litt3.Deformations
