import Solutions.Deformations.ElementaryAugmentationBasis
import Mathlib.Algebra.Algebra.Bilinear

namespace Litt3.Deformations

open scoped BigOperators

variable {k A I : Type*} [CommRing k] [CommRing A] [Algebra k A]
variable [Fintype I] [DecidableEq I]

def boundedTopExponent (q : ℕ) (positive : 0 < q) : I → Fin q :=
  fun _ => ⟨q - 1, by omega⟩

def boundedComplementExponent (q : ℕ) (positive : 0 < q) (alpha : I → Fin q) : I → Fin q :=
  fun i => ⟨q - 1 - (alpha i).val, by have := (alpha i).isLt; omega⟩

theorem bounded_complement_degree (q : ℕ) (positive : 0 < q) (alpha : I → Fin q) :
    (∑ i, (alpha i).val) +
        (∑ i, (boundedComplementExponent q positive alpha i).val) =
      (q - 1) * Fintype.card I := by
  classical
  rw [← Finset.sum_add_distrib]
  have coordinate (i : I) : (alpha i).val +
      (boundedComplementExponent q positive alpha i).val = q - 1 := by
    have lower := (alpha i).isLt
    dsimp only [boundedComplementExponent]
    omega
  simp only [coordinate, Finset.sum_const, Finset.card_univ, smul_eq_mul, Nat.mul_comm]

/-- The actual top coefficient of bounded monomial products is the
complementary-coordinate Kronecker pairing. No finite matrix is supplied. -/
theorem bounded_monomial_top_basis_pairing (q : ℕ) (positive : 0 < q)
    (e : I → A) (b : Module.Basis (I → Fin q) k A)
    (formula : ∀ alpha, b alpha = ∏ i, e i ^ (alpha i).val)
    (nilpotent : ∀ i, e i ^ q = 0) (alpha gamma : I → Fin q) :
    b.coord (boundedTopExponent q positive)
      (b gamma * b (boundedComplementExponent q positive alpha)) =
        if gamma = alpha then 1 else 0 := by
  classical
  let beta := boundedComplementExponent q positive alpha
  have product : b gamma * b beta = ∏ i, e i ^ ((gamma i).val + (beta i).val) := by
    rw [formula gamma, formula beta, ← Finset.prod_mul_distrib]
    simp only [pow_add]
  by_cases normal : ∀ i, (gamma i).val + (beta i).val < q
  · let delta : I → Fin q := fun i => ⟨(gamma i).val + (beta i).val, normal i⟩
    have literal : b gamma * b beta = b delta := by rw [product, formula delta]
    have complementary : delta = boundedTopExponent q positive ↔ gamma = alpha := by
      constructor
      · intro same
        funext i
        apply Fin.ext
        have value := congrArg (fun z : I → Fin q => (z i).val) same
        have lower := (alpha i).isLt
        dsimp only [delta, beta, boundedComplementExponent, boundedTopExponent] at value
        omega
      · intro same
        subst gamma
        funext i
        apply Fin.ext
        have lower := (alpha i).isLt
        dsimp only [delta, beta, boundedComplementExponent, boundedTopExponent]
        omega
    rw [literal]
    by_cases same : gamma = alpha
    · have top := complementary.mpr same
      simp [Module.Basis.coord_apply, Module.Basis.repr_self,
        Finsupp.single_apply, same, top]
    · have different : delta ≠ boundedTopExponent q positive :=
        fun h => same (complementary.mp h)
      simp [Module.Basis.coord_apply, Module.Basis.repr_self,
        Finsupp.single_apply, same, different, Ne.symm different]
  · obtain ⟨i, overflow⟩ : ∃ i, q ≤ (gamma i).val + (beta i).val := by
      push_neg at normal
      exact normal
    have zero : b gamma * b beta = 0 := by
      rw [product]
      exact Finset.prod_eq_zero (Finset.mem_univ i) (pow_eq_zero_of_le overflow (nilpotent i))
    have different : gamma ≠ alpha := by
      intro same
      subst gamma
      have lower := (alpha i).isLt
      dsimp only [beta, boundedComplementExponent] at overflow
      omega
    rw [zero, map_zero, if_neg different]

/-- Multiplication by the actual complementary monomial extracts every
original coefficient from the actual top-coefficient functional. -/
theorem bounded_monomial_top_coordinate_pairing (q : ℕ) (positive : 0 < q)
    (e : I → A) (b : Module.Basis (I → Fin q) k A)
    (formula : ∀ alpha, b alpha = ∏ i, e i ^ (alpha i).val)
    (nilpotent : ∀ i, e i ^ q = 0) (alpha : I → Fin q) (x : A) :
    b.coord (boundedTopExponent q positive)
      (x * b (boundedComplementExponent q positive alpha)) = b.repr x alpha := by
  let map := (b.coord (boundedTopExponent q positive)).comp
    (LinearMap.mulRight k (b (boundedComplementExponent q positive alpha)))
  have maps : map = b.coord alpha := by
    apply b.ext
    intro gamma
    change b.coord (boundedTopExponent q positive)
      (b gamma * b (boundedComplementExponent q positive alpha)) = b.coord alpha (b gamma)
    rw [bounded_monomial_top_basis_pairing q positive e b formula nilpotent alpha gamma]
    simp [Module.Basis.coord_apply, Finsupp.single_apply, eq_comm]
  exact LinearMap.congr_fun maps x

end Litt3.Deformations
