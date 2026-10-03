import Theorems.CartierAndSpin.QuarticScalarGraph
import Solutions.CartierAndSpin.QuarticKummerRecovery
import Solutions.CartierAndSpin.TraceScalarGraphTests

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L : Type*} [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [Algebra.IsSeparable K L]

theorem quarticScalarGraphRecovery (hdim : finrank K L = 4) (hfour : (4 : K) ≠ 0) :
    Specifications.QuarticScalarGraphRecovery hdim hfour := by
  dsimp only [Specifications.QuarticScalarGraphRecovery]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro M hne
    have hspace : finrank K (traceZeroSpace (K := K) (L := L) 4) = 3 := by
      have h := traceZeroSpace_finrank_add_one 4 hdim hfour
      omega
    exact nonzero_skew_three_finrank_kernel (K := K)
      (V := traceZeroSpace (K := K) (L := L) 4)
      (normalizedTraceZeroPairing (K := K) (L := L) 4)
      (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour)
      (normalizedTraceZeroPairing_symmetric (K := K) (L := L) 4) M hspace hne
  · intro M epsilon a hM hne k hk0 hk
    exact trace_scalar_graph_skew_kernel_recovers_ratio 4 hdim hfour epsilon a M hM hne k hk0 hk
  · intro k z r hr
    exact scalarGraphRatio_rescale k z r hr
  · intro M epsilon basis
    dsimp only [Specifications.ActualQuarticScalarGraph]
    constructor
    · rintro ⟨hepsilon, hgraph⟩
      exact ⟨hepsilon, (trace_scalar_graph_basis_criterion 4 hdim hfour epsilon hepsilon M basis).mp hgraph⟩
    · rintro ⟨hepsilon, htests⟩
      exact ⟨hepsilon, (trace_scalar_graph_basis_criterion 4 hdim hfour epsilon hepsilon M basis).mpr htests⟩
  · intro M k z hli basis
    have hk : k ≠ 0 := hli.ne_zero 0
    have hepsilon := (scalar_ratio_outside_base_iff_independent k z hk).mpr hli
    dsimp only [Specifications.ActualQuarticScalarGraph]
    rw [and_iff_right hepsilon]
    exact trace_scalar_graph_independent_denominator_free_iff 4 hdim hfour k z hli M basis
  · intro t m hm ht hgen
    obtain ⟨basis, bV, hbasis, hbV, hskew⟩ := quartic_kummer_skew_recovery t m hm ht hgen hdim hfour
    refine ⟨basis, bV, hbasis, hbV, hskew, ?_⟩
    intro a b c d hepsilon f M hM hself
    exact ⟨kummer_nonbase_coefficients_nonzero t a b c d hepsilon,
      quartic_kummer_self_adjoint_graph_boundary_matrix basis t hbasis m ht hfour hdim bV hbV
        a b c d hepsilon f M hM hself⟩

theorem quarticScalarGraphRecovery_of_char_ne_two (hdim : finrank K L = 4)
    (hchar : (2 : K) ≠ 0) :
    Specifications.QuarticScalarGraphRecovery hdim (quartic_normalization_nonzero hchar) :=
  quarticScalarGraphRecovery hdim (quartic_normalization_nonzero hchar)

end Litt3.CartierAndSpin
