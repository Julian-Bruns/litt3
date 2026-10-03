import Solutions.CartierAndSpin.FieldEndomorphismFixedIndependence
import Mathlib.FieldTheory.Finiteness
import Mathlib.RingTheory.Finiteness.Cardinality

namespace Litt3.CartierAndSpin

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- The actual fixed space of a field-endomorphism semilinear operator,
over the literal scalar equalizer subfield. -/
def fieldEndomorphismFixedSubspace (sigma : k →+* k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    Submodule (sigma.eqLocusField (RingHom.id k)) V where
  carrier := {v | C v = v}
  zero_mem' := C.map_zero
  add_mem' := by
    intro v w hv hw
    change C (v + w) = v + w
    rw [map_add, hv, hw]
  smul_mem' := by
    intro a v hv
    change C ((a : k) • v) = (a : k) • v
    rw [hC, hv]
    exact congrArg (fun x : k => x • v) a.property

/-- An identity-on-underlying-vectors identification with the literal
additive fixed kernel. -/
def fieldEndomorphismFixedKernelEquiv (sigma : k →+* k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    fieldEndomorphismFixedSubspace sigma C hC ≃+ (C - AddMonoidHom.id V).ker where
  toFun v := ⟨v.val, sub_eq_zero.mpr v.property⟩
  invFun v := ⟨v.val, sub_eq_zero.mp v.property⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl

variable [Module.Finite k V]

/-- The actual fixed space is finite dimensional over the actual scalar
fixed field. No perfectness, endomorphism surjectivity, operator
invertibility or characteristic hypothesis is used. -/
theorem field_endomorphism_fixed_module_finite
    (sigma : k →+* k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    Module.Finite (sigma.eqLocusField (RingHom.id k))
      (fieldEndomorphismFixedSubspace sigma C hC) := by
  classical
  let W := fieldEndomorphismFixedSubspace sigma C hC
  let b := Module.Free.chooseBasis (sigma.eqLocusField (RingHom.id k)) W
  have hind : LinearIndependent k (W.subtype ∘ b) :=
    field_endomorphism_fixed_independent sigma C hC (W.subtype ∘ b)
      (fun i => (b i).property)
      (b.linearIndependent.map' W.subtype (Submodule.ker_subtype W))
  letI := hind.finite
  exact Module.Finite.of_basis b

/-- Fixed-field dimension of the literal fixed group is bounded by
ambient k-dimension. -/
theorem field_endomorphism_fixed_finrank_le
    (sigma : k →+* k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    Module.finrank (sigma.eqLocusField (RingHom.id k))
        (fieldEndomorphismFixedSubspace sigma C hC) ≤ Module.finrank k V := by
  classical
  let W := fieldEndomorphismFixedSubspace sigma C hC
  letI := field_endomorphism_fixed_module_finite sigma C hC
  let b := Module.Free.chooseBasis (sigma.eqLocusField (RingHom.id k)) W
  have hind : LinearIndependent k (W.subtype ∘ b) :=
    field_endomorphism_fixed_independent sigma C hC (W.subtype ∘ b)
      (fun i => (b i).property)
      (b.linearIndependent.map' W.subtype (Submodule.ker_subtype W))
  rw [Module.finrank_eq_card_basis b]
  exact hind.fintype_card_le_finrank

/-- If the ACTUAL scalar fixed field is finite, the literal fixed group
is finite. Ambient scalars may still form an infinite field. -/
theorem field_endomorphism_fixed_kernel_finite
    (sigma : k →+* k) [Finite (sigma.eqLocusField (RingHom.id k))] (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    Finite (C - AddMonoidHom.id V).ker := by
  letI := field_endomorphism_fixed_module_finite sigma C hC
  letI := Module.finite_of_finite (sigma.eqLocusField (RingHom.id k))
    (M := fieldEndomorphismFixedSubspace sigma C hC)
  exact Finite.of_equiv _ (fieldEndomorphismFixedKernelEquiv sigma C hC).toEquiv

/-- Exact cardinal formula for a finite actual scalar fixed field. -/
theorem field_endomorphism_fixed_kernel_card
    (sigma : k →+* k) [Finite (sigma.eqLocusField (RingHom.id k))] (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    Nat.card (C - AddMonoidHom.id V).ker =
      Nat.card (sigma.eqLocusField (RingHom.id k)) ^
        Module.finrank (sigma.eqLocusField (RingHom.id k))
          (fieldEndomorphismFixedSubspace sigma C hC) := by
  letI := field_endomorphism_fixed_module_finite sigma C hC
  rw [← Nat.card_congr (fieldEndomorphismFixedKernelEquiv sigma C hC).toEquiv,
    Module.natCard_eq_pow_finrank (K := sigma.eqLocusField (RingHom.id k))]

/-- Sharp fixed-cardinality bound by q to the ambient dimension,
where q is the size of the literal fixed scalar field. -/
theorem field_endomorphism_fixed_kernel_card_le
    (sigma : k →+* k) [Finite (sigma.eqLocusField (RingHom.id k))] (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v) :
    Nat.card (C - AddMonoidHom.id V).ker ≤
      Nat.card (sigma.eqLocusField (RingHom.id k)) ^ Module.finrank k V := by
  rw [field_endomorphism_fixed_kernel_card sigma C hC]
  exact Nat.pow_le_pow_right Nat.card_pos
    (field_endomorphism_fixed_finrank_le sigma C hC)

end Litt3.CartierAndSpin
