import Solutions.QuotientGeometry.ArtinSchreierTranslations
import Mathlib.FieldTheory.Galois.Basic
import Mathlib.FieldTheory.Finite.Basic

namespace Litt3.QuotientGeometry

theorem artin_schreier_field_degree
    {K : Type*} [Field K] (p : ℕ) (hp : 1 < p) (a : K) :
    Module.finrank K (ArtinSchreierAlgebra K p a) = p := by
  change Module.finrank K (Polynomial K ⧸ Ideal.span {artinSchreierPolynomial p a}) = p
  rw [finrank_quotient_span_eq_natDegree, (artin_schreier_monic_degree p hp a).2]

/-- Irreducibility and prime characteristic produce every translation
in the actual degree-p field. Counting genuine automorphisms against the
exact degree proves Galoisness without an assumed splitting statement. -/
theorem artin_schreier_galois
    {K : Type*} [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (a : K)
    [Fact (Irreducible (artinSchreierPolynomial p a))] :
    IsGalois K (ArtinSchreierAlgebra K p a) := by
  classical
  let E := ArtinSchreierAlgebra K p a
  letI : Field E := inferInstance
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI : FiniteDimensional K E :=
    (artin_schreier_monic_degree p hp a).1.finite_adjoinRoot
  let cast : ZMod p →+* K := ZMod.castHom (dvd_refl p) K
  have hfixed (c : ZMod p) : (cast c) ^ p = cast c := by
    rw [← map_pow]
    congr 1
    simpa only [ZMod.card] using FiniteField.pow_card c
  choose e he using fun c : ZMod p => artin_schreier_translation_exists p a (cast c) (hfixed c)
  have hinjective : Function.Injective e := by
    intro c d h
    apply cast.injective
    apply (algebraMap K E).injective
    have hroot := congrArg (fun f : E ≃ₐ[K] E => f (AdjoinRoot.root (artinSchreierPolynomial p a))) h
    dsimp only at hroot
    rw [he c, he d] at hroot
    exact add_left_cancel hroot
  have hcardlower : p ≤ Nat.card (E ≃ₐ[K] E) := by
    simpa only [Nat.card_zmod] using Nat.card_le_card_of_injective e hinjective
  have hcard : Nat.card (E ≃ₐ[K] E) = Module.finrank K E := by
    apply le_antisymm
    · simpa only [Fintype.card_eq_nat_card] using (AlgEquiv.card_le (F := K) (K := E))
    · simpa only [E, artin_schreier_field_degree p hp a] using hcardlower
  exact IsGalois.of_card_aut_eq_finrank K E hcard

end Litt3.QuotientGeometry
