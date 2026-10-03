import Solutions.Deformations.PolynomialSmithCounts
import Solutions.Deformations.PolynomialFiniteCoordinates
import Solutions.Deformations.ZModSmithExistence

namespace Litt3.Deformations

set_option maxRecDepth 2048 in
/-- The full finite Smith clause on the actual original polynomial
module. The actual normal form is constructed, and all its factor
counts are derived from the proved original cokernel. -/
theorem polynomial_full_smith (p a n f : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (basis : K ≃ₗ[ZMod (p ^ (a + 1))] (Fin f → ZMod (p ^ (a + 1))))
    (A : Module.End (ZMod (p ^ (a + 1)))
      (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (commute : Commute A (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (divisible : LinearMap.range (A - polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) •
        (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
          (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) :
    ∃ normal : ScalarPowerDiagonalization (p : ZMod (p ^ (a + 1))) (p ^ a * f) (a + 1) A,
      (∀ i, normal.exponent i = 0 ∨ normal.exponent i = a ∨ normal.exponent i = a + 1) ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = 0)).card = f * (p ^ a - (n + 1)) ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = a)).card = f * n ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = a + 1)).card = f := by
  have pBound : p ≤ p ^ a := le_self_pow (by omega) (Nat.ne_of_gt aPositive)
  have bound : n + 1 ≤ p ^ a := (by omega : n + 1 ≤ p).trans pBound
  obtain ⟨normal⟩ := zmod_smith_existence p (a + 1) (p ^ a * f)
    (polynomialFiniteCoordinates p a f vanish basis) A
  exact ⟨normal, polynomial_smith_counts p a n f K aPositive characteristic bound vanish basis A
    commute divisible normal⟩

end Litt3.Deformations
