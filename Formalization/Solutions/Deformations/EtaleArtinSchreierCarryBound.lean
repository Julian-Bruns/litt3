import Theorems.Deformations.EtaleArtinSchreierCarryBound
import Solutions.Deformations.ArtinSchreierDegenerateBase
import Solutions.Deformations.ArtinSchreierPolynomialDegree
import Solutions.Deformations.ResidueSectionNormalization
import Solutions.Deformations.NilpotentIdealAdicComplete
import Solutions.Deformations.TruncatedWittMaps

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

universe u v

/-- Whole original local integral chart theorem at arbitrary prime,
rank and commutative p-adically complete base, including the zero ring. -/
theorem etale_artin_schreier_carry_bound (R : Type u) [CommRing R]
    (p : ℕ) (prime : p.Prime) [IsAdicComplete (Ideal.span {(p : R)}) R]
    (r : ℕ) (a b : Fin r → R) : EtaleArtinSchreierCarryResult.{u,v} R p prime r a b := by
  refine {
    originalBasis := ?_
    literalCarry := ?_
    closedCarry := ?_
    multiplication := ?_
    primePower := ?_
    rootLift := ?_
    semilinearMaps := ?_
    derivation := ?_
    fixedDigits := ?_
    initialPolynomial := ?_
    operationWord := ?_
  }
  · cases subsingleton_or_nontrivial R with
    | inl trivial =>
      letI := trivial
      letI := artin_schreier_chart_subsingleton p r a b
      exact ⟨Module.Basis.ofRepr (LinearEquiv.ofSubsingleton _ _),
        fun _ => Subsingleton.elim _ _⟩
    | inr nontrivial =>
      letI := nontrivial
      exact ⟨artinSchreierChartBasis p prime.one_lt r a b,
        artin_schreier_chart_basis_apply p prime.one_lt r a b⟩
  · exact artin_schreier_carry_eq_normal_general p prime r a b
  · intro d
    exact Submodule.isClosed_topologicalClosure _
  · exact artin_schreier_carry_multiplicative p r a b
  · exact artin_schreier_carry_degree_one_power p prime r a b
  · intro u v c linear
    dsimp only
    intro initial
    exact artin_schreier_chart_root_lift_general p prime r a b u v _
      (artin_schreier_affine_seed p r a b c linear) initial
  · intro S ring complete s c d coefficient map compatible units unitValues constant linear
      residue weight x member
    cases subsingleton_or_nontrivial S with
    | inl trivial =>
      letI := trivial
      letI := artin_schreier_chart_subsingleton p s c d
      rw [Subsingleton.elim (map x) 0]
      exact Submodule.zero_mem _
    | inr nontrivial =>
      letI := nontrivial
      exact artin_schreier_chart_map_degree p prime r s a b c d coefficient map compatible
        units unitValues constant linear residue weight x member
  · exact artin_schreier_chart_derivation_general p prime r a b
  · exact artin_schreier_original_residue_digits_general p prime r a b
  · exact artin_schreier_polynomial_degree p r a b
  · exact artin_schreier_operation_word p r a b

/-- The whole source theorem applies to literal truncated Witt rings:
their actual top prime power proves the needed original completeness. -/
theorem truncated_witt_artin_schreier_carry_bound (p N : ℕ) [Fact p.Prime]
    (k : Type u) [CommRing k] [CharP k p] (r : ℕ)
    (a b : Fin r → TruncatedWittVector p N k) :
    letI : IsAdicComplete (Ideal.span {(p : TruncatedWittVector p N k)})
        (TruncatedWittVector p N k) := nilpotent_prime_adic_complete p N
          (truncated_witt_top_power_zero p N k)
    EtaleArtinSchreierCarryResult.{u,v} (TruncatedWittVector p N k) p Fact.out r a b := by
  letI : IsAdicComplete (Ideal.span {(p : TruncatedWittVector p N k)})
      (TruncatedWittVector p N k) := nilpotent_prime_adic_complete p N
        (truncated_witt_top_power_zero p N k)
  exact etale_artin_schreier_carry_bound _ p Fact.out r a b

/-- The original p=5 carries have exactly the three stated increments. -/
theorem artin_schreier_five_carry_increments (d : ℤ) :
    d + ((5 - 1 : ℕ) : ℤ) * 1 = d + 4 ∧
    d + ((5 - 1 : ℕ) : ℤ) * 2 = d + 8 ∧
    d + ((5 - 1 : ℕ) : ℤ) * 3 = d + 12 := by norm_num

end Litt3.Deformations
