import Solutions.Deformations.ElementaryPrimeMixedRelation
import Solutions.Deformations.ElementaryPrimeNormMonomial
import Solutions.Deformations.GroupCoefficientMaps

namespace Litt3.Deformations

open scoped BigOperators

variable (p : ℕ) [Fact p.Prime]
variable {R S : Type*} [CommRing R] [Nontrivial R] [Field S] [CharP S p]

theorem elementary_prime_normal_maximal_exponents (r : ℕ) (alpha : Fin r → Fin p)
    (high : (p - 1) * r ≤ ∑ i, (alpha i).val) : ∀ i, (alpha i).val = (p - 1) := by
  classical
  intro i
  by_contra different
  have bounds : ∀ j : Fin r, (alpha j).val ≤ (p - 1) := fun j => by have := (alpha j).isLt; omega
  have strict : (alpha i).val < (p - 1) := by have := bounds i; omega
  have sumStrict := Finset.sum_lt_sum (s := Finset.univ)
    (f := fun j : Fin r => (alpha j).val) (g := fun _ => (p - 1))
    (fun j _ => bounds j) ⟨i, Finset.mem_univ i, strict⟩
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul] at sumStrict
  rw [Nat.mul_comm r (p - 1)] at sumStrict
  omega

/-- Every actual reduced element of weight 4r lies on the literal full
norm line. The proof reduces actual normal-basis generators. -/
theorem elementary_prime_weighted_reduction_mem_norm (φ : R →+* S) (r : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod p))
    (member : x ∈ weightedGeneratorFiltration R
      (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
      (elementaryAugmentationParameter (R := R) p r) ((p - 1) * r)) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) φ x ∈
      Submodule.span S {∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g (1 : S)} := by
  classical
  rw [← elementary_prime_normal_weights_eq p (Fact.out : p.Prime)] at member
  let map := groupCoefficientLinear (G := Fin r → ZMod p) φ
  change map x ∈ _
  induction member using Submodule.span_induction with
  | mem x member =>
    obtain ⟨j, alpha, bound, rfl⟩ := member
    rw [map_smulₛₗ]
    change φ ((p : R) ^ j) •
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) φ
        (elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r alpha) ∈ _
    rw [group_coefficient_map_augmentation_basis, map_pow, map_natCast]
    have fiveZero : (p : S) = 0 := by exact_mod_cast CharP.cast_eq_zero S p
    by_cases initial : j = 0
    · subst j
      simp only [pow_zero, one_smul] at *
      have top := elementary_prime_normal_maximal_exponents p r alpha (by simpa using bound)
      rw [elementary_augmentation_basis_apply]
      simp_rw [top]
      rw [elementary_prime_top_monomial_is_norm]
      exact Submodule.subset_span (Set.mem_singleton _)
    · rw [fiveZero, zero_pow initial, zero_smul]
      exact Submodule.zero_mem _
  | zero => simpa only [map_zero] using (Submodule.zero_mem _)
  | add x y _ _ hx hy =>
    rw [map_add]
    exact Submodule.add_mem _ hx hy
  | smul c x _ hx =>
    rw [map_smulₛₗ]
    exact Submodule.smul_mem _ _ hx

/-- The actual coefficient reduction of weight 4r is exactly the norm
line, with every coefficient realized when the coefficient map is onto. -/
theorem elementary_prime_weighted_reduction_norm_iff (φ : R →+* S)
    (onto : Function.Surjective φ) (r : ℕ)
    (y : AddMonoidAlgebra S (Fin r → ZMod p)) :
    (∃ x : AddMonoidAlgebra R (Fin r → ZMod p),
      x ∈ weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r) ((p - 1) * r) ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) φ x = y) ↔
    ∃ c : S, y = c • ∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g (1 : S) := by
  constructor
  · rintro ⟨x, member, rfl⟩
    obtain ⟨c, equality⟩ := Submodule.mem_span_singleton.mp
      (elementary_prime_weighted_reduction_mem_norm p φ r x member)
    exact ⟨c, equality.symm⟩
  · rintro ⟨c, rfl⟩
    obtain ⟨b, rfl⟩ := onto c
    let alpha : Fin r → Fin p := fun _ => ⟨p - 1, by
      have := (Fact.out : p.Prime).two_le
      omega⟩
    let x := b • elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r alpha
    refine ⟨x, ?_, ?_⟩
    · rw [← elementary_prime_normal_weights_eq p (Fact.out : p.Prime)]
      apply Submodule.smul_mem
      have generator : elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r alpha ∈
          elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r) := by
        apply Submodule.subset_span
        refine ⟨0, alpha, ?_, ?_⟩
        · simp [alpha, mul_comm]
        · simp
      exact generator
    · change groupCoefficientLinear (G := Fin r → ZMod p) φ
        (b • elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r alpha) = _
      rw [map_smulₛₗ, group_coefficient_linear_apply, group_coefficient_map_augmentation_basis,
        elementary_augmentation_basis_apply]
      simp only [alpha]
      rw [elementary_prime_top_monomial_is_norm]

end Litt3.Deformations
