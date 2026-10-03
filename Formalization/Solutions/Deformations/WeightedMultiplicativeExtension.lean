import Solutions.Deformations.BasisWeightedPowers

namespace Litt3.Deformations

variable {R A T I : Type*} [CommRing R] [CommRing A] [Algebra R A] [CommRing T]

/-- Additive residue-semilinear comparisons of genuine weighted spans
are multiplicative once multiplication is checked on the literal
original prime-power generators. -/
theorem weighted_multiplicative_extension
    (B : Module.Basis I R A) (a : R) (w : ℕ) (degree : I → ℕ)
    (φ : ∀ d, basisWeightedPowerFiltration B a w degree d →+ T) (ρ : R →+* T)
    (productMember : ∀ d e x y, x ∈ basisWeightedPowerFiltration B a w degree d →
      y ∈ basisWeightedPowerFiltration B a w degree e →
      x * y ∈ basisWeightedPowerFiltration B a w degree (d + e))
    (scalar : ∀ d t x, φ d (t • x) = ρ t * φ d x)
    (generators : ∀ d e j l i t (left : d ≤ w * j + degree i)
      (right : e ≤ w * l + degree t),
      φ (d + e) ⟨(a ^ j • B i) * (a ^ l • B t),
        productMember d e _ _ (Submodule.subset_span ⟨j, i, left, rfl⟩)
          (Submodule.subset_span ⟨l, t, right, rfl⟩)⟩ =
      φ d ⟨a ^ j • B i, Submodule.subset_span ⟨j, i, left, rfl⟩⟩ *
        φ e ⟨a ^ l • B t, Submodule.subset_span ⟨l, t, right, rfl⟩⟩)
    (d e : ℕ) (x : basisWeightedPowerFiltration B a w degree d)
    (y : basisWeightedPowerFiltration B a w degree e) :
    φ (d + e) ⟨x.val * y.val, productMember d e _ _ x.property y.property⟩ = φ d x * φ e y := by
  refine Submodule.span_induction₂ (p := fun x y hx hy =>
    φ (d + e) ⟨x * y, productMember d e x y hx hy⟩ = φ d ⟨x, hx⟩ * φ e ⟨y, hy⟩)
    ?_ ?_ ?_ ?_ ?_ ?_ ?_ x.property y.property
  · rintro _ _ ⟨j, i, left, rfl⟩ ⟨l, t, right, rfl⟩
    exact generators d e j l i t left right
  · intro y hy
    simp only [zero_mul]
    change φ (d + e) 0 = φ d 0 * φ e ⟨y, hy⟩
    rw [map_zero, map_zero, zero_mul]
  · intro x hx
    simp only [mul_zero]
    change φ (d + e) 0 = φ d ⟨x, hx⟩ * φ e 0
    rw [map_zero, map_zero, mul_zero]
  · intro x z y hx hz hy first second
    simp only [add_mul]
    change φ (d + e) (⟨x * y, productMember d e _ _ hx hy⟩ +
      ⟨z * y, productMember d e _ _ hz hy⟩) =
      φ d (⟨x, hx⟩ + ⟨z, hz⟩) * φ e ⟨y, hy⟩
    rw [map_add, map_add, add_mul, first, second]
  · intro x y z hx hy hz first second
    simp only [mul_add]
    change φ (d + e) (⟨x * y, productMember d e _ _ hx hy⟩ +
      ⟨x * z, productMember d e _ _ hx hz⟩) =
      φ d ⟨x, hx⟩ * φ e (⟨y, hy⟩ + ⟨z, hz⟩)
    rw [map_add, map_add, mul_add, first, second]
  · intro t x y hx hy induction
    simp only [smul_mul_assoc]
    change φ (d + e) (t • ⟨x * y, productMember d e _ _ hx hy⟩) =
      φ d (t • ⟨x, hx⟩) * φ e ⟨y, hy⟩
    rw [scalar, scalar, induction, mul_assoc]
  · intro t x y hx hy induction
    simp only [mul_smul_comm]
    change φ (d + e) (t • ⟨x * y, productMember d e _ _ hx hy⟩) =
      φ d ⟨x, hx⟩ * φ e (t • ⟨y, hy⟩)
    rw [scalar, scalar, induction]
    ring

end Litt3.Deformations
