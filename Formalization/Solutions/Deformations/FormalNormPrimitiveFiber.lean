import Solutions.Deformations.FormalNormPrimitiveImage

namespace Litt3.Deformations

/-- The full image mod p of every original cyclic norm solution
fiber: it is empty exactly outside pK, and otherwise is the entire
literal q−1 socle. Both directions construct or inspect actual solutions. -/
theorem formal_norm_primitive_fiber (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1))
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0) (eta : K)
    (v : Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))) :
    (∃ y : FormalCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a,
      formalPreparedCyclicOperator (n + 1) p a C
        (formal_cyclic_relation_commute_prepared (n + 1) p a C commute) y =
        (LinearMap.range (formalCyclicRelation (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
          (formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
            (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta)) ∧
      formalCyclicCoefficientReduction (K := K) p a vanish y = v) ↔
      eta ∈ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))) ∧
        ∃ theta, v = finiteSocleCoefficient (R := ZMod (p ^ (a + 1))) (p ^ a) theta := by
  let R := ZMod (p ^ (a + 1))
  constructor
  · rintro ⟨y, equation, reduction⟩
    refine ⟨(formal_cyclic_norm_solvable_free_zmod p a n K characteristic bound C commute eta).mp
      ⟨y, equation⟩, ?_⟩
    obtain ⟨theta, image⟩ := formal_norm_solution_reduction p a n K characteristic bound C commute
      vanish eta y equation
    exact ⟨theta, reduction.symm.trans image⟩
  · rintro ⟨multiple, theta, rfl⟩
    obtain ⟨y, equation⟩ := (formal_cyclic_norm_solvable_free_zmod p a n K characteristic bound C commute eta).mpr
      multiple
    obtain ⟨base, image⟩ := formal_norm_solution_reduction p a n K characteristic bound C commute
      vanish eta y equation
    obtain ⟨tau, difference⟩ := (coefficientScalarRange (K := K) (p : R)).mkQ_surjective (theta - base)
    obtain ⟨kernel, kernelEquation, kernelImage⟩ := formal_norm_kernel_socle_reduction p a n
      characteristic bound vanish C commute tau
    refine ⟨y + kernel, ?_, ?_⟩
    · rw [map_add, equation, kernelEquation, add_zero]
    · rw [map_add, image, kernelImage, difference, ← map_add]
      congr 1
      abel

end Litt3.Deformations
