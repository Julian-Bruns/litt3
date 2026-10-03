import Solutions.CartierAndSpin.ZeroSourceNormCounterexample
import Solutions.SharedTensors.RationalFunctionKaehler
import Mathlib.FieldTheory.RatFunc.AsPolynomial
import Mathlib.Data.ZMod.Basic

namespace Litt3.CartierAndSpin

open Polynomial

/-- A literal rational parameter is not a p-th power. The proof uses its
actual universal derivation and works over every prime-characteristic field. -/
theorem rational_parameter_not_pth_power (k : Type*) [Field k]
    (p : ℕ) [Fact p.Prime] [CharP k p] [CharP (RatFunc k) p] :
    ∀ a : RatFunc k, a ^ p ≠ RatFunc.X := by
  let e := Litt3.SharedTensors.polynomialFractionKaehlerCoordinate
    (k := k) (K := RatFunc k)
  let D := Litt3.SharedTensors.universalCoordinateDerivation e
  have hone : D (RatFunc.X : RatFunc k) = 1 := by
    change e (KaehlerDifferential.D k (RatFunc k) RatFunc.X) = 1
    rw [← RatFunc.algebraMap_X]
    exact Litt3.SharedTensors.polynomialFractionKaehlerCoordinate_X
  intro a ha
  have hzero : D (a ^ p) = 0 := by
    rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero (RatFunc k) p, zero_mul]
  rw [ha, hone] at hzero
  exact one_ne_zero hzero

local instance : Fact (Nat.Prime 5) := ⟨by norm_num⟩

/-- A concrete characteristic-five rational function field and element
outside its p-th powers exhibit the finite-algebra degree-zero loophole. -/
theorem rational_fifth_power_zero_source_counterexample :
    (∀ a : RatFunc (ZMod 5), a ^ 5 ≠ RatFunc.X) ∧
    (1 : (RatFunc (ZMod 5))[X]).Monic ∧
    (1 : (RatFunc (ZMod 5))[X]).Separable ∧
    (∃ a : RatFunc (ZMod 5), a ≠ 0 ∧
      Algebra.norm (RatFunc (ZMod 5))
        ((AdjoinRoot.root (1 : (RatFunc (ZMod 5))[X])) ^ 5 +
          algebraMap (RatFunc (ZMod 5)) (AdjoinRoot (1 : (RatFunc (ZMod 5))[X]))
            RatFunc.X) = a ^ 5) ∧
    ¬5 ≤ (1 : (RatFunc (ZMod 5))[X]).natDegree := by
  letI : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  exact ⟨rational_parameter_not_pth_power (ZMod 5) 5,
    zero_source_norm_degree_counterexample (RatFunc.X : RatFunc (ZMod 5)) 5 (by norm_num)⟩

end Litt3.CartierAndSpin
