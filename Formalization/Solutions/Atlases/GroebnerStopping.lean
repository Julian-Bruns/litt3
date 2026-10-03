import Definitions.Atlases.GroebnerStopping
import Mathlib.Tactic

namespace Litt3.Atlases

open MvPolynomial Submodule
open scoped MonomialOrder

variable {K σ : Type*} [Field K]

theorem standard_remainder_quotient_mem_span
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K)) (r : MvPolynomial σ K)
    (hr : ∀ d ∈ r.support, d ∈ standardMonomials m G) :
    Ideal.Quotient.mkₐ K I r ∈
      span K (Set.range (standardMonomialImages m G I)) := by
  classical
  rw [r.as_sum, map_sum]
  apply sum_mem
  intro d hd
  have hm : Ideal.Quotient.mkₐ K I (monomial d 1) ∈
      span K (Set.range (standardMonomialImages m G I)) :=
    subset_span ⟨⟨d, hr d hd⟩, rfl⟩
  convert smul_mem _ (r.coeff d) hm using 1
  rw [← map_smul]
  simp only [smul_monomial, smul_eq_mul, mul_one]

/-- Division by the actual derived equations proves that their
standard monomials span the original quotient, before any S-pair test. -/
theorem standard_monomials_span_quotient
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K)) (hGI : G ⊆ I) :
    span K (Set.range (standardMonomialImages m G I)) = ⊤ := by
  classical
  apply eq_top_iff.mpr
  intro x _
  obtain ⟨f, rfl⟩ := Ideal.Quotient.mkₐ_surjective K I x
  let b : {g : MvPolynomial σ K // g ∈ G ∧ g ≠ 0} → MvPolynomial σ K :=
    fun g => g.val
  have hb : ∀ i, IsUnit (m.leadingCoeff (b i)) :=
    fun i => isUnit_iff_ne_zero.mpr (m.leadingCoeff_eq_zero_iff.not.mpr i.property.2)
  obtain ⟨c, r, hf, _, hr⟩ := m.div hb f
  have hc : Finsupp.linearCombination (MvPolynomial σ K) b c ∈ I := by
    rw [Finsupp.linearCombination_apply, Finsupp.sum]
    exact I.sum_mem fun i _ => I.mul_mem_left _ (hGI i.property.1)
  have hq : Ideal.Quotient.mkₐ K I f = Ideal.Quotient.mkₐ K I r := by
    rw [hf, map_add]
    have hz : Ideal.Quotient.mkₐ K I
        (Finsupp.linearCombination (MvPolynomial σ K) b c) = 0 :=
      Ideal.Quotient.eq_zero_iff_mem.mpr hc
    rw [hz, zero_add]
  rw [hq]
  apply standard_remainder_quotient_mem_span
  intro d hd g hg hne
  exact hr d hd ⟨g, hg, hne⟩

/-- An independently known quotient dimension forbids an undersized
standard-monomial certificate and makes an exact bound a true basis. -/
theorem standard_monomial_count_exact
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K)) (hGI : G ⊆ I)
    [Fintype (standardMonomials m G)] [FiniteDimensional K (MvPolynomial σ K ⧸ I)]
    (hcount : Fintype.card (standardMonomials m G) ≤
      Module.finrank K (MvPolynomial σ K ⧸ I)) :
    Fintype.card (standardMonomials m G) = Module.finrank K (MvPolynomial σ K ⧸ I) ∧
      LinearIndependent K (standardMonomialImages m G I) := by
  have hs := standard_monomials_span_quotient m G I hGI
  refine ⟨le_antisymm hcount (finrank_le_of_span_eq_top hs), ?_⟩
  exact linearIndependent_of_top_le_span_of_card_le_finrank (le_of_eq hs.symm) hcount

/-- Independence of the actual standard monomial quotient images
forces every standard remainder in the original ideal to be zero. -/
theorem standard_remainder_zero_of_quotient_zero
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K))
    (hli : LinearIndependent K (standardMonomialImages m G I))
    (r : MvPolynomial σ K) (hr : ∀ d ∈ r.support, d ∈ standardMonomials m G)
    (hq : Ideal.Quotient.mkₐ K I r = 0) : r = 0 := by
  classical
  let c : standardMonomials m G →₀ K :=
    Finsupp.subtypeDomain (fun d => d ∈ standardMonomials m G) r
  have hc : Finsupp.linearCombination K (standardMonomialImages m G I) c =
      Ideal.Quotient.mkₐ K I r := by
    rw [Finsupp.linearCombination_apply]
    change (Finsupp.subtypeDomain (fun d => d ∈ standardMonomials m G) r).sum
      (fun d a => a • Ideal.Quotient.mkₐ K I (monomial d.val 1)) = _
    rw [Finsupp.sum_subtypeDomain_index
      (h := fun d a => a • Ideal.Quotient.mkₐ K I (monomial d 1)) hr,
      Finsupp.sum]
    conv_rhs => rw [r.as_sum, map_sum]
    apply Finset.sum_congr rfl
    intro d _
    rw [← map_smul]
    simp only [smul_monomial, smul_eq_mul, mul_one]
    rfl
  have hz : c = 0 := hli (by rw [hc, hq, map_zero])
  exact (Finsupp.subtypeDomain_eq_zero_iff hr).mp hz

/-- An upper standard-monomial count equal to the independently known
colength proves actual leading divisibility for every ideal element.
No S-pair completion or coefficient census is a hypothesis. -/
theorem groebner_stopping_from_known_colength
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K)) (hGI : G ⊆ I)
    [Fintype (standardMonomials m G)] [FiniteDimensional K (MvPolynomial σ K ⧸ I)]
    (hcount : Fintype.card (standardMonomials m G) ≤
      Module.finrank K (MvPolynomial σ K ⧸ I)) : IsGroebnerBasisFor m G I := by
  classical
  have hli := (standard_monomial_count_exact m G I hGI hcount).2
  refine ⟨hGI, ?_⟩
  intro f hf hne
  let b : {g : MvPolynomial σ K // g ∈ G ∧ g ≠ 0} → MvPolynomial σ K :=
    fun g => g.val
  have hb : ∀ i, IsUnit (m.leadingCoeff (b i)) :=
    fun i => isUnit_iff_ne_zero.mpr (m.leadingCoeff_eq_zero_iff.not.mpr i.property.2)
  obtain ⟨c, r, hdecomp, hdeg, hr⟩ := m.div hb f
  have hc : Finsupp.linearCombination (MvPolynomial σ K) b c ∈ I := by
    rw [Finsupp.linearCombination_apply, Finsupp.sum]
    exact I.sum_mem fun i _ => I.mul_mem_left _ (hGI i.property.1)
  have hrI : r ∈ I := by
    have hsub := I.sub_mem hf hc
    simpa only [hdecomp, add_sub_cancel_left] using hsub
  have hrzero : r = 0 := standard_remainder_zero_of_quotient_zero m G I hli r
    (fun d hd g hg hn => hr d hd ⟨g, hg, hn⟩)
    (Ideal.Quotient.eq_zero_iff_mem.mpr hrI)
  rw [hrzero, add_zero] at hdecomp
  have hlead : (Finsupp.linearCombination (MvPolynomial σ K) b c).coeff
      (m.degree f) ≠ 0 := by
    rw [← hdecomp]
    exact m.coeff_degree_ne_zero_iff.mpr hne
  simp only [Finsupp.linearCombination_apply, Finsupp.sum, smul_eq_mul, coeff_sum] at hlead
  obtain ⟨i, _, hi⟩ := Finset.exists_ne_zero_of_sum_ne_zero hlead
  have hiprod : b i * c i ≠ 0 := by
    intro hz
    apply hi
    simp only [mul_comm (c i), hz, coeff_zero]
  have hile : m.degree f ≼[m] m.degree (b i * c i) := by
    apply m.le_degree
    rw [mem_support_iff]
    simpa only [mul_comm (c i)] using hi
  have hieq : m.degree (b i * c i) = m.degree f := by
    exact m.toSyn.injective (le_antisymm (hdeg i) hile)
  refine ⟨i.val, i.property.1, i.property.2, ?_⟩
  rw [← hieq, m.degree_mul' hiprod]
  exact le_add_of_nonneg_right (by positivity)

/-- The leading-divisibility criterion also proves that the actual
derived equations generate the original ideal. -/
theorem groebnerBasisFor_generates_ideal
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K)) (hGB : IsGroebnerBasisFor m G I) :
    Ideal.span G = I := by
  classical
  refine le_antisymm (Ideal.span_le.mpr hGB.1) ?_
  intro f hf
  let b : {g : MvPolynomial σ K // g ∈ G ∧ g ≠ 0} → MvPolynomial σ K :=
    fun g => g.val
  have hb : ∀ i, IsUnit (m.leadingCoeff (b i)) :=
    fun i => isUnit_iff_ne_zero.mpr (m.leadingCoeff_eq_zero_iff.not.mpr i.property.2)
  obtain ⟨c, r, hdecomp, _, hr⟩ := m.div hb f
  have hc : Finsupp.linearCombination (MvPolynomial σ K) b c ∈ Ideal.span G := by
    rw [Finsupp.linearCombination_apply, Finsupp.sum]
    exact (Ideal.span G).sum_mem fun i _ =>
      (Ideal.span G).mul_mem_left _ (Ideal.subset_span i.property.1)
  have hrI : r ∈ I := by
    have hsub := I.sub_mem hf ((Ideal.span_le.mpr hGB.1) hc)
    simpa only [hdecomp, add_sub_cancel_left] using hsub
  have hz : r = 0 := by
    by_contra hne
    obtain ⟨g, hg, hn, hd⟩ := hGB.2 r hrI hne
    exact hr (m.degree r) (m.degree_mem_support hne) ⟨g, hg, hn⟩ hd
  rw [hdecomp, hz, add_zero]
  exact hc

/-- The stopping certificate gives equality of the actual leading
monomial ideals, not merely equality of their reported dimensions. -/
theorem groebnerBasisFor_leading_ideal_eq
    (m : MonomialOrder σ) (G : Set (MvPolynomial σ K))
    (I : Ideal (MvPolynomial σ K)) (hGB : IsGroebnerBasisFor m G I) :
    leadingMonomialIdeal m G = leadingMonomialIdeal m (I : Set (MvPolynomial σ K)) := by
  classical
  apply le_antisymm
  · apply Ideal.span_le.mpr
    rintro t ⟨g, hg, hn, rfl⟩
    exact Ideal.subset_span ⟨g, hGB.1 hg, hn, rfl⟩
  · apply Ideal.span_le.mpr
    rintro t ⟨f, hf, hn, rfl⟩
    obtain ⟨g, hg, hgn, hd⟩ := hGB.2 f hf hn
    have hmem : monomial (m.degree g) (1 : K) ∈ leadingMonomialIdeal m G :=
      Ideal.subset_span ⟨g, hg, hgn, rfl⟩
    have hm := (leadingMonomialIdeal m G).mul_mem_right
      (monomial (m.degree f - m.degree g) 1) hmem
    simpa only [monomial_mul, one_mul, add_tsub_cancel_of_le hd] using hm

end Litt3.Atlases
