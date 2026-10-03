import Definitions.Deformations.ArtinSchreierDigits
import Definitions.Deformations.NormalSignedFiltration
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.RingTheory.Derivation.Basic
import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.Algebra.MvPolynomial.Degrees

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

universe u v

/-- The full original integral Artin--Schreier carry theorem. All maps,
roots, derivations and digits refer to the literal unchanged chart.
No geometric etale-cover structure is asserted by this local theorem. -/
structure EtaleArtinSchreierCarryResult (R : Type u) [CommRing R]
    (p : ℕ) (prime : p.Prime) [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) : Prop where
  originalBasis : ∃ basis : Module.Basis (Fin r → Fin p) R (artinSchreierChart R p r a b),
    ∀ alpha, basis alpha = ∏ i, artinSchreierChartCoordinate R p r a b i ^ (alpha i).val
  literalCarry : ∀ d : ℤ, artinSchreierCarry R p r a b d =
    normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
      (artinSchreierChartCoordinate R p r a b) d
  closedCarry : ∀ d : ℤ,
    IsClosed (artinSchreierCarry R p r a b d : Set (artinSchreierChart R p r a b))
  multiplication : ∀ (d e : ℤ) (x y : artinSchreierChart R p r a b),
    x ∈ artinSchreierCarry R p r a b d → y ∈ artinSchreierCarry R p r a b e →
      x * y ∈ artinSchreierCarry R p r a b (d + e)
  primePower : ∀ x : artinSchreierChart R p r a b,
    x ∈ artinSchreierCarry R p r a b 1 → x ^ p ∈ artinSchreierCarry R p r a b 1
  rootLift : ∀ (u : Rˣ) (v c : R) (linear : Fin r → R),
    let seed : artinSchreierChart R p r a b := c • 1 +
      ∑ i, linear i • artinSchreierChartCoordinate R p r a b i
    seed ^ p ≡ u.val • seed + v • (1 : artinSchreierChart R p r a b)
      [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] →
    ∃ x : artinSchreierChart R p r a b,
      x ^ p = u.val • x + v • (1 : artinSchreierChart R p r a b) ∧
      x ∈ artinSchreierCarry R p r a b 1 ∧
      x ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] ∧
      ∀ y : artinSchreierChart R p r a b,
        y ^ p = u.val • y + v • (1 : artinSchreierChart R p r a b) →
        y ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] → y = x
  semilinearMaps : ∀ (S : Type v) [CommRing S]
    [IsAdicComplete (Ideal.span {(p : S)}) S]
    (s : ℕ) (c d : Fin s → S) (coefficient : R →+* S)
    (map : artinSchreierChart R p r a b →+* artinSchreierChart S p s c d),
    (∀ t : R, map (algebraMap R (artinSchreierChart R p r a b) t) =
      algebraMap S (artinSchreierChart S p s c d) (coefficient t)) →
    ∀ (units : Fin r → Sˣ), (∀ i, coefficient (a i) = (units i).val) →
    ∀ (constant : Fin r → S) (linear : Fin r → Fin s → S),
    (∀ i, map (artinSchreierChartCoordinate R p r a b i) ≡
      constant i • (1 : artinSchreierChart S p s c d) +
        ∑ j, linear i j • artinSchreierChartCoordinate S p s c d j
          [SMOD (Ideal.span {(p : artinSchreierChart S p s c d)})]) →
    ∀ (weight : ℤ) (x : artinSchreierChart R p r a b),
      x ∈ artinSchreierCarry R p r a b weight →
        map x ∈ artinSchreierCarry S p s c d weight
  derivation : ∀ (units : Fin r → Rˣ), (∀ i, (units i).val = a i) →
    ∀ D : Derivation ℤ R R,
    ∃ E : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
      (∀ c, E (algebraMap R _ c) = algebraMap R _ (D c)) ∧
      (∀ (d : ℤ) (x : artinSchreierChart R p r a b),
        x ∈ artinSchreierCarry R p r a b d → E x ∈ artinSchreierCarry R p r a b d) ∧
      ∀ F : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
        (∀ c, F (algebraMap R _ c) = algebraMap R _ (D c)) → F = E
  fixedDigits : ∀ (d : ℤ) (lift : R ⧸ Ideal.span {(p : R)} → R),
    (∀ c, Ideal.Quotient.mk (Ideal.span {(p : R)}) (lift c) = c) → lift 0 = 0 →
    ∀ (m : ℕ) (x : artinSchreierChart R p r a b),
    x ∈ artinSchreierCarry R p r a b d →
    ∃ digits : Fin m → (Fin r → Fin p) → R ⧸ Ideal.span {(p : R)},
      x ≡ (∑ j : Fin m, (p : artinSchreierChart R p r a b) ^ j.val *
        artinSchreierNormalDigit p prime.one_lt r a b lift (digits j))
        [SMOD ((Ideal.span {(p : artinSchreierChart R p r a b)}) ^ m)] ∧
      ∀ (j : Fin m) (alpha : Fin r → Fin p),
        d + ((p - 1 : ℕ) : ℤ) * j.val < (∑ i, (alpha i).val : ℕ) → digits j alpha = 0
  initialPolynomial : ∀ (f : MvPolynomial (Fin r) R) (d : ℕ), f.totalDegree ≤ d →
    f.eval₂ (algebraMap R (artinSchreierChart R p r a b))
      (artinSchreierChartCoordinate R p r a b) ∈ artinSchreierCarry R p r a b (d : ℤ)
  operationWord : ∀ (operations : List
      (artinSchreierChart R p r a b → artinSchreierChart R p r a b)),
    (∀ operation ∈ operations, ∀ (d : ℤ) x,
      x ∈ artinSchreierCarry R p r a b d → operation x ∈ artinSchreierCarry R p r a b d) →
    ∀ (d : ℤ) (x : artinSchreierChart R p r a b), x ∈ artinSchreierCarry R p r a b d →
      operations.foldl (fun y operation => operation y) x ∈ artinSchreierCarry R p r a b d

end Litt3.Deformations
