import Definitions.CartierAndSpin.QuotientResidueFunctional
import Mathlib.LinearAlgebra.Matrix.Block
import Mathlib.LinearAlgebra.Dual.Basis
import Mathlib.Data.Fin.Rev
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

/-- The true residue Gram matrix, with the test powers reversed. -/
noncomputable def quotientResidueReversedMatrix {D : R[X]} (hD : D.Monic) :
    Matrix (Fin D.natDegree) (Fin D.natDegree) R :=
  fun i j => quotientResidueFunctional hD
    (AdjoinRoot.root D ^ (j : ℕ) * AdjoinRoot.root D ^ (i.rev : ℕ))

theorem quotient_residue_functional_power {D : R[X]} (hD : D.Monic) (m : ℕ) :
    quotientResidueFunctional hD (AdjoinRoot.root D ^ m) =
      (X ^ m %ₘ D).coeff (D.natDegree - 1) := by
  rw [← AdjoinRoot.mk_X, ← map_pow]
  rfl

/-- The reversed matrix is triangular over every commutative ring;
zero divisors, repeated roots and nilpotents are all allowed. -/
theorem quotient_residue_reversed_matrix_triangular {D : R[X]} (hD : D.Monic) :
    (quotientResidueReversedMatrix hD).BlockTriangular id := by
  classical
  intro i j hij
  nontriviality R
  change j < i at hij
  have hexp : (j : ℕ) + (i.rev : ℕ) < D.natDegree - 1 := by
    simp only [Fin.rev] at *
    omega
  have hsmall : (X ^ ((j : ℕ) + (i.rev : ℕ)) : R[X]).degree < D.degree := by
    rw [degree_X_pow, degree_eq_natDegree hD.ne_zero]
    exact_mod_cast (show (j : ℕ) + (i.rev : ℕ) < D.natDegree by omega)
  change quotientResidueFunctional hD
    (AdjoinRoot.root D ^ (j : ℕ) * AdjoinRoot.root D ^ (i.rev : ℕ)) = 0
  rw [← pow_add, quotient_residue_functional_power,
    (modByMonic_eq_self_iff hD).mpr hsmall, coeff_X_pow]
  simp only [if_neg (show D.natDegree - 1 ≠ (j : ℕ) + (i.rev : ℕ) by omega)]

/-- Every diagonal entry is literally one, including over rings with
zero divisors. -/
theorem quotient_residue_reversed_matrix_diagonal {D : R[X]} (hD : D.Monic)
    (i : Fin D.natDegree) : quotientResidueReversedMatrix hD i i = 1 := by
  classical
  nontriviality R
  have hexp : (i : ℕ) + (i.rev : ℕ) = D.natDegree - 1 := by
    simp only [Fin.rev]
    omega
  have hsmall : (X ^ (D.natDegree - 1) : R[X]).degree < D.degree := by
    rw [degree_X_pow, degree_eq_natDegree hD.ne_zero]
    exact_mod_cast (show D.natDegree - 1 < D.natDegree by omega)
  change quotientResidueFunctional hD
    (AdjoinRoot.root D ^ (i : ℕ) * AdjoinRoot.root D ^ (i.rev : ℕ)) = 1
  rw [← pow_add, hexp, quotient_residue_functional_power,
    (modByMonic_eq_self_iff hD).mpr hsmall, coeff_X_pow]
  simp

/-- Universal unimodularity of the actual monic quotient residue pairing.
No separability, characteristic or integral-domain premise is needed. -/
theorem quotient_residue_reversed_matrix_det {D : R[X]} (hD : D.Monic) :
    (quotientResidueReversedMatrix hD).det = 1 := by
  classical
  rw [Matrix.det_of_upperTriangular (quotient_residue_reversed_matrix_triangular hD)]
  simp only [quotient_residue_reversed_matrix_diagonal, Finset.prod_const_one]

end Litt3.CartierAndSpin
