import Solutions.CartierAndSpin.WeylMinimalPolynomials
import Mathlib.LinearAlgebra.Charpoly.Basic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
  [Module.Finite K V] {p : ℕ} [CharP K p]

/-- At dimension equal to the actual positive characteristic, a Weyl
operator has its ENTIRE characteristic polynomial as minimal polynomial.
No prime enumeration, scalar-power identity, normal form or cyclic-vector
premise is required. -/
theorem characteristic_dimension_weyl_minpoly_eq_charpoly
    (T M : Module.End K V) (hp : 0 < p)
    (hdim : Module.finrank K V = p) (hweyl : T * M - M * T = 1) :
    minpoly K T = T.charpoly := by
  letI : Nontrivial V := Module.nontrivial_of_finrank_pos (hdim ▸ hp)
  symm
  apply Polynomial.eq_of_monic_of_dvd_of_natDegree_le
    (minpoly.monic (LinearMap.isIntegral T)) T.charpoly_monic T.minpoly_dvd_charpoly
  rw [LinearMap.charpoly_natDegree, hdim]
  exact weyl_characteristic_le_minpoly_degree T M hweyl (LinearMap.isIntegral T)

end Litt3.CartierAndSpin
