import Definitions.Deformations.ArtinSchreierChart
import Definitions.Deformations.ClosedSignedFiltration
import Mathlib.Topology.Algebra.Nonarchimedean.AdicTopology
import Mathlib.Topology.Algebra.Ring.Basic

namespace Litt3.Deformations

namespace ArtinSchreierAdic

scoped instance chartTopology (R : Type*) [CommRing R] (p r : ℕ) (a b : Fin r → R) :
    TopologicalSpace (artinSchreierChart R p r a b) :=
  (Ideal.span {(p : artinSchreierChart R p r a b)}).adicTopology

scoped instance chartTopologicalRing (R : Type*) [CommRing R] (p r : ℕ) (a b : Fin r → R) :
    IsTopologicalRing (artinSchreierChart R p r a b) :=
  (Ideal.span {(p : artinSchreierChart R p r a b)}).ringFilterBasis.isTopologicalRing

scoped instance chartConstSmul (R : Type*) [CommRing R] (p r : ℕ) (a b : Fin r → R) :
    ContinuousConstSMul R (artinSchreierChart R p r a b) where
  continuous_const_smul c := by
    simpa only [Algebra.smul_def] using
      (continuous_const.mul continuous_id : Continuous fun x : artinSchreierChart R p r a b =>
        algebraMap R (artinSchreierChart R p r a b) c * x)

end ArtinSchreierAdic

open scoped ArtinSchreierAdic

/-- The actual closed p-adic carry module in the literal chart with
the unchanged original normal coordinates. -/
noncomputable def artinSchreierCarry (R : Type*) [CommRing R] (p r : ℕ)
    (a b : Fin r → R) (d : ℤ) : Submodule R (artinSchreierChart R p r a b) :=
  closedSignedFiltration R (p : artinSchreierChart R p r a b) (p - 1)
    (artinSchreierChartCoordinate R p r a b) d

end Litt3.Deformations
