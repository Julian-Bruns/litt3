import Solutions.Deformations.ArtinSchreierChartLift
import Solutions.Deformations.DerivationSquareZeroGraph

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Actual solutions of the linearized original relations construct an
integral derivation on the full original chart. The derivation conclusion
is obtained from a square-zero universal map, not assumed as input. -/
theorem artin_schreier_derivation_of_linearized_relations (p : ℕ) (large : 1 < p)
    (r : ℕ) (a b : Fin r → R) (D : Derivation ℤ R R)
    (delta : Fin r → artinSchreierChart R p r a b)
    (linearized : ∀ i,
      ((p : artinSchreierChart R p r a b) *
          artinSchreierChartCoordinate R p r a b i ^ (p - 1) - algebraMap R _ (a i)) *
        delta i = algebraMap R _ (D (a i)) * artinSchreierChartCoordinate R p r a b i +
          algebraMap R _ (D (b i))) :
    ∃ E : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b),
      (∀ c, E (algebraMap R _ c) = algebraMap R _ (D c)) ∧
      ∀ i, E (artinSchreierChartCoordinate R p r a b i) = delta i := by
  let B := artinSchreierChart R p r a b
  let coefficient := derivationGraphAlong D (algebraMap R B)
  letI : Algebra R (TrivSqZeroExt B B) := coefficient.toAlgebra
  let coordinates : Fin r → TrivSqZeroExt B B :=
    fun i => ⟨artinSchreierChartCoordinate R p r a b i, delta i⟩
  have relations : ∀ i, coordinates i ^ p =
      algebraMap R (TrivSqZeroExt B B) (a i) * coordinates i +
        algebraMap R (TrivSqZeroExt B B) (b i) := by
    intro i
    apply TrivSqZeroExt.ext
    · change artinSchreierChartCoordinate R p r a b i ^ p =
        algebraMap R B (a i) * artinSchreierChartCoordinate R p r a b i +
          algebraMap R B (b i)
      simpa only [Algebra.smul_def, mul_one] using artin_schreier_chart_relation p r a b i
    · simp only [TrivSqZeroExt.snd_pow, TrivSqZeroExt.snd_add, TrivSqZeroExt.snd_mul]
      change p • artinSchreierChartCoordinate R p r a b i ^ p.pred • delta i =
        algebraMap R B (a i) • delta i +
          MulOpposite.op (artinSchreierChartCoordinate R p r a b i) •
            algebraMap R B (D (a i)) + algebraMap R B (D (b i))
      simp only [nsmul_eq_mul, smul_eq_mul, op_smul_eq_smul, Nat.pred_eq_sub_one]
      linear_combination linearized i
  let F := (artinSchreierChartLift p r a b coordinates relations).toRingHom
  have coeff (c : R) : F (algebraMap R B c) = coefficient c :=
    (artinSchreierChartLift p r a b coordinates relations).commutes c
  have coord (i : Fin r) : F (artinSchreierChartCoordinate R p r a b i) = coordinates i :=
    artin_schreier_chart_lift_coordinate p r a b coordinates relations i
  have firstHom : (TrivSqZeroExt.fstHom ℤ B B).toRingHom.comp F = RingHom.id B := by
    apply artin_schreier_chart_ringHom_ext p large r a b
    · intro c
      change (F (algebraMap R B c)).fst = algebraMap R B c
      rw [coeff]
      rfl
    · intro i
      change (F (artinSchreierChartCoordinate R p r a b i)).fst =
        artinSchreierChartCoordinate R p r a b i
      rw [coord]
      rfl
  have first (x : B) : (F x).fst = x := DFunLike.congr_fun firstHom x
  refine ⟨squareZeroGraphDerivation F first, ?_, ?_⟩
  · intro c
    change (F (algebraMap R B c)).snd = algebraMap R B (D c)
    rw [coeff]
    rfl
  · intro i
    change (F (artinSchreierChartCoordinate R p r a b i)).snd = delta i
    rw [coord]
    rfl

end Litt3.Deformations
