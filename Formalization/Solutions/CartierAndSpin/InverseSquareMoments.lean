import Definitions.CartierAndSpin.InverseSquareMoments
import Solutions.CartierAndSpin.SplitResidues
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FieldSimp

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K ι : Type*} [Field K]

/-- The exact polynomial identity behind inverse-square interpolation.
It is proved before evaluation at roots, so the two divisions are concrete
polynomial identities and no residue theorem is assumed. -/
theorem inverseSquareResidueNumerator_identity (j : ℕ) (tau : K)
    (F phi H J S A B : K[X]) (htau : tau ≠ 0)
    (hsource : F = phi * H + C tau) (hphi : phi.derivative = 0)
    (hH : H = phi * J + S) (hdivision : X ^ j * S.derivative = phi * A + B) :
    phi * inverseSquareResidueNumerator j tau J A B H - X ^ j * H.derivative =
      -C tau⁻¹ * B * F := by
  have hHprime : H.derivative = phi * J.derivative + S.derivative := by
    rw [hH, Polynomial.derivative_add, Polynomial.derivative_mul, hphi,
      zero_mul, zero_add]
  have hCinv : C tau⁻¹ * C tau = (1 : K[X]) := by
    rw [← map_mul]
    simp [htau]
  rw [inverseSquareResidueNumerator, hHprime]
  linear_combination -hdivision + C tau⁻¹ * B * hsource + B * hCinv

/-- The inverse-square root sum is the residue-weight sum of an actual
polynomial numerator. Every denominator is certified nonzero from the
complete simple-root factorization. -/
theorem split_inverseSquare_moment_eq_residue_sum (s : Finset ι) (node : ι → K)
    (hinj : Set.InjOn node s) (j : ℕ) (tau c : K)
    (F phi H J S A B : K[X]) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = phi * H + C tau) (hphi : phi.derivative = 0)
    (hH : H = phi * J + S) (hdivision : X ^ j * S.derivative = phi * A + B) :
    (∑ i ∈ s, (node i) ^ j / phi.eval (node i) ^ 2) =
      splitPolynomialResidueSum s node
        (inverseSquareResidueNumerator j tau J A B H) F := by
  classical
  unfold splitPolynomialResidueSum
  apply sum_congr rfl
  intro i hi
  have hFzero : F.eval (node i) = 0 := by
    rw [hFsplit, Polynomial.eval_mul, Polynomial.eval_C,
      Lagrange.eval_nodal_at_node hi, mul_zero]
  have hFderivative : F.derivative = phi * H.derivative := by
    rw [hsource, Polynomial.derivative_add, Polynomial.derivative_mul,
      Polynomial.derivative_C, hphi, zero_mul, zero_add, add_zero]
  have hnonzero : F.derivative.eval (node i) ≠ 0 := by
    rw [hFsplit]
    simp only [Polynomial.derivative_mul, Polynomial.derivative_C, zero_mul, zero_add,
      Polynomial.eval_mul, Polynomial.eval_C]
    exact mul_ne_zero hc (derivative_nodal_eval_ne_zero s node hinj i hi)
  rw [hFderivative, Polynomial.eval_mul] at hnonzero
  obtain ⟨hphi_nonzero, hHprime_nonzero⟩ := mul_ne_zero_iff.mp hnonzero
  have hid := congrArg (fun P : K[X] => P.eval (node i))
    (inverseSquareResidueNumerator_identity j tau F phi H J S A B htau
      hsource hphi hH hdivision)
  simp only [Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_pow,
    Polynomial.eval_X, Polynomial.eval_neg, Polynomial.eval_C, hFzero,
    mul_zero, sub_eq_zero] at hid
  rw [hFderivative, Polynomial.eval_mul]
  field_simp
  exact hid.symm

/-- Polynomial reduction by X^p+q cannot change coefficient p-1 below
degree 2p-1. This controls the auxiliary polar coefficient symbolically. -/
theorem coeff_mod_inseparableFactor_top (P : K[X]) (p : ℕ) (q : K)
    (hp : 2 ≤ p) (hdegree : P.natDegree < 2 * p - 1) :
    (P %ₘ (X ^ p + C q)).coeff (p - 1) = P.coeff (p - 1) := by
  have hmonic : (X ^ p + C q : K[X]).Monic :=
    Polynomial.monic_X_pow_add_C q (by omega)
  have hquot_degree : (P /ₘ (X ^ p + C q)).natDegree < p - 1 := by
    rw [Polynomial.natDegree_divByMonic P hmonic, Polynomial.natDegree_X_pow_add_C]
    omega
  have hquot_coeff : (P /ₘ (X ^ p + C q)).coeff (p - 1) = 0 :=
    Polynomial.coeff_eq_zero_of_natDegree_lt hquot_degree
  have hproduct_coeff : ((X ^ p + C q) * (P /ₘ (X ^ p + C q))).coeff (p - 1) = 0 := by
    rw [add_mul, Polynomial.coeff_add, Polynomial.coeff_X_pow_mul',
      if_neg (by omega), Polynomial.coeff_C_mul, hquot_coeff, mul_zero, add_zero]
  have h := congrArg (fun Q : K[X] => Q.coeff (p - 1))
    (Polynomial.modByMonic_add_div P hmonic)
  simpa only [Polynomial.coeff_add, hproduct_coeff, add_zero] using h

/-- The characteristic-p polar coefficient is exactly -j*s_(p-j), without
an auxiliary purely inseparable extension or a Taylor-residue assumption. -/
theorem inverseSquare_polar_coefficient (S : K[X]) (p : ℕ) [CharP K p]
    (q : K) (hp : 2 ≤ p) (hS : S.natDegree < p) (j : ℕ) (hj : j < p) :
    ((X ^ j * S.derivative) %ₘ (X ^ p + C q)).coeff (p - 1) =
      -(j : K) * S.coeff (p - j) := by
  have hdegree : (X ^ j * S.derivative).natDegree < 2 * p - 1 := by
    have hmul : (X ^ j * S.derivative).natDegree ≤
        (X ^ j : K[X]).natDegree + S.derivative.natDegree := Polynomial.natDegree_mul_le
    have hderivative := Polynomial.natDegree_derivative_le S
    rw [Polynomial.natDegree_X_pow] at hmul
    omega
  rw [coeff_mod_inseparableFactor_top (X ^ j * S.derivative) p q hp hdegree,
    Polynomial.coeff_X_pow_mul', if_pos (by omega), Polynomial.coeff_derivative]
  have hindex : p - 1 - j + 1 = p - j := by omega
  have hcast : ((p - 1 - j : ℕ) : K) + 1 = -(j : K) := by
    calc
      _ = ((p - 1 - j + 1 : ℕ) : K) := by simp only [Nat.cast_add, Nat.cast_one]
      _ = ((p - j : ℕ) : K) := by rw [hindex]
      _ = -(j : K) := by rw [Nat.cast_sub hj.le, CharP.cast_eq_zero, zero_sub]
  rw [hindex, hcast]
  ring

theorem source_degree_and_leadingCoefficient (F H : K[X]) (p : ℕ) (q tau : K)
    (hp : 0 < p) (hH : H ≠ 0) (hsource : F = (X ^ p + C q) * H + C tau) :
    F.natDegree = p + H.natDegree ∧ F.leadingCoeff = H.leadingCoeff := by
  have hmonic : (X ^ p + C q : K[X]).Monic := Polynomial.monic_X_pow_add_C q hp.ne'
  have hproduct : 0 < ((X ^ p + C q) * H).degree := by
    rw [Polynomial.degree_mul, Polynomial.degree_X_pow_add_C hp,
      Polynomial.degree_eq_natDegree hH]
    exact_mod_cast (show 0 < p + H.natDegree by omega)
  constructor
  · rw [hsource, Polynomial.natDegree_add_C, Polynomial.natDegree_mul hmonic.ne_zero hH,
      Polynomial.natDegree_X_pow_add_C]
  · rw [hsource, Polynomial.leadingCoeff_add_of_degree_lt'
      (Polynomial.degree_C_le.trans_lt hproduct), Polynomial.leadingCoeff_mul,
      hmonic.leadingCoeff, one_mul]

/-- All inverse-square coefficient moments for the actual split source,
with arbitrary source degree. The quotient/remainder definitions are actual
polynomial division, and the numerator degree bounds are proved internally. -/
theorem split_inseparable_source_inverseSquare_moment (s : Finset ι) (node : ι → K)
    (hinj : Set.InjOn node s) (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau c : K) (hp : 2 ≤ p) (hH : H ≠ 0) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) (j : ℕ) (hj : j < p) :
    (∑ i ∈ s, (node i) ^ j / ((node i) ^ p + q) ^ 2) =
      (j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau := by
  classical
  let phi : K[X] := X ^ p + C q
  let J := H /ₘ phi
  let S := H %ₘ phi
  let A := (X ^ j * S.derivative) /ₘ phi
  let B := (X ^ j * S.derivative) %ₘ phi
  let P := inverseSquareResidueNumerator j tau J A B H
  have hp' : 0 < p := by omega
  have hmonic : phi.Monic := Polynomial.monic_X_pow_add_C q hp'.ne'
  have hphi_degree : phi.natDegree = p := Polynomial.natDegree_X_pow_add_C
  have hphi_not_one : phi ≠ 1 := by
    intro hequal
    have h := congrArg Polynomial.natDegree hequal
    rw [hphi_degree, Polynomial.natDegree_one] at h
    omega
  have hSdegree : S.natDegree < p := by
    have h := Polynomial.natDegree_modByMonic_lt H hmonic hphi_not_one
    rwa [hphi_degree] at h
  have hBdegree : B.natDegree < p := by
    have h := Polynomial.natDegree_modByMonic_lt (X ^ j * S.derivative) hmonic hphi_not_one
    rwa [hphi_degree] at h
  have hDdegree : (X ^ j * S.derivative).natDegree < 2 * p - 1 := by
    have hmul : (X ^ j * S.derivative).natDegree ≤ j + S.derivative.natDegree := by
      simpa only [Polynomial.natDegree_X_pow] using
        (Polynomial.natDegree_mul_le (p := (X ^ j : K[X])) (q := S.derivative))
    have hderivative := Polynomial.natDegree_derivative_le S
    omega
  have hAdegree : A.natDegree < p - 1 := by
    have h := Polynomial.natDegree_divByMonic (X ^ j * S.derivative) hmonic
    change A.natDegree = _ at h
    rw [hphi_degree] at h
    omega
  have hJdegree : J.natDegree ≤ H.natDegree := by
    change (H /ₘ phi).natDegree ≤ H.natDegree
    rw [Polynomial.natDegree_divByMonic H hmonic]
    exact Nat.sub_le _ _
  have hXJdegree : (X ^ j * J.derivative).natDegree < p + H.natDegree - 1 := by
    by_cases hHzero : H.natDegree = 0
    · have hJzero : J.natDegree = 0 := Nat.eq_zero_of_le_zero (hHzero ▸ hJdegree)
      rw [Polynomial.derivative_of_natDegree_zero hJzero, mul_zero, Polynomial.natDegree_zero]
      omega
    · have hmul : (X ^ j * J.derivative).natDegree ≤ j + J.derivative.natDegree := by
        simpa only [Polynomial.natDegree_X_pow] using
          (Polynomial.natDegree_mul_le (p := (X ^ j : K[X])) (q := J.derivative))
      have hderivative := Polynomial.natDegree_derivative_le J
      omega
  have hFdata := source_degree_and_leadingCoefficient F H p q tau hp' hH hsource
  have hcard : s.card = p + H.natDegree := by
    have hnat : F.natDegree = s.card := by
      rw [hFsplit, Polynomial.natDegree_C_mul hc, Lagrange.natDegree_nodal]
    omega
  have hleading : H.leadingCoeff = c := by
    rw [← hFdata.2, hFsplit, Polynomial.leadingCoeff_mul, Polynomial.leadingCoeff_C,
      Lagrange.nodal_monic.leadingCoeff, mul_one]
  have hAcoeff : A.coeff (s.card - 1) = 0 :=
    Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)
  have hXJcoeff : (X ^ j * J.derivative).coeff (s.card - 1) = 0 :=
    Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)
  have hBHcoeff : (B * H).coeff (s.card - 1) = B.coeff (p - 1) * c := by
    have hindex : s.card - 1 = (p - 1) + H.natDegree := by omega
    rw [hindex, Polynomial.coeff_mul_add_eq_of_natDegree_le (by omega) le_rfl,
      Polynomial.coeff_natDegree, hleading]
  have hPcoeff : P.coeff (s.card - 1) = -tau⁻¹ * B.coeff (p - 1) * c := by
    simp only [P, inverseSquareResidueNumerator, Polynomial.coeff_sub,
      Polynomial.coeff_add, hAcoeff, hXJcoeff, zero_add, zero_sub,
      mul_assoc, Polynomial.coeff_C_mul, hBHcoeff]
    ring
  have hPdegree : P.natDegree < s.card := by
    have hBH : (B * H).natDegree ≤ B.natDegree + H.natDegree := Polynomial.natDegree_mul_le
    have hterm : (C tau⁻¹ * B * H).natDegree ≤ (B * H).natDegree := by
      rw [mul_assoc]
      exact Polynomial.natDegree_C_mul_le _ _
    have hsum : (A + X ^ j * J.derivative).natDegree ≤
      max A.natDegree (X ^ j * J.derivative).natDegree := Polynomial.natDegree_add_le _ _
    have hsub : P.natDegree ≤ max (A + X ^ j * J.derivative).natDegree
      (C tau⁻¹ * B * H).natDegree := Polynomial.natDegree_sub_le _ _
    omega
  have hHdivision : H = phi * J + S := by
    have h := Polynomial.modByMonic_add_div H hmonic
    change S + phi * J = H at h
    exact h.symm.trans (add_comm _ _)
  have hdivision : X ^ j * S.derivative = phi * A + B := by
    have h := Polynomial.modByMonic_add_div (X ^ j * S.derivative) hmonic
    change B + phi * A = X ^ j * S.derivative at h
    exact h.symm.trans (add_comm _ _)
  have hsum := split_inverseSquare_moment_eq_residue_sum s node hinj j tau c
    F phi H J S A B htau hc hFsplit hsource
    (inseparableSourceFactor_derivative p q) hHdivision hdivision
  have hPdegree' : P.degree < ↑s.card :=
    (Polynomial.degree_le_natDegree).trans_lt (by exact_mod_cast hPdegree)
  rw [hFsplit, splitPolynomialResidueSum_scale,
    splitPolynomialResidueSum_nodal_eq_coefficient s node P hinj hPdegree', hPcoeff] at hsum
  have hBcoeff := inverseSquare_polar_coefficient S p q hp hSdegree j hj
  change B.coeff (p - 1) = _ at hBcoeff
  rw [hBcoeff] at hsum
  have hscalar : c⁻¹ * (-tau⁻¹ * (-(j : K) * S.coeff (p - j)) * c) =
      (j : K) * S.coeff (p - j) / tau := by
    field_simp
  rw [hscalar] at hsum
  simpa only [phi, S, Polynomial.eval_add, Polynomial.eval_pow,
    Polynomial.eval_X, Polynomial.eval_C] using hsum

end Litt3.CartierAndSpin
