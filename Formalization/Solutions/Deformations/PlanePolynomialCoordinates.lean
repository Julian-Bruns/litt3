import Solutions.Deformations.TruncatedMonomialResidue
import Solutions.Deformations.HypersurfaceNormalFormTransport
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Algebra.MvPolynomial.Rename

namespace Litt3.Deformations

open MvPolynomial

variable {R I : Type*} [CommRing R] [DecidableEq I]

/-- Actual linear substitution of one original variable, fixing every
other original variable and every coefficient. -/
noncomputable def planePolynomialShearHom (x y : I) (t : R) :
    MvPolynomial I R →ₐ[R] MvPolynomial I R :=
  aeval (fun i => if i = x then X x + C t * X y else X i)

@[simp] theorem planePolynomialShearHom_X (x y i : I) (t : R) :
    planePolynomialShearHom x y t (X i) =
      if i = x then X x + C t * X y else X i := by
  simp [planePolynomialShearHom]

/-- This is a genuine automorphism of the full original polynomial
algebra; its true inverse is the opposite shear. -/
noncomputable def planePolynomialShear (x y : I) (different : x ≠ y) (t : R) :
    MvPolynomial I R ≃ₐ[R] MvPolynomial I R :=
  AlgEquiv.ofAlgHom (planePolynomialShearHom x y t) (planePolynomialShearHom x y (-t))
    (by
      ext i
      by_cases hi : i = x
      · subst i
        simp [AlgHom.comp_apply, different.symm, map_add, map_mul, planePolynomialShearHom]
      · simp [AlgHom.comp_apply, hi])
    (by
      ext i
      by_cases hi : i = x
      · subst i
        simp [AlgHom.comp_apply, different.symm, map_add, map_mul, planePolynomialShearHom]
      · simp [AlgHom.comp_apply, hi])

@[simp] theorem planePolynomialShear_X (x y i : I) (different : x ≠ y) (t : R) :
    planePolynomialShear x y different t (X i) =
      if i = x then X x + C t * X y else X i := by
  simp [planePolynomialShear, planePolynomialShearHom]

@[simp] theorem planePolynomialShear_symm (x y : I) (different : x ≠ y) (t : R) :
    (planePolynomialShear x y different t).symm = planePolynomialShear x y different (-t) := by
  ext i
  simp [planePolynomialShear, planePolynomialShearHom]

/-- The actual permutation interchanging the two original variables. -/
noncomputable def planePolynomialSwap (x y : I) :
    MvPolynomial I R ≃ₐ[R] MvPolynomial I R :=
  renameEquiv R (Equiv.swap x y)

theorem plane_polynomial_swap_ideal_invariant (q : I → ℕ) (x y : I) (equal : q x = q y) :
    (truncatedMonomialIdeal R I q).map (planePolynomialSwap x y).toRingHom =
      truncatedMonomialIdeal R I q := by
  have hq (i : I) : q (Equiv.swap x y i) = q i := by
    by_cases hx : i = x
    · subst i; simpa using equal.symm
    · by_cases hy : i = y
      · subst i; simpa using equal
      · simp [Equiv.swap_apply_of_ne_of_ne hx hy]
  rw [truncated_monomial_original_variable_generators, Ideal.map_span]
  have himage : (planePolynomialSwap x y).toRingHom ''
      Set.range (fun i => (X i : MvPolynomial I R) ^ q i) =
      Set.range (fun i => (X i : MvPolynomial I R) ^ q i) := by
    ext P
    constructor
    · rintro ⟨_, ⟨i, rfl⟩, rfl⟩
      refine ⟨Equiv.swap x y i, ?_⟩
      simp [planePolynomialSwap, renameEquiv_apply, map_pow, hq]
    · rintro ⟨i, rfl⟩
      refine ⟨(X (Equiv.swap x y i) : MvPolynomial I R) ^ q (Equiv.swap x y i),
        Set.mem_range_self _, ?_⟩
      simp [planePolynomialSwap, renameEquiv_apply, map_pow, hq]
  rw [himage]

variable (p : ℕ) [Fact p.Prime] [CharP R p]

/-- Equal actual Frobenius cutoffs on the two changed variables suffice.
Every other cutoff may be arbitrary and its original variable is fixed. -/
theorem plane_polynomial_shear_ideal_map_le (q : I → ℕ) (n : ℕ)
    (x y : I) (different : x ≠ y) (qx : q x = p ^ n) (qy : q y = p ^ n) (t : R) :
    (truncatedMonomialIdeal R I q).map (planePolynomialShear x y different t).toRingHom ≤
      truncatedMonomialIdeal R I q := by
  rw [Ideal.map_le_iff_le_comap, truncated_monomial_original_variable_generators]
  apply Ideal.span_le.mpr
  rintro _ ⟨i, rfl⟩
  change planePolynomialShear x y different t (X i ^ q i) ∈
    Ideal.span (Set.range (fun j => (X j : MvPolynomial I R) ^ q j))
  rw [← truncated_monomial_original_variable_generators]
  rw [map_pow, planePolynomialShear_X]
  have hx : (X x : MvPolynomial I R) ^ q x ∈ truncatedMonomialIdeal R I q := by
    rw [truncated_monomial_original_variable_generators]
    exact Ideal.subset_span (Set.mem_range_self x)
  have hy : (X y : MvPolynomial I R) ^ q y ∈ truncatedMonomialIdeal R I q := by
    rw [truncated_monomial_original_variable_generators]
    exact Ideal.subset_span (Set.mem_range_self y)
  by_cases hi : i = x
  · subst i
    rw [if_pos rfl, qx, add_pow_char_pow, mul_pow]
    exact (truncatedMonomialIdeal R I q).add_mem (qx ▸ hx)
      ((truncatedMonomialIdeal R I q).mul_mem_left (C t ^ p ^ n) (qy ▸ hy))
  · rw [if_neg hi]
    rw [truncated_monomial_original_variable_generators]
    exact Ideal.subset_span (Set.mem_range_self i)

theorem plane_polynomial_shear_ideal_invariant (q : I → ℕ) (n : ℕ)
    (x y : I) (different : x ≠ y) (qx : q x = p ^ n) (qy : q y = p ^ n) (t : R) :
    (truncatedMonomialIdeal R I q).map (planePolynomialShear x y different t).toRingHom =
      truncatedMonomialIdeal R I q := by
  apply le_antisymm (plane_polynomial_shear_ideal_map_le p q n x y different qx qy t)
  have h := plane_polynomial_shear_ideal_map_le p q n x y different qx qy (-t)
  have hm := Ideal.map_mono (f := (planePolynomialShear x y different t).toRingHom) h
  rw [← planePolynomialShear_symm x y different t] at hm
  rw [Ideal.map_map] at hm
  have hc : (planePolynomialShear x y different t).toRingHom.comp
      (planePolynomialShear x y different t).symm.toRingHom = RingHom.id _ := by
    apply RingHom.ext
    intro a
    exact (planePolynomialShear x y different t).apply_symm_apply a
  rw [hc, Ideal.map_id] at hm
  exact hm

/-- The full arbitrary hypersurface equation is transported, together
with every original variable-power relation. -/
noncomputable def planePolynomialShearHypersurfaceEquiv (q : I → ℕ) (n : ℕ)
    (x y : I) (different : x ≠ y) (qx : q x = p ^ n) (qy : q y = p ^ n) (t : R)
    (P : MvPolynomial I R) :
    (MvPolynomial I R ⧸ (truncatedMonomialIdeal R I q ⊔ Ideal.span ({P} : Set _))) ≃ₐ[R]
      (MvPolynomial I R ⧸ (truncatedMonomialIdeal R I q ⊔
        Ideal.span ({planePolynomialShear x y different t P} : Set _))) :=
  hypersurfaceNormalFormQuotientEquiv R (MvPolynomial I R)
    (truncatedMonomialIdeal R I q) (planePolynomialShear x y different t)
    P (planePolynomialShear x y different t P) 1
    (plane_polynomial_shear_ideal_invariant p q n x y different qx qy t) (by simp)

end Litt3.Deformations
