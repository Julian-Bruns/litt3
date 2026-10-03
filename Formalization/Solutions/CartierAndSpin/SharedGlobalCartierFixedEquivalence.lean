import Solutions.CartierAndSpin.SharedGlobalCartierFixedRealization

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- If actual shared rational regularity is proved, genuine shared
H0 Cartier-fixed forms are canonically PRIME-LINEAR equivalent to the
original rational fixed intersection. True generic injection and actual
sheaf gluing establish bijectivity, without assumed H0 identification. -/
noncomputable def actualSharedH0FixedRationalEquivOfRegular :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
      have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
      exact h
    sharedRationalDifferentialSubspace k X.functionField Y.functionField
        s.source.functionField ≤ schemeGlobalRegularDifferentials (s.left ≫ sX) →
      actualSharedGlobalCartierFixed (p := p) s sX sY hbase ≃ₗ[ZMod p]
        sharedIntrinsicCartierFixedForms k X.functionField Y.functionField
          s.source.functionField (actualSmoothCurveRationalCartier (p := p) (s.left ≫ sX)) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  intro hregular
  apply LinearEquiv.ofBijective (actualSharedH0FixedRationalMap (p := p) s sX sY hbase)
  constructor
  · intro a b h
    apply Subtype.ext
    apply sharedGlobalDifferentialRationalRealization_injective s sX sY hbase
    apply Subtype.ext
    have hval := congrArg Subtype.val h
    exact hval
  · intro omega
    let theta : sharedRationalDifferentialSubspace k X.functionField Y.functionField
      s.source.functionField := ⟨omega.val, omega.property.1⟩
    obtain ⟨a, ha⟩ := sharedGlobalDifferentialRationalRealization_surjective_of_regular
      s sX sY hbase hregular theta
    have haval := congrArg Subtype.val ha
    have hfixed : actualSharedGlobalCartier (p := p) s sX sY hbase a = a := by
      apply sharedGlobalDifferentialRationalRealization_injective s sX sY hbase
      apply Subtype.ext
      rw [actual_shared_H0_cartier_rational_realization, haval]
      exact (mem_intrinsicCartierFixedSubgroup _ _).mp omega.property.2
    exact ⟨⟨a, sub_eq_zero.mpr hfixed⟩, Subtype.ext haval⟩

end Litt3.CartierAndSpin
