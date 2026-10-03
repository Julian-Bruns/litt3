import Solutions.Deformations.ToricHypersurfaceQuotientRelations

namespace Litt3.Deformations

variable (K : Type*) [CommRing K] (Q R s : ℕ)

theorem toric_hypersurface_monomial_axes (a : Fin 3 →₀ ℕ) :
    MvPolynomial.monomial a (1 : K) =
      MvPolynomial.X 0 ^ a 0 * MvPolynomial.X 1 ^ a 1 * MvPolynomial.X 2 ^ a 2 := by
  have exponents : a = Finsupp.single 0 (a 0) + Finsupp.single 1 (a 1) +
      Finsupp.single 2 (a 2) := by
    ext i; fin_cases i <;> simp
  simp only [MvPolynomial.X_pow_eq_monomial,MvPolynomial.monomial_mul,one_mul]
  exact congrArg (fun b => MvPolynomial.monomial b (1 : K)) exponents

theorem toric_hypersurface_original_relations :
    let m := Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
    m (MvPolynomial.X 0) * m (MvPolynomial.X 1) = m (MvPolynomial.X 2) ^ s ∧
      m (MvPolynomial.X 0) ^ Q = 0 ∧ m (MvPolynomial.X 1) ^ Q = 0 ∧
      m (MvPolynomial.X 2) ^ R = 0 := by
  dsimp
  have member (g : MvPolynomial (Fin 3) K)
      (h : g ∈ ({MvPolynomial.X 0 * MvPolynomial.X 1 - MvPolynomial.X 2 ^ s,
        MvPolynomial.X 0 ^ Q, MvPolynomial.X 1 ^ Q, MvPolynomial.X 2 ^ R} : Set _)) :
      Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s) g=0 :=
    Ideal.Quotient.eq_zero_iff_mem.mpr (Ideal.subset_span h)
  refine ⟨?_,?_,?_,?_⟩
  · apply sub_eq_zero.mp
    simpa only [map_sub,map_mul,map_pow] using member _ (by simp)
  · simpa only [map_pow] using member _ (by simp)
  · simpa only [map_pow] using member _ (by simp)
  · simpa only [map_pow] using member _ (by simp)

/-- Every original monomial reduces using the literal xy=z^s relation. -/
theorem toric_hypersurface_original_monomial_normalization (a : Fin 3 →₀ ℕ) :
    Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s) (MvPolynomial.monomial a 1) =
    Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
      (MvPolynomial.monomial (toricHypersurfaceExponent (toricHypersurfaceNormalize s a)) 1) := by
  let m := Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
  have relation := (toric_hypersurface_original_relations K Q R s).1
  rw [toric_hypersurface_monomial_axes,toric_hypersurface_monomial_axes]
  simp only [map_mul,map_pow,toricHypersurfaceExponent,Finsupp.add_apply,
    Finsupp.single_apply,Fin.reduceEq,ite_true,ite_false,add_zero,zero_add,
    toricHypersurfaceNormalize]
  exact toric_hypersurface_axis_reduction (m (MvPolynomial.X 0))
    (m (MvPolynomial.X 1)) (m (MvPolynomial.X 2)) s relation (a 0) (a 1) (a 2)

/-- Every removed normalized monomial lies in the whole ORIGINAL ideal,
including the extra axis cutoffs forced by the toric relation. -/
theorem toric_hypersurface_removed_original_class (a : ToricHypersurfaceData)
    (axis : a.x=0 ∨ a.y=0) (killed : ¬ toricHypersurfaceSurvives Q R s a) :
    Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
      (MvPolynomial.monomial (toricHypersurfaceExponent a) 1) = 0 := by
  let m := Ideal.Quotient.mk (toricHypersurfaceIdeal K Q R s)
  obtain ⟨relation,hx,hy,hz⟩ := toric_hypersurface_original_relations K Q R s
  rw [toric_hypersurface_monomial_axes]
  simp only [map_mul,map_pow,toricHypersurfaceExponent,Finsupp.add_apply,
    Finsupp.single_apply,Fin.reduceEq,ite_true,ite_false,add_zero,zero_add]
  exact toric_hypersurface_axis_cutoff (m (MvPolynomial.X 0))
    (m (MvPolynomial.X 1)) (m (MvPolynomial.X 2)) Q R s a axis relation hx hy hz killed

end Litt3.Deformations
