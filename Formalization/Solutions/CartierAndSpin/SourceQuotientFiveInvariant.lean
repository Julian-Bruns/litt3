import Solutions.CartierAndSpin.SourceQuotientMomentTranslation
import Solutions.CartierAndSpin.CharacteristicFiveMomentInvariant

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K] [CharP K 5]

/-- The characteristic-five invariant I is literally invariant in
the actual translated quotient, not just in the old quotient's new
coordinate or after multiplication by an unverified scalar. -/
theorem source_quotient_five_invariant_translation (D : Derivation R K K)
    (F H : K[X]) (q tau : K) (hdegree : 5 ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hs : (H %ₘ (X ^ 5 + C q)).coeff 4 = 0) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      ∀ b : K,
        let quotientEquiv := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let E' := transportedDerivation (quotientEquiv.symm.restrictScalars R) E
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) =
          functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F)) := by
  obtain ⟨unit, E, hunit, compatible, hzero, hone, htranslations⟩ :=
    source_quotient_moment_translation D F H 5 q tau (by omega) hdegree htau hsep hsource
      (by simpa only [Nat.reduceSub] using hs)
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro b
  dsimp only
  obtain ⟨hunit', compatible', hmoments, htwo, hdisc⟩ := htranslations b
  rw [functional_discriminant_eq_three_five_invariant,
    functional_discriminant_eq_three_five_invariant] at hdisc
  have hthree : (3 : K) ≠ 0 := by
    change ((3 : ℕ) : K) ≠ 0
    rw [Ne, CharP.cast_eq_zero_iff K 5]
    norm_num
  exact mul_left_cancel₀ hthree hdisc

end Litt3.CartierAndSpin
