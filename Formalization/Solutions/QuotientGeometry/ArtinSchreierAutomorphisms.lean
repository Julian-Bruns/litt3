import Solutions.QuotientGeometry.ArtinSchreierGalois
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.QuotientGeometry

theorem prime_galois_fixed_by_nontrivial
    {K E : Type*} [Field K] [Field E] [Algebra K E] [FiniteDimensional K E] [IsGalois K E]
    (p : ℕ) [Fact p.Prime] (hdegree : Module.finrank K E = p)
    (τ : E ≃ₐ[K] E) (hτ : τ ≠ 1) (x : E) (hfix : τ x = x) :
    ∃ v : K, algebraMap K E v = x := by
  apply (IsGalois.mem_range_algebraMap_iff_fixed x).mpr
  intro σ
  have hcard : Nat.card (E ≃ₐ[K] E) = p := by rw [IsGalois.card_aut_eq_finrank, hdegree]
  have hpowers := zpowers_eq_top_of_prime_card hcard hτ
  have hstab : τ ∈ MulAction.stabilizer (E ≃ₐ[K] E) x := by
    simpa only [MulAction.mem_stabilizer_iff, AlgEquiv.smul_def] using hfix
  have hle : Subgroup.zpowers τ ≤ MulAction.stabilizer (E ≃ₐ[K] E) x :=
    Subgroup.zpowers_le.mpr hstab
  rw [hpowers] at hle
  have hσ := hle (Subgroup.mem_top σ)
  simpa only [MulAction.mem_stabilizer_iff, AlgEquiv.smul_def] using hσ

/-- Every genuine automorphism of an actual irreducible Artin--Schreier
field is translation by a Frobenius-fixed constant in the original base. -/
theorem artin_schreier_automorphism_translation
    {K : Type*} [Field K] (p : ℕ) [Fact p.Prime] [CharP K p] (a : K)
    [Fact (Irreducible (artinSchreierPolynomial p a))]
    (τ : ArtinSchreierAlgebra K p a ≃ₐ[K] ArtinSchreierAlgebra K p a) :
    ∃ c : K, c ^ p = c ∧
      τ (AdjoinRoot.root (artinSchreierPolynomial p a)) =
        AdjoinRoot.root (artinSchreierPolynomial p a) +
          algebraMap K (ArtinSchreierAlgebra K p a) c := by
  let E := ArtinSchreierAlgebra K p a
  letI : Field E := inferInstance
  haveI : CharP E p := charP_of_injective_algebraMap (algebraMap K E).injective p
  let z : E := AdjoinRoot.root (artinSchreierPolynomial p a)
  have hroot : z ^ p - z = algebraMap K E a := artin_schreier_root_equation p a
  have hτroot : (τ z) ^ p - τ z = algebraMap K E a := by
    have h := congrArg τ hroot
    rw [map_sub, map_pow] at h
    exact h.trans (τ.commutes a)
  have hdelta : (τ z - z) ^ p = τ z - z := by
    rw [sub_pow_char]
    linear_combination hτroot - hroot
  have hmem := (Subfield.mem_bot_iff_pow_eq_self E p).mpr hdelta
  obtain ⟨n, hn⟩ := (mem_bot_iff_intCast p E).mp hmem
  refine ⟨(n : K), ?_, ?_⟩
  · apply (algebraMap K E).injective
    simpa only [map_pow, map_intCast, hn] using hdelta
  · rw [map_intCast, hn]
    dsimp only [z]
    ring

end Litt3.QuotientGeometry
