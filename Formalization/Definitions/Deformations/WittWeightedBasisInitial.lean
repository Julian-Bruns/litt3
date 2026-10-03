import Definitions.Deformations.WittWeightedInitial

namespace Litt3.Deformations

open scoped BigOperators

noncomputable def wittWeightedBasisRepresentative (p N : ℕ) [Fact p.Prime]
    {k M I : Type*} [CommRing k] [AddCommGroup M]
    [Module (TruncatedWittVector p N k) M] [Fintype I]
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (degree : I → ℕ) (c : I → k) : M :=
  ∑ i, wittWeightedInitialCoefficient p N w d (degree i) (c i) • B i

/-- Literal associated-weight class in an actual Witt module with a
fixed original basis; both the representative and remainder are actual. -/
def WittWeightedBasisInitial (p N : ℕ) [Fact p.Prime]
    {k M I : Type*} [CommRing k] [AddCommGroup M]
    [Module (TruncatedWittVector p N k) M] [Fintype I]
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (degree : I → ℕ) (x : M) (c : I → k) : Prop :=
  (∀ i, ¬ wittWeightActive w d (degree i) N → c i = 0) ∧
  x - wittWeightedBasisRepresentative p N B w d degree c ∈
    basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree (d + 1)

end Litt3.Deformations
