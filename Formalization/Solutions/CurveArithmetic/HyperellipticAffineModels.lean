import Definitions.CurveArithmetic.HyperellipticAffineModels
import Theorems.CurveArithmetic.HyperellipticAffineModels
import Solutions.CurveArithmetic.FiniteAffineInvariant
import Solutions.CurveArithmetic.AffineParameters
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem affine_plane_hom_X
    {L : Type*} [CommRing L] (u : Lˣ) (v : L) (i : Fin 2) :
    affinePlaneHom u v (MvPolynomial.X i) =
      (![MvPolynomial.C u.val * MvPolynomial.X 0 + MvPolynomial.C v,
        MvPolynomial.C u.val * MvPolynomial.X 1] : Fin 2 → MvPolynomial (Fin 2) L) i :=
  MvPolynomial.aeval_X _ i

theorem affine_plane_hom_inverse_comp
    {L : Type*} [CommRing L] (u : Lˣ) (v : L) :
    (affinePlaneHom u v).comp (affinePlaneHom u⁻¹ (-(u⁻¹).val * v)) = AlgHom.id L _ := by
  apply MvPolynomial.algHom_ext
  intro i
  fin_cases i
  all_goals rw [AlgHom.comp_apply, affine_plane_hom_X, AlgHom.id_apply]
  · change affinePlaneHom u v
      (MvPolynomial.C (u⁻¹).val * MvPolynomial.X 0 +
        MvPolynomial.C (-(u⁻¹).val * v)) = MvPolynomial.X 0
    rw [map_add, map_mul]
    simp only [affinePlaneHom, MvPolynomial.aeval_C, MvPolynomial.aeval_X]
    change MvPolynomial.C (u⁻¹).val *
        (MvPolynomial.C u.val * MvPolynomial.X 0 + MvPolynomial.C v) +
        MvPolynomial.C (-(u⁻¹).val * v) = MvPolynomial.X 0
    rw [mul_add, ← mul_assoc, ← MvPolynomial.C_mul, u.inv_mul,
      MvPolynomial.C_1, one_mul, ← MvPolynomial.C_mul]
    rw [add_assoc, ← MvPolynomial.C_add]
    simp
  · change affinePlaneHom u v
      (MvPolynomial.C (u⁻¹).val * MvPolynomial.X 1) = MvPolynomial.X 1
    rw [map_mul]
    simp only [affinePlaneHom, MvPolynomial.aeval_C, MvPolynomial.aeval_X]
    change MvPolynomial.C (u⁻¹).val *
      (MvPolynomial.C u.val * MvPolynomial.X 1) = MvPolynomial.X 1
    rw [← mul_assoc, ← MvPolynomial.C_mul, u.inv_mul, MvPolynomial.C_1, one_mul]

noncomputable def affinePlaneEquiv
    {L : Type*} [CommRing L] (u : Lˣ) (v : L) :
    MvPolynomial (Fin 2) L ≃ₐ[L] MvPolynomial (Fin 2) L :=
  AlgEquiv.ofAlgHom (affinePlaneHom u v)
    (affinePlaneHom u⁻¹ (-(u⁻¹).val * v))
    (affine_plane_hom_inverse_comp u v)
    (by
      have h := affine_plane_hom_inverse_comp u⁻¹ (-(u⁻¹).val * v)
      simp only [inv_inv] at h
      have hshift : -u.val * (-(u⁻¹).val * v) = v := by
        rw [← mul_assoc, neg_mul_neg, u.mul_inv, one_mul]
      rw [hshift] at h
      exact h)

theorem affine_plane_equiv_X
    {L : Type*} [CommRing L] (u : Lˣ) (v : L) (i : Fin 2) :
    affinePlaneEquiv u v (MvPolynomial.X i) =
      (![MvPolynomial.C u.val * MvPolynomial.X 0 + MvPolynomial.C v,
        MvPolynomial.C u.val * MvPolynomial.X 1] : Fin 2 → MvPolynomial (Fin 2) L) i := by
  exact MvPolynomial.aeval_X _ i

/-- The affine coefficient change carries the actual defining equation
to a unit multiple. It does not require a separability or genus input. -/
theorem finite_branch_equation_affine_change
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) :
    affinePlaneEquiv (u.map (algebraMap K L).toMonoidHom) (algebraMap K L v)
      (finiteBranchEquation K (finiteAffineTransform u v a)) =
    MvPolynomial.C (algebraMap K L u.val) ^ 2 * finiteBranchEquation K a := by
  let cu : MvPolynomial (Fin 2) L := MvPolynomial.C (algebraMap K L u.val)
  let cv : MvPolynomial (Fin 2) L := MvPolynomial.C (algebraMap K L v)
  let x : MvPolynomial (Fin 2) L := MvPolynomial.X 0
  let y : MvPolynomial (Fin 2) L := MvPolynomial.X 1
  have hdelta : (cu * x + cv) ^ Fintype.card K - (cu * x + cv) =
      cu * (x ^ Fintype.card K - x) := by
    let frob := FiniteField.frobeniusAlgHom K (MvPolynomial (Fin 2) L)
    change frob (algebraMap K _ u.val * x + algebraMap K _ v) -
      (algebraMap K _ u.val * x + algebraMap K _ v) = _
    rw [map_add, map_mul, frob.commutes, frob.commutes]
    change cu * x ^ Fintype.card K + cv - (cu * x + cv) = _
    ring
  have hshift : cu * x + cv - MvPolynomial.C (finiteAffineTransform u v a) =
      cu * (x - MvPolynomial.C a) := by
    simp only [finiteAffineTransform, map_add, map_mul, cu, cv]
    ring
  change (affinePlaneHom (u.map (algebraMap K L).toMonoidHom) (algebraMap K L v))
      (finiteBranchEquation K (finiteAffineTransform u v a)) = _
  simp only [finiteBranchEquation, map_sub, map_pow, map_mul, affinePlaneHom,
    MvPolynomial.aeval_X, MvPolynomial.aeval_C, Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.cons_val_fin_one, Units.coe_map,
    MonoidHom.coe_coe]
  change (cu * y) ^ 2 -
      ((cu * x + cv) ^ Fintype.card K - (cu * x + cv)) *
        (cu * x + cv - MvPolynomial.C (finiteAffineTransform u v a)) =
      cu ^ 2 * (y ^ 2 - (x ^ Fintype.card K - x) * (x - MvPolynomial.C a))
  rw [hdelta, hshift]
  ring

theorem finite_branch_ideal_affine_change
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) :
    (finiteBranchIdeal K (finiteAffineTransform u v a)).map
      (affinePlaneEquiv (u.map (algebraMap K L).toMonoidHom)
        (algebraMap K L v)).toRingHom = finiteBranchIdeal K a := by
  rw [finiteBranchIdeal, Ideal.map_span, Set.image_singleton]
  change Ideal.span {affinePlaneEquiv (u.map (algebraMap K L).toMonoidHom)
      (algebraMap K L v) (finiteBranchEquation K (finiteAffineTransform u v a))} =
    Ideal.span {finiteBranchEquation K a}
  rw [finite_branch_equation_affine_change]
  apply Ideal.span_singleton_mul_left_unit
  exact (((u.isUnit.map (algebraMap K L)).map MvPolynomial.C).pow 2)

/-- An actual isomorphism of the affine curve coordinate rings. No
presumed abstract isomorphism or supplied polynomial correspondence is
used: the equations and inverse affine changes are constructed. -/
noncomputable def finiteBranchAffineCoordinateEquiv
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) :
    FiniteBranchCoordinateRing K (finiteAffineTransform u v a) ≃ₐ[L]
      FiniteBranchCoordinateRing K a :=
  Ideal.quotientEquivAlg _ _
    (affinePlaneEquiv (u.map (algebraMap K L).toMonoidHom) (algebraMap K L v))
    (finite_branch_ideal_affine_change u v a).symm

theorem finite_branch_affine_coordinate_isomorphism_target :
    Targets.FiniteBranchAffineCoordinateIsomorphism := by
  intro K L _ _ _ _ u v a
  exact ⟨finiteBranchAffineCoordinateEquiv u v a⟩

theorem finite_branch_coordinate_equiv_of_invariant_eq
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a b : L) (ha : a ∉ Set.range (algebraMap K L))
    (hb : b ∉ Set.range (algebraMap K L))
    (hequal : finiteAffineInvariant K a = finiteAffineInvariant K b) :
    Nonempty (FiniteBranchCoordinateRing K b ≃ₐ[L] FiniteBranchCoordinateRing K a) := by
  obtain ⟨u, v, rfl⟩ := (finite_affine_invariant_complete a b ha hb).mp hequal
  exact ⟨finiteBranchAffineCoordinateEquiv u v a⟩

theorem quadratic_finite_branch_coordinate_equiv
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    [Algebra.IsAlgebraic K L]
    (a b : L) (ha : a ∉ Set.range (algebraMap K L))
    (hb : b ∉ Set.range (algebraMap K L))
    (hdegreeA : Module.finrank K (IntermediateField.adjoin K {a}) = 2)
    (hdegreeB : Module.finrank K (IntermediateField.adjoin K {b}) = 2) :
    Nonempty (FiniteBranchCoordinateRing K b ≃ₐ[L] FiniteBranchCoordinateRing K a) := by
  obtain ⟨u, v, rfl⟩ := quadratic_parameters_affine_equivalent a b ha hb hdegreeA hdegreeB
  exact ⟨finiteBranchAffineCoordinateEquiv u v a⟩

end Litt3.CurveArithmetic
