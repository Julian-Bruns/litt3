import Solutions.SharedTensors.SchemeDivisorGluing
import Solutions.SharedTensors.PrincipalClassGluing
import Solutions.SharedTensors.ProductPrincipalQuotients
import Solutions.SharedTensors.SchemeClumpGluing
import Solutions.QuotientGeometry.FunctionFieldRecovery

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry
universe u

variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  [FinitePrincipalSupport X] [FinitePrincipalSupport Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  [ClosedPointDVRStalks s.source] [FinitePrincipalSupport s.source]

noncomputable def FiniteEtaleSpan.endpointDivisorClassEquiv :
    s.divisorGluingSquare.EndpointDivisorClasses ≃+
      DivisorClassGroup (schemeDivisorSystem X) × DivisorClassGroup (schemeDivisorSystem Y) :=
  productPrincipalQuotientsEquiv (principalDivisorMap (schemeDivisorSystem X))
    (principalDivisorMap (schemeDivisorSystem Y))

/-- The actual two-leg map on the actual integral divisor-class groups. -/
noncomputable def FiniteEtaleSpan.jointDivisorClassMap :
    DivisorClassGroup (schemeDivisorSystem X) × DivisorClassGroup (schemeDivisorSystem Y) →+
      DivisorClassGroup (schemeDivisorSystem s.source) :=
  s.divisorGluingSquare.endpointDivisorClassMap.comp s.endpointDivisorClassEquiv.symm.toAddMonoidHom

theorem actual_joint_divisor_class_map_representative
    (A : Divisor (ClosedPoint X)) (B : Divisor (ClosedPoint Y)) :
    s.jointDivisorClassMap (divisorClassMap (schemeDivisorSystem X) A,
      divisorClassMap (schemeDivisorSystem Y) B) =
      divisorClassMap (schemeDivisorSystem s.source)
        (schemeDivisorPullback s.left A - schemeDivisorPullback s.right B) := by
  have heq := productPrincipalQuotientsEquiv_mk
    (principalDivisorMap (schemeDivisorSystem X)) (principalDivisorMap (schemeDivisorSystem Y)) A B
  change s.endpointDivisorClassEquiv
    (QuotientAddGroup.mk' s.divisorGluingSquare.endpointPrincipal.range (A, B)) =
      (divisorClassMap (schemeDivisorSystem X) A, divisorClassMap (schemeDivisorSystem Y) B) at heq
  change s.divisorGluingSquare.endpointDivisorClassMap
    (s.endpointDivisorClassEquiv.symm _) = _
  rw [← heq]
  rw [s.endpointDivisorClassEquiv.symm_apply_apply]
  rfl

/-- The accepted global-function input is stated literally in the actual
source function field: every zero-principal-divisor unit is a constant.
Its proof from smooth proper connected curve hypotheses remains separate. -/
def FiniteEtaleSpan.principalKernelConstants
    {K : Type u} [Field K] (sZ : s.source ⟶ Spec (.of K)) : Prop :=
  ∀ u : Additive s.source.functionFieldˣ,
    principalDivisorMap (schemeDivisorSystem s.source) u = 0 →
      ∃ a : Additive Kˣ, rationalUnitPullback (genericBaseFieldHom sZ) a = u

theorem actual_source_constants_absorb_principal_units
    {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sZ : s.source ⟶ Spec (.of K))
    (hbase : s.left ≫ sX = sZ) (hconstants : s.principalKernelConstants sZ) :
    s.divisorGluingSquare.AbsorbsPrincipalUnits := by
  intro u hu
  obtain ⟨a, ha⟩ := hconstants u hu
  have hφ : (schemeFunctionFieldPullback s.left).comp (genericBaseFieldHom sX) =
      genericBaseFieldHom sZ :=
    (generic_field_map_over_iff_constants sZ sX _).mp
      (actual_scheme_function_field_map_over_base sZ sX s.left hbase)
  refine ⟨(rationalUnitPullback (genericBaseFieldHom sX) a, 0), ?_, ?_⟩
  · apply Prod.ext
    · exact scheme_constant_principal_divisor_zero sX a
    · change principalDivisorMap (schemeDivisorSystem Y) 0 = 0
      exact map_zero _
  · change rationalUnitPullback (schemeFunctionFieldPullback s.left)
      (rationalUnitPullback (genericBaseFieldHom sX) a) - rationalUnitPullback
      (schemeFunctionFieldPullback s.right) 0 = u
    rw [map_zero, sub_zero]
    apply Additive.toMul.injective
    apply Units.ext
    exact (DFunLike.congr_fun hφ a.toMul.val).trans
      (congrArg (fun u : Additive s.source.functionFieldˣ => u.toMul.val) ha)

noncomputable def FiniteEtaleSpan.endpointDivisorClassKernelEquiv :
    s.divisorGluingSquare.endpointDivisorClassMap.ker ≃+ s.jointDivisorClassMap.ker where
  toFun a := ⟨s.endpointDivisorClassEquiv a.val, by
    change s.divisorGluingSquare.endpointDivisorClassMap
      (s.endpointDivisorClassEquiv.symm (s.endpointDivisorClassEquiv a.val)) = 0
    rw [s.endpointDivisorClassEquiv.symm_apply_apply]
    exact a.property⟩
  invFun b := ⟨s.endpointDivisorClassEquiv.symm b.val, b.property⟩
  left_inv a := Subtype.ext (s.endpointDivisorClassEquiv.symm_apply_apply a.val)
  right_inv b := Subtype.ext (s.endpointDivisorClassEquiv.apply_symm_apply b.val)
  map_add' a b := Subtype.ext (s.endpointDivisorClassEquiv.map_add a.val b.val)

/-- Constants absorb the actual source-unit ambiguity, identifying all
actual gluing classes with the actual joint divisor-class kernel. The
line-bundle interpretation is a separate geometric theorem. -/
noncomputable def actual_same_source_gluing_equiv_joint_divisor_class_kernel
    {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sZ : s.source ⟶ Spec (.of K))
    (hbase : s.left ≫ sX = sZ) (hconstants : s.principalKernelConstants sZ) :
    s.divisorGluingSquare.GluingClasses ≃+ s.jointDivisorClassMap.ker :=
  (s.divisorGluingSquare.gluingDivisorClassKernelEquiv
    (actual_source_constants_absorb_principal_units s sX sZ hbase hconstants)).trans
      s.endpointDivisorClassKernelEquiv

noncomputable def actual_same_source_no_clump_relations_equiv_joint_divisor_class_kernel
    [JacobsonSpace s.source] (hc : IsEmpty s.fiberClump)
    {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (sZ : s.source ⟶ Spec (.of K))
    (hbase : s.left ≫ sX = sZ) (hconstants : s.principalKernelConstants sZ) :
    s.quotientPrincipalDivisorMap.ker ≃+ s.jointDivisorClassMap.ker :=
  (actual_same_source_no_clump_gluing_equiv_relations s hc).symm.trans
    (actual_same_source_gluing_equiv_joint_divisor_class_kernel s sX sZ hbase hconstants)

end Litt3.SharedTensors
