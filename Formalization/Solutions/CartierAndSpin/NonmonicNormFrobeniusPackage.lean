import Solutions.CartierAndSpin.NormSourceNormalization
import Theorems.CartierAndSpin.NormFrobeniusRemainder

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The full positive-degree finite source-algebra theorem, including
nonmonic and disconnected separable source polynomials. -/
theorem nonmonic_source_norm_frobenius_remainder_package (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f)
    (F : K[X]) (hsep : F.Separable) (hpositive : 0 < F.natDegree) :
    Specifications.SourceNormFrobeniusRemainder p f F := by
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, natDegree_zero] at hpositive
    exact (lt_irrefl 0) hpositive
  constructor
  · constructor
    · intro hnorm
      obtain ⟨H, tau, htau, hsource⟩ :=
        nonmonic_source_norm_frobenius_remainder p hp f hnot F hF hsep hnorm
      refine ⟨(H, tau), ⟨htau, hsource⟩, ?_⟩
      intro other hother
      let L := AlgebraicClosure K
      obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq
        (-(algebraMap K L) f) hp.pos
      have h := inseparable_remainder_presentation_unique p hp f c hc F
        other.1 H other.2 tau hother.2 hsource
      exact Prod.ext h.1 h.2
    · rintro ⟨remainder, hsource, _⟩
      exact nonmonic_source_frobenius_remainder_norm p hp f F remainder.1 remainder.2
        hsource.1 hF hsep hsource.2
  · intro hnorm
    obtain ⟨H, tau, _htau, hsource⟩ :=
      nonmonic_source_norm_frobenius_remainder p hp f hnot F hF hsep hnorm
    exact frobenius_remainder_positive_degree_bound p hp.pos f F H tau hpositive hsource

end Litt3.CartierAndSpin
