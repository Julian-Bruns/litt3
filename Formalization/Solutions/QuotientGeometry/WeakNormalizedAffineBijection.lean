import Solutions.QuotientGeometry.WeakNormalizedAutomorphisms

namespace Litt3.QuotientGeometry

theorem affine_laurent_pole_coefficients_injective
    {k : Type*} [Field k] (ζ η b c : k)
    (heq : (HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b : LaurentSeries k) =
      HahnSeries.C η * HahnSeries.single (-1) 1 + HahnSeries.C c) : ζ = η ∧ b = c := by
  have hζ := congrArg (fun f : LaurentSeries k => f.coeff (-1)) heq
  have hb := congrArg (fun f : LaurentSeries k => f.coeff 0) heq
  constructor
  · simpa [HahnSeries.C_apply, HahnSeries.single_mul_single] using hζ
  · simpa [HahnSeries.C_apply, HahnSeries.single_mul_single] using hb

theorem weak_normalized_affine_automorphism_injective
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) :
    Function.Injective (fun z : rootsOfUnity h k × linearizedTranslationGroup p α γ =>
      weakNormalizedAffineAutomorphism p h hh hdiv α γ hα z.1 z.2) := by
  intro z w heq
  have hpole := congrArg (fun σ : WeakNormalizedAutomorphisms p h hh α γ hα =>
    σ.val (HahnSeries.single (-1) 1)) heq
  dsimp only at hpole
  rw [weak_normalized_affine_automorphism_pole, weak_normalized_affine_automorphism_pole] at hpole
  have hcoeff := affine_laurent_pole_coefficients_injective _ _ _ _ hpole
  exact Prod.ext (rootsOfUnity.coe_injective hcoeff.1) (Subtype.ext hcoeff.2)

/-- The literal p*h automorphisms exhaust the entire actual base-field
automorphism group, rather than a proposed subgroup. -/
theorem weak_normalized_affine_automorphism_bijective
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    Function.Bijective (fun z : rootsOfUnity h k × linearizedTranslationGroup p α γ =>
      weakNormalizedAffineAutomorphism p h hh hdiv α γ hα z.1 z.2) := by
  classical
  letI : NeZero h := ⟨hh.ne'⟩
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  have hchar : (h : k) ≠ 0 := by
    rw [ne_eq, CharP.cast_eq_zero_iff k p]
    exact Nat.not_dvd_of_pos_of_lt hh
      (lt_of_le_of_lt (Nat.le_of_dvd (by omega) hdiv) (by omega))
  have hB := linearized_translation_group_card p α γ hα hγ
  have hA := weak_normalized_automorphisms_card p h hh hdiv α γ hα hγ
  letI : Finite (linearizedTranslationGroup p α γ) :=
    Nat.finite_of_card_ne_zero (by rw [hB]; exact (Fact.out : p.Prime).ne_zero)
  letI : Finite (WeakNormalizedAutomorphisms p h hh α γ hα) :=
    Nat.finite_of_card_ne_zero (by rw [hA]; exact Nat.mul_ne_zero (Fact.out : p.Prime).ne_zero hh.ne')
  letI : Fintype (linearizedTranslationGroup p α γ) := Fintype.ofFinite _
  letI : Fintype (WeakNormalizedAutomorphisms p h hh α γ hα) := Fintype.ofFinite _
  apply (Fintype.bijective_iff_injective_and_card _).mpr
  refine ⟨weak_normalized_affine_automorphism_injective p h hh hdiv α γ hα, ?_⟩
  simp only [← Nat.card_eq_fintype_card, Nat.card_prod,
    tame_scalar_group_card h hh hchar, hB, hA, Nat.mul_comm]

theorem weak_normalized_automorphism_pole_injective
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    Function.Injective (fun σ : WeakNormalizedAutomorphisms p h hh α γ hα =>
      σ.val (HahnSeries.single (-1) 1)) := by
  intro σ τ heq
  have hbij := weak_normalized_affine_automorphism_bijective p h hh hdiv α γ hα hγ
  obtain ⟨z, rfl⟩ := hbij.2 σ
  obtain ⟨w, rfl⟩ := hbij.2 τ
  dsimp only at heq
  rw [weak_normalized_affine_automorphism_pole, weak_normalized_affine_automorphism_pole] at heq
  have hcoeff := affine_laurent_pole_coefficients_injective _ _ _ _ heq
  have hzw : z = w := Prod.ext (rootsOfUnity.coe_injective hcoeff.1) (Subtype.ext hcoeff.2)
  rw [hzw]

end Litt3.QuotientGeometry
