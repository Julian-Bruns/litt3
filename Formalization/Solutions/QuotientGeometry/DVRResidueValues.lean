import Solutions.QuotientGeometry.DVRFunctionFieldCompletion

namespace Litt3.QuotientGeometry

open IsLocalRing

variable {k R : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]

/-- The actual coefficient field is the actual residue field, through
its given algebra map. -/
noncomputable def dvrCoefficientResidueEquiv
    (d : DVRCompletionParameters k R) : k ≃+* ResidueField R :=
  RingEquiv.ofBijective (algebraMap k (ResidueField R))
    ⟨(algebraMap k (ResidueField R)).injective, d.residue_surjective⟩

/-- Evaluation of an original regular function in its original residue
field, then in the actual coefficient field. -/
noncomputable def dvrResidueValue
    (d : DVRCompletionParameters k R) : R →+* k :=
  (dvrCoefficientResidueEquiv d).symm.toRingHom.comp (residue R)

theorem dvrResidueValue_residue
    (d : DVRCompletionParameters k R) (r : R) :
    algebraMap k (ResidueField R) (dvrResidueValue d r) = residue R r :=
  (dvrCoefficientResidueEquiv d).apply_symm_apply (residue R r)

/-- The constant coefficient of the constructed whole expansion is
the actual residue value of the original regular function. -/
theorem completedDVRStalkEmbedding_constant_residue
    (d : DVRCompletionParameters k R) (r : R) :
    PowerSeries.constantCoeff (completedDVRStalkEmbedding d r) = dvrResidueValue d r := by
  apply (algebraMap k (ResidueField R)).injective
  rw [dvrResidueValue_residue]
  have he := dvrPowerSeriesChart_residue d.parameter d.irreducible d.residue_surjective
    (completedDVRStalkEmbedding d r)
  change AdicCompletion.evalOneₐ (maximalIdeal R)
      (d.chart (d.chart.symm (AdicCompletion.of _ R r))) = _ at he
  rw [d.chart.apply_symm_apply, AdicCompletion.evalOneₐ_of] at he
  exact he.symm

theorem dvrResidueValue_unit_nonzero
    (d : DVRCompletionParameters k R) (r : R) (hu : IsUnit r) : dvrResidueValue d r ≠ 0 :=
  (hu.map (dvrResidueValue d)).ne_zero

end Litt3.QuotientGeometry
