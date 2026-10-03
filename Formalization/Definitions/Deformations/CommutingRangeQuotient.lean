import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- The literal endomorphism induced on the actual cokernel by an
actual commuting endomorphism. -/
def commutingRangeQuotientEnd (A T : Module.End R M) (commute : Commute A T) :
    Module.End R (M ⧸ LinearMap.range A) :=
  (LinearMap.range A).mapQ (LinearMap.range A) T (by
    rintro v ⟨w, rfl⟩
    exact ⟨T w, LinearMap.congr_fun commute.eq w⟩)

end Litt3.Deformations
