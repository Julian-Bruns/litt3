import Definitions.CurveArithmetic.HyperellipticAffineSchemes
import Solutions.CurveArithmetic.HyperellipticAffineModels

namespace Litt3.CurveArithmetic

open CategoryTheory

/-- The coordinate-ring substitution gives an actual scheme
isomorphism. Extending to the smooth projective models remains a
separate geometric theorem. -/
noncomputable def finiteBranchAffineSchemeIso
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L) :
    finiteBranchAffineScheme K a ≅
      finiteBranchAffineScheme K (finiteAffineTransform u v a) :=
  AlgebraicGeometry.Scheme.Spec.mapIso
    (finiteBranchAffineCoordinateEquiv u v a).toRingEquiv.toCommRingCatIso.op

theorem finite_branch_affine_scheme_isomorphic_of_invariant_eq
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a b : L) (ha : a ∉ Set.range (algebraMap K L))
    (hb : b ∉ Set.range (algebraMap K L))
    (hequal : finiteAffineInvariant K a = finiteAffineInvariant K b) :
    Nonempty (finiteBranchAffineScheme K a ≅ finiteBranchAffineScheme K b) := by
  obtain ⟨u, v, rfl⟩ := (finite_affine_invariant_complete a b ha hb).mp hequal
  exact ⟨finiteBranchAffineSchemeIso u v a⟩

end Litt3.CurveArithmetic
