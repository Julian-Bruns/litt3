import Solutions.SharedTensors.SemilinearLineCartier
import Mathlib.FieldTheory.Finite.Basic

namespace Litt3.SharedTensors

open Module

open scoped Classical

variable {k V : Type*} [Field k] [IsAlgClosed k]
  [AddCommGroup V] [Module k V]
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Fixed elements on the genuine line are exactly multiples of a
nonzero fixed generator by elements of the ACTUAL prime subfield.
The target is the literal additive kernel of C-1. -/
noncomputable def actual_cartier_fixed_generator_prime_subfield_equiv
    (hdim : Module.finrank k V = 1) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v)
    (v : V) (hv : v ≠ 0) (hfixed : C v = v) :
    (⊥ : Subfield k) ≃+ (C - AddMonoidHom.id V).ker := by
  let f : (⊥ : Subfield k) →+ (C - AddMonoidHom.id V).ker :=
    { toFun := fun a => ⟨(a : k) • v, by
        change C ((a : k) • v) - (a : k) • v = 0
        apply sub_eq_zero.mpr
        apply (actual_inverse_power_semilinear_fixed_scalar_iff
          (Fact.out : p.Prime).pos C hC v hv hfixed (a : k)).mpr
        exact (Subfield.mem_bot_iff_pow_eq_self k p).mp a.property⟩
      map_zero' := by apply Subtype.ext; simp
      map_add' := by intro a b; apply Subtype.ext; simp [add_smul] }
  apply AddEquiv.ofBijective f
  constructor
  · intro a b h
    apply Subtype.ext
    exact (smul_left_injective k hv) (congrArg Subtype.val h)
  · intro w
    obtain ⟨a, ha⟩ := exists_smul_eq_of_finrank_eq_one hdim hv w.val
    have hfixedw : C w.val = w.val := sub_eq_zero.mp w.property
    have hap : a ^ p = a :=
      (actual_inverse_power_semilinear_fixed_scalar_iff
        (Fact.out : p.Prime).pos C hC v hv hfixed a).mp (by rw [ha]; exact hfixedw)
    exact ⟨⟨a, (Subfield.mem_bot_iff_pow_eq_self k p).mpr hap⟩, Subtype.ext ha⟩

/-- A nonzero Cartier-type operator on an actual one-dimensional space
has exactly p fixed elements. Both a fixed generator and its actual
prime-field parametrization are derived symbolically. -/
theorem actual_nonzero_cartier_line_fixed_card
    [Module.Finite k V] (hdim : Module.finrank k V = 1) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) (hne : C ≠ 0) :
    Nat.card (C - AddMonoidHom.id V).ker = p := by
  have hdim' : Module.finrank k V = Module.finrank k k := by
    simpa only [Module.finrank_self] using hdim
  obtain ⟨v, hv, hfixed⟩ := actual_line_inverse_power_semilinear_nonzero_fixed_generator
    (Fact.out : p.Prime).one_lt
    (LinearEquiv.ofFinrankEq (R := k) V k hdim') C hC hne
  exact (Nat.card_congr (actual_cartier_fixed_generator_prime_subfield_equiv
    hdim C hC v hv hfixed).toEquiv).symm.trans (Subfield.card_bot k p)

/-- In rank at most one, the literal fixed group has cardinality one
for the zero operator and p otherwise. This includes the zero space. -/
theorem actual_rank_le_one_cartier_fixed_card
    [Module.Finite k V] (hdim : Module.finrank k V ≤ 1) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Nat.card (C - AddMonoidHom.id V).ker = if C = 0 then 1 else p := by
  classical
  by_cases hzero : C = 0
  · subst C
    have hs : Subsingleton ((0 : V →+ V) - AddMonoidHom.id V).ker := by
      apply Subsingleton.intro
      intro a b
      apply Subtype.ext
      have ha : -a.val = 0 := by simpa using a.property
      have hb : -b.val = 0 := by simpa using b.property
      rw [neg_eq_zero.mp ha, neg_eq_zero.mp hb]
    letI := hs
    simp
  · have hdimone : Module.finrank k V = 1 := by
      by_contra hne
      have hz : Module.finrank k V = 0 := by omega
      letI : Subsingleton V := Module.finrank_zero_iff.mp hz
      apply hzero
      ext v
      exact Subsingleton.elim _ _
    rw [if_neg hzero]
    exact actual_nonzero_cartier_line_fixed_card hdimone C hC hzero

end Litt3.SharedTensors
