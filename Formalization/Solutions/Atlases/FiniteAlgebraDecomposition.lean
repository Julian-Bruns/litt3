import Solutions.Atlases.NilpotentIdealBounds
import Solutions.Atlases.LocalMultiplicityDimensions
import Mathlib.RingTheory.Ideal.Quotient.Operations
import Mathlib.RingTheory.LocalRing.Basic
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Tactic

namespace Litt3.Atlases

section Ideals

variable {A ι : Type*} [CommRing A]

theorem finite_coprime_ideal_inf_eq_prod (s : Finset ι) (I : ι → Ideal A)
    (coprime : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → IsCoprime (I i) (I j)) :
    (⨅ i ∈ s, I i) = ∏ i ∈ s, I i := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert i s hi ih =>
      rw [Finset.iInf_insert, Finset.prod_insert hi]
      have hcop : IsCoprime (I i) (⨅ j ∈ s, I j) :=
        Ideal.isCoprime_biInf fun j hj => coprime i (Finset.mem_insert_self i s)
          j (Finset.mem_insert_of_mem hj) (by intro he; exact hi (he ▸ hj))
      rw [Ideal.inf_eq_mul_of_isCoprime hcop]
      rw [ih (fun j hj k hk => coprime j (Finset.mem_insert_of_mem hj)
        k (Finset.mem_insert_of_mem hk))]

/-- Every positive power of a genuine maximal ideal has a local quotient.
This is proved from the actual maximal ideals of that quotient. -/
theorem maximalIdeal_pow_quotient_local (P : Ideal A) [P.IsMaximal]
    {n : ℕ} (hn : 0 < n) : IsLocalRing (A ⧸ P ^ n) := by
  let q := Ideal.Quotient.mk (P ^ n)
  have hker : RingHom.ker q ≤ P := by
    rw [Ideal.mk_ker]
    exact Ideal.pow_le_self hn.ne'
  let J := P.map q
  have hJ : J.IsMaximal := Ideal.IsMaximal.map_of_surjective_of_ker_le
    Ideal.Quotient.mk_surjective hker
  apply IsLocalRing.of_unique_max_ideal
  refine ⟨J, hJ, ?_⟩
  intro Q hQ
  letI := hQ
  have hQc : (Q.comap q).IsMaximal :=
    Ideal.comap_isMaximal_of_surjective q Ideal.Quotient.mk_surjective
  have hPQ : P ≤ Q.comap q := by
    intro x hx
    apply hQc.isPrime.mem_of_pow_mem n
    change q (x ^ n) ∈ Q
    have hz : q (x ^ n) = 0 := Ideal.Quotient.eq_zero_iff_mem.mpr (Ideal.pow_mem_pow hx n)
    rw [hz]
    exact Q.zero_mem
  have he : P = Q.comap q := (inferInstance : P.IsMaximal).eq_of_le hQc.ne_top hPQ
  have hmap := congrArg (Ideal.map q) he
  rw [Ideal.map_comap_of_surjective q Ideal.Quotient.mk_surjective] at hmap
  exact hmap.symm

end Ideals

section FiniteAlgebra

variable {k A : Type*} [Field k] [CommRing A] [Algebra k A] [FiniteDimensional k A]

include k in
/-- The actual intersection of all maximal ideals is the nilradical
of a finite algebra, without reducedness or perfectness. -/
theorem finite_algebra_nilradical_eq_iInf_maximal :
    nilradical A = ⨅ P : MaximalSpectrum A, P.asIdeal := by
  letI : IsArtinianRing A := isArtinian_of_tower k inferInstance
  ext x
  rw [PrimeSpectrum.nilradical_eq_iInf, iInf,
    IsArtinianRing.primeSpectrum_asIdeal_range_eq]
  rfl

/-- The actual dimension bounds the simultaneous powers in the
Artinian decomposition. Every original nilpotent multiplicity is retained. -/
theorem finite_algebra_iInf_maximal_pow_eq_bot :
    (⨅ P : MaximalSpectrum A, P.asIdeal ^ Module.finrank k A) = ⊥ := by
  classical
  letI : IsArtinianRing A := isArtinian_of_tower k inferInstance
  letI := Fintype.ofFinite (MaximalSpectrum A)
  have hcop : ∀ P Q : MaximalSpectrum A, P ≠ Q → IsCoprime P.asIdeal Q.asIdeal :=
    fun P Q h => Ideal.isCoprime_iff_sup_eq.mpr
      (P.isMaximal.coprime_of_ne Q.isMaximal (fun he => h (MaximalSpectrum.ext he)))
  have he : (⨅ P : MaximalSpectrum A, P.asIdeal ^ Module.finrank k A) =
      ∏ P : MaximalSpectrum A, P.asIdeal ^ Module.finrank k A := by
    simpa using finite_coprime_ideal_inf_eq_prod Finset.univ _
      (fun P _ Q _ h => (hcop P Q h).pow)
  have hf : (∏ P : MaximalSpectrum A, P.asIdeal) = nilradical A := by
    rw [finite_algebra_nilradical_eq_iInf_maximal (k := k)]
    symm
    simpa using finite_coprime_ideal_inf_eq_prod Finset.univ _ (fun P _ Q _ => hcop P Q)
  rw [he, Finset.prod_pow, hf, nilradical_pow_finrank (k := k)]

/-- The complete actual finite algebra, including every nilpotent
multiplicity, is a product of its bounded local factors. -/
noncomputable def finiteAlgebraLocalFactorsEquiv :
    A ≃ₐ[k] (∀ P : MaximalSpectrum A, A ⧸ P.asIdeal ^ Module.finrank k A) := by
  classical
  letI : IsArtinianRing A := isArtinian_of_tower k inferInstance
  have hcop : Pairwise (fun P Q : MaximalSpectrum A =>
      IsCoprime (P.asIdeal ^ Module.finrank k A) (Q.asIdeal ^ Module.finrank k A)) := by
    intro P Q h
    exact (Ideal.isCoprime_iff_sup_eq.mpr
      (P.isMaximal.coprime_of_ne Q.isMaximal
        (fun he => h (MaximalSpectrum.ext he)))).pow
  let e : A ≃+* (∀ P : MaximalSpectrum A, A ⧸ P.asIdeal ^ Module.finrank k A) :=
    (RingEquiv.quotientBot A).symm.trans
      ((Ideal.quotEquivOfEq (finite_algebra_iInf_maximal_pow_eq_bot (k := k)).symm).trans
        (Ideal.quotientInfRingEquivPiQuotient _ hcop))
  exact { __ := e, commutes' := fun r => rfl }

theorem finiteAlgebraLocalFactorsEquiv_apply (x : A) (P : MaximalSpectrum A) :
    finiteAlgebraLocalFactorsEquiv (k := k) x P =
      Ideal.Quotient.mkₐ k (P.asIdeal ^ Module.finrank k A) x := rfl

theorem finite_algebra_finrank_pos_of_maximal (P : MaximalSpectrum A) :
    0 < Module.finrank k A := by
  letI := Ideal.Quotient.field P.asIdeal
  have hd : 0 < Module.finrank k (A ⧸ P.asIdeal) := Module.finrank_pos
  have hle := (P.asIdeal.restrictScalars k).finrank_quotient_add_finrank
  have he := (Submodule.Quotient.restrictScalarsEquiv k P.asIdeal).finrank_eq
  rw [he] at hle
  omega

instance finiteAlgebraLocalFactorIsLocalRing (P : MaximalSpectrum A) :
    IsLocalRing (A ⧸ P.asIdeal ^ Module.finrank k A) :=
  maximalIdeal_pow_quotient_local P.asIdeal
    (finite_algebra_finrank_pos_of_maximal (k := k) P)

/-- Each actual local factor has the actual local dimension formula. -/
theorem finite_algebra_local_factor_dimension (P : MaximalSpectrum A) :
    Module.finrank k (A ⧸ P.asIdeal ^ Module.finrank k A) =
      Module.finrank k (IsLocalRing.ResidueField (A ⧸ P.asIdeal ^ Module.finrank k A)) *
        (Module.length (A ⧸ P.asIdeal ^ Module.finrank k A)
          (A ⧸ P.asIdeal ^ Module.finrank k A)).toNat := by
  have h := finite_local_algebra_dimension_length (k := k)
    (C := A ⧸ P.asIdeal ^ Module.finrank k A)
  simpa only [ENat.toNat_mul, ENat.toNat_coe] using congrArg ENat.toNat h

/-- The actual finite-algebra dimension is the sum of the dimensions
of ALL local factors. No completeness of a found root list is assumed. -/
theorem finite_algebra_dimension_sum_local_factors [Fintype (MaximalSpectrum A)] :
    Module.finrank k A =
      ∑ P : MaximalSpectrum A, Module.finrank k (A ⧸ P.asIdeal ^ Module.finrank k A) := by
  classical
  conv_lhs => rw [(finiteAlgebraLocalFactorsEquiv (k := k) (A := A)).toLinearEquiv.finrank_eq]
  exact Module.finrank_pi_fintype k

/-- The residue field of each local factor is the residue field of its
original closed point, with the actual scalar structure. -/
noncomputable def finiteAlgebraLocalFactorResidueEquiv (P : MaximalSpectrum A) :
    IsLocalRing.ResidueField (A ⧸ P.asIdeal ^ Module.finrank k A) ≃ₐ[k] A ⧸ P.asIdeal := by
  let q := Ideal.Quotient.mk (P.asIdeal ^ Module.finrank k A)
  have hker : RingHom.ker q ≤ P.asIdeal := by
    rw [Ideal.mk_ker]
    exact Ideal.pow_le_self
      (finite_algebra_finrank_pos_of_maximal (k := k) P).ne'
  have hm : (P.asIdeal.map q).IsMaximal :=
    Ideal.IsMaximal.map_of_surjective_of_ker_le Ideal.Quotient.mk_surjective hker
  let e := Ideal.quotEquivOfEq (IsLocalRing.eq_maximalIdeal hm).symm
  have hle : P.asIdeal ^ Module.finrank k A ≤ P.asIdeal :=
    Ideal.pow_le_self (finite_algebra_finrank_pos_of_maximal (k := k) P).ne'
  exact { __ := e.trans (DoubleQuot.quotQuotEquivQuotOfLE hle),
          commutes' := fun r => rfl }

theorem finite_algebra_local_factor_dimension_residue (P : MaximalSpectrum A) :
    Module.finrank k (A ⧸ P.asIdeal ^ Module.finrank k A) =
      Module.finrank k (A ⧸ P.asIdeal) *
        (Module.length (A ⧸ P.asIdeal ^ Module.finrank k A)
          (A ⧸ P.asIdeal ^ Module.finrank k A)).toNat := by
  rw [finite_algebra_local_factor_dimension P,
    (finiteAlgebraLocalFactorResidueEquiv (k := k) P).toLinearEquiv.finrank_eq]

end FiniteAlgebra
end Litt3.Atlases
