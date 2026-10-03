import Definitions.Deformations.ArtinSchreierCarry

namespace Litt3.Deformations

open scoped BigOperators

/-- A literal original normal polynomial with fixed residue-section
coefficients; the actual original quotient basis is unchanged. -/
noncomputable def artinSchreierNormalDigit {R k : Type*} [CommRing R] [CommRing k]
    (p : ℕ) (large : 1 < p) (r : ℕ) (a b : Fin r → R)
    (lift : k → R) (digits : (Fin r → Fin p) → k) : artinSchreierChart R p r a b :=
  ∑ alpha, lift (digits alpha) •
    ∏ i, artinSchreierChartCoordinate R p r a b i ^ (alpha i).val

end Litt3.Deformations
