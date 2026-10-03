import Solutions.Deformations.ArtinSchreierCarry
import Solutions.Deformations.ArtinSchreierChartComplete
import Solutions.Deformations.ArtinSchreierWeightedRoot

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

variable {R : Type*} [CommRing R]

/-- Every literal coefficient lift of an affine-linear original
residue expression already lies in actual degree one. -/
theorem artin_schreier_affine_seed (p r : ℕ) (a b : Fin r → R)
    (c : R) (d : Fin r → R) :
    c • (1 : artinSchreierChart R p r a b) +
      ∑ i, d i • artinSchreierChartCoordinate R p r a b i ∈
        artinSchreierCarry R p r a b 1 := by
  have one : (1 : artinSchreierChart R p r a b) ∈ artinSchreierCarry R p r a b 1 := by
    apply (signedGeneratorFiltration R (p : artinSchreierChart R p r a b) (p - 1)
      (artinSchreierChartCoordinate R p r a b) 1).le_topologicalClosure
    exact signed_generator_filtration_monotone _ (p - 1) _ (by omega)
      (signed_generator_initial_one (R := R) _ (p - 1) _)
  apply Submodule.add_mem _ (Submodule.smul_mem _ c one)
  apply Submodule.sum_mem
  intro i _
  apply Submodule.smul_mem
  exact (signedGeneratorFiltration R (p : artinSchreierChart R p r a b) (p - 1)
    (artinSchreierChartCoordinate R p r a b) 1).le_topologicalClosure
      (signed_generator_coordinate _ (p - 1) _ i)

/-- Actual source root-lifting clause in the original integral chart.
Completeness is derived from the original coefficient ring and the
actual normal basis; the ambient chart need not be etale. -/
theorem artin_schreier_chart_root_lift (p : ℕ) (prime : p.Prime) [Nontrivial R]
    [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) (u : Rˣ) (v : R)
    (seed : artinSchreierChart R p r a b)
    (seedMember : seed ∈ artinSchreierCarry R p r a b 1)
    (initial : seed ^ p ≡ u.val • seed + v • (1 : artinSchreierChart R p r a b)
      [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})]) :
    ∃ x : artinSchreierChart R p r a b,
      x ^ p = u.val • x + v • (1 : artinSchreierChart R p r a b) ∧
      x ∈ artinSchreierCarry R p r a b 1 ∧
      x ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] ∧
      ∀ y : artinSchreierChart R p r a b,
        y ^ p = u.val • y + v • (1 : artinSchreierChart R p r a b) →
        y ≡ seed [SMOD (Ideal.span {(p : artinSchreierChart R p r a b)})] → y = x := by
  letI : IsAdicComplete (Ideal.span {(p : artinSchreierChart R p r a b)})
      (artinSchreierChart R p r a b) := artin_schreier_chart_adic_complete p prime r a b
  exact artin_schreier_closed_root_lift p prime rfl
    (artinSchreierChartCoordinate R p r a b) a b (artin_schreier_chart_relation p r a b)
      u v seed seedMember initial

end Litt3.Deformations
