import Solutions.QuotientGeometry.RationalCoordinateDerivationUniqueness

namespace Litt3.QuotientGeometry

/-- The rational PRODUCT residue ratio is nonzero because its original
representative W and the original denominator G are actual local units. -/
theorem rational_product_residue_power_ratio_nonzero
    {k R : Type*} [Field k] [CommRing R] [IsDomain R]
    [Algebra k R] [IsDiscreteValuationRing R]
    (d : DVRCompletionParameters k R) (p : ℕ) (W : Rˣ)
    (G : R) (hG : IsUnit G) :
    (dvrResidueValue d W.val) ^ p / (dvrResidueValue d G) ^ 2 ≠ 0 := by
  exact div_ne_zero
    (pow_ne_zero p (dvrResidueValue_unit_nonzero d W.val W.isUnit))
    (pow_ne_zero 2 (dvrResidueValue_unit_nonzero d G hG))

/-- ONE nonzero constant works on the ENTIRE nonempty original fiber
as soon as the proved two-point comparison applies to every pair. There
is no cardinality restriction or finite enumeration. -/
theorem rational_product_fiber_single_nonzero_constant
    {ι k : Type*} [Nonempty ι] [Field k] (p : ℕ)
    (w g : ι → k) (hw : ∀ i, w i ≠ 0) (hg : ∀ i, g i ≠ 0)
    (hequal : ∀ i j, (w i) ^ p / (g i) ^ 2 = (w j) ^ p / (g j) ^ 2) :
    ∃ C : k, C ≠ 0 ∧ ∀ i, (w i) ^ p / (g i) ^ 2 = C := by
  exact nonzero_fiber_values_constant (fun i => (w i) ^ p / (g i) ^ 2)
    (fun i => div_ne_zero (pow_ne_zero p (hw i)) (pow_ne_zero 2 (hg i))) hequal

end Litt3.QuotientGeometry
