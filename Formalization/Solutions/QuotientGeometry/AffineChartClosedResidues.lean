import Solutions.QuotientGeometry.AffineChartStalkCoefficients
import Solutions.QuotientGeometry.LocalCoefficientResidueTransport
import Solutions.QuotientGeometry.ClosedAffineResidueCoefficients

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {X : Scheme.{u}} {k : Type u} [Field k] [IsAlgClosed k]

/-- At every actual closed Scheme point in a finite-type affine
chart, the original structure-map coefficient field surjects onto
the actual stalk residue field. No stalk or chart model is supplied. -/
theorem actual_closed_affine_chart_stalk_residue_surjective
    (sX : X ⟶ Spec (.of k)) (U : X.Opens) (hU : IsAffineOpen U) (x : U)
    (hx : IsClosed ({(x : X)} : Set X))
    (hfinite : letI := (chartBaseFieldHom sX U).toAlgebra; Algebra.FiniteType k Γ(X, U)) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    Function.Surjective (algebraMap k (IsLocalRing.ResidueField (X.presheaf.stalk x))) := by
  letI := (chartBaseFieldHom sX U).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  letI : Algebra.FiniteType k Γ(X, U) := hfinite
  letI : (hU.primeIdealOf x).asIdeal.IsMaximal :=
    hU.primeIdealOf_isMaximal_of_isClosed x hx
  exact actual_local_algEquiv_residue_coefficients_surjective
    (actualAffineChartStalkCoefficientAlgEquiv sX U hU x)
    (closed_affine_residue_coefficients_surjective (hU.primeIdealOf x).asIdeal)

end Litt3.QuotientGeometry
