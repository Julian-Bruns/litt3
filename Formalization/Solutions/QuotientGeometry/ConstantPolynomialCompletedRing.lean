import Solutions.QuotientGeometry.ConstantPoleEisenstein
import Solutions.QuotientGeometry.ConstantPolynomialParameter
import Solutions.QuotientGeometry.MonicRootBaseChange

namespace Litt3.QuotientGeometry

theorem constant_pole_reciprocal_completed_root
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    (constantPoleReciprocal g).eval₂
      (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
        (constant_polynomial_parameter_zero g hg))).toRingHom PowerSeries.X = 0 := by
  have hleading : g.leadingCoeff ≠ 0 :=
    Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg)
  have hc : PowerSeries.constantCoeff (constantPolynomialUnit g) ≠ 0 := by
    rw [constant_polynomial_unit_constant]
    exact hleading
  have hcomp :
      (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
        (constant_polynomial_parameter_zero g hg))).toRingHom.comp PowerSeries.C =
        PowerSeries.C := by
    apply RingHom.ext
    intro a
    exact (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))).commutes a
  rw [constantPoleReciprocal, Polynomial.eval₂_sub, Polynomial.eval₂_X_pow,
    Polynomial.eval₂_mul, Polynomial.eval₂_C, Polynomial.eval₂_map, hcomp]
  change PowerSeries.X ^ g.natDegree -
    (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))) PowerSeries.X *
      g.reverse.eval₂ PowerSeries.C PowerSeries.X = 0
  rw [PowerSeries.coe_substAlgHom, PowerSeries.subst_X
    (PowerSeries.HasSubst.of_constantCoeff_zero' (constant_polynomial_parameter_zero g hg))]
  change PowerSeries.X ^ g.natDegree -
    (PowerSeries.X ^ g.natDegree * (constantPolynomialUnit g)⁻¹) * constantPolynomialUnit g = 0
  rw [mul_assoc, PowerSeries.inv_mul_cancel _ hc, mul_one, sub_self]

/-- The actual WHOLE completed ring is the genuine monic reciprocal
polynomial quotient, with its original parameter embedding and its
literal uniformizer. No monogenicity or generation hypothesis is supplied. -/
theorem constant_polynomial_completed_ring_model
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    ∃ e : AdjoinRoot (constantPoleReciprocal g) ≃+* PowerSeries k,
      (∀ r : PowerSeries k, e (AdjoinRoot.of (constantPoleReciprocal g) r) =
        PowerSeries.subst (constantPolynomialParameter g) r) ∧
      e (AdjoinRoot.root (constantPoleReciprocal g)) = PowerSeries.X := by
  classical
  let q := constantPoleReciprocal g
  let b := constantPolynomialParameter g
  let φ : PowerSeries k →+* PowerSeries k := (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
    (constant_polynomial_parameter_zero g hg))).toRingHom
  let i := HahnSeries.ofPowerSeries ℤ k
  let Φ := parameterLaurentMap b (constant_polynomial_parameter_zero g hg)
    (constant_polynomial_parameter_injective g hg)
  have hroot : q.eval₂ φ PowerSeries.X = 0 := constant_pole_reciprocal_completed_root g hg
  let f := AdjoinRoot.lift φ PowerSeries.X hroot
  have hφ (r : PowerSeries k) : φ r = PowerSeries.subst b r := by
    change (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))) r = _
    rw [PowerSeries.coe_substAlgHom]
  have hcomp : Φ.comp i = i.comp φ := by
    apply RingHom.ext
    intro r
    change Φ (i r) = i (φ r)
    rw [hφ]
    exact parameter_laurent_map_power_series b (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg) r
  have hrootL : (q.map i).eval₂ Φ (i PowerSeries.X) = 0 := by
    rw [Polynomial.eval₂_map, hcomp, ← Polynomial.hom_eval₂, hroot, map_zero]
  have hirred := constant_pole_reciprocal_fraction_irreducible g hg hzero
  haveI : Fact (Irreducible (q.map i)) := ⟨hirred⟩
  let E := AdjoinRoot (q.map i)
  letI : Field E := inferInstance
  let j := AdjoinRoot.map i q (q.map i) dvd_rfl
  let F : E →+* LaurentSeries k := AdjoinRoot.lift Φ (i PowerSeries.X) hrootL
  have hjinj : Function.Injective j :=
    monic_adjoin_root_map_injective i HahnSeries.ofPowerSeries_injective q
      (constant_pole_reciprocal_monic_degree g hg hzero).1
  have hcompare : F.comp j = i.comp f := by
    apply AdjoinRoot.ringHom_ext
    · apply RingHom.ext
      intro r
      change F (j (AdjoinRoot.of q r)) = i (f (AdjoinRoot.of q r))
      rw [AdjoinRoot.map_of, AdjoinRoot.lift_of, AdjoinRoot.lift_of]
      exact congr_fun (congrArg DFunLike.coe hcomp) r
    · change F (j (AdjoinRoot.root q)) = i (f (AdjoinRoot.root q))
      rw [AdjoinRoot.map_root, AdjoinRoot.lift_root, AdjoinRoot.lift_root]
  have hfinj : Function.Injective f := by
    intro x y hxy
    apply hjinj
    apply F.injective
    have h := congrArg i hxy
    simpa only [← RingHom.comp_apply, ← hcompare] using h
  have hfsurj : Function.Surjective f := by
    intro r
    let a := finiteParameterComponents g.natDegree b (constantPolynomialUnit g)⁻¹ r
    refine ⟨∑ j : Fin g.natDegree,
      AdjoinRoot.root q ^ j.val * AdjoinRoot.of q (a j), ?_⟩
    rw [map_sum]
    simp only [map_mul, map_pow]
    simp only [f, AdjoinRoot.lift_root, AdjoinRoot.lift_of, hφ]
    change (∑ j : Fin g.natDegree, PowerSeries.X ^ j.val * PowerSeries.subst b (a j)) = r
    apply (finite_parameter_power_series_decomposition g.natDegree hg b
      (constantPolynomialUnit g)⁻¹ r rfl ?_).symm
    rw [PowerSeries.constantCoeff_inv, constant_polynomial_unit_constant]
    exact inv_ne_zero (Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg))
  refine ⟨RingEquiv.ofBijective f ⟨hfinj, hfsurj⟩, ?_, ?_⟩
  · intro r
    change f (AdjoinRoot.of q r) = PowerSeries.subst b r
    rw [AdjoinRoot.lift_of, hφ]
  · exact AdjoinRoot.lift_root hroot

end Litt3.QuotientGeometry
