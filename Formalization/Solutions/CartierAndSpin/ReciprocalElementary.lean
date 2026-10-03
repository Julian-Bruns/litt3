import Solutions.CartierAndSpin.MaximalSymmetricValue

namespace Litt3.CartierAndSpin

open Finset Classical

variable {K ι : Type*} [Field K] [Fintype ι]

/-- The actual reciprocal elementary-function identity, proved by the
complement bijection of finite subsets. All multiplicities are retained. -/
theorem finiteElementarySymmetric_reciprocal (u : ι → K) (hvalues : ∀ i, u i ≠ 0)
    (k : ℕ) (hk : k ≤ Fintype.card ι) :
    finiteElementarySymmetric u (Fintype.card ι - k) =
      (∏ i, u i) * finiteElementarySymmetric (fun i => (u i)⁻¹) k := by
  rw [finiteElementarySymmetric_eq_finset_sum, finiteElementarySymmetric_eq_finset_sum, mul_sum]
  symm
  apply sum_bij (fun s _ => sᶜ)
  · intro s hs
    apply mem_powersetCard.mpr
    exact ⟨subset_univ _, by rw [card_compl, (mem_powersetCard.mp hs).2]⟩
  · intro s _ t _ hst
    exact compl_injective hst
  · intro t ht
    refine ⟨tᶜ, ?_, compl_compl t⟩
    apply mem_powersetCard.mpr
    refine ⟨subset_univ _, ?_⟩
    rw [card_compl, (mem_powersetCard.mp ht).2, Nat.sub_sub_self hk]
  · intro s _
    have hnonzero : (∏ i ∈ s, u i) ≠ 0 := prod_ne_zero_iff.mpr (fun i _ => hvalues i)
    rw [← prod_mul_prod_compl s u, prod_inv_distrib,
      mul_comm (∏ i ∈ s, u i) (∏ i ∈ sᶜ, u i), mul_assoc, mul_inv_cancel₀ hnonzero, mul_one]

end Litt3.CartierAndSpin
