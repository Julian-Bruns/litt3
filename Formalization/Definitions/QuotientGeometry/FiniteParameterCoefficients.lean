import Mathlib.RingTheory.PowerSeries.Substitution
import Mathlib.Data.Nat.Init

namespace Litt3.QuotientGeometry

/-- The actual triangular basis series, ordered by its parameter order. -/
noncomputable def finiteParameterBasis
    {k : Type*} [Field k] (n : ℕ) (b : PowerSeries k) (j : ℕ) : PowerSeries k :=
  PowerSeries.X ^ (j % n) * b ^ (j / n)

/-- Recursive coefficients in the n residue-class parameter decomposition. -/
noncomputable def finiteParameterCoeff
    {k : Type*} [Field k] (n : ℕ) (b c f : PowerSeries k) (j : ℕ) : k :=
  Nat.strongRecOn' j fun j ih =>
    (PowerSeries.coeff j f - ∑ i : Fin j,
      ih i.val i.isLt * PowerSeries.coeff j (finiteParameterBasis n b i.val)) /
        PowerSeries.constantCoeff c ^ (j / n)

noncomputable def finiteParameterComponents
    {k : Type*} [Field k] (n : ℕ) (b c f : PowerSeries k) (i : Fin n) : PowerSeries k :=
  PowerSeries.mk (fun d => finiteParameterCoeff n b c f (d * n + i.val))

end Litt3.QuotientGeometry
