import Solutions.CartierAndSpin.TraceScalarGraph

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L ι : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

omit [FiniteDimensional K L] in
theorem scalar_ratio_outside_base_iff_independent (k z : L) (hk : k ≠ 0) :
    z / k ∉ Set.range (algebraMap K L) ↔ LinearIndependent K ![k, z] := by
  rw [LinearIndependent.pair_iff' hk]
  constructor
  · intro h c hc
    apply h
    refine ⟨c, ?_⟩
    apply (eq_div_iff hk).mpr
    simpa only [Algebra.smul_def] using hc
  · intro h hbase
    obtain ⟨c, hc⟩ := hbase
    apply h c
    rw [Algebra.smul_def, hc, div_mul_cancel₀ _ hk]

omit [FiniteDimensional K L] in
theorem traceZeroProjection_product_shift (n : ℕ) (epsilon v : L) (a : K) :
    traceZeroProjection (K := K) n (epsilon * (v + algebraMap K L a)) =
      traceZeroProjection (K := K) n (epsilon * v) +
        a • traceZeroProjection (K := K) n epsilon := by
  rw [mul_add, map_add]
  congr 1
  rw [mul_comm epsilon, ← Algebra.smul_def, map_smul]

theorem trace_scalar_graph_pointwise_shift_iff (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (epsilon : L)
    (v w : traceZeroSpace (K := K) (L := L) n) :
    w - traceZeroCompression n hdim hn epsilon v ∈
      Submodule.span K ({traceZeroProjectionToSpace n hdim hn epsilon} :
        Set (traceZeroSpace (K := K) (L := L) n)) ↔
      ∃ a b : K, epsilon * ((v : L) + algebraMap K L a) = (w : L) + algebraMap K L b := by
  rw [Submodule.mem_span_singleton]
  constructor
  · rintro ⟨a, ha⟩
    have ha' := congrArg Subtype.val ha
    change a • traceZeroProjection (K := K) n epsilon =
      (w : L) - traceZeroProjection (K := K) n (epsilon * (v : L)) at ha'
    have hp : traceZeroProjection (K := K) n
        (epsilon * ((v : L) + algebraMap K L a)) = w := by
      rw [traceZeroProjection_product_shift, ha']
      abel
    refine ⟨a, normalizedTrace n (epsilon * ((v : L) + algebraMap K L a)), ?_⟩
    rw [traceZeroProjection_apply] at hp
    exact (sub_eq_iff_eq_add.mp hp)
  · rintro ⟨a, b, hab⟩
    refine ⟨a, ?_⟩
    apply Subtype.ext
    change a • traceZeroProjection (K := K) n epsilon =
      (w : L) - traceZeroProjection (K := K) n (epsilon * (v : L))
    have hp := congrArg (traceZeroProjection (K := K) n) hab
    rw [traceZeroProjection_product_shift, map_add, traceZeroProjection_eq_self,
      traceZeroProjection_algebraMap n hdim hn b, add_zero] at hp
    exact eq_sub_iff_add_eq.mpr (by simpa only [add_comm] using hp)

theorem trace_scalar_graph_denominator_free_iff (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (k z : L) (hk : k ≠ 0)
    (M : traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n)
    (basis : Basis ι K (traceZeroSpace (K := K) (L := L) n))
    (hepsilon : z / k ∉ Set.range (algebraMap K L)) :
    (∃ a : traceZeroSpace (K := K) (L := L) n →ₗ[K] K,
      M = traceZeroCompression n hdim hn (z / k) +
        a.smulRight (traceZeroProjectionToSpace n hdim hn (z / k))) ↔
      ∀ i, k * (M (basis i) : L) - z * (basis i : L) ∈
        Submodule.span K ({k, z} : Set L) := by
  rw [trace_scalar_graph_basis_criterion n hdim hn (z / k) hepsilon M basis]
  apply forall_congr'
  intro i
  rw [trace_scalar_graph_pointwise_shift_iff n hdim hn (z / k) (basis i) (M (basis i))]
  exact (scalarGraph_denominatorFree_iff k z (basis i : L) (M (basis i) : L) hk).symm

theorem trace_scalar_graph_independent_denominator_free_iff (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (k z : L) (hli : LinearIndependent K ![k, z])
    (M : traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n)
    (basis : Basis ι K (traceZeroSpace (K := K) (L := L) n)) :
    (∃ a : traceZeroSpace (K := K) (L := L) n →ₗ[K] K,
      M = traceZeroCompression n hdim hn (z / k) +
        a.smulRight (traceZeroProjectionToSpace n hdim hn (z / k))) ↔
      ∀ i, k * (M (basis i) : L) - z * (basis i : L) ∈
        Submodule.span K ({k, z} : Set L) := by
  have hk : k ≠ 0 := hli.ne_zero 0
  exact trace_scalar_graph_denominator_free_iff n hdim hn k z hk M basis
    ((scalar_ratio_outside_base_iff_independent k z hk).mpr hli)

end Litt3.CartierAndSpin
