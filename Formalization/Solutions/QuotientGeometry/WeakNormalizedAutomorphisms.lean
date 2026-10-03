import Solutions.QuotientGeometry.WeakAffineSemidirect
import Solutions.QuotientGeometry.WeakTameGalois
import Solutions.QuotientGeometry.FixedEmbeddingAutomorphisms

namespace Litt3.QuotientGeometry

noncomputable def weakNormalizedEmbedding
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (α γ : k) (hα : α ≠ 0) : LaurentSeries k →+* LaurentSeries k :=
  let g := weakTamePolynomial p h α γ
  let hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    exact Nat.mul_pos (Fact.out : p.Prime).pos hh
  parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
    (constant_polynomial_parameter_injective g hg)

noncomputable abbrev WeakNormalizedAutomorphisms
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (α γ : k) (hα : α ≠ 0) :=
  fixedEmbeddingAutomorphisms (weakNormalizedEmbedding p h hh α γ hα)

theorem weak_normalized_automorphisms_card
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    Nat.card (WeakNormalizedAutomorphisms p h hh α γ hα) = p * h := by
  let Φ := weakNormalizedEmbedding p h hh α γ hα
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := Φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  haveI : IsGalois (LaurentSeries k) (LaurentSeries k) :=
    weak_tame_normalized_laurent_galois p h hh hdiv α γ hα hγ
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    exact Nat.mul_pos (Fact.out : p.Prime).pos hh
  obtain ⟨e, he⟩ := constant_polynomial_laurent_field_model g hg
    (weak_tame_polynomial_constant_zero p h (Fact.out : p.Prime).one_lt hh α γ)
  have hdegree := constant_pole_field_model_degree g hg
    (weak_tame_polynomial_constant_zero p h (Fact.out : p.Prime).one_lt hh α γ) Φ e he
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) := hdegree.1
  rw [fixed_embedding_automorphisms_card Φ]
  rw [IsGalois.card_aut_eq_finrank]
  simpa only [g, weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    using hdegree.2

noncomputable def weakNormalizedAffineAutomorphism
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0)
    (ζ : rootsOfUnity h k) (b : linearizedTranslationGroup p α γ) :
    WeakNormalizedAutomorphisms p h hh α γ hα := by
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    exact Nat.mul_pos (Fact.out : p.Prime).pos hh
  have hζ : (ζ.val : k) ^ h = 1 := (mem_rootsOfUnity' h ζ.val).mp ζ.property
  have hfix := tame_scalar_frobenius_fixed p h (Fact.out : p.Prime).one_lt hdiv
    (ζ.val : k) hζ
  let data := constant_polynomial_affine_parameter_automorphism g hg (ζ.val : k) b.val
    ζ.val.ne_zero (weak_tame_polynomial_affine_symmetry p h α γ (ζ.val : k) b.val
      hfix hζ b.property)
  exact ⟨data.choose.toRingEquiv, data.choose_spec.1⟩

theorem weak_normalized_affine_automorphism_pole
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0)
    (ζ : rootsOfUnity h k) (b : linearizedTranslationGroup p α γ) :
    (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα ζ b).val (HahnSeries.single (-1) 1) =
      HahnSeries.C (ζ.val : k) * HahnSeries.single (-1) 1 + HahnSeries.C b.val := by
  let g := weakTamePolynomial p h α γ
  have hg : 0 < g.natDegree := by
    rw [weak_tame_polynomial_degree p h (Fact.out : p.Prime).one_lt α γ hα]
    exact Nat.mul_pos (Fact.out : p.Prime).pos hh
  have hζ : (ζ.val : k) ^ h = 1 := (mem_rootsOfUnity' h ζ.val).mp ζ.property
  have hfix := tame_scalar_frobenius_fixed p h (Fact.out : p.Prime).one_lt hdiv
    (ζ.val : k) hζ
  exact (constant_polynomial_affine_parameter_automorphism g hg (ζ.val : k) b.val
    ζ.val.ne_zero (weak_tame_polynomial_affine_symmetry p h α γ (ζ.val : k) b.val
      hfix hζ b.property)).choose_spec.2

end Litt3.QuotientGeometry
