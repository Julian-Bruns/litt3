import Solutions.QuotientGeometry.ArtinSchreierAutomorphisms
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.QuotientGeometry

/-- An actual fixed-base isomorphism of irreducible Artin--Schreier fields
forces the actual defining classes to differ by a nonzero prime-field
scalar and a genuine base-field coboundary. -/
theorem artin_schreier_equiv_implies_line_relation
    {K : Type*} [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (a b : K)
    [Fact (Irreducible (artinSchreierPolynomial p a))]
    [Fact (Irreducible (artinSchreierPolynomial p b))]
    (φ : ArtinSchreierAlgebra K p a ≃ₐ[K] ArtinSchreierAlgebra K p b) :
    ∃ c v : K, c ≠ 0 ∧ c ^ p = c ∧ a - c * b = v ^ p - v := by
  classical
  let A := ArtinSchreierAlgebra K p a
  let B := ArtinSchreierAlgebra K p b
  letI : Field A := inferInstance
  letI : Field B := inferInstance
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI : FiniteDimensional K B := (artin_schreier_monic_degree p hp b).1.finite_adjoinRoot
  haveI : IsGalois K B := artin_schreier_galois p b
  haveI : CharP B p := charP_of_injective_algebraMap (algebraMap K B).injective p
  let z : A := AdjoinRoot.root (artinSchreierPolynomial p a)
  let t : B := AdjoinRoot.root (artinSchreierPolynomial p b)
  obtain ⟨τ, hτroot⟩ := artin_schreier_translation_exists p b (1 : K) (by simp)
  have hτ : τ ≠ 1 := by
    intro h
    simpa [h] using hτroot
  let τA : A ≃ₐ[K] A := (φ.trans τ).trans φ.symm
  have hτA : τA ≠ 1 := by
    intro h
    apply hτ
    ext x
    have hx := congrArg (fun e : A ≃ₐ[K] A => φ (e (φ.symm x))) h
    dsimp only [τA, AlgEquiv.trans_apply] at hx
    rw [φ.apply_symm_apply, φ.apply_symm_apply] at hx
    simpa only [AlgEquiv.one_apply, φ.apply_symm_apply] using hx
  obtain ⟨c, hcfrob, hcroot⟩ := artin_schreier_automorphism_translation p a τA
  have hc : c ≠ 0 := by
    intro hzero
    apply hτA
    apply AlgEquiv.coe_algHom_injective
    apply AdjoinRoot.algHom_ext
    simpa [hzero] using hcroot
  let y : B := φ z
  have hτy : τ y = y + algebraMap K B c := by
    calc
      τ y = φ (τA z) := (φ.apply_symm_apply (τ (φ z))).symm
      _ = φ z + algebraMap K B c := by rw [hcroot, map_add, φ.commutes]
      _ = y + algebraMap K B c := rfl
  have hfix : τ (y - algebraMap K B c * t) = y - algebraMap K B c * t := by
    rw [map_sub, map_mul, τ.commutes, hτy]
    change y + algebraMap K B c - algebraMap K B c * τ t = _
    rw [show τ t = t + 1 by simpa [t] using hτroot]
    ring
  obtain ⟨v, hv⟩ := prime_galois_fixed_by_nontrivial p
    (artin_schreier_field_degree p hp b) τ hτ (y - algebraMap K B c * t) hfix
  refine ⟨c, v, hc, hcfrob, ?_⟩
  have hy : y ^ p - y = algebraMap K B a := by
    have h := congrArg φ (artin_schreier_root_equation p a)
    rw [map_sub, map_pow] at h
    exact h.trans (φ.commutes a)
  have ht : t ^ p - t = algebraMap K B b := artin_schreier_root_equation p b
  apply (algebraMap K B).injective
  rw [map_sub, map_mul, map_sub, map_pow, hv, sub_pow_char, mul_pow]
  rw [← map_pow (algebraMap K B) c p, hcfrob]
  linear_combination -hy + algebraMap K B c * ht

/-- A genuine base coboundary and nonzero Frobenius-fixed scalar
construct an actual field isomorphism by the universal root map. -/
theorem artin_schreier_line_relation_implies_equiv
    {K : Type*} [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (a b c v : K)
    [Fact (Irreducible (artinSchreierPolynomial p a))]
    [Fact (Irreducible (artinSchreierPolynomial p b))]
    (hc : c ≠ 0) (hcfrob : c ^ p = c) (hline : a - c * b = v ^ p - v) :
    Nonempty (ArtinSchreierAlgebra K p a ≃ₐ[K] ArtinSchreierAlgebra K p b) := by
  let A := ArtinSchreierAlgebra K p a
  let B := ArtinSchreierAlgebra K p b
  letI : Field A := inferInstance
  letI : Field B := inferInstance
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI : FiniteDimensional K A := (artin_schreier_monic_degree p hp a).1.finite_adjoinRoot
  haveI : FiniteDimensional K B := (artin_schreier_monic_degree p hp b).1.finite_adjoinRoot
  haveI : CharP B p := charP_of_injective_algebraMap (algebraMap K B).injective p
  let t : B := AdjoinRoot.root (artinSchreierPolynomial p b)
  let y : B := algebraMap K B c * t + algebraMap K B v
  have ht : t ^ p - t = algebraMap K B b := artin_schreier_root_equation p b
  have hy : y ^ p - y = algebraMap K B a := by
    have h := congrArg (algebraMap K B) hline
    simp only [map_sub, map_mul, map_pow] at h
    dsimp only [y]
    rw [add_pow_char, mul_pow, ← map_pow (algebraMap K B) c p, hcfrob]
    linear_combination -h + algebraMap K B c * ht
  have hroot : (artinSchreierPolynomial p a).eval₂ (algebraMap K B) y = 0 := by
    simpa [artinSchreierPolynomial, sub_eq_zero] using hy
  let f : A →ₐ[K] B := AdjoinRoot.liftAlgHom (artinSchreierPolynomial p a)
    (Algebra.ofId K B) y hroot
  have hdim : Module.finrank K A = Module.finrank K B := by
    rw [artin_schreier_field_degree p hp a, artin_schreier_field_degree p hp b]
  have hsurj : Function.Surjective f :=
    (LinearMap.injective_iff_surjective_of_finrank_eq_finrank hdim (f := f.toLinearMap)).mp f.injective
  exact ⟨AlgEquiv.ofBijective f ⟨f.injective, hsurj⟩⟩

theorem artin_schreier_fields_equiv_iff
    {K : Type*} [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (a b : K)
    [Fact (Irreducible (artinSchreierPolynomial p a))]
    [Fact (Irreducible (artinSchreierPolynomial p b))] :
    Nonempty (ArtinSchreierAlgebra K p a ≃ₐ[K] ArtinSchreierAlgebra K p b) ↔
      ∃ c v : K, c ≠ 0 ∧ c ^ p = c ∧ a - c * b = v ^ p - v := by
  constructor
  · rintro ⟨φ⟩
    exact artin_schreier_equiv_implies_line_relation p a b φ
  · rintro ⟨c, v, hc, hcfrob, hline⟩
    exact artin_schreier_line_relation_implies_equiv p a b c v hc hcfrob hline

end Litt3.QuotientGeometry
