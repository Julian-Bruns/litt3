import Solutions.Deformations.ArtinSchreierChartRoot
import Solutions.Deformations.SemilinearChartDegree
import Solutions.Deformations.AdicRingHomContinuous

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

variable {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S]

/-- Actual semilinear maps between arbitrary-rank original charts
derive their coordinate carry bounds from the genuine mapped unit
equations and original affine-linear residue data. The target chart
need not be etale. -/
theorem artin_schreier_chart_map_coordinate (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : S)}) S]
    (r s : ℕ) (a b : Fin r → R) (c d : Fin s → S)
    (coefficient : R →+* S)
    (map : artinSchreierChart R p r a b →+* artinSchreierChart S p s c d)
    (compatible : ∀ t : R, map (algebraMap R (artinSchreierChart R p r a b) t) =
      algebraMap S (artinSchreierChart S p s c d) (coefficient t))
    (units : Fin r → Sˣ) (unitValues : ∀ i, coefficient (a i) = (units i).val)
    (constant : Fin r → S) (linear : Fin r → Fin s → S)
    (residue : ∀ i, map (artinSchreierChartCoordinate R p r a b i) ≡
      constant i • (1 : artinSchreierChart S p s c d) +
        ∑ j, linear i j • artinSchreierChartCoordinate S p s c d j
          [SMOD (Ideal.span {(p : artinSchreierChart S p s c d)})])
    (i : Fin r) :
    map (artinSchreierChartCoordinate R p r a b i) ∈ artinSchreierCarry S p s c d 1 := by
  let z := map (artinSchreierChartCoordinate R p r a b i)
  let seed : artinSchreierChart S p s c d := constant i • 1 +
    ∑ j, linear i j • artinSchreierChartCoordinate S p s c d j
  have root : z ^ p = (units i).val • z + coefficient (b i) • (1 : artinSchreierChart S p s c d) := by
    have source := congrArg map (artin_schreier_chart_relation p r a b i)
    simp only [Algebra.smul_def, map_pow, map_add, map_mul, compatible, map_one, unitValues] at source
    simpa only [z, Algebra.smul_def, mul_one] using source
  have congruence : z ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart S p s c d)})] := residue i
  have initial : seed ^ p ≡ (units i).val • seed +
      coefficient (b i) • (1 : artinSchreierChart S p s c d)
        [SMOD (Ideal.span {(p : artinSchreierChart S p s c d)})] := by
    have powers := (congruence.pow p).symm
    rw [root] at powers
    have multiples := (SModEq.refl (U := Ideal.span {(p : artinSchreierChart S p s c d)})
      (algebraMap S (artinSchreierChart S p s c d) (units i).val)).mul congruence
    have sameConstant := SModEq.refl (U := Ideal.span {(p : artinSchreierChart S p s c d)})
      (coefficient (b i) • (1 : artinSchreierChart S p s c d))
    exact powers.trans (by simpa only [Algebra.smul_def] using multiples.add sameConstant)
  obtain ⟨x, xRoot, member, xResidue, unique⟩ := artin_schreier_chart_root_lift p prime s c d
    (units i) (coefficient (b i)) seed (artin_schreier_affine_seed p s c d (constant i) (linear i)) initial
  change z ∈ artinSchreierCarry S p s c d 1
  rw [unique z root congruence]
  exact member

/-- The full all-degree source map bound, with genuine semilinear
coefficient maps and continuity derived from the actual p-adic rings. -/
theorem artin_schreier_chart_map_degree (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : S)}) S]
    (r s : ℕ) (a b : Fin r → R) (c d : Fin s → S)
    (coefficient : R →+* S)
    (map : artinSchreierChart R p r a b →+* artinSchreierChart S p s c d)
    (compatible : ∀ t : R, map (algebraMap R (artinSchreierChart R p r a b) t) =
      algebraMap S (artinSchreierChart S p s c d) (coefficient t))
    (units : Fin r → Sˣ) (unitValues : ∀ i, coefficient (a i) = (units i).val)
    (constant : Fin r → S) (linear : Fin r → Fin s → S)
    (residue : ∀ i, map (artinSchreierChartCoordinate R p r a b i) ≡
      constant i • (1 : artinSchreierChart S p s c d) +
        ∑ j, linear i j • artinSchreierChartCoordinate S p s c d j
          [SMOD (Ideal.span {(p : artinSchreierChart S p s c d)})])
    (weight : ℤ) (x : artinSchreierChart R p r a b)
    (member : x ∈ artinSchreierCarry R p r a b weight) :
    map x ∈ artinSchreierCarry S p s c d weight := by
  apply semilinear_chart_degree_preserves p (p - 1)
    (artinSchreierChartCoordinate R p r a b) (artinSchreierChartCoordinate S p s c d)
    coefficient map compatible (prime_adic_ringHom_continuous p rfl rfl map) ?_ weight x member
  exact artin_schreier_chart_map_coordinate p prime r s a b c d coefficient map compatible
    units unitValues constant linear residue

end Litt3.Deformations
