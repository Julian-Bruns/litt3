import Solutions.QuotientGeometry.WeakTamePolynomialSymmetries
import Solutions.QuotientGeometry.WeakTameRootCounts
import Solutions.QuotientGeometry.AffineParameterAutomorphisms
import Solutions.QuotientGeometry.ConstantPolynomialFieldModel
import Solutions.QuotientGeometry.ConstantPoleFieldTransport
import Mathlib.FieldTheory.Galois.Basic

namespace Litt3.QuotientGeometry

/-- Counts distinct genuine affine automorphisms of the WHOLE
original parameter extension against its proved exact degree. -/
theorem weak_tame_normalized_laurent_galois_and_automorphisms
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    let g := weakTamePolynomial p h α γ
    let hg : 0 < g.natDegree := by
      rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
      exact Nat.mul_pos (Fact.out : p.Prime).pos hh
    let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg)
    letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    IsGalois (LaurentSeries k) (LaurentSeries k) ∧
      ∀ σ : LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k,
        ∃ ζ b : k, ζ ^ h = 1 ∧ α * b ^ p + γ * b = 0 ∧
          σ (HahnSeries.single (-1) 1) = HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b := by
  classical
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h hp α γ hα]
    exact Nat.mul_pos (by omega) hh
  let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
    (constant_polynomial_parameter_injective g hg)
  obtain ⟨eG, heG⟩ := constant_polynomial_laurent_field_model g hg
    (weak_tame_polynomial_constant_zero p h hp hh α γ)
  have hdegree := constant_pole_field_model_degree g hg
    (weak_tame_polynomial_constant_zero p h hp hh α γ) Φ eG heG
  let Z : Finset k := (Polynomial.X ^ h - Polynomial.C (1 : k)).roots.toFinset
  let B : Finset k := (linearizedConstantPolynomial p α γ).roots.toFinset
  have hchar : (h : k) ≠ 0 := by
    rw [ne_eq, CharP.cast_eq_zero_iff k p]
    exact Nat.not_dvd_of_pos_of_lt hh (lt_of_le_of_lt (Nat.le_of_dvd (by omega) hdiv) (by omega))
  have hZ : Z.card = h := tame_scalar_roots_card h hh hchar
  have hB : B.card = p := linearized_constant_roots_card p hp α γ hα hγ
  have hζ (z : Z) : z.val ^ h = 1 := (mem_tame_scalar_roots h hh z.val).mp z.property
  have hζzero (z : Z) : z.val ≠ 0 := by
    intro hz
    have hzroot := hζ z
    rw [hz, zero_pow hh.ne'] at hzroot
    exact zero_ne_one hzroot
  have hb (b : B) : α * b.val ^ p + γ * b.val = 0 :=
    (mem_linearized_constant_roots p hp α γ hα b.val).mp b.property
  have hexists (c : Z × B) :
      ∃ E : LaurentSeries k ≃ₐ[k] LaurentSeries k,
        (∀ r : LaurentSeries k, E (Φ r) = Φ r) ∧
        E (HahnSeries.single (-1) 1) = HahnSeries.C c.1.val * HahnSeries.single (-1) 1 +
          HahnSeries.C c.2.val :=
    constant_polynomial_affine_parameter_automorphism g hg c.1.val c.2.val (hζzero c.1)
      (weak_tame_polynomial_affine_symmetry p h α γ c.1.val c.2.val
        (tame_scalar_frobenius_fixed p h hp hdiv c.1.val (hζ c.1)) (hζ c.1) (hb c.2))
  choose E hE hEpole using hexists
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) := hdegree.1
  have hrank : Module.finrank (LaurentSeries k) (LaurentSeries k) = p * h := by
    simpa only [g, weak_tame_polynomial_degree p h hp α γ hα] using hdegree.2
  let A (c : Z × B) : LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k :=
    { __ := (E c).toRingEquiv
      commutes' := fun r => hE c r }
  have hinj : Function.Injective A := by
    intro c d heq
    have hpoleeq := congrArg (fun σ : LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k =>
      σ (HahnSeries.single (-1) 1)) heq
    change E c (HahnSeries.single (-1) 1) = E d (HahnSeries.single (-1) 1) at hpoleeq
    rw [hEpole, hEpole] at hpoleeq
    have hz := congrArg (fun f : LaurentSeries k => f.coeff (-1)) hpoleeq
    have hb := congrArg (fun f : LaurentSeries k => f.coeff 0) hpoleeq
    have hzc : c.1.val = d.1.val := by
      simpa [HahnSeries.C_apply, HahnSeries.single_mul_single] using hz
    have hbc : c.2.val = d.2.val := by
      simpa [HahnSeries.C_apply, HahnSeries.single_mul_single] using hb
    exact Prod.ext (Subtype.ext hzc) (Subtype.ext hbc)
  have hcardlower : p * h ≤ Nat.card (LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k) := by
    have hcardinj := Nat.card_le_card_of_injective A hinj
    simpa only [Nat.card_prod, Nat.card_eq_fintype_card, Fintype.card_prod,
      Fintype.card_coe, hZ, hB, Nat.mul_comm] using hcardinj
  have hcard : Nat.card (LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k) =
      Module.finrank (LaurentSeries k) (LaurentSeries k) := by
    apply Nat.le_antisymm
    · simpa only [Fintype.card_eq_nat_card] using
      (AlgEquiv.card_le (F := LaurentSeries k) (K := LaurentSeries k))
    · rwa [hrank]
  haveI : IsGalois (LaurentSeries k) (LaurentSeries k) :=
    IsGalois.of_card_aut_eq_finrank (LaurentSeries k) (LaurentSeries k) hcard
  refine ⟨inferInstance, ?_⟩
  intro σ
  have hdom : Fintype.card (Z × B) =
      Fintype.card (LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k) := by
    rw [Fintype.card_prod, Fintype.card_coe, Fintype.card_coe, hZ, hB,
      Fintype.card_eq_nat_card, hcard, hrank]
    exact Nat.mul_comm h p
  have hsurj : Function.Surjective A :=
    ((Fintype.bijective_iff_injective_and_card A).mpr ⟨hinj, hdom⟩).2
  obtain ⟨c, hc⟩ := hsurj σ
  refine ⟨c.1.val, c.2.val, hζ c.1, hb c.2, ?_⟩
  rw [← hc]
  exact hEpole c

theorem weak_tame_normalized_laurent_galois
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    let g := weakTamePolynomial p h α γ
    let hg : 0 < g.natDegree := by
      rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
      exact Nat.mul_pos (Fact.out : p.Prime).pos hh
    let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg)
    letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    IsGalois (LaurentSeries k) (LaurentSeries k) :=
  (weak_tame_normalized_laurent_galois_and_automorphisms p h hh hdiv α γ hα hγ).1

end Litt3.QuotientGeometry
