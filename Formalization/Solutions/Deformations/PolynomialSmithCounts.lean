import Solutions.Deformations.PolynomialCommutingCokernel
import Solutions.Deformations.SmithCountsFromCokernel

namespace Litt3.Deformations

set_option maxRecDepth 2048 in
/-- Exact finite Smith factor counts for every actual scalar-power
normal form of the original cyclic comparison. The original cokernel
is constructed here; the only external input is generic diagonalization
existence, expressed as actual two-basis maps with the full identity. -/
theorem polynomial_smith_counts (p a n f : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (basis : K ≃ₗ[ZMod (p ^ (a + 1))] (Fin f → ZMod (p ^ (a + 1))))
    (A : Module.End (ZMod (p ^ (a + 1)))
      (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (commute : Commute A (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (divisible : LinearMap.range (A - polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) •
        (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
          (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))))
    (normal : ScalarPowerDiagonalization (p : ZMod (p ^ (a + 1))) (p ^ a * f) (a + 1) A) :
    (∀ i, normal.exponent i = 0 ∨ normal.exponent i = a ∨ normal.exponent i = a + 1) ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = 0)).card = f * (p ^ a - (n + 1)) ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = a)).card = f * n ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = a + 1)).card = f := by
  obtain ⟨cokernel, normClass⟩ := polynomial_commuting_cyclic_cokernel p a n vanish characteristic bound A commute divisible
  exact smith_counts_from_cokernel p a (p ^ a) n f aPositive K _ basis A normal cokernel

end Litt3.Deformations
