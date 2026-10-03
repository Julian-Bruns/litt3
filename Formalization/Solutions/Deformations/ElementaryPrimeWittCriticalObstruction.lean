import Definitions.Deformations.ElementaryPrimeCriticalTheta
import Solutions.Deformations.ElementaryPrimeActualCriticalObstruction
import Solutions.Deformations.ElementaryPrimeWittRepairPolynomial
import Solutions.Deformations.ElementaryPrimeWittPreimageBound
import Solutions.Deformations.ElementaryPrimeWittTailAbsorption

set_option maxHeartbeats 2000000

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by have := (Fact.out : p.Prime).two_le; omega) k

/-- The entire actual canonical detector/image equivalence for the
original Witt algebra and original merely additive operator. Actual
repair vectors, their coefficient twist, and all higher corrections
are constructed; no source image conclusion is supplied as an input. -/
theorem elementary_prime_witt_critical_obstruction
    (large : 2 < p) (principalLower : 2 ≤ a) (principalUpper : a + 1 ≤ p - 1)
    (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ a : Fin r → ZMod p, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (a i)) ≠ 0)
    (R : elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r + a - 1)) :
    (∀ i : Fin r, elementaryPrimeCriticalTheta p k r q
      (elementaryPrimeWittInitialPolynomial p (r + 1) k r ((p - 1) * r + a - 1) R) i = 0) ↔
      ∃ x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p),
        x ∈ elementaryPrimeWittRepairSpace p (r + 1) k r ∧ L x = R.val := by
  have weightPositive : 0 < p - 1 := by omega
  have topPositive : 0 < (p - 1) * r := Nat.mul_pos weightPositive positive
  let N := r + 1
  let e := (p - 1) * r - 1
  let c := (p - 1) * r + a - 1
  let Z := elementaryPrimeWittInitialPolynomial p N k r c R
  have zHomogeneous := elementary_prime_witt_initial_polynomial_homogeneous p N k r c R
  have index : e + a = c := by dsimp only [e, c]; omega
  constructor
  · intro detectors
    obtain ⟨T, tHomogeneous, divisible, preimage⟩ :=
      (elementary_prime_actual_critical_obstruction p k large r a positive principalLower principalUpper q reduction.2.1 anisotropic Z zHomogeneous).mp detectors
    obtain ⟨y, yRepresentation⟩ := (elementary_prime_witt_associated_map_full_range p N k r e
      (weightedRootTruncation k p N (Fact.out : 0 < N) r T)).mpr ⟨T, tHomogeneous, rfl⟩
    have yPolynomial := elementary_prime_witt_initial_polynomial_unique p N k r e
      (by dsimp only [e, N]; rw [Nat.mul_add, Nat.mul_one]; omega) y T tHomogeneous yRepresentation
    have yRepair : y.val ∈ elementaryPrimeWittRepairSpace p N k r := by
      apply (elementary_prime_witt_critical_repair_polynomial p N k large r positive y).mpr
      rwa [yPolynomial]
    let x := (elementaryPrimeWittFrobeniusWeight p N k r e).symm y
    have frobenius : elementaryPrimeWittFrobeniusWeight p N k r e x = y :=
      (elementaryPrimeWittFrobeniusWeight p N k r e).apply_symm_apply y
    have xRepair : x.val ∈ elementaryPrimeWittRepairSpace p N k r :=
      (elementary_prime_witt_critical_frobenius_repair p N k large r positive x).mp (by rw [frobenius]; exact yRepair)
    obtain ⟨lxMember, lxInitial⟩ := elementary_prime_witt_operator_initial p N k r e a principalUpper L q reduction x
    have member : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r c := by simpa only [index] using lxMember
    have initialAtC := (elementary_prime_witt_associated_map_reindex p N k r c (e + a)
      index.symm (L x.val) member lxMember).trans lxInitial
    rw [frobenius, yRepresentation, ← map_mul, preimage] at initialAtC
    have exactClass : elementaryPrimeWittAssociatedMap p N k r c ⟨L x.val, member⟩ =
        elementaryPrimeWittAssociatedMap p N k r c R := by
      exact initialAtC.trans (elementary_prime_witt_initial_polynomial_truncation p N k r c R)
    have residual := (elementary_prime_witt_associated_map_equal_iff p N k r c R
      ⟨L x.val, member⟩).mp exactClass.symm
    have nextIndex : c + 1 = (p - 1) * r + a := by
      dsimp only [c]
      omega
    obtain ⟨h, hMember, hImage⟩ := elementary_prime_witt_tail_absorption p r a k (by have := (Fact.out : p.Prime).two_le; omega) principalUpper positive L q reduction anisotropic
      (R.val - L x.val) (by simpa only [nextIndex] using residual)
    refine ⟨x.val + h, ?_, ?_⟩
    · have hRepair : h ∈ elementaryPrimeWittRepairSpace p N k r :=
        Submodule.mem_sup.mpr ⟨0, (elementaryPrimeWittPrimeSpace p N k r).zero_mem,
          h, hMember, zero_add h⟩
      exact (elementaryPrimeWittRepairSpace p N k r).add_mem xRepair hRepair
    · rw [map_add, hImage]
      abel
  · rintro ⟨u, repair, image⟩
    have member : u ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r e :=
      elementary_prime_witt_critical_preimage_bound p r a k large (by have := (Fact.out : p.Prime).two_le; omega) principalUpper L q reduction anisotropic u (by rw [image]; exact R.property)
    let x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r e := ⟨u, member⟩
    let y := elementaryPrimeWittFrobeniusWeight p N k r e x
    let T := elementaryPrimeWittInitialPolynomial p N k r e y
    have tHomogeneous := elementary_prime_witt_initial_polynomial_homogeneous p N k r e y
    have yRepair := (elementary_prime_witt_critical_frobenius_repair p N k large r positive x).mpr repair
    have divisible := (elementary_prime_witt_critical_repair_polynomial p N k large r positive y).mp yRepair
    obtain ⟨lxMember, lxInitial⟩ := elementary_prime_witt_operator_initial p N k r e a principalUpper L q reduction x
    have rMember : R.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r (e + a) := by
      change L u ∈ _ at lxMember
      rwa [image] at lxMember
    have reindex := elementary_prime_witt_associated_map_reindex p N k r c (e + a)
      index.symm R.val R.property rMember
    have operatorAtR : elementaryPrimeWittAssociatedMap p N k r (e + a) ⟨R.val, rMember⟩ =
        weightedRootTruncation k p N (Fact.out : 0 < N) r
          (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q)) *
          elementaryPrimeWittAssociatedMap p N k r e y := by
      change elementaryPrimeWittAssociatedMap p N k r (e + a) ⟨L u, lxMember⟩ =
        weightedRootTruncation k p N (Fact.out : 0 < N) r
          (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q)) *
          elementaryPrimeWittAssociatedMap p N k r e y at lxInitial
      have supplied : (⟨L u, lxMember⟩ : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
          p (by have := (Fact.out : p.Prime).two_le; omega) r (e + a)) = ⟨R.val, rMember⟩ := Subtype.ext image
      rwa [supplied] at lxInitial
    have truncatedImage : weightedRootTruncation k p N (Fact.out : 0 < N) r
        (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * T) =
        weightedRootTruncation k p N (Fact.out : 0 < N) r Z := by
      rw [map_mul, elementary_prime_witt_initial_polynomial_truncation]
      exact operatorAtR.symm.trans (reindex.symm.trans
        (elementary_prime_witt_initial_polynomial_truncation p N k r c R).symm)
    have productHomogeneous := weighted_root_homogeneous_mul k p (by have := (Fact.out : p.Prime).two_le; omega) r a e _ T
      (weighted_root_polynomial_homogeneous k p (by have := (Fact.out : p.Prime).two_le; omega) r a q reduction.2.1) tHomogeneous
    have productAtC : weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * T ∈
        weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r c := by
      simpa only [show a + e = c by omega] using productHomogeneous
    have preimage : weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * T = Z := by
      apply sub_eq_zero.mp
      apply weighted_root_homogeneous_strict_truncation_zero k p (by have := (Fact.out : p.Prime).two_le; omega) r N c
        (Fact.out : 0 < N) (by dsimp only [c, N]; rw [Nat.mul_add, Nat.mul_one]; omega) _
        (Submodule.sub_mem _ productAtC zHomogeneous)
      rw [map_sub, truncatedImage, sub_self]
    exact (elementary_prime_actual_critical_obstruction p k large r a positive principalLower principalUpper q reduction.2.1 anisotropic Z zHomogeneous).mpr
      ⟨T, tHomogeneous, divisible, preimage⟩

end Litt3.Deformations
