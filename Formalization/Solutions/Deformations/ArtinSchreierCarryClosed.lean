import Solutions.Deformations.ArtinSchreierCarry
import Solutions.Deformations.ArtinSchreierNormalDegree
import Solutions.Deformations.PrimePowerIdeal
import Mathlib.Topology.Algebra.OpenSubgroup

namespace Litt3.Deformations

open scoped ArtinSchreierAdic BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The literal normal carry span contains a full power of the original
prime ideal. No completeness or invertibility hypothesis is needed. -/
theorem artin_schreier_normal_contains_prime_power (p : ℕ) (large : 1 < p)
    (r : ℕ) (a b : Fin r → R) (d : ℤ) :
    ∀ x : artinSchreierChart R p r a b,
      x ∈ (Ideal.span {(p : artinSchreierChart R p r a b)}) ^
        (r * p + d.natAbs + 1) →
      x ∈ normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
        (artinSchreierChartCoordinate R p r a b) d := by
  classical
  intro x member
  rw [Ideal.span_singleton_pow, Ideal.mem_span_singleton] at member
  obtain ⟨y, rfl⟩ := member
  let basis := artinSchreierChartBasis (R := R) p large r a b
  rw [← basis.sum_repr y, Finset.mul_sum]
  apply Submodule.sum_mem
  intro alpha _
  rw [Algebra.mul_smul_comm]
  apply Submodule.smul_mem
  have bound : (generatorMonomialWeight (fun i => (alpha i).val) : ℤ) ≤
      d + (p - 1 : ℕ) * (r * p + d.natAbs + 1) := by
    have degree : generatorMonomialWeight (fun i => (alpha i).val) ≤ r * p := by
      unfold generatorMonomialWeight
      calc
        ∑ i : Fin r, (alpha i).val ≤ ∑ _i : Fin r, p :=
          Finset.sum_le_sum fun i _ => Nat.le_of_lt (alpha i).isLt
        _ = r * p := by simp
    have absolute : -(d : ℤ) ≤ (d.natAbs : ℤ) := by
      simpa only [Int.natCast_natAbs] using neg_le_abs d
    have weight : 1 ≤ p - 1 := by omega
    have multiple : (r * p + d.natAbs + 1 : ℕ) ≤
        (p - 1 : ℕ) * (r * p + d.natAbs + 1) := by
      simpa only [one_mul] using Nat.mul_le_mul_right (r * p + d.natAbs + 1) weight
    have degree' : (generatorMonomialWeight (fun i => (alpha i).val) : ℤ) ≤
      (r * p : ℕ) := by exact_mod_cast degree
    have multiple' : ((r * p + d.natAbs + 1 : ℕ) : ℤ) ≤
        ((p - 1 : ℕ) : ℤ) * ((r * p + d.natAbs + 1 : ℕ) : ℤ) := by
      exact_mod_cast multiple
    norm_num only [Nat.cast_add, Nat.cast_mul, Nat.cast_one, Int.natCast_natAbs]
      at degree' multiple' absolute ⊢
    omega
  simpa [basis, artin_schreier_chart_basis_apply, generatorMonomial] using
    normal_signed_generator_member (R := R) p
      (p : artinSchreierChart R p r a b) (p - 1)
      (artinSchreierChartCoordinate R p r a b) d (r * p + d.natAbs + 1)
      (fun i => (alpha i).val) (fun i => (alpha i).isLt) bound

/-- Every algebraic normal carry module is genuinely closed in the
original chart's p-adic topology, even without completeness. -/
theorem artin_schreier_normal_isClosed (p : ℕ) (large : 1 < p)
    (r : ℕ) (a b : Fin r → R) (d : ℤ) :
    IsClosed (normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
      (artinSchreierChartCoordinate R p r a b) d :
        Set (artinSchreierChart R p r a b)) := by
  let G := normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
    (artinSchreierChartCoordinate R p r a b) d
  have adic : IsAdic (Ideal.span {(p : artinSchreierChart R p r a b)}) := rfl
  have neighborhoods : (G : Set (artinSchreierChart R p r a b)) ∈ nhds 0 := by
    apply Filter.mem_of_superset
      (adic.hasBasis_nhds_zero.mem_of_mem (i := r * p + d.natAbs + 1) trivial)
    exact artin_schreier_normal_contains_prime_power p large r a b d
  exact G.toAddSubgroup.isClosed_of_isOpen
    (G.toAddSubgroup.isOpen_of_mem_nhds neighborhoods)

/-- The closed carry used in the complete topology is exactly the
literal original algebraic normal span, with no extra elements. -/
theorem artin_schreier_carry_eq_normal (p : ℕ) (prime : p.Prime)
    (r : ℕ) (a b : Fin r → R) (d : ℤ) :
    artinSchreierCarry R p r a b d =
      normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
        (artinSchreierChartCoordinate R p r a b) d := by
  rw [artin_schreier_carry_normal_form p prime r a b d]
  exact (artin_schreier_normal_isClosed p prime.one_lt r a b d).submodule_topologicalClosure_eq

end Litt3.Deformations
