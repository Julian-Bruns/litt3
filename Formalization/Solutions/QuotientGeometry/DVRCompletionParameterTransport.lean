import Solutions.QuotientGeometry.LocalCoefficientResidueTransport
import Solutions.QuotientGeometry.DVRPowerSeriesChart
import Definitions.QuotientGeometry.DVRCompletionParameters

namespace Litt3.QuotientGeometry

variable {k R S : Type*} [Field k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [Algebra k S]

/-- A true coefficient-ring equivalence transports the entire actual
completion parameters. The target DVR and residue coefficients are
derived, and the transported uniformizer is exactly the original image. -/
noncomputable def actualDVRCompletionParametersTransport
    (dR : DVRCompletionParameters k R) (e : R ≃ₐ[k] S) :
    letI : IsDiscreteValuationRing S :=
      IsDiscreteValuationRing.RingEquivClass.isDiscreteValuationRing e
    DVRCompletionParameters k S := by
  letI : IsDiscreteValuationRing S :=
    IsDiscreteValuationRing.RingEquivClass.isDiscreteValuationRing e
  exact ⟨e dR.parameter, (MulEquiv.irreducible_iff e).mpr dR.irreducible,
    actual_local_algEquiv_residue_coefficients_surjective e.symm dR.residue_surjective⟩

end Litt3.QuotientGeometry
