import Definitions.Atlases.IdempotentParts
import Mathlib.RingTheory.LocalRing.Basic
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.Tactic

namespace Litt3.Atlases

variable {k A ι : Type*} [CommRing k] [CommRing A] [Algebra k A] [DecidableEq ι]

theorem local_idempotent_zero_or_one [IsLocalRing A] (x : A)
    (hx : IsIdempotentElem x) : x = 0 ∨ x = 1 := by
  rcases IsLocalRing.isUnit_or_isUnit_one_sub_self x with h | h
  · exact Or.inr ((IsIdempotentElem.iff_eq_one_of_isUnit h).mp hx)
  · have he := (IsIdempotentElem.iff_eq_one_of_isUnit h).mp hx.one_sub
    exact Or.inl (by linear_combination -he)

variable (R : ι → Type*) [∀ i, CommRing (R i)] [∀ i, Algebra k (R i)]

/-- The actual coordinate idempotents transported through an actual
algebra decomposition. -/
noncomputable def coordinateIdempotent (e : A ≃ₐ[k] ∀ i, R i) (i : ι) : A := by
  classical
  exact e.symm (Pi.single i 1)

theorem coordinateIdempotent_apply (e : A ≃ₐ[k] ∀ i, R i) (i : ι) :
    e (coordinateIdempotent R e i) = Pi.single i 1 := e.apply_symm_apply _

theorem coordinateIdempotent_idempotent (e : A ≃ₐ[k] ∀ i, R i) (i : ι) :
    IsIdempotentElem (coordinateIdempotent R e i) := by
  classical
  apply e.injective
  change e (_ * _) = e _
  simp only [map_mul, coordinateIdempotent_apply]
  ext j
  by_cases h : i = j
  · subst h; simp
  · simp [h]

theorem coordinateIdempotents_complete [Fintype ι] (e : A ≃ₐ[k] ∀ i, R i) :
    CompleteOrthogonalIdempotents (coordinateIdempotent R e) := by
  classical
  exact (CompleteOrthogonalIdempotents.single R).map e.symm.toRingHom

/-- An actual coordinate factor is linearly isomorphic to its entire
idempotent part in the original algebra. -/
noncomputable def coordinateIdempotentPartEquiv (e : A ≃ₐ[k] ∀ i, R i) (i : ι) :
    idempotentPart (k := k) (coordinateIdempotent R e i) ≃ₗ[k] R i := by
  classical
  let f : idempotentPart (k := k) (coordinateIdempotent R e i) →ₗ[k] R i :=
    (LinearMap.proj i).comp (e.toLinearMap.comp (idempotentPart _).subtype)
  refine LinearEquiv.ofBijective f ⟨?_, ?_⟩
  · intro x y hxy
    apply Subtype.ext
    apply e.injective
    funext j
    by_cases h : i = j
    · subst h; exact hxy
    · have hx := congrFun (congrArg e x.property) j
      have hy := congrFun (congrArg e y.property) j
      simp only [map_mul, coordinateIdempotent_apply, Pi.mul_apply,
        Pi.single_eq_of_ne (Ne.symm h), zero_mul] at hx hy
      exact hx.symm.trans hy
  · intro a
    let x := e.symm (Pi.single i a)
    have hx : coordinateIdempotent R e i * x = x := by
      apply e.injective
      simp only [map_mul, coordinateIdempotent_apply, x, e.apply_symm_apply]
      ext j
      by_cases h : i = j
      · subst h; simp
      · simp [h]
    refine ⟨⟨x, hx⟩, ?_⟩
    change e x i = a
    simp [x]

theorem coordinateIdempotentPart_finrank [StrongRankCondition k]
    (e : A ≃ₐ[k] ∀ i, R i) (i : ι) :
    Module.finrank k (idempotentPart (k := k) (coordinateIdempotent R e i)) =
      Module.finrank k (R i) :=
  (coordinateIdempotentPartEquiv R e i).finrank_eq

end Litt3.Atlases
