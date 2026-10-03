import Solutions.CartierAndSpin.TraceBaseChange
import Mathlib.RingTheory.Norm.Basic

namespace Litt3.CartierAndSpin

open Module Polynomial

section CompatibleBases

variable {K L A B ι : Type*} [CommRing K] [CommRing L] [Algebra K L]
  [CommRing A] [Algebra K A] [CommRing B] [Algebra L B] [Algebra K B]
  [IsScalarTower K L B] [Fintype ι]

/-- The actual determinant norm commutes with scalar extension whenever
the images of an actual finite basis form the extended basis. -/
theorem algebra_norm_map_of_compatible (f : A →ₐ[K] B)
    (base : Basis ι K A) (extended : Basis ι L B)
    (hcompatible : ∀ i, f (base i) = extended i) (x : A) :
    Algebra.norm L (f x) = algebraMap K L (Algebra.norm K x) := by
  classical
  rw [Algebra.norm_eq_matrix_det base, Algebra.norm_eq_matrix_det extended,
    RingHom.map_det]
  congr 1
  ext i j
  change Algebra.leftMulMatrix extended (f x) i j =
    algebraMap K L (Algebra.leftMulMatrix base x i j)
  rw [Algebra.leftMulMatrix_eq_repr_mul,
    Algebra.leftMulMatrix_eq_repr_mul, ← hcompatible, ← map_mul]
  exact basis_repr_map_of_compatible f base extended hcompatible (x * base j) i

end CompatibleBases

section PolynomialQuotient

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- Norm base change for literal polynomial source algebras. The polynomial
may be inseparable, reducible, or constant; only its being nonzero is needed. -/
theorem polynomial_quotient_norm_coefficient_extension (F : K[X]) (hF : F ≠ 0)
    (x : AdjoinRoot F) :
    Algebra.norm L (polynomialQuotientCoefficientMap (L := L) F x) =
      algebraMap K L (Algebra.norm K x) := by
  classical
  have hmap : F.map (algebraMap K L) ≠ 0 := Polynomial.map_ne_zero hF
  have hdegree : (F.map (algebraMap K L)).natDegree = F.natDegree :=
    Polynomial.natDegree_map_eq_of_injective (algebraMap K L).injective F
  let base := (AdjoinRoot.powerBasis hF).basis
  let extended := ((AdjoinRoot.powerBasis hmap).basis).reindex (finCongr hdegree)
  apply algebra_norm_map_of_compatible (polynomialQuotientCoefficientMap F)
    base extended _ x
  intro i
  dsimp only [base, extended]
  rw [Basis.reindex_apply, PowerBasis.basis_eq_pow, PowerBasis.basis_eq_pow,
    map_pow, AdjoinRoot.powerBasis_gen, AdjoinRoot.powerBasis_gen,
    polynomialQuotientCoefficientMap_root]
  rfl

end PolynomialQuotient

end Litt3.CartierAndSpin
