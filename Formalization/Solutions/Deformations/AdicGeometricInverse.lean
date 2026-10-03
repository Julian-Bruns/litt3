import Solutions.Deformations.AdicContractingFixedPoint
import Solutions.Deformations.AdicApproximationClosed
import Solutions.Deformations.ClosedSignedOperations

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousMul A] [ContinuousConstSMul R A]

/-- Construct the actual geometric inverse in closed degree zero
through the full genuine adic contraction, with coefficient torsion. -/
theorem adic_geometric_inverse_degree_zero (p : ℕ) (w : ℕ) (e : I → A)
    [IsAdicComplete (Ideal.span {(p : A)}) A]
    (adic : IsAdic (Ideal.span {(p : A)}))
    (v : A) (primeMember : v ∈ Ideal.span {(p : A)})
    (degreeMember : v ∈ closedSignedFiltration R (p : A) w e 0) :
    ∃ x : A, (1 - v) * x = 1 ∧ x ∈ closedSignedFiltration R (p : A) w e 0 := by
  let J := Ideal.span {(p : A)}
  let T : A → A := fun x => 1 + v * x
  have improves : ∀ n : ℕ, 0 < n → ∀ x y : A,
      x ≡ y [SMOD (J ^ n)] → T x ≡ T y [SMOD (J ^ (n + 1))] := by
    intro n _ x y congruence
    apply SModEq.sub_mem.mpr
    have product := Ideal.mul_mem_mul primeMember (SModEq.sub_mem.mp congruence)
    rw [← pow_succ'] at product
    convert product using 1
    dsimp only [T]
    ring
  have initial : T 1 ≡ (1 : A) [SMOD J] := by
    apply SModEq.sub_mem.mpr
    simpa [T] using primeMember
  obtain ⟨x, fixed, residue, approximations, unique⟩ :=
    adic_contracting_fixed_point J T improves 1 initial
  have iterationMember (n : ℕ) : T^[n] 1 ∈ closedSignedFiltration R (p : A) w e 0 := by
    induction n with
    | zero => exact closed_signed_initial_one (R := R) (p : A) w e
    | succ n induction =>
      rw [Function.iterate_succ_apply']
      apply Submodule.add_mem _ (closed_signed_initial_one (R := R) (p : A) w e)
      simpa using closed_signed_filtration_multiplicative (p : A) w e 0 0 v _ degreeMember induction
  have member := adic_approximation_mem_closed J adic (fun n => T^[n] 1) x approximations
    (closedSignedFiltration R (p : A) w e 0)
    (Submodule.isClosed_topologicalClosure _) iterationMember
  refine ⟨x, ?_, member⟩
  change 1 + v * x = x at fixed
  linear_combination -fixed

end Litt3.Deformations
