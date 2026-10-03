import Theorems.Deformations.CyclicRadicalWidth
import Solutions.Deformations.CyclicGroupAlgebra
import Solutions.Deformations.TruncatedRadicalFiltration
import Solutions.Deformations.RadicalFiltrationTransport
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k : Type*} [Field k]

noncomputable def cyclicMonoidAugmentationAlgebraEquiv (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    TruncatedCoefficientRing k (p ^ a) ≃ₐ[k] k[Multiplicative (ZMod (p ^ a))] :=
  (cyclicAugmentationAlgebraEquiv (k := k) p a).trans
    (AddMonoidAlgebra.toMultiplicativeAlgEquiv k (ZMod (p ^ a)))

theorem actual_cyclic_radical_layer_dimensions (p a : ℕ) [Fact p.Prime] [CharP k p]
    (i : ℕ) :
    Module.finrank k (FiltrationLayer (jacobsonRadicalFiltration
      (k := k) (A := k[Multiplicative (ZMod (p ^ a))])) i) =
        if i < p ^ a then 1 else 0 := by
  rw [← algebra_equiv_radical_layer_finrank (cyclicMonoidAugmentationAlgebraEquiv (k := k) p a) i]
  exact actual_truncated_radical_layer_dimensions (p ^ a)
    (pow_pos (Fact.out : p.Prime).pos a) i

/-- Exact all-index radical-window maximum in the actual cyclic
p-power group algebra, for every lag and every exponent, including zero. -/
theorem actual_cyclic_radical_width (p a lag : ℕ) [Fact p.Prime] [CharP k p] :
    Specifications.ActualCyclicRadicalWidth (k := k) p a lag := by
  have window_eq : ∀ i, groupRadicalHilbertWindow (k := k)
      (G := Multiplicative (ZMod (p ^ a))) lag i =
      ∑ j ∈ Finset.range lag, Module.finrank k
        (FiltrationLayer (jacobsonRadicalFiltration
          (k := k) (A := TruncatedCoefficientRing k (p ^ a))) (i + j)) := by
    intro i
    apply Finset.sum_congr rfl
    intro j _
    exact (algebra_equiv_radical_layer_finrank
      (cyclicMonoidAugmentationAlgebraEquiv (k := k) p a) (i + j)).symm
  obtain ⟨upper, attained⟩ := actual_truncated_radical_width (k := k) (p ^ a)
    (pow_pos (Fact.out : p.Prime).pos a) lag
  refine ⟨?_, ⟨0, ?_⟩⟩
  · intro i
    rw [window_eq i]
    exact upper i
  · rw [window_eq 0]
    exact attained

theorem actual_nontrivial_cyclic_adjacent_width (p a : ℕ)
    [Fact p.Prime] [CharP k p] (nontrivial : 1 < p ^ a) :
    Specifications.AttainedNaturalMaximum (groupRadicalHilbertWindow (k := k)
      (G := Multiplicative (ZMod (p ^ a))) 2) 2 := by
  simpa only [Specifications.ActualCyclicRadicalWidth,
    min_eq_right (show 2 ≤ p ^ a from nontrivial)] using
      actual_cyclic_radical_width (k := k) p a 2

/-- Every actual cyclic group of the given p-power order has the
same genuine radical width; no distinguished generator is required. -/
theorem actual_cyclic_group_radical_width {G : Type*} [Group G]
    (p a lag : ℕ) [Fact p.Prime] [CharP k p] (cyclic : IsCyclic G)
    (card : Nat.card G = p ^ a) :
    Specifications.AttainedNaturalMaximum (groupRadicalHilbertWindow (k := k) (G := G) lag)
      (min (p ^ a) lag) := by
  haveI : NeZero (p ^ a) := ⟨pow_ne_zero a (Fact.out : p.Prime).ne_zero⟩
  let eG : Multiplicative (ZMod (p ^ a)) ≃* G :=
    (AddEquiv.toMultiplicative (ZMod.ringEquivCongr card.symm).toAddEquiv).trans
      (zmodCyclicMulEquiv cyclic)
  let eA : k[Multiplicative (ZMod (p ^ a))] ≃ₐ[k] k[G] := MonoidAlgebra.domCongr k k eG
  have window_eq : ∀ i, groupRadicalHilbertWindow (k := k) (G := G) lag i =
      groupRadicalHilbertWindow (k := k) (G := Multiplicative (ZMod (p ^ a))) lag i := by
    intro i
    exact (algebra_equiv_radical_window_finrank eA lag i).symm
  obtain ⟨upper, i, hi⟩ := actual_cyclic_radical_width (k := k) p a lag
  refine ⟨?_, i, ?_⟩
  · intro j
    rw [window_eq j]
    exact upper j
  · rw [window_eq i]
    exact hi

end Litt3.Deformations
