import Mathlib.RingTheory.Smooth.Basic
import Mathlib.RingTheory.Etale.Basic
import Mathlib.RingTheory.DiscreteValuationRing.TFAE
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace Litt3.SharedTensors

open IsLocalRing
open scoped TensorProduct

variable {k R : Type*} [Field k] [CommRing R] [IsLocalRing R]
  [Algebra k R] [Algebra.FormallySmooth k R]

/-- At a rational residue point of any formally smooth algebra, the actual
local cotangent space is the residue fiber of the actual universal differential
module. The isomorphism follows from the checked conormal exact sequence. -/
theorem rational_smooth_local_cotangent_equiv
    (hres : Function.Surjective (algebraMap k (ResidueField R))) :
    Nonempty (CotangentSpace R ≃ₗ[ResidueField R]
      ResidueField R ⊗[R] KaehlerDifferential k R) := by
  let e : k ≃ₐ[k] ResidueField R := AlgEquiv.ofBijective (Algebra.ofId k (ResidueField R))
    ⟨(algebraMap k (ResidueField R)).injective, hres⟩
  letI : Algebra.FormallySmooth k (ResidueField R) := Algebra.FormallySmooth.of_equiv e
  letI : Algebra.FormallyUnramified k (ResidueField R) := Algebra.FormallyUnramified.of_equiv e
  have hs : Function.Surjective (algebraMap R (ResidueField R)) := residue_surjective
  let f := KaehlerDifferential.kerCotangentToTensor k R (ResidueField R)
  have hinj : Function.Injective f :=
    (Algebra.FormallySmooth.kerCotangentToTensor_injective_iff hs).mpr inferInstance
  have hsurj : Function.Surjective f := by
    rw [← LinearMap.range_eq_top,
      KaehlerDifferential.range_kerCotangentToTensor k R (ResidueField R) hs]
    apply eq_top_iff.mpr
    intro x _
    exact Subsingleton.elim _ _
  have hker : RingHom.ker (algebraMap R (ResidueField R)) = maximalIdeal R := ker_residue
  have eR : CotangentSpace R ≃ₗ[R] ResidueField R ⊗[R] KaehlerDifferential k R := by
    change (maximalIdeal R).Cotangent ≃ₗ[R] _
    exact hker ▸ LinearEquiv.ofBijective f ⟨hinj, hsurj⟩
  exact ⟨eR.extendScalarsOfSurjective hs⟩

/-- A free rank-one actual differential module at a rational smooth
Noetherian local domain constructs a genuine DVR, in every characteristic. -/
theorem rational_smooth_local_dvr
    [IsDomain R] [IsNoetherianRing R]
    [Module.Free R (KaehlerDifferential k R)]
    (hres : Function.Surjective (algebraMap k (ResidueField R)))
    (hrank : Module.rank R (KaehlerDifferential k R) = 1) :
    IsDiscreteValuationRing R := by
  obtain ⟨e⟩ := rational_smooth_local_cotangent_equiv hres
  apply IsLocalRing.finrank_CotangentSpace_eq_one_iff.mp
  rw [e.finrank_eq, Module.finrank_baseChange]
  exact Module.finrank_eq_of_rank_eq hrank

end Litt3.SharedTensors
