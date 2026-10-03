import Solutions.Deformations.FormalLeadingNormCarry
import Solutions.Deformations.FormalCyclicOperatorLift

namespace Litt3.Deformations

set_option maxRecDepth 2048 in
/-- The exact terminal carry on actual original cyclic classes. The
original partial equation and original finite leading coefficients
are the hypotheses; the entire relation witness is constructed. -/
theorem formal_prepared_terminal_carry (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (eta : K)
    (constant : K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))))
    (D : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))))
    (y r : FormalCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)
    (equation : formalPreparedCyclicOperator (n + 1) p a C
      (formal_cyclic_relation_commute_prepared (n + 1) p a C commute) y -
      (LinearMap.range (formalCyclicRelation (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
        (formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
          (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta)) =
      (p : ZMod (p ^ (a + 1))) ^ a • r)
    (etaReduction : (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ eta = constant)
    (pattern : coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (p ^ a)
      (formalCyclicCoefficientReduction (K := K) p a vanish y) =
      coefficientSeriesShift (R := ZMod (p ^ (a + 1))) (p ^ a - (n + 1) - 1)
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) constant) +
      coefficientSeriesShift (R := ZMod (p ^ (a + 1))) (p ^ a - (n + 1))
        (coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (n + 1) D)) :
    coefficientSeriesPrefix (R := ZMod (p ^ (a + 1))) (n + 1)
      (coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (p ^ a)
        (formalCyclicCoefficientReduction (K := K) p a vanish r)) =
      -truncatedLogValue (R := ZMod (p ^ (a + 1))) (n + 1)
        (finiteCoefficientShift (R := ZMod (p ^ (a + 1))) (n + 1))
        ((Fin.cons constant 0 : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K)
          (p : ZMod (p ^ (a + 1)))) +
          finiteCoefficientShift (R := ZMod (p ^ (a + 1))) (n + 1) D) := by
  let R := ZMod (p ^ (a + 1))
  let A := preparedSeriesOperator (n + 1) (p : R) C
  let q := (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
  let w := coefficientSeriesPrefixSection (R := R) (p ^ a) (formalCyclicCoordinates (K := K) p a vanish y)
  let s := coefficientSeriesPrefixSection (R := R) (p ^ a) (formalCyclicCoordinates (K := K) p a vanish r)
  have yRepresentative : q w = y := by
    have identity := (formalCyclicCoordinates (K := K) p a vanish).symm_apply_apply y
    rw [formal_cyclic_coordinates_symm] at identity
    exact identity
  have rRepresentative : q s = r := by
    have identity := (formalCyclicCoordinates (K := K) p a vanish).symm_apply_apply r
    rw [formal_cyclic_coordinates_symm] at identity
    exact identity
  rw [← yRepresentative, ← rRepresentative] at equation
  change q (A w) - q (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)) =
    (p : R) ^ a • q s at equation
  have zero : q (A w - formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta) -
      (p : R) ^ a • s) = 0 := by
    rw [map_sub, map_sub, map_smul, equation, sub_self]
  obtain ⟨z, same⟩ := (Submodule.Quotient.mk_eq_zero _).mp zero
  have full : A w = (p : R) ^ a • s +
      formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta) +
      formalCyclicRelation (R := R) p a z := by
    rw [same]
    abel
  have wReduction := formal_cyclic_finite_representative_reduction p a vanish y
  have rReduction := formal_cyclic_finite_representative_reduction p a vanish r
  have carry := formal_leading_norm_carry p a n K aPositive characteristic vanish C commute eta constant D w s z
    full etaReduction (wReduction.trans pattern)
  funext j
  have point := congrFun rReduction j.val
  change (coefficientScalarRange (K := K) (p : R)).mkQ (s j.val) =
    coefficientSeriesPrefixSection (R := R) (p ^ a)
      (formalCyclicCoefficientReduction (K := K) p a vanish r) j.val at point
  exact point.symm.trans (carry j)

end Litt3.Deformations
