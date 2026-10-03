import Theorems.Deformations.WeightedAlgebraWidth
import Solutions.Deformations.WeightedBasisFiltration
import Solutions.Deformations.MultiplicativeFiltration
import Solutions.Deformations.HilbertCoefficients

namespace Litt3.Deformations

open Module

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A]

theorem positive_subspace_power_le_filtration (F : ℕ → Submodule k A)
    (multiplicative : IsMultiplicativeFiltration F) (J : Submodule k A) (base : J ≤ F 1)
    (n : ℕ) : J ^ (n + 1) ≤ F (n + 1) := by
  induction n with
  | zero => simpa only [Nat.zero_add, pow_one] using base
  | succ n ih =>
      rw [pow_succ]
      apply Submodule.mul_le.mpr
      intro x hx y hy
      exact multiplicative (n + 1) 1 x y (ih hx) (base hy)

theorem filtration_power_member (F : ℕ → Submodule k A)
    (multiplicative : IsMultiplicativeFiltration F) (initial : 1 ∈ F 0)
    (x : A) (base : x ∈ F 1) (n : ℕ) : x ^ n ∈ F n := by
  induction n with
  | zero => simpa only [pow_zero] using initial
  | succ n ih =>
      rw [pow_succ]
      exact multiplicative n 1 (x ^ n) x ih base

/-- Checking actual basis products suffices for multiplicativity
of the entire span filtration, including noncommutative products. -/
theorem weighted_basis_filtration_multiplicative (basis : Basis ι k A)
    (weight : ι → ℕ) (products : BasisProductsRespectWeight basis weight) :
    IsMultiplicativeFiltration (weightedBasisFiltration basis weight) := by
  intro i j x y hx hy
  induction hx using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨a, ha, rfl⟩ := hx
    induction hy using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨b, hb, rfl⟩ := hy
      exact weighted_basis_filtration_antitone basis weight (add_le_add ha hb)
        (products a b)
    | zero => simp
    | add y z hy hz ihy ihz =>
      rw [mul_add]
      exact (weightedBasisFiltration basis weight (i + j)).add_mem ihy ihz
    | smul r y hy ih =>
      rw [mul_smul_comm]
      exact (weightedBasisFiltration basis weight (i + j)).smul_mem r ih
  | zero => simp
  | add x z hx hz ihx ihz =>
    rw [add_mul]
    exact (weightedBasisFiltration basis weight (i + j)).add_mem ihx ihz
  | smul r x hx ih =>
    rw [smul_mul_assoc]
    exact (weightedBasisFiltration basis weight (i + j)).smul_mem r ih

/-- A genuine ordered monomial basis with p exponents in each of
the weights 1,1,2 forces the uniform p-squared cokernel bound for
every actual step-two relation. It applies to any such algebra,
without assuming a group algebra or a geometric defect operator. -/
theorem weighted_heisenberg_cokernel_bound [FiniteDimensional k A]
    (p : ℕ) (positive : 0 < p) (basis : Basis (Fin p × Fin p × Fin p) k A)
    (products : BasisProductsRespectWeight basis (heisenbergMonomialWeight p))
    (f : A) (quadratic :
      f ∈ weightedBasisFiltration basis (heisenbergMonomialWeight p) 2) :
    Specifications.WeightedHeisenbergCokernelBound (k := k) p f := by
  let F := weightedBasisFiltration basis (heisenbergMonomialWeight p)
  have hwidth := multiplicative_filtration_width F
    (fun i => weighted_basis_filtration_antitone basis _ (Nat.le_succ i))
    (weighted_basis_filtration_multiplicative basis _ products) f quadratic
  have hlayers := weighted_basis_hilbert_dimensions basis (heisenbergMonomialWeight p)
  have hpoly : weightedBasisHilbertPolynomial (heisenbergMonomialWeight p) =
      heisenbergHilbertPolynomial p := heisenberg_monomial_weight_polynomial p
  have hbound := hwidth (2 * p - 2)
  change Module.finrank k (FiltrationLayer (weightedBasisFiltration basis _) (2 * p - 2)) +
    Module.finrank k (FiltrationLayer (weightedBasisFiltration basis _) (2 * p - 2 + 1)) ≤
      Module.finrank k (A ⧸ LinearMap.range (LinearMap.mulRight k f)) at hbound
  rw [hlayers, hlayers, hpoly] at hbound
  rw [(heisenberg_adjacent_hilbert_maximum p positive).2] at hbound
  exact hbound

end Litt3.Deformations
