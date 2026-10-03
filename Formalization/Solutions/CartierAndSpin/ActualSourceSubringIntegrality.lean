import Solutions.CartierAndSpin.SubringSourceIntegrality
import Solutions.CartierAndSpin.SubringMonicRemainder
import Solutions.CartierAndSpin.SplitSourceDifferentialTrace
import Definitions.CartierAndSpin.SourceQuotientEnergy

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- Local source regularity is literal membership in the actual preserved
subring. The original source constructs both quotient objects; no s-unit,
critical discriminant, characteristic or degree restriction is needed. -/
theorem actual_source_subring_integrality (S : Subring K) (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) (q tau leading : K) (node : ι → K)
    (hp : 0 < p) (hsep : F.Separable) (hinj : Function.Injective node)
    (hleading : leading ≠ 0) (htau : tau ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hD : ∀ x ∈ S, D x ∈ S) (hH : ∀ j, H.coeff j ∈ S)
    (hq : q ∈ S) (htauInv : tau⁻¹ ∈ S) (hnodes : ∀ i, node i ∈ S) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      sourceQuotientDifferentialEnergy F E unit ∈ S ∧
      clearedDifferentialExpression D (sourceQuotientDifferentialEnergy F E unit) q tau
        ((H %ₘ (X ^ p + C q)).coeff (p - 1))
        ((H %ₘ (X ^ p + C q)).coeff (p - 2)) ∈ S ∧
      sourceQuotientDifferentialEnergy F E unit -
        D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2)) / tau ∈ S := by
  classical
  obtain ⟨unit, hunit⟩ := source_phi_isUnit (AdjoinRoot.mkₐ F) F (X ^ p + C q) H tau
    htau hsource AdjoinRoot.mk_self
  obtain ⟨E, compatible⟩ := separable_polynomial_quotient_derivation_exists D F hsep
  have hroots : ∀ i, F.eval (node i) = 0 := by
    intro i
    rw [hfactor, eval_mul, Lagrange.eval_nodal_at_node (mem_univ i), mul_zero]
  have henergy : sourceQuotientDifferentialEnergy F E unit ∈ S := by
    unfold sourceQuotientDifferentialEnergy
    rw [split_actual_source_differential_trace D F hsep node hinj leading hleading
      hfactor E compatible (X ^ p + C q) unit hunit]
    apply split_derivative_energy_mem_subring S D univ node _ hD
    · exact fun i _ => hnodes i
    · intro i _
      simp only [eval_add, eval_pow, eval_X, eval_C]
      exact source_factor_inverse_mem_subring S F H p q tau (node i) hsource (hroots i)
        htau htauInv hH (hnodes i)
  have hs := source_remainder_coefficient_mem_subring S H q p (p - 1) hp hH hq
  have hc := source_remainder_coefficient_mem_subring S H q p (p - 2) hp hH hq
  exact ⟨unit, E, hunit, compatible, henergy,
    cleared_energy_mem_subring S D _ q tau _ _ hD henergy hq htauInv hs hc,
    affine_energy_mem_subring S D _ q tau _ hD henergy hq htauInv hc⟩

end Litt3.CartierAndSpin
