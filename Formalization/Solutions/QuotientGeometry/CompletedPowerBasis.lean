import Definitions.QuotientGeometry.LiftedCompletedEmbedding
import Solutions.QuotientGeometry.ConstantPolynomialCompletedRing

namespace Litt3.QuotientGeometry

/-- The WHOLE completed ring has an actual integral power basis over
the genuine, distinctly typed downstairs parameter ring. Its literal
uniformizer has exactly the reciprocal minimal polynomial. -/
theorem constant_polynomial_completed_power_basis
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    ∃ pb : PowerBasis (CompletedPowerSeriesBase k) (PowerSeries k),
      pb.gen = PowerSeries.X ∧
      minpoly (CompletedPowerSeriesBase k) (PowerSeries.X : PowerSeries k) =
        liftedConstantPoleReciprocal g := by
  classical
  let A := CompletedPowerSeriesBase k
  let q := liftedConstantPoleReciprocal g
  let Q := AdjoinRoot q
  let AQ : Algebra A Q := inferInstance
  letI : Algebra A Q := AQ
  letI : SMul A Q := AQ.toSMul
  letI : Module A Q := Algebra.toModule
  have hqmonic : q.Monic :=
    (constant_pole_reciprocal_monic_degree g hg hzero).1.map _
  let pb0 := AdjoinRoot.powerBasis' hqmonic
  have hminq : minpoly A (AdjoinRoot.root q) = q := by
    refine minpoly.eq_of_linearIndependent A (AdjoinRoot.root q) hqmonic ?_ q.natDegree ?_ ?_
    · rw [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self]
    · exact Polynomial.degree_eq_natDegree hqmonic.ne_zero
    · have hfun : (fun j : Fin q.natDegree => AdjoinRoot.root q ^ j.val) = ⇑pb0.basis :=
        funext fun j => (pb0.basis_eq_pow j).symm
      rw [hfun]
      exact pb0.basis.linearIndependent
  let down : A ≃+* PowerSeries k := ULift.ringEquiv
  have hpoly : q.map down.toRingHom = constantPoleReciprocal g := by
    change ((constantPoleReciprocal g).map down.symm.toRingHom).map down.toRingHom = _
    rw [Polynomial.map_map]
    have hcomp : down.toRingHom.comp down.symm.toRingHom = RingHom.id (PowerSeries k) := by
      apply RingHom.ext
      intro r
      exact down.apply_symm_apply r
    rw [hcomp, Polynomial.map_id]
  let ebase := AdjoinRoot.mapRingEquiv down q (constantPoleReciprocal g)
    (hpoly ▸ Associated.refl _)
  obtain ⟨e0, he0, hroot0⟩ := constant_polynomial_completed_ring_model g hg hzero
  let e : Q ≃+* PowerSeries k := ebase.trans e0
  have he (r : A) : e (AdjoinRoot.of q r) =
      liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg) r := by
    change e0 (ebase (AdjoinRoot.of q r)) = _
    rw [AdjoinRoot.coe_mapRingEquiv, AdjoinRoot.map_of, he0]
    change PowerSeries.subst (constantPolynomialParameter g) r.down = _
    symm
    change (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))) r.down = _
    rw [PowerSeries.coe_substAlgHom]
  have heroot : e (AdjoinRoot.root q) = PowerSeries.X := by
    change e0 (ebase (AdjoinRoot.root q)) = _
    rw [AdjoinRoot.coe_mapRingEquiv, AdjoinRoot.map_root, hroot0]
  letI : Algebra A (PowerSeries k) :=
    (liftedCompletedEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).toAlgebra
  letI : SMul A (PowerSeries k) :=
    (liftedCompletedEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
  letI : Module A (PowerSeries k) := Algebra.toModule
  let ea : Q ≃ₐ[A] PowerSeries k :=
    { __ := e
      commutes' := fun r => by
        change e (algebraMap A Q r) = _
        rw [AdjoinRoot.algebraMap_eq]
        exact he r }
  refine ⟨pb0.map ea, ?_, ?_⟩
  · exact heroot
  · rw [← heroot]
    change minpoly A (ea (AdjoinRoot.root q)) = q
    rw [minpoly.algEquiv_eq]
    exact hminq

end Litt3.QuotientGeometry
