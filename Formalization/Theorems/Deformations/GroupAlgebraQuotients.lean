import Definitions.Deformations.GroupAlgebraQuotients
import Theorems.Deformations.BoundedNaturalMaximum

namespace Litt3.Deformations.Specifications

variable {k A B : Type*} [Field k] [Ring A] [Ring B] [Algebra k A] [Algebra k B]

/-- Full coefficient dimension comparison for actual left
regular one-relation quotients along an algebra quotient. -/
def LeftPrincipalQuotientDimensionMonotone (φ : A →ₐ[k] B) (f : A) : Prop :=
  Module.finrank k (LeftPrincipalQuotient (φ f)) ≤
    Module.finrank k (LeftPrincipalQuotient f)

end Litt3.Deformations.Specifications

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

variable {k G H : Type*} [Field k] [Group G] [Group H]

/-- Every actual attained radical-window maximum of the quotient
group algebra bounds the full source left one-relation quotient. -/
def GroupQuotientRadicalWidth (_φ : G →* H) (lag : ℕ) (f : k[G]) : Prop :=
  ∃ w : ℕ,
    (∀ i, (∑ j ∈ Finset.range lag, Module.finrank k
      (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := k[H])) (i + j))) ≤ w) ∧
    (∃ i, (∑ j ∈ Finset.range lag, Module.finrank k
      (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := k[H])) (i + j))) = w) ∧
    w ≤ Module.finrank k (LeftPrincipalQuotient f)

def GroupQuotientRadicalMaximaMonotone (_φ : G →* H) (lag : ℕ) : Prop :=
  ∃ wG wH : ℕ,
    AttainedNaturalMaximum (groupRadicalHilbertWindow (k := k) (G := G) lag) wG ∧
    AttainedNaturalMaximum (groupRadicalHilbertWindow (k := k) (G := H) lag) wH ∧
    wH ≤ wG

end Litt3.Deformations.Specifications
