import Solutions.CartierAndSpin.PolynomialQuotientNormShift
import Mathlib.Algebra.CharP.Reduced

namespace Litt3.CartierAndSpin

open Polynomial

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- Actual norm/Frobenius evaluation for every nonzero polynomial,
including inseparable source algebras with nilpotents. No splitting field
or source separability is needed. -/
theorem arbitrary_source_norm_inseparable_root (F : K[X]) (hF : F ≠ 0)
    (p : ℕ) [Fact p.Prime] [CharP L p] (f : K) (c : L)
    (hc : c ^ p = -algebraMap K L f) :
    algebraMap K L (Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f))) =
      (algebraMap K L ((-1 : K) ^ F.natDegree * F.leadingCoeff⁻¹) *
        (F.map (algebraMap K L)).eval c) ^ p := by
  let G := F.map (algebraMap K L)
  have hG : G ≠ 0 := Polynomial.map_ne_zero hF
  have hdegree : G.natDegree = F.natDegree :=
    natDegree_map_eq_of_injective (algebraMap K L).injective F
  rw [← polynomial_quotient_norm_coefficient_extension F hF]
  have hmap : polynomialQuotientCoefficientMap (L := L) F
      (AdjoinRoot.mk F (X ^ p + C f)) =
      AdjoinRoot.mk G (X ^ p + C (algebraMap K L f)) := by
    change polynomialQuotientCoefficientMap F
      ((AdjoinRoot.root F) ^ p + algebraMap K (AdjoinRoot F) f) =
      (AdjoinRoot.root G) ^ p + algebraMap L (AdjoinRoot G) (algebraMap K L f)
    rw [map_add, map_pow, polynomialQuotientCoefficientMap_root,
      (polynomialQuotientCoefficientMap F).commutes]
    rfl
  have hphi : AdjoinRoot.mk G (X ^ p + C (algebraMap K L f)) =
      (AdjoinRoot.root G - algebraMap L (AdjoinRoot G) c) ^ p := by
    have hpoly : (X - C c) ^ p = (X ^ p + C (algebraMap K L f) : L[X]) := by
      rw [sub_pow_char, ← C_pow, hc, C_neg, sub_neg_eq_add]
    rw [← hpoly, map_pow, map_sub, AdjoinRoot.mk_X, AdjoinRoot.mk_C]
    rfl
  rw [hmap, hphi, map_pow, polynomial_quotient_norm_root_sub_scalar G hG c]
  rw [hdegree, map_mul, map_pow, map_neg, map_one, map_inv₀]
  have hleading : G.leadingCoeff = algebraMap K L F.leadingCoeff := by
    exact leadingCoeff_map_of_injective (algebraMap K L).injective F
  rw [hleading]
  congr 1
  ring

end Litt3.CartierAndSpin
