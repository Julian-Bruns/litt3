import Solutions.QuotientGeometry.WeakNormalizedAffineBijection

namespace Litt3.QuotientGeometry

theorem weak_normalized_automorphism_constant
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (α γ : k) (hα : α ≠ 0)
    (σ : WeakNormalizedAutomorphisms p h hh α γ hα) (a : k) :
    σ.val (HahnSeries.C a) = HahnSeries.C a := by
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    exact Nat.mul_pos (Fact.out : p.Prime).pos hh
  have hconstant : weakNormalizedEmbedding p h hh α γ hα (HahnSeries.C a) = HahnSeries.C a :=
    parameter_laurent_map_constant (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg) (constant_polynomial_parameter_injective g hg) a
  rw [← hconstant, σ.property, hconstant]

theorem weak_normalized_affine_antihom
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (x y : WeakAffineSemidirect p h hdiv α γ) :
    weakNormalizedAffineAutomorphism p h hh hdiv α γ hα (x * y).right (x * y).left.toAdd =
      weakNormalizedAffineAutomorphism p h hh hdiv α γ hα y.right y.left.toAdd *
        weakNormalizedAffineAutomorphism p h hh hdiv α γ hα x.right x.left.toAdd := by
  apply weak_normalized_automorphism_pole_injective p h hh hdiv α γ hα hγ
  change (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα (x * y).right
      (x * y).left.toAdd).val (HahnSeries.single (-1) 1) =
    (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα y.right y.left.toAdd).val
      ((weakNormalizedAffineAutomorphism p h hh hdiv α γ hα x.right x.left.toAdd).val
        (HahnSeries.single (-1) 1))
  rw [weak_normalized_affine_automorphism_pole, weak_normalized_affine_automorphism_pole,
    map_add, map_mul, weak_normalized_automorphism_constant,
    weak_normalized_automorphism_constant, weak_normalized_affine_automorphism_pole]
  change HahnSeries.C ((x.right.val : k) * (y.right.val : k)) *
      HahnSeries.single (-1) 1 +
      HahnSeries.C (x.left.toAdd.val + (x.right.val : k) * y.left.toAdd.val) = _
  rw [map_mul, map_add, map_mul]
  ring

noncomputable def weakNormalizedSemidirectHom
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    WeakAffineSemidirect p h hdiv α γ →* WeakNormalizedAutomorphisms p h hh α γ hα where
  toFun x := (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα x.right x.left.toAdd)⁻¹
  map_one' := by
    have hid : weakNormalizedAffineAutomorphism p h hh hdiv α γ hα 1 0 = 1 := by
      apply weak_normalized_automorphism_pole_injective p h hh hdiv α γ hα hγ
      dsimp only
      rw [weak_normalized_affine_automorphism_pole]
      simp
    change (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα 1 0)⁻¹ = 1
    rw [hid, inv_one]
  map_mul' x y := by
    rw [weak_normalized_affine_antihom p h hh hdiv α γ hα hγ, mul_inv_rev]

/-- The entire literal fixed-base automorphism group is isomorphic to
the genuine scalar-action semidirect product of its p-element cyclic
translation group and its h-element cyclic root-of-unity group. -/
theorem weak_normalized_semidirect_hom_bijective
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    Function.Bijective (weakNormalizedSemidirectHom p h hh hdiv α γ hα hγ) := by
  have hbij := weak_normalized_affine_automorphism_bijective p h hh hdiv α γ hα hγ
  constructor
  · intro x y heq
    have hraw := inv_injective heq
    have hpair : (x.right, x.left.toAdd) = (y.right, y.left.toAdd) := hbij.1 hraw
    apply SemidirectProduct.ext
    · exact Multiplicative.ext (congrArg Prod.snd hpair)
    · exact congrArg Prod.fst hpair
  · intro σ
    obtain ⟨⟨ζ, b⟩, hb⟩ := hbij.2 σ⁻¹
    dsimp only at hb
    refine ⟨⟨Multiplicative.ofAdd b, ζ⟩, ?_⟩
    change (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα ζ b)⁻¹ = σ
    rw [hb, inv_inv]

noncomputable def weakNormalizedSemidirectEquiv
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    WeakAffineSemidirect p h hdiv α γ ≃* WeakNormalizedAutomorphisms p h hh α γ hα :=
  MulEquiv.ofBijective (weakNormalizedSemidirectHom p h hh hdiv α γ hα hγ)
    (weak_normalized_semidirect_hom_bijective p h hh hdiv α γ hα hγ)

end Litt3.QuotientGeometry
