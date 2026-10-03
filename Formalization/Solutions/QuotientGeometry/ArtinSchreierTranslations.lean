import Definitions.QuotientGeometry.ArtinSchreierPolynomial
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.QuotientGeometry

theorem artin_schreier_monic_degree
    {R : Type*} [CommRing R] [Nontrivial R] (p : ℕ) (hp : 1 < p) (a : R) :
    (artinSchreierPolynomial p a).Monic ∧ (artinSchreierPolynomial p a).natDegree = p := by
  have hlower : (Polynomial.X + Polynomial.C a).degree < (p : WithBot ℕ) := by
    exact lt_of_le_of_lt (Polynomial.degree_add_le _ _) (max_lt
      (by simpa using (show (1 : WithBot ℕ) < p by exact_mod_cast hp))
      (lt_of_le_of_lt Polynomial.degree_C_le (by exact_mod_cast (by omega : 0 < p))))
  have heq : artinSchreierPolynomial p a = Polynomial.X ^ p -
      (Polynomial.X + Polynomial.C a) := by simp only [artinSchreierPolynomial]; ring
  rw [heq]
  refine ⟨Polynomial.monic_X_pow_sub hlower, Polynomial.natDegree_eq_of_degree_eq_some ?_⟩
  rw [Polynomial.degree_sub_eq_left_of_degree_lt (by simpa using hlower), Polynomial.degree_X_pow]

theorem artin_schreier_root_equation
    {R : Type*} [CommRing R] (p : ℕ) (a : R) :
    let z := AdjoinRoot.root (artinSchreierPolynomial p a)
    z ^ p - z = algebraMap R (ArtinSchreierAlgebra R p a) a := by
  have h := AdjoinRoot.eval₂_root (artinSchreierPolynomial p a)
  simpa [artinSchreierPolynomial, sub_eq_zero] using h

theorem artin_schreier_shifted_root
    {R : Type*} [CommRing R] [IsDomain R] (p : ℕ) [Fact p.Prime] [CharP R p]
    (a c : R) (hc : c ^ p = c) :
    (artinSchreierPolynomial p a).eval₂
      (algebraMap R (ArtinSchreierAlgebra R p a))
      (AdjoinRoot.root (artinSchreierPolynomial p a) +
        algebraMap R (ArtinSchreierAlgebra R p a) c) = 0 := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  have hdegree : (artinSchreierPolynomial p a).degree ≠ 0 := by
    intro h
    have hn : (artinSchreierPolynomial p a).natDegree = (0 : ℕ) :=
      Polynomial.natDegree_eq_of_degree_eq_some h
    rw [(artin_schreier_monic_degree p hp a).2] at hn
    omega
  haveI : CharP (ArtinSchreierAlgebra R p a) p :=
    charP_of_injective_ringHom (AdjoinRoot.of.injective_of_degree_ne_zero hdegree) p
  have hroot := artin_schreier_root_equation p a
  dsimp only [artinSchreierPolynomial] at hroot
  simp only [artinSchreierPolynomial, Polynomial.eval₂_sub, Polynomial.eval₂_pow,
    Polynomial.eval₂_X, Polynomial.eval₂_C, add_pow_char, ← map_pow, hc]
  linear_combination hroot

/-- Every Frobenius-fixed base element gives a genuine translation
automorphism of the actual polynomial quotient over every domain. -/
theorem artin_schreier_translation_exists
    {R : Type*} [CommRing R] [IsDomain R] (p : ℕ) [Fact p.Prime] [CharP R p]
    (a c : R) (hc : c ^ p = c) :
    ∃ e : ArtinSchreierAlgebra R p a ≃ₐ[R] ArtinSchreierAlgebra R p a,
      e (AdjoinRoot.root (artinSchreierPolynomial p a)) =
        AdjoinRoot.root (artinSchreierPolynomial p a) +
          algebraMap R (ArtinSchreierAlgebra R p a) c := by
  let A := ArtinSchreierAlgebra R p a
  let z : A := AdjoinRoot.root (artinSchreierPolynomial p a)
  have hneg : (-c) ^ p = -c := by
    rw [← frobenius_def, map_neg, frobenius_def, hc]
  let f : A →ₐ[R] A := AdjoinRoot.liftAlgHom (artinSchreierPolynomial p a)
    (Algebra.ofId R A) (z + algebraMap R A c) (artin_schreier_shifted_root p a c hc)
  let g : A →ₐ[R] A := AdjoinRoot.liftAlgHom (artinSchreierPolynomial p a)
    (Algebra.ofId R A) (z + algebraMap R A (-c)) (artin_schreier_shifted_root p a (-c) hneg)
  have hf : f z = z + algebraMap R A c := AdjoinRoot.liftAlgHom_root _ _ _ _
  have hg : g z = z + algebraMap R A (-c) := AdjoinRoot.liftAlgHom_root _ _ _ _
  have hgf : g.comp f = AlgHom.id R A := by
    apply AdjoinRoot.algHom_ext
    change g (f z) = z
    rw [hf, map_add, g.commutes, hg, map_neg]
    ring
  have hfg : f.comp g = AlgHom.id R A := by
    apply AdjoinRoot.algHom_ext
    change f (g z) = z
    rw [hg, map_add, f.commutes, hf, map_neg]
    ring
  refine ⟨AlgEquiv.ofAlgHom f g hfg hgf, ?_⟩
  exact hf

end Litt3.QuotientGeometry
