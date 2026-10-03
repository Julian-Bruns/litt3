import Solutions.Atlases.IdempotentParts
import Solutions.Atlases.CanonicalReducedSubalgebra

namespace Litt3.Atlases

section Products

variable {k A ι : Type*} [CommRing k] [CommRing A] [Algebra k A] [DecidableEq ι]
  (R : ι → Type*) [∀ i, CommRing (R i)] [∀ i, Algebra k (R i)]
  [∀ i, IsLocalRing (R i)]

theorem coordinateIdempotent_primitive (e : A ≃ₐ[k] ∀ i, R i) (i : ι) :
    IsPrimitiveIdempotent (coordinateIdempotent R e i) := by
  classical
  refine ⟨coordinateIdempotent_idempotent R e i, ?_, ?_⟩
  · intro hz
    have h := congrFun (congrArg e hz) i
    exact one_ne_zero (by
      simpa only [coordinateIdempotent_apply, map_zero, Pi.zero_apply, Pi.single_eq_same] using h)
  · intro f hf hef
    have hs (j : ι) (hji : j ≠ i) : e f j = 0 := by
      have h := congrFun (congrArg e hef) j
      simpa only [map_mul, coordinateIdempotent_apply, Pi.mul_apply,
        Pi.single_eq_of_ne hji, zero_mul] using h.symm
    have hfi : IsIdempotentElem (e f i) := by
      have h := congrFun (congrArg e hf.eq) i
      simpa only [IsIdempotentElem, map_mul, Pi.mul_apply] using h
    rcases local_idempotent_zero_or_one (e f i) hfi with hz | ho
    · left
      apply e.injective
      rw [map_zero]
      funext j
      by_cases hji : j = i
      · subst hji; exact hz
      · exact hs j hji
    · right
      apply e.injective
      rw [coordinateIdempotent_apply]
      funext j
      by_cases hji : j = i
      · subst hji; simpa only [Pi.single_eq_same] using ho
      · simpa only [Pi.single_eq_of_ne hji] using hs j hji

/-- Every actual primitive idempotent of a product of local rings is
one coordinate idempotent. Thus no missing factor can be hidden by a list. -/
theorem primitiveIdempotent_iff_coordinate (e : A ≃ₐ[k] ∀ i, R i) (a : A) :
    IsPrimitiveIdempotent a ↔ ∃ i, a = coordinateIdempotent R e i := by
  classical
  constructor
  · rintro ⟨ha, hne, hprim⟩
    have he : e a ≠ 0 := by intro hz; exact hne (e.injective (hz.trans (map_zero e).symm))
    obtain ⟨i, hi⟩ := Function.ne_iff.mp he
    have hai : IsIdempotentElem (e a i) := by
      simpa only [IsIdempotentElem, map_mul, Pi.mul_apply] using
        congrFun (congrArg e ha.eq) i
    have hone : e a i = 1 :=
      (local_idempotent_zero_or_one (e a i) hai).resolve_left hi
    have hmul : a * coordinateIdempotent R e i = coordinateIdempotent R e i := by
      apply e.injective
      simp only [map_mul, coordinateIdempotent_apply]
      ext j
      by_cases hji : j = i
      · subst hji; simp [hone]
      · simp [hji]
    rcases hprim _ (coordinateIdempotent_idempotent R e i) hmul with hz | heq
    · exact ((coordinateIdempotent_primitive R e i).2.1 hz).elim
    · exact ⟨i, heq.symm⟩
  · rintro ⟨i, rfl⟩
    exact coordinateIdempotent_primitive R e i

end Products

section Canonical

variable {K A : Type*} [Field K] [PerfectField K] [CommRing A] [Algebra K A]
  [FiniteDimensional K A]

/-- Every actual idempotent of A lies in its canonical reduced subalgebra;
the uniqueness follows from the actual nilpotent difference. -/
theorem idempotent_mem_canonicalReducedSubalgebra (e : A) (he : IsIdempotentElem e) :
    e ∈ canonicalReducedSubalgebra (K := K) (A := A) := by
  let q := Ideal.Quotient.mkₐ K (nilradical A)
  let s := canonicalReducedSection (K := K) (A := A)
  have hse : IsIdempotentElem (s (q e)) := (he.map q).map s
  have hdiff : IsNilpotent (e - s (q e)) :=
    mem_nilradical.mp (canonicalReducedSection_difference_mem_nilradical (K := K) e)
  have heq : e = s (q e) :=
    eq_of_isNilpotent_sub_of_isIdempotentElem he hse hdiff
  exact ⟨q e, heq.symm⟩

end Canonical
end Litt3.Atlases
