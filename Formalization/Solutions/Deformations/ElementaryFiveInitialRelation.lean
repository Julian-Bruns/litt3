import Solutions.Deformations.ElementaryNormalWeights

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem elementary_five_prime_parameter_member (r : ℕ) (i : Fin r) (j n d : ℕ)
    (bound : d ≤ 4 * j + n) :
    (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) ^ j *
      elementaryAugmentationParameter (R := R) 5 r i ^ n ∈
      weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r) d := by
  simpa only [generator_monomial_single, generator_monomial_weight_single] using
    weighted_generator_member (R := R)
      (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
      (elementaryAugmentationParameter (R := R) 5 r) d j (Pi.single i n)
      (by simpa only [generator_monomial_weight_single] using bound)

theorem elementary_five_parameter_power_member (r : ℕ) (i : Fin r) (n : ℕ) :
    elementaryAugmentationParameter (R := R) 5 r i ^ n ∈
      weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r) n := by
  simpa only [pow_zero, one_mul] using
    elementary_five_prime_parameter_member (R := R) r i 0 n n (by omega)

/-- The actual original five-cycle relation has exactly the source
initial term; every integral binomial correction lies one weight higher. -/
theorem elementary_five_initial_relation (r : ℕ) (i : Fin r) :
    elementaryAugmentationParameter (R := R) 5 r i ^ 5 +
        (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * elementaryAugmentationParameter (R := R) 5 r i ∈
      weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r) 6 := by
  let e := elementaryAugmentationParameter (R := R) 5 r i
  have second := elementary_five_prime_parameter_member (R := R) r i 1 2 6 (by omega)
  have third := elementary_five_prime_parameter_member (R := R) r i 1 3 6 (by omega)
  have fourth := elementary_five_prime_parameter_member (R := R) r i 1 4 6 (by omega)
  simp only [pow_one] at second third fourth
  have result := Submodule.add_mem _
    (Submodule.add_mem _ (Submodule.smul_mem _ (-(2 : R)) second)
      (Submodule.smul_mem _ (-(2 : R)) third))
    (Submodule.smul_mem _ (-(1 : R)) fourth)
  have relation := elementary_five_coordinate_relation (R := R) r i
  dsimp only at relation
  change e ^ 5 + (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * e ∈ _
  have identity : e ^ 5 + (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * e =
      (-(2 : R)) • ((5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * e ^ 2) +
      (-(2 : R)) • ((5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * e ^ 3) +
      (-(1 : R)) • ((5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * e ^ 4) := by
    rw [relation]
    simp only [Algebra.smul_def, map_neg, map_ofNat, map_one]
    ring
  rw [identity]
  exact result

end Litt3.Deformations
