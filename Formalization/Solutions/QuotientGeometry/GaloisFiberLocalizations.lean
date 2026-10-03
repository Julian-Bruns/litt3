import Mathlib.FieldTheory.Galois.IsGaloisGroup
import Mathlib.RingTheory.Localization.AtPrime.Basic

namespace Litt3.QuotientGeometry

open scoped Pointwise

variable {A R : Type*} [CommRing A] [CommRing R] [Algebra A R]

theorem prime_complement_map_of_equiv
    (e : R ≃ₐ[A] R) (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hP : P = Q.comap e.toRingHom) :
    Submonoid.map e P.primeCompl = Q.primeCompl := by
  ext x
  simp only [Submonoid.mem_map]
  constructor
  · rintro ⟨y, hy, rfl⟩
    change e y ∉ Q
    intro hz
    apply hy
    rw [hP]
    exact hz
  · intro hx
    refine ⟨e.symm x, ?_, e.apply_symm_apply x⟩
    change e.symm x ∉ P
    rw [hP]
    change e (e.symm x) ∉ Q
    simpa only [e.apply_symm_apply] using hx

/-- A genuine base-algebra automorphism carrying one actual prime to
another constructs an equivalence of their actual local rings. -/
noncomputable def primeLocalizationAlgEquiv
    (e : R ≃ₐ[A] R) (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hP : P = Q.comap e.toRingHom) :
    Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q :=
  IsLocalization.algEquivOfAlgEquiv _ _ e (prime_complement_map_of_equiv e P Q hP)

theorem primeLocalizationAlgEquiv_ring
    (e : R ≃ₐ[A] R) (P Q : Ideal R) [P.IsPrime] [Q.IsPrime]
    (hP : P = Q.comap e.toRingHom) (r : R) :
    primeLocalizationAlgEquiv e P Q hP (algebraMap R (Localization.AtPrime P) r) =
      algebraMap R (Localization.AtPrime Q) (e r) :=
  IsLocalization.algEquivOfAlgEquiv_eq (h := e) (prime_complement_map_of_equiv e P Q hP) r

variable {G : Type*} [Group G] [Finite G] [MulSemiringAction G R]
  [SMulCommClass G A R] [Algebra.IsInvariant A R G]

/-- For an actual finite invariant/Galois coordinate-ring extension,
EVERY pair of primes above the SAME base prime has a constructed
base-algebra equivalence of its actual local rings. Both transitivity
and the equivalence are derived from the true finite group action. -/
theorem galois_fiber_actual_local_rings_equivalent
    (P Q : Ideal R) [P.IsPrime] [Q.IsPrime] (hPQ : P.under A = Q.under A) :
    ∃ (g : G) (e : Localization.AtPrime P ≃ₐ[A] Localization.AtPrime Q),
      Q = g • P ∧
      ∀ r : R, e (algebraMap R (Localization.AtPrime P) r) =
        algebraMap R (Localization.AtPrime Q) (g • r) := by
  obtain ⟨g, hg⟩ := Algebra.IsInvariant.exists_smul_of_under_eq A R G P Q hPQ
  let e := MulSemiringAction.toAlgAut G A R g
  have hP : P = Q.comap e.toRingHom := by
    ext r
    change r ∈ P ↔ g • r ∈ Q
    rw [hg]
    exact Ideal.smul_mem_pointwise_smul_iff.symm
  refine ⟨g, primeLocalizationAlgEquiv e P Q hP, hg, ?_⟩
  intro r
  exact primeLocalizationAlgEquiv_ring e P Q hP r

end Litt3.QuotientGeometry
