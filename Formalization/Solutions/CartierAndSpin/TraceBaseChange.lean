import Mathlib.RingTheory.Trace.Basic
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset Module Polynomial

section CompatibleBases

variable {K L A B ι : Type*} [CommRing K] [CommRing L] [Algebra K L]
  [CommRing A] [Algebra K A] [CommRing B] [Algebra L B] [Algebra K B]
  [IsScalarTower K L B] [Fintype ι]

/-- Coordinate extension along an actual algebra map, when its images
of a finite base basis form a basis over the extended scalar ring. -/
theorem basis_repr_map_of_compatible (f : A →ₐ[K] B)
    (base : Basis ι K A) (extended : Basis ι L B)
    (hcompatible : ∀ i, f (base i) = extended i) (x : A) (i : ι) :
    extended.repr (f x) i = algebraMap K L (base.repr x i) := by
  classical
  have hsum : f x = ∑ j, algebraMap K L (base.repr x j) • extended j := by
    rw (occs := [1]) [← base.sum_repr x]
    rw [map_sum]
    apply sum_congr rfl
    intro j hj
    have h := f.toLinearMap.map_smul (base.repr x j) (base j)
    change f (base.repr x j • base j) = base.repr x j • f (base j) at h
    rw [h, hcompatible]
    exact (IsScalarTower.algebraMap_smul L _ _).symm
  rw [hsum]
  exact congrFun (extended.repr_sum_self (fun j => algebraMap K L (base.repr x j))) i

/-- Trace commutes with an actual scalar extension map whose basis is
the scalar extension of a base basis. This includes disconnected algebras. -/
theorem algebra_trace_map_of_compatible (f : A →ₐ[K] B)
    (base : Basis ι K A) (extended : Basis ι L B)
    (hcompatible : ∀ i, f (base i) = extended i) (x : A) :
    Algebra.trace L B (f x) = algebraMap K L (Algebra.trace K A x) := by
  classical
  rw [Algebra.trace_eq_matrix_trace base, Algebra.trace_eq_matrix_trace extended,
    Matrix.trace, Matrix.trace, map_sum]
  apply sum_congr rfl
  intro i hi
  change Algebra.leftMulMatrix extended (f x) i i =
    algebraMap K L (Algebra.leftMulMatrix base x i i)
  rw [Algebra.leftMulMatrix_eq_repr_mul, Algebra.leftMulMatrix_eq_repr_mul,
    ← hcompatible, ← map_mul]
  exact basis_repr_map_of_compatible f base extended hcompatible (x * base i) i

end CompatibleBases

section PolynomialQuotient

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The canonical scalar-extension map between actual polynomial
quotients. No irreducibility or connectedness is assumed. -/
noncomputable def polynomialQuotientCoefficientMap (F : K[X]) :
    AdjoinRoot F →ₐ[K] AdjoinRoot (F.map (algebraMap K L)) :=
  AdjoinRoot.mapAlgHom (Algebra.ofId K L) F (F.map (algebraMap K L)) (dvd_refl _)

theorem polynomialQuotientCoefficientMap_root (F : K[X]) :
    polynomialQuotientCoefficientMap (L := L) F (AdjoinRoot.root F) =
      AdjoinRoot.root (F.map (algebraMap K L)) := by
  simp [polynomialQuotientCoefficientMap]

/-- The trace in K[W]/F is preserved by coefficient extension to L[W]/F.
Separable and irreducible are both unnecessary for this structural fact. -/
theorem polynomial_quotient_trace_coefficient_extension (F : K[X]) (hF : F ≠ 0)
    (x : AdjoinRoot F) :
    Algebra.trace L (AdjoinRoot (F.map (algebraMap K L)))
        (polynomialQuotientCoefficientMap (L := L) F x) =
      algebraMap K L (Algebra.trace K (AdjoinRoot F) x) := by
  classical
  have hmap : F.map (algebraMap K L) ≠ 0 :=
    Polynomial.map_ne_zero hF
  have hdegree : (F.map (algebraMap K L)).natDegree = F.natDegree :=
    Polynomial.natDegree_map_eq_of_injective (algebraMap K L).injective F
  let base := (AdjoinRoot.powerBasis hF).basis
  let extended := ((AdjoinRoot.powerBasis hmap).basis).reindex (finCongr hdegree)
  apply algebra_trace_map_of_compatible (polynomialQuotientCoefficientMap F)
    base extended _ x
  intro i
  dsimp only [base, extended]
  rw [Basis.reindex_apply, PowerBasis.basis_eq_pow, PowerBasis.basis_eq_pow,
    map_pow, AdjoinRoot.powerBasis_gen, AdjoinRoot.powerBasis_gen,
    polynomialQuotientCoefficientMap_root]
  rfl

end PolynomialQuotient

end Litt3.CartierAndSpin
