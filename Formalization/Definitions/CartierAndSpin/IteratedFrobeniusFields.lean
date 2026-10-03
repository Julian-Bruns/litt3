import Definitions.SharedTensors.FrobeniusCoordinates

namespace Litt3.CartierAndSpin

variable (L : Type*) [Field L] (p : ℕ) [Fact p.Prime] [CharP L p]

/-- The literal subfield of p^e-th powers in the original field. -/
def iteratedFrobeniusSubfield (e : ℕ) : Subfield L :=
  (iterateFrobenius L p e).fieldRange

/-- The original field is genuinely isomorphic to its Frobenius image;
no perfectness of the original field is assumed. -/
noncomputable def iteratedFrobeniusImageEquiv (e : ℕ) :
    L ≃+* iteratedFrobeniusSubfield L p e :=
  (iterateFrobenius L p e).rangeRestrictFieldEquiv

end Litt3.CartierAndSpin
