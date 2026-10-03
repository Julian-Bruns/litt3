import Solutions.Deformations.ArtinSchreierChart
import Solutions.Deformations.FiniteBasisAdicComplete
import Solutions.Deformations.AdicCompleteAlgebraMap

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The literal original finite free chart over a p-adically complete
coefficient ring is actually p-adically complete as a ring. -/
theorem artin_schreier_chart_adic_complete (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) :
    IsAdicComplete (Ideal.span {(p : artinSchreierChart R p r a b)})
      (artinSchreierChart R p r a b) := by
  letI : IsAdicComplete (Ideal.span {(p : R)}) (artinSchreierChart R p r a b) :=
    finite_basis_adic_complete (Ideal.span {(p : R)})
      (artinSchreierChartBasis p prime.one_lt r a b)
  have complete := adic_complete_algebra_map
    (A := artinSchreierChart R p r a b) (Ideal.span {(p : R)})
  simpa only [Ideal.map_span, Set.image_singleton, map_natCast] using complete

end Litt3.Deformations
