import Solutions.Deformations.ElementaryNormalWeights
import Solutions.Deformations.ElementaryNormMonomial
import Solutions.Deformations.GroupCoefficientMaps

namespace Litt3.Deformations

open scoped BigOperators

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S] [CharP S 5]

theorem elementary_normal_maximal_exponents (r : ℕ) (alpha : Fin r → Fin 5)
    (high : 4 * r ≤ ∑ i, (alpha i).val) : ∀ i, (alpha i).val = 4 := by
  classical
  intro i
  by_contra different
  have bounds : ∀ j : Fin r, (alpha j).val ≤ 4 := fun j => by have := (alpha j).isLt; omega
  have strict : (alpha i).val < 4 := by have := bounds i; omega
  have sumStrict := Finset.sum_lt_sum (s := Finset.univ)
    (f := fun j : Fin r => (alpha j).val) (g := fun _ => 4)
    (fun j _ => bounds j) ⟨i, Finset.mem_univ i, strict⟩
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul] at sumStrict
  omega

/-- Every actual reduced element of weight 4r lies on the literal full
norm line. The proof reduces actual normal-basis generators. -/
theorem elementary_weighted_reduction_mem_norm (φ : R →+* S) (r : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod 5))
    (member : x ∈ weightedGeneratorFiltration R
      (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
      (elementaryAugmentationParameter (R := R) 5 r) (4 * r)) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5) φ x ∈
      Submodule.span S {∑ g : Fin r → ZMod 5, AddMonoidAlgebra.single g (1 : S)} := by
  classical
  rw [← elementary_five_normal_weights_eq] at member
  let map := groupCoefficientLinear (G := Fin r → ZMod 5) φ
  change map x ∈ _
  induction member using Submodule.span_induction with
  | mem x member =>
    obtain ⟨j, alpha, bound, rfl⟩ := member
    rw [map_smulₛₗ]
    change φ ((5 : R) ^ j) •
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5) φ
        (elementaryAugmentationBasis (R := R) 5 (by omega) r alpha) ∈ _
    rw [group_coefficient_map_augmentation_basis, map_pow, map_ofNat]
    have fiveZero : (5 : S) = 0 := by exact_mod_cast CharP.cast_eq_zero S 5
    by_cases initial : j = 0
    · subst j
      simp only [pow_zero, one_smul] at *
      have top := elementary_normal_maximal_exponents r alpha (by simpa using bound)
      rw [elementary_augmentation_basis_apply]
      simp_rw [top]
      rw [elementary_top_monomial_is_norm]
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
theorem elementary_weighted_reduction_norm_iff (φ : R →+* S)
    (onto : Function.Surjective φ) (r : ℕ)
    (y : AddMonoidAlgebra S (Fin r → ZMod 5)) :
    (∃ x : AddMonoidAlgebra R (Fin r → ZMod 5),
      x ∈ weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r) (4 * r) ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5) φ x = y) ↔
    ∃ c : S, y = c • ∑ g : Fin r → ZMod 5, AddMonoidAlgebra.single g (1 : S) := by
  constructor
  · rintro ⟨x, member, rfl⟩
    obtain ⟨c, equality⟩ := Submodule.mem_span_singleton.mp
      (elementary_weighted_reduction_mem_norm φ r x member)
    exact ⟨c, equality.symm⟩
  · rintro ⟨c, rfl⟩
    obtain ⟨b, rfl⟩ := onto c
    let alpha : Fin r → Fin 5 := fun _ => ⟨4, by omega⟩
    let x := b • elementaryAugmentationBasis (R := R) 5 (by omega) r alpha
    refine ⟨x, ?_, ?_⟩
    · rw [← elementary_five_normal_weights_eq]
      apply Submodule.smul_mem
      have generator : elementaryAugmentationBasis (R := R) 5 (by omega) r alpha ∈
          elementaryNormalWeightFiltration R 5 (by omega) r (4 * r) := by
        apply Submodule.subset_span
        refine ⟨0, alpha, ?_, ?_⟩
        · simp [alpha, mul_comm]
        · simp
      exact generator
    · change groupCoefficientLinear (G := Fin r → ZMod 5) φ
        (b • elementaryAugmentationBasis (R := R) 5 (by omega) r alpha) = _
      rw [map_smulₛₗ, group_coefficient_linear_apply, group_coefficient_map_augmentation_basis,
        elementary_augmentation_basis_apply]
      simp only [alpha]
      rw [elementary_top_monomial_is_norm]

end Litt3.Deformations
