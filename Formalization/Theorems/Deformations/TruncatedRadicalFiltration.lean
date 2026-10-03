import Definitions.Deformations.TruncatedRadicalFiltration

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def ActualTruncatedRadical (N : ℕ) : Prop :=
  jacobsonRadicalSubspace (k := k) (A := TruncatedCoefficientRing k N) =
    principalCoefficientSubspace (truncatedParameter k N)

def ActualTruncatedRadicalLayerDimensions (N : ℕ) : Prop :=
  ∀ i, Module.finrank k
    (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := TruncatedCoefficientRing k N)) i) =
      if i < N then 1 else 0

def ActualTruncatedRadicalWidth (N lag : ℕ) : Prop :=
  let window := fun i => ∑ j ∈ Finset.range lag, Module.finrank k
    (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := TruncatedCoefficientRing k N))
      (i + j))
  (∀ i, window i ≤ min N lag) ∧ window 0 = min N lag

end Litt3.Deformations.Specifications
