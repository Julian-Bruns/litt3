import Theorems.QuotientGeometry.FreeFiniteActions
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- Evaluation at a point embeds a freely acting group into its fiber. -/
theorem free_action_evaluation_injective
    {G A : Type*} [Group G] [MulAction G A]
    (hfree : FixedPointFreeAction G A) (a : A) :
    Function.Injective (fun g : G => g • a) := by
  intro g h heq
  change g • a = h • a at heq
  have hfixed : (h⁻¹ * g) • a = a := by
    rw [mul_smul, heq, inv_smul_smul]
  have hone : h⁻¹ * g = 1 := hfree _ _ hfixed
  exact (inv_mul_eq_one.mp hone).symm

theorem free_action_card_le_fiber
    {G A : Type*} [Group G] [Fintype G] [Fintype A] [MulAction G A]
    (hfree : FixedPointFreeAction G A) (a : A) :
    Fintype.card G ≤ Fintype.card A :=
  Fintype.card_le_of_injective _ (free_action_evaluation_injective hfree a)

theorem small_fiber_free_action_bound
    {G A : Type*} [Group G] [Fintype G] [Fintype A] [MulAction G A]
    (hfree : FixedPointFreeAction G A) (hne : Nonempty A)
    (hsmall : Fintype.card A ≤ 2) : Fintype.card G ≤ 2 := by
  obtain ⟨a⟩ := hne
  exact (free_action_card_le_fiber hfree a).trans hsmall

theorem small_fiber_free_action_target : Targets.SmallFiberFreeActionBound := by
  intro G A instGroup instG instA instAction hfree hne hsmall
  exact small_fiber_free_action_bound hfree hne hsmall

/-- Freeness gives exact cardinal divisibility, not only an upper bound. -/
theorem free_action_card_dvd_fiber
    {G A : Type*} [Group G] [Fintype G] [Fintype A] [MulAction G A]
    (hfree : FixedPointFreeAction G A) : Fintype.card G ∣ Fintype.card A := by
  classical
  have hstab : ∀ a : A, MulAction.stabilizer G a = ⊥ := by
    intro a
    apply (Subgroup.eq_bot_iff_forall _).mpr
    intro g hg
    exact hfree g a hg
  letI := Fintype.ofFinite (MulAction.orbitRel.Quotient G A)
  have hcard := Fintype.card_congr (MulAction.selfEquivOrbitsQuotientProd hstab)
  rw [Fintype.card_prod] at hcard
  rw [hcard]
  exact dvd_mul_left _ _

/-- Every element of a group freely acting on a nonempty two-point fiber
has square one. This isolates the cyclic-fiber part of the geometric proof. -/
theorem small_fiber_elements_square_one
    {G A : Type*} [Group G] [Fintype G] [Fintype A] [MulAction G A]
    (hfree : FixedPointFreeAction G A) (hne : Nonempty A)
    (hsmall : Fintype.card A ≤ 2) (g : G) : g ^ 2 = 1 := by
  have hbound := small_fiber_free_action_bound hfree hne hsmall
  have hpositive : 0 < Fintype.card G := Fintype.card_pos_iff.mpr inferInstance
  have hcases : Fintype.card G = 1 ∨ Fintype.card G = 2 := by omega
  rcases hcases with hcard | hcard
  · have hpow : g ^ Fintype.card G = 1 := pow_card_eq_one
    rw [hcard, pow_one] at hpow
    simp [hpow]
  · simpa only [hcard] using (pow_card_eq_one : g ^ Fintype.card G = 1)

/-- Any group of exponent two is abelian, without finiteness assumptions. -/
theorem exponent_two_elements_commute
    {G : Type*} [Group G] (hexponent : ∀ g : G, g ^ 2 = 1) (g h : G) :
    g * h = h * g := by
  have hinv : ∀ x : G, x⁻¹ = x := by
    intro x
    apply inv_eq_of_mul_eq_one_left
    simpa only [pow_two] using hexponent x
  calc
    g * h = (g * h)⁻¹ := (hinv _).symm
    _ = h⁻¹ * g⁻¹ := mul_inv_rev _ _
    _ = h * g := by rw [hinv h, hinv g]

end Litt3.QuotientGeometry
