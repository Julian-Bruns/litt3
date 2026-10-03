import Mathlib.RingTheory.LaurentSeries
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.GroupTheory.QuotientGroup.Basic

namespace Litt3.QuotientGeometry

/-- The genuine additive Artin–Schreier homomorphism. -/
def artinSchreierAddHom (R : Type*) [CommRing R]
    (p : ℕ) [Fact p.Prime] [CharP R p] : R →+ R where
  toFun v := v ^ p - v
  map_zero' := by simp [Nat.Prime.ne_zero (Fact.out : p.Prime)]
  map_add' v w := by rw [add_pow_char]; abel

/-- Classes modulo the actual image of the Artin–Schreier homomorphism. -/
abbrev ArtinSchreierClasses (R : Type*) [CommRing R]
    (p : ℕ) [Fact p.Prime] [CharP R p] :=
  R ⧸ (artinSchreierAddHom R p).range

def artinSchreierClass {R : Type*} [CommRing R]
    (p : ℕ) [Fact p.Prime] [CharP R p] (f : R) : ArtinSchreierClasses R p :=
  QuotientAddGroup.mk f

/-- Two actual pole-one scalar classes span the same prime-field line
when a nonzero Frobenius-fixed constant identifies their coboundary classes. -/
def LaurentArtinSchreierLineEquivalent
    {k : Type*} [Field k] (p : ℕ) (a b : k) (ψ : LaurentSeries k) : Prop :=
  ∃ c : k, c ≠ 0 ∧ c ^ p = c ∧
    ∃ v : LaurentSeries k,
      HahnSeries.C a * ψ - HahnSeries.C (c * b) * ψ = v ^ p - v

end Litt3.QuotientGeometry
