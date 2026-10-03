import Solutions.SharedTensors.SmoothLocalCotangent
import Mathlib.RingTheory.Smooth.StandardSmoothCotangent
import Mathlib.RingTheory.Etale.Kaehler
import Mathlib.RingTheory.Localization.Submodule

namespace Litt3.SharedTensors

open IsLocalRing
open scoped TensorProduct

variable {k A R : Type*} [Field k] [CommRing A] [Nontrivial A] [Algebra k A]
  [CommRing R] [IsDomain R] [IsLocalRing R]
  [Algebra A R] [Algebra k R] [IsScalarTower k A R]

/-- Every local domain obtained by arbitrary localization of a genuine
standard smooth curve algebra at a rational residue point is a DVR.
Neither local smooth finite presentation nor a supplied DVR is assumed. -/
theorem standard_smooth_localization_rational_dvr
    [Algebra.IsStandardSmoothOfRelativeDimension 1 k A]
    (S : Submonoid A) [IsLocalization S R]
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    IsDiscreteValuationRing R := by
  letI : Algebra.IsStandardSmooth k A :=
    Algebra.IsStandardSmoothOfRelativeDimension.isStandardSmooth 1
  letI : IsNoetherianRing A := Algebra.FiniteType.isNoetherianRing k A
  letI : IsNoetherianRing R := IsLocalization.isNoetherianRing S R inferInstance
  letI : Algebra.FormallyEtale A R := Algebra.FormallyEtale.of_isLocalization S
  letI : Algebra.FormallySmooth k R := Algebra.FormallySmooth.comp k A R
  let e := KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k A R
  letI : Module.Free R (KaehlerDifferential k R) := Module.Free.of_equiv e
  have hr := e.lift_rank_eq
  rw [Module.rank_baseChange,
    Algebra.IsStandardSmoothOfRelativeDimension.rank_kaehlerDifferential 1] at hr
  apply rational_smooth_local_dvr hres
  simpa only [Cardinal.lift_natCast, Cardinal.lift_eq_nat_iff] using hr.symm

end Litt3.SharedTensors
