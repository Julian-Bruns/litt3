import Solutions.CartierAndSpin.ActualSourceUnitMomentIntegrality
import Solutions.CartierAndSpin.CharacteristicFiveMomentInvariant
import Solutions.CartierAndSpin.UnsplitMomentTranslation

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]
  [CharP K 5] [Fintype ι]

/-- The actual source boundary invariants remain integral after every
meromorphic source translation, though the translated roots need not
themselves belong to the local subring. -/
theorem source_boundary_subring_integrality (S : Subring K) (D : Derivation R K K)
    (F H : K[X]) (q tau leading : K) (node : ι → K)
    (hdegree : 5 ≤ F.natDegree) (hsep : F.Separable) (hinj : Function.Injective node)
    (hleading : leading ≠ 0) (htau : tau ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal Finset.univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hs : (H %ₘ (X ^ 5 + C q)).coeff 4 = 0)
    (hD : ∀ x ∈ S, D x ∈ S) (hnodes : ∀ i, node i ∈ S)
    (hInv : ∀ i, (node i ^ 5 + q)⁻¹ ∈ S) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      (∀ n, functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) n ∈ S) ∧
      ∀ b : K,
        functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
          (E (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)) 2 ∈ S ∧
        functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
          (E (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)) ∈ S := by
  obtain ⟨unit, E, hunit, compatible, hzero, hone, htranslations⟩ :=
    sourceTraceZeroMomentTranslations D F H 5 q tau (by omega) hdegree htau hsep hsource
      (by simpa only [Nat.reduceSub] using hs)
  have hmoment : ∀ n, functionalMoment (Algebra.trace K (AdjoinRoot F))
      (↑unit⁻¹ : AdjoinRoot F) (E (AdjoinRoot.root F)) n ∈ S := by
    intro n
    apply actual_source_unit_derivative_moment_mem_subring S D F node leading
      (X ^ 5 + C q) hsep hinj hleading hfactor hD hnodes _ unit E hunit compatible n
    simpa only [eval_add, eval_pow, eval_X, eval_C] using hInv
  have hI : functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F))
      (↑unit⁻¹ : AdjoinRoot F) (E (AdjoinRoot.root F)) ∈ S :=
    S.add_mem (S.mul_mem (hmoment 2) (hmoment 4)) (S.pow_mem (hmoment 3) 2)
  refine ⟨unit, E, hunit, compatible, hmoment, ?_⟩
  intro b
  refine ⟨?_, ?_⟩
  · rw [(htranslations b).2.2.1]
    exact hmoment 2
  · rw [map_add, compatible, functional_five_invariant_translation
      (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
      (E (AdjoinRoot.root F)) (D b) hzero hone]
    exact hI

end Litt3.CartierAndSpin
