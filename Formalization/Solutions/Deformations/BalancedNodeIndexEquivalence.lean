import Definitions.Deformations.BalancedNodeNormalMonomials
import Mathlib.Tactic

namespace Litt3.Deformations

theorem balanced_node_normal_exponent_survives (Q : ℕ) (positive : 0 < Q)
    (t : Option (Fin (Q - 1) ⊕ Fin (Q - 1))) :
    balancedNodeNormalExponent Q t ∉ balancedNodeRemovedExponents Q := by
  classical
  rcases t with _ | (i | i)
  · simp [balancedNodeNormalExponent, balancedNodeRemovedExponents, positive.ne']
  · simp only [balancedNodeNormalExponent, balancedNodeRemovedExponents, Set.mem_setOf_eq,
      Finsupp.single_eq_same, Finsupp.single_eq_of_ne (show (1 : Fin 2) ≠ 0 by decide)]
    have := i.isLt
    omega
  · simp only [balancedNodeNormalExponent, balancedNodeRemovedExponents, Set.mem_setOf_eq,
      Finsupp.single_eq_same, Finsupp.single_eq_of_ne (show (0 : Fin 2) ≠ 1 by decide)]
    have := i.isLt
    omega

theorem balanced_node_normal_exponent_injective (Q : ℕ) :
    Function.Injective (balancedNodeNormalExponent Q) := by
  classical
  intro t u same
  have zero := congrArg (fun a : Fin 2 →₀ ℕ => a 0) same
  have one := congrArg (fun a : Fin 2 →₀ ℕ => a 1) same
  rcases t with _ | (i | i) <;> rcases u with _ | (j | j)
  · rfl
  · simp [balancedNodeNormalExponent] at zero
  · simp [balancedNodeNormalExponent] at one
  · simp [balancedNodeNormalExponent] at zero
  · have equal : i = j := Fin.ext (by simpa [balancedNodeNormalExponent] using zero)
    simp [equal]
  · simp [balancedNodeNormalExponent] at zero
  · simp [balancedNodeNormalExponent] at one
  · simp [balancedNodeNormalExponent] at zero
  · have equal : i = j := Fin.ext (by simpa [balancedNodeNormalExponent] using one)
    simp [equal]

/-- Every original surviving monomial lies on exactly one nonzero
axis, except for the single shared constant. -/
theorem balanced_node_normal_exponent_surjective (Q : ℕ) (positive : 0 < Q)
    (a : Fin 2 →₀ ℕ) (survives : a ∉ balancedNodeRemovedExponents Q) :
    ∃ t, balancedNodeNormalExponent Q t = a := by
  classical
  have bounds : a 0 < Q ∧ a 1 < Q ∧ (a 0 = 0 ∨ a 1 = 0) := by
    simp only [balancedNodeRemovedExponents, Set.mem_setOf_eq] at survives
    omega
  by_cases zero : a 0 = 0
  · by_cases one : a 1 = 0
    · refine ⟨none, ?_⟩
      ext i
      fin_cases i <;> simp [balancedNodeNormalExponent, zero, one]
    · have lower : 0 < a 1 := by omega
      refine ⟨some (.inr ⟨a 1 - 1, by omega⟩), ?_⟩
      ext i
      fin_cases i <;> simp [balancedNodeNormalExponent, zero, Nat.sub_add_cancel (show 1 ≤ a 1 by omega)]
  · have lower : 0 < a 0 := by omega
    have one : a 1 = 0 := by omega
    refine ⟨some (.inl ⟨a 0 - 1, by omega⟩), ?_⟩
    ext i
    fin_cases i <;> simp [balancedNodeNormalExponent, one, Nat.sub_add_cancel (show 1 ≤ a 0 by omega)]

/-- Genuine exact indexing equivalence of all original quotient-basis
monomials, constructed from their actual truncation and node relations. -/
noncomputable def balancedNodeIndexEquiv (Q : ℕ) (positive : 0 < Q) :
    Option (Fin (Q - 1) ⊕ Fin (Q - 1)) ≃
      {a : Fin 2 →₀ ℕ // a ∉ balancedNodeRemovedExponents Q} :=
  Equiv.ofBijective (fun t => ⟨balancedNodeNormalExponent Q t,
    balanced_node_normal_exponent_survives Q positive t⟩)
    ⟨fun _ _ same => balanced_node_normal_exponent_injective Q (congrArg Subtype.val same),
      fun a => by
        obtain ⟨t, same⟩ := balanced_node_normal_exponent_surjective Q positive a.val a.property
        exact ⟨t, Subtype.ext same⟩⟩

end Litt3.Deformations
