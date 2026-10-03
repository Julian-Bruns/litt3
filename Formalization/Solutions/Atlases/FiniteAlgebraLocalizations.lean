import Solutions.Atlases.ReducedFactorIdempotents
import Mathlib.RingTheory.Localization.AtPrime.Basic
import Mathlib.RingTheory.Localization.Algebra

namespace Litt3.Atlases

variable {k A : Type*} [Field k] [CommRing A] [Algebra k A] [FiniteDimensional k A]

/-- The bounded CRT factor is the actual localization at the original
maximal ideal, with its original A-algebra map. -/
instance finiteAlgebraLocalFactorIsLocalization (P : MaximalSpectrum A) :
    IsLocalization P.asIdeal.primeCompl (A ⧸ P.asIdeal ^ Module.finrank k A) := by
  classical
  let C := A ⧸ P.asIdeal ^ Module.finrank k A
  let q : A →+* C := Ideal.Quotient.mk (P.asIdeal ^ Module.finrank k A)
  have hle : P.asIdeal ^ Module.finrank k A ≤ P.asIdeal :=
    Ideal.pow_le_self (finite_algebra_finrank_pos_of_maximal (k := k) P).ne'
  have hm : (P.asIdeal.map q).IsMaximal :=
    Ideal.IsMaximal.map_of_surjective_of_ker_le Ideal.Quotient.mk_surjective
      (by simpa only [Ideal.mk_ker] using hle)
  have hc : (P.asIdeal.map q).comap q = P.asIdeal := by
    rw [Ideal.comap_map_of_surjective q Ideal.Quotient.mk_surjective,
      ← RingHom.ker_eq_comap_bot, Ideal.mk_ker, sup_eq_left.mpr hle]
  let decomp := finiteAlgebraLocalFactorsEquiv (k := k) (A := A)
  let ep := coordinateIdempotent
    (fun P : MaximalSpectrum A => A ⧸ P.asIdeal ^ Module.finrank k A) decomp P
  have hep : ep ∉ P.asIdeal := by
    intro h
    have hz : Ideal.Quotient.mk P.asIdeal ep = 0 := Ideal.Quotient.eq_zero_iff_mem.mpr h
    have hone := local_coordinate_idempotent_residue (K := k) P P
    change Ideal.Quotient.mk P.asIdeal ep = _ at hone
    simp only [↓reduceIte] at hone
    exact one_ne_zero (hone.symm.trans hz)
  refine (isLocalization_iff _ _).mpr ⟨?_, ?_, ?_⟩
  · intro s
    apply IsLocalRing.notMem_maximalIdeal.mp
    rw [← IsLocalRing.eq_maximalIdeal hm]
    intro hs
    have hmem : (s : A) ∈ (P.asIdeal.map q).comap q := hs
    rw [hc] at hmem
    exact s.property hmem
  · intro z
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective z
    exact ⟨(x, 1), by simp⟩
  · intro x y hxy
    refine ⟨⟨ep, hep⟩, ?_⟩
    apply decomp.injective
    rw [map_mul, map_mul]
    change decomp ep * decomp x = decomp ep * decomp y
    dsimp only [ep]
    rw [coordinateIdempotent_apply]
    funext Q
    by_cases he : Q = P
    · subst he
      simpa only [Pi.mul_apply, Pi.single_eq_same, one_mul,
        finiteAlgebraLocalFactorsEquiv_apply] using hxy
    · simp only [Pi.mul_apply, Pi.single_eq_of_ne he, zero_mul]

noncomputable def finiteAlgebraLocalFactorLocalizationEquiv (P : MaximalSpectrum A) :
    (A ⧸ P.asIdeal ^ Module.finrank k A) ≃ₐ[A] Localization.AtPrime P.asIdeal :=
  IsLocalization.algEquiv P.asIdeal.primeCompl _ _

end Litt3.Atlases
