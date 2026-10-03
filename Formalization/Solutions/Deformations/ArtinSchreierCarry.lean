import Definitions.Deformations.ArtinSchreierCarry
import Solutions.Deformations.ArtinSchreierChart
import Solutions.Deformations.ClosedSignedFiltration

namespace Litt3.Deformations

open scoped ArtinSchreierAdic

variable {R : Type*} [CommRing R]

/-- Full multiplicativity of the actual closed integral chart carries. -/
theorem artin_schreier_carry_multiplicative (p r : ℕ) (a b : Fin r → R)
    (d e : ℤ) (x y : artinSchreierChart R p r a b)
    (hx : x ∈ artinSchreierCarry R p r a b d)
    (hy : y ∈ artinSchreierCarry R p r a b e) :
    x * y ∈ artinSchreierCarry R p r a b (d + e) :=
  closed_signed_filtration_multiplicative _ (p - 1) _ d e x y hx hy

/-- Full actual degree-one pth-power closure. No coefficient a_i
needs to be a unit, and the ambient chart need not be etale. -/
theorem artin_schreier_carry_degree_one_power (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (x : artinSchreierChart R p r a b)
    (member : x ∈ artinSchreierCarry R p r a b 1) :
    x ^ p ∈ artinSchreierCarry R p r a b 1 :=
  artin_schreier_closed_degree_one_power p prime _ a b
    (artin_schreier_chart_relation p r a b) x member

/-- Exact normal monomial form of the actual closed source G_d,
including negative d and every coefficient prime-power digit. -/
theorem artin_schreier_carry_normal_form (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) :
    artinSchreierCarry R p r a b d =
      (normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
        (artinSchreierChartCoordinate R p r a b) d).topologicalClosure :=
  artin_schreier_closed_normal_form p prime.one_lt _ (p - 1) _ a b
    (artin_schreier_chart_relation p r a b) d

end Litt3.Deformations
