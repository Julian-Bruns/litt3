import Definitions.Jacobians.OriginalLineSheaves
import Mathlib.CategoryTheory.IsomorphismClasses

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- ALL actual original module SHEAVES locally free of rank one,
with their genuine original whole-neighborhood local-freeness proofs. -/
abbrev ActualOriginalLineSheaves (X : Scheme.{u}) :=
  {M : X.Modules // ActualOriginalLineSheaf X M}

/-- Actual GLOBAL original module-SHEAF isomorphism is the equivalence
relation on ALL original line sheaves. No divisor presentation is included. -/
def actualOriginalLineSheafIsoSetoid (X : Scheme.{u}) :
    Setoid (ActualOriginalLineSheaves X) :=
  (isIsomorphicSetoid X.Modules).comap Subtype.val

/-- The honest isomorphism classes of ALL original line SHEAVES.
This is a quotient of genuine original sheaves, not a renamed divisor
class group or an assumed Picard-scheme realization. -/
abbrev ActualOriginalLineSheafIsoClasses (X : Scheme.{u}) :=
  Quotient (actualOriginalLineSheafIsoSetoid X)

def actualOriginalLineSheafIsoClass (X : Scheme.{u})
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) :
    ActualOriginalLineSheafIsoClasses X :=
  Quotient.mk (actualOriginalLineSheafIsoSetoid X) ⟨M, hM⟩

end Litt3.Jacobians
