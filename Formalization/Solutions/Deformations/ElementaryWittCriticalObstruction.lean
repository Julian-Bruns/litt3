import Definitions.Deformations.ElementaryCriticalTheta
import Solutions.Deformations.ElementaryWittRepairPolynomial
import Solutions.Deformations.ElementaryWittPreimageBound
import Solutions.Deformations.ElementaryWittTailAbsorption

set_option maxHeartbeats 2000000

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (r : ℕ) (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]
variable [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
  truncated_witt_nontrivial 5 (r + 1) (by omega) k

/-- The entire actual canonical detector/image equivalence for the
original Witt algebra and original merely additive operator. Actual
repair vectors, their coefficient twist, and all higher corrections
are constructed; no source image conclusion is supplied as an input. -/
theorem elementary_witt_critical_obstruction (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryWittQuadraticReduction (r + 1) k r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (R : elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (4 * r + 1)) :
    (∀ i : Fin r, elementaryCriticalTheta k r q
      (elementaryWittInitialPolynomial (r + 1) k r (4 * r + 1) R) i = 0) ↔
      ∃ x : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5),
        x ∈ elementaryWittRepairSpace (r + 1) k r ∧ L x = R.val := by
  let N := r + 1
  let e := 4 * r - 1
  let c := 4 * r + 1
  let Z := elementaryWittInitialPolynomial N k r c R
  have zHomogeneous := elementary_witt_initial_polynomial_homogeneous N k r c R
  have index : e + 2 = c := by dsimp only [e, c]; omega
  constructor
  · intro detectors
    obtain ⟨T, tHomogeneous, divisible, preimage⟩ :=
      (elementary_actual_critical_obstruction k r positive q reduction.2.1 anisotropic Z zHomogeneous).mp detectors
    obtain ⟨y, yRepresentation⟩ := (elementary_witt_associated_map_full_range N k r e
      (weightedRootTruncation k 5 N (Fact.out : 0 < N) r T)).mpr ⟨T, tHomogeneous, rfl⟩
    have yPolynomial := elementary_witt_initial_polynomial_unique N k r e
      (by dsimp only [e, N]; omega) y T tHomogeneous yRepresentation
    have yRepair : y.val ∈ elementaryWittRepairSpace N k r := by
      apply (elementary_witt_critical_repair_polynomial N k r positive y).mpr
      rwa [yPolynomial]
    let x := (elementaryWittFrobeniusWeight N k r e).symm y
    have frobenius : elementaryWittFrobeniusWeight N k r e x = y :=
      (elementaryWittFrobeniusWeight N k r e).apply_symm_apply y
    have xRepair : x.val ∈ elementaryWittRepairSpace N k r :=
      (elementary_witt_critical_frobenius_repair N k r positive x).mp (by rw [frobenius]; exact yRepair)
    obtain ⟨lxMember, lxInitial⟩ := elementary_witt_operator_initial N k r e L q reduction x
    have member : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
        5 (by omega) r c := by simpa only [index] using lxMember
    have initialAtC := (elementary_witt_associated_map_reindex N k r c (e + 2)
      index.symm (L x.val) member lxMember).trans lxInitial
    rw [frobenius, yRepresentation, ← map_mul, preimage] at initialAtC
    have exactClass : elementaryWittAssociatedMap N k r c ⟨L x.val, member⟩ =
        elementaryWittAssociatedMap N k r c R := by
      exact initialAtC.trans (elementary_witt_initial_polynomial_truncation N k r c R)
    have residual := (elementary_witt_associated_map_equal_iff N k r c R
      ⟨L x.val, member⟩).mp exactClass.symm
    obtain ⟨h, hMember, hImage⟩ := elementary_witt_tail_absorption r k positive L q reduction anisotropic
      (R.val - L x.val) (by simpa only [c, Nat.add_assoc] using residual)
    refine ⟨x.val + h, ?_, ?_⟩
    · have hRepair : h ∈ elementaryWittRepairSpace N k r :=
        Submodule.mem_sup.mpr ⟨0, (elementaryWittPrimeSpace N k r).zero_mem,
          h, hMember, zero_add h⟩
      exact (elementaryWittRepairSpace N k r).add_mem xRepair hRepair
    · rw [map_add, hImage]
      abel
  · rintro ⟨u, repair, image⟩
    have member : u ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
        5 (by omega) r e :=
      elementary_witt_critical_preimage_bound r k L q reduction anisotropic u (by rw [image]; exact R.property)
    let x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r e := ⟨u, member⟩
    let y := elementaryWittFrobeniusWeight N k r e x
    let T := elementaryWittInitialPolynomial N k r e y
    have tHomogeneous := elementary_witt_initial_polynomial_homogeneous N k r e y
    have yRepair := (elementary_witt_critical_frobenius_repair N k r positive x).mpr repair
    have divisible := (elementary_witt_critical_repair_polynomial N k r positive y).mp yRepair
    obtain ⟨lxMember, lxInitial⟩ := elementary_witt_operator_initial N k r e L q reduction x
    have rMember : R.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
        5 (by omega) r (e + 2) := by
      change L u ∈ _ at lxMember
      rwa [image] at lxMember
    have reindex := elementary_witt_associated_map_reindex N k r c (e + 2)
      index.symm R.val R.property rMember
    have operatorAtR : elementaryWittAssociatedMap N k r (e + 2) ⟨R.val, rMember⟩ =
        weightedRootTruncation k 5 N (Fact.out : 0 < N) r
          (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) *
          elementaryWittAssociatedMap N k r e y := by
      change elementaryWittAssociatedMap N k r (e + 2) ⟨L u, lxMember⟩ =
        weightedRootTruncation k 5 N (Fact.out : 0 < N) r
          (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) *
          elementaryWittAssociatedMap N k r e y at lxInitial
      have supplied : (⟨L u, lxMember⟩ : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
          5 (by omega) r (e + 2)) = ⟨R.val, rMember⟩ := Subtype.ext image
      rwa [supplied] at lxInitial
    have truncatedImage : weightedRootTruncation k 5 N (Fact.out : 0 < N) r
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * T) =
        weightedRootTruncation k 5 N (Fact.out : 0 < N) r Z := by
      rw [map_mul, elementary_witt_initial_polynomial_truncation]
      exact operatorAtR.symm.trans (reindex.symm.trans
        (elementary_witt_initial_polynomial_truncation N k r c R).symm)
    have productHomogeneous := weighted_root_homogeneous_mul k 5 (by omega) r 2 e _ T
      (weighted_root_polynomial_homogeneous k 5 (by omega) r 2 q reduction.2.1) tHomogeneous
    have productAtC : weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * T ∈
        weightedRootHomogeneousComponent k 5 (by omega) r c := by
      simpa only [show 2 + e = c by omega] using productHomogeneous
    have preimage : weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * T = Z := by
      apply sub_eq_zero.mp
      apply weighted_root_homogeneous_strict_truncation_zero k 5 (by omega) r N c
        (Fact.out : 0 < N) (by dsimp only [c, N]; norm_num; omega) _
        (Submodule.sub_mem _ productAtC zHomogeneous)
      rw [map_sub, truncatedImage, sub_self]
    exact (elementary_actual_critical_obstruction k r positive q reduction.2.1 anisotropic Z zHomogeneous).mpr
      ⟨T, tHomogeneous, divisible, preimage⟩

end Litt3.Deformations
