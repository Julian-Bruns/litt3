import Solutions.Jacobians.RationalLinearPlaces

namespace Litt3.Jacobians

open scoped Classical

/-- Every actual finite place of K(t) is a linear prime when K is
algebraically closed. This classifies the genuine prime ideals, not a
chosen finite enumeration of rational points. -/
theorem rational_linear_place_surjective
    {K : Type*} [Field K] [IsAlgClosed K] :
    Function.Surjective (rationalLinearPlace K) := by
  intro v
  let p : Polynomial K := Submodule.IsPrincipal.generator v.asIdeal
  have hspan : Ideal.span {p} = v.asIdeal := Ideal.span_singleton_generator v.asIdeal
  have hp : p ≠ 0 := by
    intro hp
    apply v.ne_bot
    rw [← hspan, hp, Ideal.span_singleton_zero]
  have hprime : Prime p := (Ideal.span_singleton_prime hp).mp (hspan ▸ v.isPrime)
  obtain ⟨c, hc⟩ := IsAlgClosed.exists_root p
    (ne_of_gt (Polynomial.degree_pos_of_irreducible hprime.irreducible))
  have hmem : p ∈ (rationalLinearPlace K c).asIdeal :=
    Ideal.mem_span_singleton.mpr (Polynomial.dvd_iff_isRoot.mpr hc)
  have hle : v.asIdeal ≤ (rationalLinearPlace K c).asIdeal := by
    rw [← hspan]
    exact Ideal.span_le.mpr (Set.singleton_subset_iff.mpr hmem)
  have heq := v.isMaximal.eq_of_le (rationalLinearPlace K c).isPrime.ne_top hle
  exact ⟨c, IsDedekindDomain.HeightOneSpectrum.ext heq.symm⟩

noncomputable def rationalLinearPlaceEquiv
    (K : Type*) [Field K] [IsAlgClosed K] :
    K ≃ IsDedekindDomain.HeightOneSpectrum (Polynomial K) :=
  Equiv.ofBijective (rationalLinearPlace K)
    ⟨rational_linear_place_injective, rational_linear_place_surjective⟩

/-- The full genuine place type has one place at infinity and precisely
the affine points of the algebraically closed constant field. -/
noncomputable def rationalProjectivePlaceEquiv
    (K : Type*) [Field K] [IsAlgClosed K] :
    Option K ≃ RationalProjectivePlaces K :=
  Equiv.optionCongr (rationalLinearPlaceEquiv K)

end Litt3.Jacobians
