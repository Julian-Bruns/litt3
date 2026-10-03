import Solutions.Deformations.ElementaryPrimeMixedRelation

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]
variable (p : ℕ) [Fact p.Prime]

theorem elementary_prime_parameter_member (r : ℕ) (i : Fin r) (j n d : ℕ)
    (bound : d ≤ (p - 1) * j + n) :
    (p : AddMonoidAlgebra R (Fin r → ZMod p)) ^ j *
      elementaryAugmentationParameter (R := R) p r i ^ n ∈
      weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r) d := by
  simpa only [generator_monomial_single, generator_monomial_weight_single] using
    weighted_generator_member (R := R)
      (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
      (elementaryAugmentationParameter (R := R) p r) d j (Pi.single i n)
      (by simpa only [generator_monomial_weight_single] using bound)

theorem elementary_prime_parameter_power_member (r : ℕ) (i : Fin r) (n : ℕ) :
    elementaryAugmentationParameter (R := R) p r i ^ n ∈
      weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r) n := by
  simpa only [pow_zero, one_mul] using
    elementary_prime_parameter_member (R := R) p r i 0 n n (by omega)

/-- The literal original prime-cycle relation has initial term E^p+tau E;
every other original integral binomial term lies strictly higher. -/
theorem elementary_prime_initial_relation (r : ℕ) (i : Fin r) :
    elementaryAugmentationParameter (R := R) p r i ^ p +
        (p : AddMonoidAlgebra R (Fin r → ZMod p)) * elementaryAugmentationParameter (R := R) p r i ∈
      weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r) (p + 1) := by
  classical
  have prime := (Fact.out : p.Prime)
  have two := prime.two_le
  let e := elementaryAugmentationParameter (R := R) p r i
  let zero : Fin (p - 1) := ⟨0, by omega⟩
  let term := fun l : Fin (p - 1) => originalPrimeRelationCoefficients (R := R) p l • e ^ (l.val + 1)
  have first : term zero = -e := by
    simp [term, zero, originalPrimeRelationCoefficients, Nat.div_self prime.pos]
  have split : (∑ l : Fin (p - 1), term l) =
      (∑ l ∈ Finset.univ.erase zero, term l) - e := by
    rw [← Finset.sum_erase_add _ _ (Finset.mem_univ zero), first, sub_eq_add_neg]
  have relation := elementary_original_prime_relation_sum (R := R) p prime r i
  change e ^ p = (p : AddMonoidAlgebra R (Fin r → ZMod p)) * ∑ l, term l at relation
  have identity : e ^ p + (p : AddMonoidAlgebra R (Fin r → ZMod p)) * e =
      ∑ l ∈ Finset.univ.erase zero,
        originalPrimeRelationCoefficients (R := R) p l •
          ((p : AddMonoidAlgebra R (Fin r → ZMod p)) * e ^ (l.val + 1)) := by
    rw [relation, split, mul_sub, sub_add_cancel]
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro l _
    simp only [term, Algebra.smul_def]
    ring
  change e ^ p + (p : AddMonoidAlgebra R (Fin r → ZMod p)) * e ∈ _
  rw [identity]
  apply Submodule.sum_mem
  intro l member
  have nonzero : l ≠ zero := (Finset.mem_erase.mp member).1
  have valNonzero : l.val ≠ 0 := by
    intro equality
    exact nonzero (Fin.ext equality)
  have bound : p + 1 ≤ (p - 1) * 1 + (l.val + 1) := by omega
  exact Submodule.smul_mem _ _ (by
    simpa only [pow_one] using elementary_prime_parameter_member (R := R) p r i 1
      (l.val + 1) (p + 1) bound)

end Litt3.Deformations
