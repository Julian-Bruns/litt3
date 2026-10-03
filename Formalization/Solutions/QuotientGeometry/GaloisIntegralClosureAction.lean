import Solutions.QuotientGeometry.GaloisFiberBaseMaps
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

namespace Litt3.QuotientGeometry

variable (A K L : Type*) [CommRing A] [IsDomain A] [Field K] [Field L]
  [Algebra A K] [Algebra K L] [Algebra A L] [IsScalarTower A K L]
  [IsFractionRing A K]

/-- Every actual Galois field automorphism preserves the actual integral
closure, and restriction respects the true automorphism group law. -/
noncomputable def galoisIntegralClosureAutHom :
    (L ≃ₐ[K] L) →* (integralClosure A L ≃+* integralClosure A L) where
  toFun σ := (σ.restrictScalars A).mapIntegralClosure.toRingEquiv
  map_one' := by
    ext x
    rfl
  map_mul' σ τ := by
    ext x
    rfl

/-- The action on the actual integral closure is constructed from
restriction of the actual full field Galois group. -/
noncomputable def galoisIntegralClosureAction :
    MulSemiringAction (L ≃ₐ[K] L) (integralClosure A L) :=
  MulSemiringAction.compHom _ (galoisIntegralClosureAutHom A K L)

theorem galoisIntegralClosureAction_apply (σ : L ≃ₐ[K] L) (x : integralClosure A L) :
    letI := galoisIntegralClosureAction A K L
    ((σ • x : integralClosure A L) : L) = σ (x : L) := rfl

theorem galoisIntegralClosureAction_commutes :
    letI := galoisIntegralClosureAction A K L
    SMulCommClass (L ≃ₐ[K] L) A (integralClosure A L) := by
  letI := galoisIntegralClosureAction A K L
  refine ⟨?_⟩
  intro σ a x
  apply Subtype.ext
  simp only [Subalgebra.coe_smul, Algebra.smul_def]
  change (σ.restrictScalars A) (algebraMap A L a * (x : L)) =
    algebraMap A L a * (σ.restrictScalars A) (x : L)
  rw [map_mul, (σ.restrictScalars A).commutes]

/-- Fixed integral elements of an actual Galois field extension lie
in the original integrally closed base ring. Thus the true invariant
coordinate-ring hypothesis needed for all-prime transitivity is derived. -/
theorem galoisIntegralClosureAction_isInvariant [IsIntegrallyClosed A] [IsGalois K L] :
    letI := galoisIntegralClosureAction A K L
    Algebra.IsInvariant A (integralClosure A L) (L ≃ₐ[K] L) := by
  letI := galoisIntegralClosureAction A K L
  refine ⟨?_⟩
  intro x hx
  have hxL : ∀ σ : L ≃ₐ[K] L, σ (x : L) = x := by
    intro σ
    exact congrArg (fun y : integralClosure A L => (y : L)) (hx σ)
  obtain ⟨z, hz⟩ := Algebra.IsInvariant.isInvariant (A := K) (B := L)
    (G := L ≃ₐ[K] L) (x : L) hxL
  have hi : IsIntegral A (algebraMap K L z) := hz.symm ▸ x.property
  have hiz : IsIntegral A z :=
    (isIntegral_algebraMap_iff (algebraMap K L).injective).mp hi
  obtain ⟨a, ha⟩ := IsIntegrallyClosedIn.isIntegral_iff.mp hiz
  refine ⟨a, ?_⟩
  apply Subtype.ext
  change algebraMap A L a = (x : L)
  rw [IsScalarTower.algebraMap_apply A K L, ha]
  exact hz

end Litt3.QuotientGeometry
