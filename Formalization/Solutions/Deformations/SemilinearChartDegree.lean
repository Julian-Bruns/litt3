import Solutions.Deformations.ClosedSignedOperations

namespace Litt3.Deformations

open scoped BigOperators

variable {R S A B I J : Type*} [CommRing R] [CommRing S] [CommRing A] [CommRing B]
  [Algebra R A] [Algebra S B] [Fintype I] [Fintype J]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousConstSMul R A]
  [TopologicalSpace B] [ContinuousAdd B] [ContinuousMul B] [ContinuousConstSMul S B]

/-- A genuine semilinear ring map whose actual original coordinates
have degree one preserves every closed signed chart carry module.
The coefficient homomorphism is explicit, and actual integer primes
are automatically preserved. -/
theorem semilinear_chart_degree_preserves (p w : ℕ) (e : I → A) (f : J → B)
    (coefficient : R →+* S) (map : A →+* B)
    (compatible : ∀ c : R, map (algebraMap R A c) = algebraMap S B (coefficient c))
    (continuousMap : Continuous map)
    (coordinateMember : ∀ i, map (e i) ∈ closedSignedFiltration S (p : B) w f 1)
    (d : ℤ) (x : A) (member : x ∈ closedSignedFiltration R (p : A) w e d) :
    map x ∈ closedSignedFiltration S (p : B) w f d := by
  have monomial (alpha : I → ℕ) : map (generatorMonomial e alpha) ∈
      closedSignedFiltration S (p : B) w f (generatorMonomialWeight alpha : ℤ) := by
    have product := closed_signed_finite_product (R := S) (p : B) w f Finset.univ
      (fun i => map (e i) ^ alpha i) (fun i => (alpha i : ℤ))
      (fun i _ => by
        simpa using closed_signed_power (p : B) w f 1 (map (e i)) (coordinateMember i) (alpha i))
    simpa [generatorMonomial, generatorMonomialWeight, map_prod, map_pow] using product
  have images : Set.MapsTo map (signedGeneratorFiltration R (p : A) w e d : Set A)
      (closedSignedFiltration S (p : B) w f d : Set B) := by
    intro y hy
    induction hy using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨j, alpha, bound, rfl⟩ := hy
      rw [map_mul, map_pow, map_natCast]
      have lowered := closed_signed_prime_power_mul (p : B) w f
        (generatorMonomialWeight alpha : ℤ) j (map (generatorMonomial e alpha)) (monomial alpha)
      exact closed_signed_filtration_monotone (p : B) w f (by omega) lowered
    | zero => simpa using (closedSignedFiltration S (p : B) w f d).zero_mem
    | add y z _ _ iy iz => rw [map_add]; exact Submodule.add_mem _ iy iz
    | smul c y _ induction =>
      rw [Algebra.smul_def, map_mul, compatible, ← Algebra.smul_def]
      exact Submodule.smul_mem _ (coefficient c) induction
  have image := images.closure continuousMap member
  simpa only [closedSignedFiltration, Submodule.topologicalClosure_coe, closure_closure] using image

end Litt3.Deformations
