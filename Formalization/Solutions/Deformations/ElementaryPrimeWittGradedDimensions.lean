import Solutions.Deformations.PrimeHomogeneousProjectiveEquiv
import Solutions.Deformations.ElementaryPrimeWittGradedScalars
import Solutions.Deformations.WeightedRootHomogeneousTruncation
import Solutions.Deformations.WeightedRootStrictTruncation

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization WeightedRootPolynomialScalars ElementaryPrimeGradedScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

/-- Below actual truncation weight, each full literal parameter degree
is genuinely equivalent to its entire untruncated homogeneous component. -/
noncomputable def elementaryPrimeHomogeneousTruncationEquiv
    (r d : ℕ) (small : d < (p - 1) * N) :
    weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d ≃ₗ[k]
      elementaryPrimeTruncatedParameterDegree p N k r d := by
  let T := weightedRootTruncation k p N (Fact.out : 0 < N) r
  let map : weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d →ₗ[k]
      elementaryPrimeTruncatedParameterDegree p N k r d :=
    { toFun := fun X => ⟨T X.val, ⟨X, rfl⟩⟩
      map_add' := fun X Y => Subtype.ext (T.map_add X.val Y.val)
      map_smul' := fun c X => Subtype.ext
        (elementary_prime_parameter_truncation_smul p N k r c X.val) }
  apply LinearEquiv.ofBijective map
  constructor
  · intro X Y equal
    have same : T X.val = T Y.val := congrArg Subtype.val equal
    apply Subtype.ext
    apply sub_eq_zero.mp
    apply weighted_root_homogeneous_strict_truncation_zero k p (Fact.out : p.Prime).one_lt
      r N d (Fact.out : 0 < N) small (X.val - Y.val)
      (Submodule.sub_mem _ X.property Y.property)
    rw [map_sub, same, sub_self]
  · intro z
    have member := z.property
    change ∃ X : weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d,
      T X.val = z.val at member
    obtain ⟨X, image⟩ := member
    exact ⟨X, Subtype.ext image⟩

/-- Exact projective dimension of the genuine original Witt quotient classes. -/
theorem elementary_prime_witt_graded_projective_finrank
    (r d : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]
    (small : d < (p - 1) * N) (sourceBound : (p - 1) * r - 1 ≤ d)
    (nonzero : d % (p - 1) ≠ 0) :
    Module.finrank k (ElementaryPrimeWittGradedClass p N k r d) =
      (p ^ r - 1) / (p - 1) := by
  let equivalence := (elementaryPrimeWittGradedClassLinearEquiv p N k r d).trans
    (elementaryPrimeHomogeneousTruncationEquiv p N k r d small).symm
  exact equivalence.finrank_eq.trans
    (prime_homogeneous_projective_finrank p k (ZMod.castHom (dvd_refl p) k)
      r d sourceBound nonzero)

end Litt3.Deformations
