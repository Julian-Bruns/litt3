import Solutions.CartierAndSpin.PurePowerQuotient
import Mathlib.FieldTheory.Fixed
import Mathlib.Data.Set.Card

/-!
# Geometric solution counts for independent pure-power leading forms

Distinct solution pairs define distinct homomorphisms from the actual finite
quotient algebra. Dedekind independence bounds those homomorphisms by its
dimension. No nonempty or reduced zero locus is presumed.
-/

namespace Litt3.CartierAndSpin

variable {K Ω ι : Type*} [Field K] [Field Ω] [Algebra K Ω] [Fintype ι]

theorem purePowerPairPointBound (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K) (point : ι → Ω × Ω) :
    Specifications.PurePowerPairPointBound m a b c d R S point := by
  intro hR hS hdet hpoint hF hG
  let I := purePowerPairIdeal m a b c d R S
  let Q := MvPolynomial (Fin 2) K ⧸ I
  let q := Ideal.Quotient.mkₐ K I
  let evalPoint (i : ι) : MvPolynomial (Fin 2) K →ₐ[K] Ω :=
    MvPolynomial.aeval ![(point i).1, (point i).2]
  have hkernel (i : ι) : ∀ P : MvPolynomial (Fin 2) K,
      P ∈ I → evalPoint i P = 0 := by
    have hle : I ≤ RingHom.ker (evalPoint i).toRingHom := by
      apply Ideal.span_le.mpr
      intro P hP
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hP
      rcases hP with rfl | rfl
      · exact hF i
      · exact hG i
    intro P hP
    exact hle hP
  let f (i : ι) : Q →ₐ[K] Ω := Ideal.Quotient.liftₐ I (evalPoint i) (hkernel i)
  have hcomp (i : ι) : (f i).comp q = evalPoint i :=
    Ideal.Quotient.liftₐ_comp I (evalPoint i) (hkernel i)
  have hf : Function.Injective f := by
    intro i j hij
    apply hpoint
    apply Prod.ext
    · have h := congrArg (fun e : Q →ₐ[K] Ω => (e.comp q) (MvPolynomial.X 0)) hij
      dsimp only at h
      rw [hcomp, hcomp] at h
      simpa [evalPoint] using h
    · have h := congrArg (fun e : Q →ₐ[K] Ω => (e.comp q) (MvPolynomial.X 1)) hij
      dsimp only at h
      rw [hcomp, hcomp] at h
      simpa [evalPoint] using h
  have hquot := purePowerPairFiniteQuotient m a b c d R S hR hS hdet
  letI : Module.Finite K Q := hquot.1
  have hlinear := (linearIndependent_toLinearMap K Q Ω).comp f hf
  have hcard := hlinear.fintype_card_le_finrank
  rw [Module.finrank_linearMap_self] at hcard
  exact hcard.trans hquot.2

omit [Fintype ι] in
/-- The complete geometric solution set is finite with at most m² points,
even in an infinite extension field. No existence assertion is made. -/
theorem purePowerPairSolutionSetBound (m : ℕ) (a b c d : K)
    (R S : MvPolynomial (Fin 2) K)
    (hR : R.totalDegree < m) (hS : S.totalDegree < m) (hdet : a * d - b * c ≠ 0) :
    (purePowerPairSolutionSet (Ω := Ω) m a b c d R S).Finite ∧
      (purePowerPairSolutionSet (Ω := Ω) m a b c d R S).ncard ≤ m ^ 2 := by
  classical
  let solution := purePowerPairSolutionSet (Ω := Ω) m a b c d R S
  have hfinite : solution.Finite := by
    by_contra hinfinite
    obtain ⟨t, ht, htcard⟩ := Set.Infinite.exists_subset_card_eq hinfinite (m ^ 2 + 1)
    have hbound := purePowerPairPointBound m a b c d R S
      (fun z : {z // z ∈ t} => z.val) hR hS hdet Subtype.val_injective
      (fun z => (ht z.property).1) (fun z => (ht z.property).2)
    simp only [Fintype.card_coe] at hbound
    omega
  refine ⟨hfinite, ?_⟩
  letI : Fintype solution := hfinite.fintype
  have hbound := purePowerPairPointBound m a b c d R S
    (fun z : solution => z.val) hR hS hdet Subtype.val_injective
    (fun z => z.property.1) (fun z => z.property.2)
  change solution.ncard ≤ m ^ 2
  rw [Set.ncard_eq_toFinset_card solution hfinite]
  simpa using hbound

end Litt3.CartierAndSpin
