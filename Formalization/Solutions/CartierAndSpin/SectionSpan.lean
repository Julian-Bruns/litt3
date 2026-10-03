import Theorems.CartierAndSpin.SectionSpan
import Mathlib.Tactic.Linarith

/-!
# The section-span deficit inequality

This proves the characteristic-free linear algebra step of
`section_span_clearing_degree_bound`, including arbitrary finite-dimensional
division-ring modules. It assumes a genuine surjective restriction map, not
the desired fiber length inequality. Riemann--Roch and the scheme-theoretic
fiber construction remain geometric dependencies outside this module.
-/

namespace Litt3.CartierAndSpin

variable {K V W : Type*} [DivisionRing K]
  [AddCommGroup V] [Module K V] [FiniteDimensional K V]
  [AddCommGroup W] [Module K W]

theorem finrank_image_codimension_bound (f : V →ₗ[K] W)
    (S : Submodule K V) (hsurj : Function.Surjective f) :
    Module.finrank K W ≤
      Module.finrank K (V ⧸ S) + Module.finrank K (S.map f) := by
  let j : LinearMap.ker (f.domRestrict S) →ₗ[K] LinearMap.ker f :=
    ((S.subtype).comp (LinearMap.ker (f.domRestrict S)).subtype).codRestrict
      (LinearMap.ker f) (by intro x; exact x.property)
  have hj : Function.Injective j := by
    intro x y h
    apply Subtype.ext
    apply Subtype.ext
    exact congrArg (fun z : LinearMap.ker f => (z : V)) h
  have hker := LinearMap.finrank_le_finrank_of_injective hj
  have hsource := f.finrank_range_add_finrank_ker
  have hsub := (f.domRestrict S).finrank_range_add_finrank_ker
  have hquot := S.finrank_quotient_add_finrank
  rw [LinearMap.range_eq_top.mpr hsurj, finrank_top] at hsource
  rw [LinearMap.range_domRestrict] at hsub
  omega

theorem sectionSpanRestrictionBound (f : V →ₗ[K] W) (S : Submodule K V) :
    Specifications.SectionSpanRestrictionBound f S := by
  intro hsurj
  exact finrank_image_codimension_bound f S hsurj

/-- If a subspace restricts to at most a line, the target length cannot exceed
its section-span deficit plus one. -/
theorem finrank_le_codimension_add_one (f : V →ₗ[K] W)
    (S : Submodule K V) (hsurj : Function.Surjective f)
    (hline : Module.finrank K (S.map f) ≤ 1) :
    Module.finrank K W ≤ Module.finrank K (V ⧸ S) + 1 := by
  have h := finrank_image_codimension_bound f S hsurj
  omega

end Litt3.CartierAndSpin
