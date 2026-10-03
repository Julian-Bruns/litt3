import Definitions.CurveArithmetic.HyperellipticAffineModels
import Solutions.CurveArithmetic.FiniteAffineInvariant
import Solutions.QuotientGeometry.QuadraticFunctionFields
import Mathlib.FieldTheory.Separable
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

theorem finite_base_polynomial_separable
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L] :
    (Polynomial.X ^ Fintype.card K - Polynomial.X : Polynomial L).Separable := by
  have hcast : (Fintype.card K : L) = 0 := by
    rw [← map_natCast (algebraMap K L), FiniteField.cast_card_eq_zero, map_zero]
  rw [Polynomial.separable_def]
  convert (isCoprime_one_right (x := (Polynomial.X ^ Fintype.card K - Polynomial.X :
    Polynomial L))).neg_right using 1
  rw [Polynomial.derivative_sub, Polynomial.derivative_X_pow, Polynomial.derivative_X,
    hcast, Polynomial.C_0, zero_mul, zero_sub]

theorem finite_branch_polynomial_separable
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    (finiteBranchPolynomial K a).Separable := by
  unfold finiteBranchPolynomial
  apply Polynomial.Separable.mul finite_base_polynomial_separable Polynomial.separable_X_sub_C
  apply IsCoprime.symm
  apply (Irreducible.coprime_iff_not_dvd (Polynomial.irreducible_X_sub_C a)).mpr
  intro hdvd
  have hroot := Polynomial.dvd_iff_isRoot.mp hdvd
  have hpower : a ^ Fintype.card K = a := by
    apply sub_eq_zero.mp
    simpa [Polynomial.IsRoot] using hroot
  exact ha ((finite_field_power_fixed_iff_in_base a).mp hpower)

theorem finite_branch_polynomial_squarefree
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    Squarefree (finiteBranchPolynomial K a) :=
  (finite_branch_polynomial_separable a ha).squarefree

theorem finite_branch_polynomial_degree
    {K L : Type*} [Field K] [Fintype K] [Field L] (a : L) :
    (finiteBranchPolynomial K a).natDegree = Fintype.card K + 1 := by
  unfold finiteBranchPolynomial
  rw [Polynomial.natDegree_mul
    (FiniteField.X_pow_card_sub_X_ne_zero L Fintype.one_lt_card)
    (Polynomial.X_sub_C_ne_zero a),
    FiniteField.X_pow_card_sub_X_natDegree_eq L Fintype.one_lt_card,
    Polynomial.natDegree_X_sub_C]

theorem finite_branch_quadratic_function_polynomial_irreducible
    {K L : Type*} [Field K] [Fintype K] [Field L] [Algebra K L]
    (a : L) (ha : a ∉ Set.range (algebraMap K L)) :
    Irreducible (Litt3.QuotientGeometry.quadraticFunctionPolynomial
      (finiteBranchPolynomial K a)) := by
  apply Litt3.QuotientGeometry.quadratic_function_polynomial_irreducible
    _ (finite_branch_polynomial_squarefree a ha)
  rw [finite_branch_polynomial_degree]
  exact Nat.zero_lt_succ _

end Litt3.CurveArithmetic
