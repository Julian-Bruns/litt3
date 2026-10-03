import Solutions.Deformations.FormalNormPrimitiveFiber

namespace Litt3.Deformations

/-- Exact full primitive reduction image for every original commuting
comparison, without supplying its coefficient polynomial lift. -/
theorem formal_commuting_primitive_fiber (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (A : Module.End (ZMod (p ^ (a + 1)))
      (FormalCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (commute : Commute A (formalCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (divisible : LinearMap.range (A - formalCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) •
        (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
          (FormalCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) (eta : K)
    (v : Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))) :
    (∃ y, A y = (LinearMap.range (formalCyclicRelation (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
      (formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta)) ∧
      formalCyclicCoefficientReduction (K := K) p a vanish y = v) ↔
      eta ∈ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))) ∧
        ∃ theta, v = finiteSocleCoefficient (R := ZMod (p ^ (a + 1))) (p ^ a) theta := by
  obtain ⟨C, rfl⟩ := formal_cyclic_operator_polynomial_lift p a (n + 1) vanish A commute
    (by rintro v ⟨eta, rfl⟩
        exact divisible ⟨formalCyclicConstant (R := ZMod (p ^ (a + 1))) (K := K) p a eta, rfl⟩)
  exact formal_norm_primitive_fiber p a n K characteristic bound _
    (coefficient_polynomial_operator_commute_shift (p ^ a) C 1) vanish eta v

end Litt3.Deformations
