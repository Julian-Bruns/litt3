import Solutions.Deformations.ToricHypersurfaceProjection

namespace Litt3.Deformations

variable (K : Type*) [CommRing K] (Q R s : ℕ)

theorem toric_hypersurface_projection_generator_mul (positive : 0 < s)
    (g : MvPolynomial (Fin 3) K)
    (member : g ∈ ({MvPolynomial.X 0 * MvPolynomial.X 1 - MvPolynomial.X 2 ^ s,
      MvPolynomial.X 0 ^ Q, MvPolynomial.X 1 ^ Q, MvPolynomial.X 2 ^ R} : Set _))
    (p : MvPolynomial (Fin 3) K) :
    toricHypersurfaceProjection K Q R s (p*g)=0 := by
  classical
  induction p using MvPolynomial.induction_on' with
  | monomial a c =>
      simp only [Set.mem_insert_iff,Set.mem_singleton_iff] at member
      rcases member with rfl | rfl | rfl | rfl
      · rw [mul_sub,MvPolynomial.X_pow_eq_monomial]
        simp only [MvPolynomial.X,
          MvPolynomial.monomial_mul,mul_one,map_sub,
          toric_hypersurface_projection_monomial]
        rw [← add_assoc,toric_hypersurface_normal_vector_relation,sub_self]
      · simpa only [MvPolynomial.X_pow_eq_monomial,MvPolynomial.monomial_mul,
          mul_one,toric_hypersurface_projection_monomial,smul_zero] using
          congrArg (fun v => c • v)
            (toric_hypersurface_normal_vector_cutoff K Q R s positive a 0)
      · simpa only [MvPolynomial.X_pow_eq_monomial,MvPolynomial.monomial_mul,
          mul_one,toric_hypersurface_projection_monomial,smul_zero] using
          congrArg (fun v => c • v)
            (toric_hypersurface_normal_vector_cutoff K Q R s positive a 1)
      · simpa only [MvPolynomial.X_pow_eq_monomial,MvPolynomial.monomial_mul,
          mul_one,toric_hypersurface_projection_monomial,smul_zero] using
          congrArg (fun v => c • v)
            (toric_hypersurface_normal_vector_cutoff K Q R s positive a 2)
  | add p q hp hq => simp only [add_mul,map_add,hp,hq,add_zero]

/-- The projection kills the ENTIRE original ideal, not merely its
displayed generators. Arbitrary polynomial multiples are checked. -/
theorem toric_hypersurface_ideal_le_projection_kernel (positive : 0 < s) :
    (toricHypersurfaceIdeal K Q R s).restrictScalars K ≤
      LinearMap.ker (toricHypersurfaceProjection K Q R s) := by
  intro f member
  change f ∈ Ideal.span _ at member
  have all : ∀ p, toricHypersurfaceProjection K Q R s (p*f)=0 := by
    refine Submodule.span_induction (p := fun f _ =>
      ∀ p, toricHypersurfaceProjection K Q R s (p*f)=0) ?_ ?_ ?_ ?_ member
    · intro g hg p
      exact toric_hypersurface_projection_generator_mul K Q R s positive g hg p
    · intro p; simp
    · intro f g _ _ hf hg p; simp [mul_add,hf p,hg p]
    · intro a f _ hf p
      change toricHypersurfaceProjection K Q R s (p*(a*f))=0
      rw [← mul_assoc]
      exact hf (p*a)
  simpa using all 1

end Litt3.Deformations
