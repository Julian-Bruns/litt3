import Solutions.Deformations.ArtinSchreierDerivationUnique
import Solutions.Deformations.ArtinSchreierJacobianInverse
import Solutions.Deformations.ArtinSchreierChartComplete
import Solutions.Deformations.ArtinSchreierCarryClosed
import Solutions.Deformations.DerivationSignedDegree

namespace Litt3.Deformations

open scoped ArtinSchreierAdic

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Every original base derivation extends uniquely to the actual
complete integral chart when every original linear coefficient is a
unit. The constructed extension preserves every signed carry degree. -/
theorem artin_schreier_chart_derivation (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) (units : Fin r → Rˣ)
    (coefficientUnits : ∀ i, (units i).val = a i) (D : Derivation ℤ R R) :
    ∃ E : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
      (∀ c, E (algebraMap R _ c) = algebraMap R _ (D c)) ∧
      (∀ (d : ℤ) (x : artinSchreierChart R p r a b),
        x ∈ artinSchreierCarry R p r a b d →
          E x ∈ artinSchreierCarry R p r a b d) ∧
      ∀ F : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
        (∀ c, F (algebraMap R _ c) = algebraMap R _ (D c)) → F = E := by
  classical
  let B := artinSchreierChart R p r a b
  let e := artinSchreierChartCoordinate R p r a b
  letI : IsAdicComplete (Ideal.span {(p : B)}) B :=
    artin_schreier_chart_adic_complete p prime r a b
  have coordinates (i : Fin r) : e i ∈ artinSchreierCarry R p r a b 1 :=
    (signedGeneratorFiltration R (p : B) (p - 1) e 1).le_topologicalClosure
      (signed_generator_coordinate (p : B) (p - 1) e i)
  have inverseExists (i : Fin r) : ∃ y : B,
      ((p : B) * e i ^ (p - 1) - algebraMap R B (a i)) * y = 1 ∧
        y ∈ artinSchreierCarry R p r a b 0 := by
    simpa only [coefficientUnits, Algebra.smul_def, mul_one] using
      artin_schreier_jacobian_inverse_degree_zero p e rfl (units i) (e i) (coordinates i)
  choose inverse identities inverseDegree using inverseExists
  let delta (i : Fin r) : B := inverse i *
    (algebraMap R B (D (a i)) * e i + algebraMap R B (D (b i)))
  have linearized (i : Fin r) :
      ((p : B) * e i ^ (p - 1) - algebraMap R B (a i)) * delta i =
        algebraMap R B (D (a i)) * e i + algebraMap R B (D (b i)) := by
    dsimp only [delta]
    rw [← mul_assoc, identities, one_mul]
  obtain ⟨E, extension, coordinateDerivative⟩ :=
    artin_schreier_derivation_of_linearized_relations p prime.one_lt r a b D delta linearized
  have derivatives (i : Fin r) : E (e i) ∈ artinSchreierCarry R p r a b 1 := by
    rw [coordinateDerivative]
    apply artin_schreier_carry_multiplicative p r a b 0 1 _ _ (inverseDegree i)
    apply Submodule.add_mem
    · simpa only [Algebra.smul_def] using
        (artinSchreierCarry R p r a b 1).smul_mem (D (a i)) (coordinates i)
    · have one : (1 : B) ∈ artinSchreierCarry R p r a b 1 :=
        closed_signed_filtration_monotone (p : B) (p - 1) e (by omega)
          (closed_signed_initial_one (R := R) (p : B) (p - 1) e)
      simpa only [Algebra.smul_def, mul_one] using
        (artinSchreierCarry R p r a b 1).smul_mem (D (b i)) one
  refine ⟨E, extension, ?_, ?_⟩
  · intro d x member
    have equality : artinSchreierCarry R p r a b d =
        signedGeneratorFiltration R (p : B) (p - 1) e d := by
      rw [artin_schreier_carry_eq_normal p prime r a b d]
      exact (artin_schreier_signed_normal_form p prime.one_lt (p : B) (p - 1) e
        a b (artin_schreier_chart_relation p r a b) d).symm
    rw [equality] at member
    exact derivation_signed_degree p (p - 1) e D E extension derivatives d x member
  · intro F extensionF
    exact artin_schreier_derivation_unique p prime.one_lt r a b D inverse identities
      F E extensionF extension

end Litt3.Deformations
