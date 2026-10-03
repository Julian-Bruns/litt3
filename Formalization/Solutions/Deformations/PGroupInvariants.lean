import Theorems.Deformations.PGroupInvariants
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

variable {p : ℕ} [Fact p.Prime] {G V : Type*} [Group G]
    [AddCommGroup V] [Module (ZMod p) V]

theorem vector_mem_prime_field_orbit_span (ρ : Representation (ZMod p) G V) (v : V) :
    v ∈ primeFieldOrbitSpan ρ v := by
  apply Submodule.subset_span
  exact ⟨1, by simp⟩

theorem prime_field_orbit_span_stable (ρ : Representation (ZMod p) G V) (v : V) (g : G) :
    primeFieldOrbitSpan ρ v ≤ (primeFieldOrbitSpan ρ v).comap (ρ g) := by
  apply Submodule.span_le.mpr
  rintro x ⟨h, rfl⟩
  change ρ g (ρ h v) ∈ primeFieldOrbitSpan ρ v
  apply Submodule.subset_span
  exact ⟨g * h, by simp [Module.End.mul_apply]⟩

/-- A finite p-group has a nonzero invariant in every nonzero
prime-field representation, with no finite-dimension hypothesis.
The finite orbit span is constructed, not assumed. -/
theorem nonzero_p_group_invariants [Finite G] (group : IsPGroup p G)
    (ρ : Representation (ZMod p) G V) : Specifications.NonzeroPGroupInvariants ρ := by
  classical
  rintro ⟨v, hv⟩
  let S := primeFieldOrbitSpan ρ v
  letI : FiniteDimensional (ZMod p) S :=
    FiniteDimensional.span_of_finite (ZMod p) (Set.finite_range (fun g => ρ g v))
  have hvS : v ∈ S := vector_mem_prime_field_orbit_span ρ v
  have hpositive : 0 < Module.finrank (ZMod p) S := by
    apply Module.finrank_pos_iff_exists_ne_zero.mpr
    exact ⟨⟨v, hvS⟩, by intro h; exact hv (congrArg Subtype.val h)⟩
  let e : S ≃ (Fin (Module.finrank (ZMod p) S) → ZMod p) :=
    (Module.finBasis (ZMod p) S).equivFun.toEquiv
  letI : Fintype S := Fintype.ofEquiv _ e.symm
  have hcard : Nat.card S = p ^ Module.finrank (ZMod p) S := by
    rw [Nat.card_eq_fintype_card, Fintype.card_congr e, Fintype.card_fun, ZMod.card,
      Fintype.card_fin]
  have hdiv : p ∣ Nat.card S := by
    rw [hcard]
    exact dvd_pow_self p (Nat.ne_of_gt hpositive)
  letI : MulAction G S := {
    smul := fun g x => ⟨ρ g x.val, prime_field_orbit_span_stable ρ v g x.property⟩
    one_smul := fun x => by
      apply Subtype.ext
      change ρ 1 x.val = x.val
      simp
    mul_smul := fun g h x => by
      apply Subtype.ext
      change ρ (g * h) x.val = ρ g (ρ h x.val)
      simp [Module.End.mul_apply] }
  have hzero : (0 : S) ∈ MulAction.fixedPoints G S := by
    apply MulAction.mem_fixedPoints.mpr
    intro g
    apply Subtype.ext
    exact map_zero (ρ g)
  obtain ⟨w, hw, hne⟩ := group.exists_fixed_point_of_prime_dvd_card_of_fixed_point S hdiv hzero
  refine ⟨w.val, ?_, ?_⟩
  · intro hz
    exact hne (Subtype.ext hz.symm)
  · intro g
    exact congrArg Subtype.val (MulAction.mem_fixedPoints.mp hw g)

end Litt3.Deformations
