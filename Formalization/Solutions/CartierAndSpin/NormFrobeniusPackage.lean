import Solutions.CartierAndSpin.NormFrobeniusRemainder
import Solutions.CartierAndSpin.RationalFieldTraceExtension
import Theorems.CartierAndSpin.NormFrobeniusRemainder

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- All positive-degree finite source-algebra clauses, proved for every
field of prime characteristic, without numerical computation or literature
inputs specific to function fields. -/
theorem source_norm_frobenius_remainder_package (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f)
    (F : K[X]) (hmonic : F.Monic) (hsep : F.Separable)
    (hpositive : 0 < F.natDegree) :
    Specifications.SourceNormFrobeniusRemainder p f F := by
  constructor
  · constructor
    · intro hnorm
      obtain ⟨H, tau, htau, hsource⟩ :=
        source_norm_frobenius_remainder p hp f hnot F hmonic hsep hnorm
      refine ⟨(H, tau), ⟨htau, hsource⟩, ?_⟩
      intro other hother
      let L := AlgebraicClosure K
      obtain ⟨c, hc⟩ := IsAlgClosed.exists_pow_nat_eq
        (-(algebraMap K L) f) hp.pos
      have h := inseparable_remainder_presentation_unique p hp f c hc F
        other.1 H other.2 tau hother.2 hsource
      exact Prod.ext h.1 h.2
    · rintro ⟨remainder, hsource, _⟩
      exact source_frobenius_remainder_norm p hp f F remainder.1 remainder.2
        hsource.1 hmonic hsep hsource.2
  · intro hnorm
    obtain ⟨H, tau, _htau, hsource⟩ :=
      source_norm_frobenius_remainder p hp f hnot F hmonic hsep hnorm
    exact frobenius_remainder_positive_degree_bound p hp.pos f F H tau hpositive hsource

section PrimitiveField

variable {L : Type*} [Field L] [Algebra K L]
  [FiniteDimensional K L] [Algebra.IsSeparable K L]

/-- The original primitive-field theorem, retaining both the actual field
norm and the actual minimal polynomial. Its source presentation and full
power basis are constructed from literal generation. -/
theorem primitive_norm_frobenius_remainder_package (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f) (b : L)
    (hgen : IntermediateField.adjoin K ({b} : Set L) = ⊤) :
    Specifications.PrimitiveNormFrobeniusRemainder p f b := by
  let F := minpoly K b
  have hb : IsIntegral K b := Algebra.IsIntegral.isIntegral b
  have hmonic : F.Monic := minpoly.monic hb
  have hsep : F.Separable := Algebra.IsSeparable.isSeparable K b
  have hroot : aeval b F = 0 := minpoly.aeval K b
  obtain ⟨pb, hpb, hdim⟩ := primitive_field_power_basis b F hmonic.ne_zero hroot hgen
  have hdegree : F.natDegree = Module.finrank K L := by
    rw [← hdim, Module.finrank_eq_card_basis pb.basis, Fintype.card_fin]
  obtain ⟨e, he⟩ := primitive_raw_field_quotient_equiv b F hmonic.ne_zero hroot hgen hdegree
  have hphi : e (AdjoinRoot.mk F (X ^ p + C f)) =
      b ^ p + algebraMap K L f := by
    change e ((AdjoinRoot.root F) ^ p + algebraMap K (AdjoinRoot F) f) = _
    rw [map_add, map_pow, e.commutes, he]
  have hnorm : Algebra.norm K (b ^ p + algebraMap K L f) =
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) := by
    rw [← hphi]
    exact Algebra.norm_eq_of_algEquiv e _
  have h := source_norm_frobenius_remainder_package p hp f hnot F hmonic hsep
    (minpoly.natDegree_pos hb)
  simpa only [Specifications.SourceNormFrobeniusRemainder,
    Specifications.PrimitiveNormFrobeniusRemainder, hnorm, F] using h

end PrimitiveField

end Litt3.CartierAndSpin
