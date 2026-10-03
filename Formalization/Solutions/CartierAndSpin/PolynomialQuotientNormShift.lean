import Solutions.CartierAndSpin.NormBaseChange
import Mathlib.LinearAlgebra.Matrix.Charpoly.Minpoly

namespace Litt3.CartierAndSpin

open Polynomial Matrix

section PowerBasis

variable {R A : Type*} [CommRing R] [Ring A] [Algebra R A]

/-- The actual norm of a translated power-basis generator is the signed
evaluation of its actual minimal polynomial. The algebra may have nilpotents. -/
theorem power_basis_norm_generator_sub_scalar (pb : PowerBasis R A) (c : R) :
    Algebra.norm R (pb.gen - algebraMap R A c) =
      (-1 : R) ^ pb.dim * (minpoly R pb.gen).eval c := by
  classical
  rw [Algebra.norm_eq_matrix_det pb.basis, map_sub,
    (Algebra.leftMulMatrix pb.basis).commutes]
  have hneg : Algebra.leftMulMatrix pb.basis pb.gen -
      algebraMap R (Matrix (Fin pb.dim) (Fin pb.dim) R) c =
      -(Matrix.scalar (Fin pb.dim) c - Algebra.leftMulMatrix pb.basis pb.gen) := by
    change Algebra.leftMulMatrix pb.basis pb.gen - Matrix.scalar (Fin pb.dim) c = _
    simp only [neg_sub]
  rw [hneg, Matrix.det_neg, Fintype.card_fin, ← Matrix.eval_charpoly,
    charpoly_leftMulMatrix]

end PowerBasis

section PolynomialQuotient

variable {K : Type*} [Field K]

/-- The genuine source quotient norm formula for any nonzero polynomial,
without separability or irreducibility, retaining its leading coefficient. -/
theorem polynomial_quotient_norm_root_sub_scalar (F : K[X]) (hF : F ≠ 0) (c : K) :
    Algebra.norm K (AdjoinRoot.root F - algebraMap K (AdjoinRoot F) c) =
      (-1 : K) ^ F.natDegree * (F.eval c * F.leadingCoeff⁻¹) := by
  have h := power_basis_norm_generator_sub_scalar (AdjoinRoot.powerBasis hF) c
  simpa only [AdjoinRoot.powerBasis_gen, AdjoinRoot.powerBasis_dim,
    AdjoinRoot.minpoly_root hF, eval_mul, eval_C] using h

end PolynomialQuotient

end Litt3.CartierAndSpin
