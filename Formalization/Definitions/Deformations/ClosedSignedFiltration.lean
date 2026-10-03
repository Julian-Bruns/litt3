import Definitions.Deformations.SignedGeneratorFiltration
import Mathlib.Topology.Algebra.Module.Basic

namespace Litt3.Deformations

/-- Closed integral chart-carry modules, retaining all actual signed
weights, prime powers, and original coordinates. -/
noncomputable def closedSignedFiltration (R : Type*) [CommRing R]
    {A I : Type*} [CommRing A] [Algebra R A] [Fintype I]
    [TopologicalSpace A] [ContinuousAdd A] [ContinuousConstSMul R A]
    (p : A) (w : ℕ) (e : I → A) (d : ℤ) : Submodule R A :=
  (signedGeneratorFiltration R p w e d).topologicalClosure

end Litt3.Deformations
