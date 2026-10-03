import Solutions.Deformations.FiniteProjectiveCharacters
import Solutions.Deformations.ElementaryPrimeHomogeneousNormalLift
import Solutions.Deformations.PrimeWeightedPolynomialOrigin
import Solutions.Deformations.WeightedRootHomogeneousOrigin

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

noncomputable def primeHomogeneousCharacterLinear (psi : ZMod p →+* k)
    (r d : ℕ) (nonzero : d % (p - 1) ≠ 0) :
    weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d →ₗ[k]
      finiteProjectiveCharacterSpace (ZMod p) k (Fin r → ZMod p) psi d where
  toFun x := ⟨primeWeightedPolynomialFunction p k psi r x.val, by
    constructor
    · have origin := weighted_root_homogeneous_origin_zero k p
        (Fact.out : p.Prime).one_lt r d nonzero x.val x.property
      rw [prime_weighted_polynomial_function_origin, origin]
      simp
    · intro u v
      exact prime_weighted_homogeneous_function_character p k psi r d x.val x.property u v⟩
  map_add' x y := by
    apply Subtype.ext
    exact (primeWeightedPolynomialFunction p k psi r).map_add x.val y.val
  map_smul' c x := by
    apply Subtype.ext
    exact (primeWeightedPolynomialFunctionLinear p k psi r).map_smul c x.val

/-- The entire actual homogeneous component in each sufficiently large
nontrivial character is precisely the scalar-character function space.
The inverse is constructed on the unchanged original normal coordinates. -/
theorem prime_homogeneous_character_bijective (psi : ZMod p →+* k)
    (r d : ℕ) (sourceBound : (p - 1) * r - 1 ≤ d)
    (nonzero : d % (p - 1) ≠ 0) :
    Function.Bijective (primeHomogeneousCharacterLinear p k psi r d nonzero) := by
  classical
  constructor
  · intro x y equal
    have same : primeWeightedPolynomialFunction p k psi r x.val =
        primeWeightedPolynomialFunction p k psi r y.val := congrArg Subtype.val equal
    apply Subtype.ext
    apply sub_eq_zero.mp
    apply prime_weighted_homogeneous_function_zero p k psi r d (x.val - y.val)
      (Submodule.sub_mem _ x.property y.property)
    rw [map_sub, same, sub_self]
  · intro f
    let coordinates := primeNormalFunctionCoordinates (I := Fin r) p k psi
    let c := coordinates.symm f.val
    have reconstruction : coordinates c = f.val := coordinates.apply_symm_apply f.val
    have support : ∀ alpha : Fin r → Fin p, c alpha ≠ 0 →
        (∑ i, (alpha i).val) ≤ d ∧ (∑ i, (alpha i).val) % (p - 1) = d % (p - 1) := by
      intro alpha coefficient
      have congruence : (∑ i, (alpha i).val) % (p - 1) = d % (p - 1) := by
        apply prime_normal_character_support p k psi c d
        · intro u v
          rw [reconstruction]
          exact f.property.2 u v
        · exact coefficient
      have upper : (∑ i, (alpha i).val) ≤ (p - 1) * r := by
        calc
          _ ≤ ∑ _ : Fin r, (p - 1) := Finset.sum_le_sum (fun i _ => by
            have := (alpha i).isLt; omega)
          _ = _ := by simp [Nat.mul_comm]
      have notTop : (∑ i, (alpha i).val) ≠ (p - 1) * r := by
        intro equality
        apply nonzero
        rw [← congruence, equality, Nat.mul_mod_right]
      exact ⟨by omega, congruence⟩
    let X := elementaryPrimeHomogeneousNormalLift p k r d c
    have member : X ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d :=
      elementary_prime_homogeneous_normal_lift_member p k r d c support
    refine ⟨⟨X, member⟩, ?_⟩
    apply Subtype.ext
    funext v
    exact (elementary_prime_homogeneous_normal_lift_evaluation p k psi r d c v).trans
      (congrFun reconstruction v)

noncomputable def primeHomogeneousProjectiveEquiv (psi : ZMod p →+* k)
    (r d : ℕ) (sourceBound : (p - 1) * r - 1 ≤ d)
    (nonzero : d % (p - 1) ≠ 0) :
    weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d ≃ₗ[k]
      (ℙ (ZMod p) (Fin r → ZMod p) → k) :=
  (LinearEquiv.ofBijective (primeHomogeneousCharacterLinear p k psi r d nonzero)
    (prime_homogeneous_character_bijective p k psi r d sourceBound nonzero)).trans
      (finiteProjectiveCharacterEquiv (ZMod p) k (Fin r → ZMod p) psi d)

/-- The exact projective dimension of each actual sufficiently large
nontrivial homogeneous character, uniformly in the original prime/rank. -/
theorem prime_homogeneous_projective_finrank (psi : ZMod p →+* k)
    (r d : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]
    (sourceBound : (p - 1) * r - 1 ≤ d) (nonzero : d % (p - 1) ≠ 0) :
    Module.finrank k (weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d) =
      (p ^ r - 1) / (p - 1) := by
  have dimension := (primeHomogeneousProjectiveEquiv p k psi r d sourceBound nonzero).finrank_eq
  rw [Module.finrank_fintype_fun_eq_card] at dimension
  have card : Fintype.card (ℙ (ZMod p) (Fin r → ZMod p)) = (p ^ r - 1) / (p - 1) := by
    simpa [Nat.card_eq_fintype_card, Fintype.card_fun, ZMod.card] using
      (Projectivization.card'' (ZMod p) (Fin r → ZMod p))
  exact dimension.trans card

end Litt3.Deformations
