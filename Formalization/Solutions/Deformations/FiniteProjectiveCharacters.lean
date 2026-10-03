import Solutions.Deformations.ProjectiveFiniteSums

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization

variable (F K V : Type*) [Field F] [CommRing K] [AddCommGroup V] [Module F V]

/-- Literal scalar-character functions, vanishing at the zero vector. -/
def finiteProjectiveCharacterSpace (phi : F →+* K) (d : ℕ) : Submodule K (V → K) where
  carrier := {f | f 0 = 0 ∧ ∀ (u : Fˣ) v, f ((u : F) • v) = phi u ^ d * f v}
  zero_mem' := by simp
  add_mem' := by
    rintro f g ⟨fZero, fScale⟩ ⟨gZero, gScale⟩
    constructor
    · simp [Pi.add_apply, fZero, gZero]
    · intro u v
      change f ((u : F) • v) + g ((u : F) • v) = _
      rw [fScale, gScale]
      exact (mul_add _ _ _).symm
  smul_mem' := by
    rintro c f ⟨fZero, fScale⟩
    constructor
    · simp [Pi.smul_apply, fZero]
    · intro u v
      change c * f ((u : F) • v) = phi u ^ d * (c * f v)
      rw [fScale]
      ring

noncomputable def projectiveCharacterExtension (phi : F →+* K) (d : ℕ)
    (h : ℙ F V → K) (v : V) : K := by
  classical
  exact if zero : v = 0 then 0 else
    let point := (projectiveRepUnitsEquiv F V).symm ⟨v, zero⟩
    phi point.2 ^ d * h point.1

theorem projective_character_extension_scaled_rep (phi : F →+* K) (d : ℕ)
    (h : ℙ F V → K) (P : ℙ F V) (u : Fˣ) :
    projectiveCharacterExtension F K V phi d h ((u : F) • P.rep) =
      phi u ^ d * h P := by
  classical
  have nonzero : (u : F) • P.rep ≠ 0 := smul_ne_zero u.ne_zero P.rep_nonzero
  have representation :
      (projectiveRepUnitsEquiv F V) (P, u) = ⟨(u : F) • P.rep, nonzero⟩ := rfl
  have inverse : (projectiveRepUnitsEquiv F V).symm ⟨(u : F) • P.rep, nonzero⟩ = (P, u) := by
    rw [← representation, Equiv.symm_apply_apply]
  simp only [projectiveCharacterExtension, dif_neg nonzero, inverse]

theorem projective_character_extension_rep (phi : F →+* K) (d : ℕ)
    (h : ℙ F V → K) (P : ℙ F V) :
    projectiveCharacterExtension F K V phi d h P.rep = h P := by
  simpa using projective_character_extension_scaled_rep F K V phi d h P 1

theorem projective_character_extension_member (phi : F →+* K) (d : ℕ)
    (h : ℙ F V → K) :
    projectiveCharacterExtension F K V phi d h ∈ finiteProjectiveCharacterSpace F K V phi d := by
  classical
  constructor
  · simp [projectiveCharacterExtension]
  · intro w v
    by_cases zero : v = 0
    · subst v
      simp [projectiveCharacterExtension]
    · let point := (projectiveRepUnitsEquiv F V).symm ⟨v, zero⟩
      have representation : (point.2 : F) • point.1.rep = v :=
        congrArg Subtype.val ((projectiveRepUnitsEquiv F V).apply_symm_apply ⟨v, zero⟩)
      rw [← representation]
      have multiply : (w : F) • ((point.2 : F) • point.1.rep) =
          ((w * point.2 : Fˣ) : F) • point.1.rep := by simp only [Units.val_mul, mul_smul]
      rw [multiply, projective_character_extension_scaled_rep,
        projective_character_extension_scaled_rep, Units.val_mul, map_mul, mul_pow, mul_assoc]

/-- Every literal scalar-character function is determined by its actual
projective representative values, with an explicit inverse extension. -/
noncomputable def finiteProjectiveCharacterEquiv (phi : F →+* K) (d : ℕ) :
    finiteProjectiveCharacterSpace F K V phi d ≃ₗ[K] (ℙ F V → K) where
  toFun f P := f.val P.rep
  invFun h := ⟨projectiveCharacterExtension F K V phi d h,
    projective_character_extension_member F K V phi d h⟩
  left_inv f := by
    classical
    apply Subtype.ext
    funext v
    change projectiveCharacterExtension F K V phi d (fun P => f.val P.rep) v = f.val v
    by_cases zero : v = 0
    · subst v
      simpa [projectiveCharacterExtension] using f.property.1.symm
    · let point := (projectiveRepUnitsEquiv F V).symm ⟨v, zero⟩
      have representation : (point.2 : F) • point.1.rep = v :=
        congrArg Subtype.val ((projectiveRepUnitsEquiv F V).apply_symm_apply ⟨v, zero⟩)
      rw [← representation, projective_character_extension_scaled_rep]
      exact (f.property.2 point.2 point.1.rep).symm
  right_inv h := by
    funext P
    exact projective_character_extension_rep F K V phi d h P
  map_add' f g := rfl
  map_smul' c f := rfl

end Litt3.Deformations
