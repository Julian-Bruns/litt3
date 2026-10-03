import Solutions.Atlases.PerfectReducedAlgebras
import Mathlib.Algebra.Algebra.Subalgebra.Basic
import Mathlib.RingTheory.Nilpotent.Lemmas

namespace Litt3.Atlases

variable {K A : Type*} [Field K] [PerfectField K] [CommRing A]
  [Algebra K A] [FiniteDimensional K A]

/-- The unique section of the actual nilradical quotient. -/
noncomputable def canonicalReducedSection : (A ⧸ nilradical A) →ₐ[K] A :=
  Classical.choose (finite_perfect_algebra_unique_reduced_section (K := K) (A := A))

theorem canonicalReducedSection_quotient_comp :
    (Ideal.Quotient.mkₐ K (nilradical A)).comp
      (canonicalReducedSection (K := K) (A := A)) = AlgHom.id K (A ⧸ nilradical A) :=
  (Classical.choose_spec
    (finite_perfect_algebra_unique_reduced_section (K := K) (A := A))).1

theorem canonicalReducedSection_leftInverse :
    Function.LeftInverse (Ideal.Quotient.mkₐ K (nilradical A))
      (canonicalReducedSection (K := K) (A := A)) :=
  fun x => DFunLike.congr_fun canonicalReducedSection_quotient_comp x

/-- The actual canonical reduced subalgebra inside the original algebra. -/
noncomputable def canonicalReducedSubalgebra : Subalgebra K A :=
  (canonicalReducedSection (K := K) (A := A)).range

/-- The restriction of the actual quotient map is an algebra isomorphism.
Its inverse is the unique actual section, not a chosen product presentation. -/
noncomputable def canonicalReducedQuotientEquiv :
    canonicalReducedSubalgebra (K := K) (A := A) ≃ₐ[K] (A ⧸ nilradical A) :=
  (AlgEquiv.ofLeftInverse (canonicalReducedSection_leftInverse (K := K) (A := A))).symm

theorem canonicalReducedQuotientEquiv_apply
    (x : canonicalReducedSubalgebra (K := K) (A := A)) :
    canonicalReducedQuotientEquiv (K := K) x =
      Ideal.Quotient.mkₐ K (nilradical A) (x : A) := rfl

instance canonicalReducedSubalgebra_isReduced :
    IsReduced (canonicalReducedSubalgebra (K := K) (A := A)) := by
  letI : IsReduced (A ⧸ nilradical A) :=
    (Ideal.isRadical_iff_quotient_reduced _).mp (Ideal.radical_isRadical ⊥)
  exact isReduced_of_injective (canonicalReducedQuotientEquiv (K := K) (A := A))
    (canonicalReducedQuotientEquiv (K := K) (A := A)).injective

/-- Every element differs from its canonical reduced representative
by an element of the actual nilradical. -/
theorem canonicalReducedSection_difference_mem_nilradical (x : A) :
    x - canonicalReducedSection (K := K) (Ideal.Quotient.mkₐ K (nilradical A) x) ∈
      nilradical A := by
  apply Ideal.Quotient.eq_zero_iff_mem.mp
  change Ideal.Quotient.mkₐ K (nilradical A) (_ : A) = 0
  rw [map_sub, canonicalReducedSection_leftInverse, sub_self]

end Litt3.Atlases
