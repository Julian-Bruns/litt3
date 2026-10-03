import Solutions.Deformations.AdicGeometricInverse

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousMul A] [ContinuousConstSMul R A]

/-- The literal Artin--Schreier Jacobian at any degree-one element
has a constructed actual inverse of degree zero. This uses only the
specified original coefficient unit and actual p-adic completeness. -/
theorem artin_schreier_jacobian_inverse_degree_zero (p : ℕ) (e : I → A)
    [IsAdicComplete (Ideal.span {(p : A)}) A]
    (adic : IsAdic (Ideal.span {(p : A)})) (u : Rˣ) (x : A)
    (member : x ∈ closedSignedFiltration R (p : A) (p - 1) e 1) :
    ∃ y : A, ((p : A) * x ^ (p - 1) - u.val • (1 : A)) * y = 1 ∧
      y ∈ closedSignedFiltration R (p : A) (p - 1) e 0 := by
  let v : A := (p : A) * ((u⁻¹ : Rˣ).val • x ^ (p - 1))
  have primeMember : v ∈ Ideal.span {(p : A)} :=
    Ideal.mul_mem_right _ _ (Ideal.subset_span (Set.mem_singleton _))
  have scaled := (closedSignedFiltration R (p : A) (p - 1) e ((p - 1 : ℕ) : ℤ)).smul_mem
    (u⁻¹ : Rˣ).val (by simpa using closed_signed_power (p : A) (p - 1) e 1 x member (p - 1))
  have degreeMember : v ∈ closedSignedFiltration R (p : A) (p - 1) e 0 := by
    have lowered := closed_signed_prime_power_mul (p : A) (p - 1) e
      ((p - 1 : ℕ) : ℤ) 1 ((u⁻¹ : Rˣ).val • x ^ (p - 1)) scaled
    simpa only [pow_one, Nat.cast_one, mul_one, sub_self] using lowered
  obtain ⟨t, inverse, tMember⟩ := adic_geometric_inverse_degree_zero p (p - 1) e
    adic v primeMember degreeMember
  have unitsProduct : algebraMap R A u.val * algebraMap R A (u⁻¹ : Rˣ).val = 1 := by
    rw [← map_mul]
    simp
  have factor : (p : A) * x ^ (p - 1) - u.val • (1 : A) =
      -algebraMap R A u.val * (1 - v) := by
    simp only [Algebra.smul_def, mul_one]
    dsimp only [v]
    simp only [Algebra.smul_def]
    linear_combination -((p : A) * x ^ (p - 1)) * unitsProduct
  refine ⟨-((u⁻¹ : Rˣ).val • t), ?_, ?_⟩
  · rw [factor, Algebra.smul_def]
    calc
      _ = (algebraMap R A u.val * algebraMap R A (u⁻¹ : Rˣ).val) * ((1 - v) * t) := by ring
      _ = 1 := by rw [unitsProduct, inverse, one_mul]
  · exact Submodule.neg_mem _ (Submodule.smul_mem _ _ tMember)

end Litt3.Deformations
