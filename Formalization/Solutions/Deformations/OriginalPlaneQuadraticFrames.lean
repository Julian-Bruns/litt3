import Solutions.Deformations.PlanePolynomialLinearTransport
import Mathlib.Tactic.FieldSimp

namespace Litt3.Deformations

open MvPolynomial

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- A nonzero ORIGINAL plane quadratic always has an actual selected
square frame. The full polynomial and every lower cutoff are retained. -/
theorem original_plane_quadratic_selected_frame (d : ℕ) (q : Fin (d + 2) → ℕ)
    (n : ℕ) (qx : q 0 = p ^ n) (qy : q 1 = p ^ n)
    (P : MvPolynomial (Fin (d + 2)) K)
    (bound : ∀ a ∈ P.support, 2 ≤ a.degree)
    (nonzero : planePolynomialQuadraticA d P ≠ 0 ∨
      planePolynomialQuadraticB d P ≠ 0 ∨ planePolynomialQuadraticC d P ≠ 0) :
    ∃ e : MvPolynomial (Fin (d + 2)) K ≃ₐ[K] MvPolynomial (Fin (d + 2)) K,
      (truncatedMonomialIdeal K _ q).map e.toRingHom = truncatedMonomialIdeal K _ q ∧
      (∀ i : Fin d, e (X i.succ.succ) = X i.succ.succ) ∧
      (∀ a ∈ (e P).support, 2 ≤ a.degree) ∧
      planePolynomialQuadraticA d (e P) ≠ 0 ∧
      planePolynomialDiscriminant d (e P) = planePolynomialDiscriminant d P := by
  classical
  by_cases ha : planePolynomialQuadraticA d P ≠ 0
  · refine ⟨AlgEquiv.refl, ?_, ?_, bound, ha, rfl⟩
    · change Ideal.map (RingHom.id _) (truncatedMonomialIdeal K _ q) = _
      exact Ideal.map_id (truncatedMonomialIdeal K _ q)
    · intro i; rfl
  · have haz : planePolynomialQuadraticA d P = 0 := not_ne_iff.mp ha
    by_cases hc : planePolynomialQuadraticC d P ≠ 0
    · let e := planePolynomialSwap (R := K) (0 : Fin (d + 2)) 1
      have he := plane_polynomial_swap_linear (R := K) d
      have hs := plane_polynomial_linear_support_bound d (0 : K) 1 1 0 P 2 bound
      have hco := plane_polynomial_linear_quadratic_coefficients d (0 : K) 1 1 0 P
      have hd := plane_polynomial_linear_discriminant d (0 : K) 1 1 0 P
      rw [← he] at hs hco hd
      refine ⟨e, plane_polynomial_swap_ideal_invariant q 0 1 (qx.trans qy.symm), ?_,
        hs, ?_, ?_⟩
      · intro i
        simp [e, planePolynomialSwap, renameEquiv_apply,
          Equiv.swap_apply_of_ne_of_ne, Fin.ext_iff]
      · have hA : planePolynomialQuadraticA d (e P) = planePolynomialQuadraticC d P := by
          simpa only [zero_pow (by decide : 2 ≠ 0), one_pow, mul_zero, zero_mul,
            mul_one, zero_add, add_zero] using hco.1
        exact hA.trans_ne hc
      · simpa using hd
    · have hcz : planePolynomialQuadraticC d P = 0 := not_ne_iff.mp hc
      have hb : planePolynomialQuadraticB d P ≠ 0 := by
        rcases nonzero with h | h | h
        · exact (h haz).elim
        · exact h
        · exact (h hcz).elim
      let e := planePolynomialShear (1 : Fin (d + 2)) 0 (by simp) (1 : K)
      have he := plane_polynomial_y_shear_linear (R := K) d (1 : K)
      have hs := plane_polynomial_linear_support_bound d (1 : K) 0 1 1 P 2 bound
      have hco := plane_polynomial_linear_quadratic_coefficients d (1 : K) 0 1 1 P
      have hd := plane_polynomial_linear_discriminant d (1 : K) 0 1 1 P
      rw [← he] at hs hco hd
      refine ⟨e, plane_polynomial_shear_ideal_invariant p q n 1 0 (by simp) qy qx 1,
        ?_, hs, ?_, ?_⟩
      · intro i
        simp [e, Fin.ext_iff]
      · have hA : planePolynomialQuadraticA d (e P) = planePolynomialQuadraticB d P := by
          simpa only [one_pow, mul_one, haz, hcz, zero_mul, mul_zero,
            zero_add, add_zero] using hco.1
        exact hA.trans_ne hb
      · simpa using hd

/-- The actual square-completing shear clears the ORIGINAL xy
coefficient, without altering the entire higher-order equation. -/
theorem original_plane_quadratic_cleared_frame (two : (2 : K) ≠ 0)
    (d : ℕ) (q : Fin (d + 2) → ℕ) (n : ℕ) (qx : q 0 = p ^ n) (qy : q 1 = p ^ n)
    (P : MvPolynomial (Fin (d + 2)) K)
    (bound : ∀ a ∈ P.support, 2 ≤ a.degree)
    (nonzero : planePolynomialQuadraticA d P ≠ 0 ∨
      planePolynomialQuadraticB d P ≠ 0 ∨ planePolynomialQuadraticC d P ≠ 0) :
    ∃ e : MvPolynomial (Fin (d + 2)) K ≃ₐ[K] MvPolynomial (Fin (d + 2)) K,
      (truncatedMonomialIdeal K _ q).map e.toRingHom = truncatedMonomialIdeal K _ q ∧
      (∀ i : Fin d, e (X i.succ.succ) = X i.succ.succ) ∧
      (∀ a ∈ (e P).support, 2 ≤ a.degree) ∧
      planePolynomialQuadraticA d (e P) ≠ 0 ∧
      planePolynomialQuadraticB d (e P) = 0 ∧
      planePolynomialDiscriminant d (e P) = planePolynomialDiscriminant d P := by
  classical
  obtain ⟨e, hinv, hfix, hs, ha, hd⟩ :=
    original_plane_quadratic_selected_frame K p d q n qx qy P bound nonzero
  let a := planePolynomialQuadraticA d (e P)
  let b := planePolynomialQuadraticB d (e P)
  let t := -b / (2 * a)
  let c := planePolynomialShear (0 : Fin (d + 2)) 1 (by simp) t
  have hc := plane_polynomial_x_shear_linear (R := K) d t
  have hco := plane_polynomial_linear_quadratic_coefficients d (1 : K) t 0 1 (e P)
  have hcs := plane_polynomial_linear_support_bound d (1 : K) t 0 1 (e P) 2 hs
  have hcd := plane_polynomial_linear_discriminant d (1 : K) t 0 1 (e P)
  rw [← hc] at hco hcs hcd
  have hca : planePolynomialQuadraticA d (c (e P)) = a := by
    simpa [a, c] using hco.1
  have hcb : planePolynomialQuadraticB d (c (e P)) = 0 := by
    have hh : planePolynomialQuadraticB d (c (e P)) = 2 * a * t + b := by
      simpa [a, b, c] using hco.2.1
    rw [hh]
    dsimp [t]
    have ha' : a ≠ 0 := ha
    field_simp [two, ha']
    ring
  refine ⟨e.trans c, ?_, ?_, hcs, hca.trans_ne ha, hcb, ?_⟩
  · have hcomp : (e.trans c).toRingHom = c.toRingHom.comp e.toRingHom := rfl
    rw [hcomp, ← Ideal.map_map, hinv]
    exact plane_polynomial_shear_ideal_invariant p q n 0 1 (by simp) qx qy t
  · intro i
    change c (e (X i.succ.succ)) = X i.succ.succ
    rw [hfix]
    simp [c, Fin.ext_iff]
  · have hD : planePolynomialDiscriminant d (c (e P)) = planePolynomialDiscriminant d (e P) := by
      simpa only [mul_one, mul_zero, sub_zero, one_pow, one_mul] using hcd
    exact hD.trans hd

/-- The entire ORIGINAL rank-one plane quadratic is normalized by an
actual invertible coordinate change with all actual power relations. -/
theorem original_plane_quadratic_rank_one_quotient_frame (two : (2 : K) ≠ 0)
    (d : ℕ) (q : Fin (d + 2) → ℕ) (n : ℕ) (qx : q 0 = p ^ n) (qy : q 1 = p ^ n)
    (P : MvPolynomial (Fin (d + 2)) K)
    (bound : ∀ a ∈ P.support, 2 ≤ a.degree)
    (nonzero : P.coeff (Finsupp.single 0 2) ≠ 0 ∨ P.coeff (Finsupp.single 1 2) ≠ 0)
    (rankOne : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) ^ 2 =
      4 * P.coeff (Finsupp.single 0 2) * P.coeff (Finsupp.single 1 2)) :
    ∃ P' : MvPolynomial (Fin (d + 2)) K,
      Nonempty ((MvPolynomial (Fin (d + 2)) K ⧸
        (truncatedMonomialIdeal K _ q ⊔ Ideal.span ({P} : Set _))) ≃ₐ[K]
        (MvPolynomial (Fin (d + 2)) K ⧸
          (truncatedMonomialIdeal K _ q ⊔ Ideal.span ({P'} : Set _)))) ∧
      (∀ a ∈ P'.support, 2 ≤ a.degree) ∧
      P'.coeff (Finsupp.single 0 2) ≠ 0 ∧
      P'.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0 ∧
      P'.coeff (Finsupp.single 1 2) = 0 := by
  have hn : planePolynomialQuadraticA d P ≠ 0 ∨
      planePolynomialQuadraticB d P ≠ 0 ∨ planePolynomialQuadraticC d P ≠ 0 := by
    rcases nonzero with h | h
    · exact Or.inl (by simpa using h)
    · exact Or.inr (Or.inr (by simpa using h))
  obtain ⟨e, hinv, hfix, hs, ha, hb, hd⟩ :=
    original_plane_quadratic_cleared_frame K p two d q n qx qy P bound hn
  have hzero : planePolynomialDiscriminant d P = 0 := by
    simp [planePolynomialDiscriminant, rankOne]
  have hprod : 4 * planePolynomialQuadraticA d (e P) * planePolynomialQuadraticC d (e P) = 0 := by
    rw [hzero] at hd
    unfold planePolynomialDiscriminant at hd
    rw [hb] at hd
    linear_combination -hd
  have four : (4 : K) ≠ 0 := by
    convert mul_ne_zero two two using 1
    norm_num
  have hz : planePolynomialQuadraticC d (e P) = 0 :=
    (mul_eq_zero.mp hprod).resolve_left (mul_ne_zero four ha)
  refine ⟨e P, ⟨hypersurfaceNormalFormQuotientEquiv K _ (truncatedMonomialIdeal K _ q)
    e P (e P) 1 hinv (by simp)⟩, hs, ?_, ?_, ?_⟩
  · simpa using ha
  · simpa using hb
  · simpa using hz

/-- Every ORIGINAL nondegenerate plane quadratic obtains a cleared
selected-square frame, even over a field where the quadratic does not split.
The equivalence transports the FULL original hypersurface quotient. -/
theorem original_plane_quadratic_nondegenerate_quotient_frame (two : (2 : K) ≠ 0)
    (d : ℕ) (q : Fin (d + 2) → ℕ) (n : ℕ) (qx : q 0 = p ^ n) (qy : q 1 = p ^ n)
    (P : MvPolynomial (Fin (d + 2)) K)
    (bound : ∀ a ∈ P.support, 2 ≤ a.degree)
    (nondegenerate : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) ^ 2 -
      4 * P.coeff (Finsupp.single 0 2) * P.coeff (Finsupp.single 1 2) ≠ 0) :
    ∃ P' : MvPolynomial (Fin (d + 2)) K,
      Nonempty ((MvPolynomial (Fin (d + 2)) K ⧸
        (truncatedMonomialIdeal K _ q ⊔ Ideal.span ({P} : Set _))) ≃ₐ[K]
        (MvPolynomial (Fin (d + 2)) K ⧸
          (truncatedMonomialIdeal K _ q ⊔ Ideal.span ({P'} : Set _)))) ∧
      (∀ a ∈ P'.support, 2 ≤ a.degree) ∧
      P'.coeff (Finsupp.single 0 2) ≠ 0 ∧
      P'.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0 ∧
      P'.coeff (Finsupp.single 1 2) ≠ 0 := by
  have hnd : planePolynomialDiscriminant d P ≠ 0 := by
    simpa [planePolynomialDiscriminant] using nondegenerate
  have hn : planePolynomialQuadraticA d P ≠ 0 ∨
      planePolynomialQuadraticB d P ≠ 0 ∨ planePolynomialQuadraticC d P ≠ 0 := by
    by_contra h
    simp only [not_or, not_ne_iff] at h
    apply hnd
    unfold planePolynomialDiscriminant
    rw [h.1, h.2.1, h.2.2]
    simp
  obtain ⟨e, hinv, hfix, hs, ha, hb, hd⟩ :=
    original_plane_quadratic_cleared_frame K p two d q n qx qy P bound hn
  have hz : planePolynomialQuadraticC d (e P) ≠ 0 := by
    intro hc
    apply hnd
    rw [← hd]
    unfold planePolynomialDiscriminant
    rw [hb, hc]
    simp
  refine ⟨e P, ⟨hypersurfaceNormalFormQuotientEquiv K _ (truncatedMonomialIdeal K _ q)
    e P (e P) 1 hinv (by simp)⟩, hs, ?_, ?_, ?_⟩
  · simpa using ha
  · simpa using hb
  · simpa using hz

end Litt3.Deformations
