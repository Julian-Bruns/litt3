import Solutions.CartierAndSpin.InverseFrobeniusFixedIndependence
import Mathlib.FieldTheory.Finiteness
import Mathlib.RingTheory.Finiteness.Cardinality

namespace Litt3.CartierAndSpin

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]
    {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The actual fixed elements, regarded as a vector subspace over the
literal prime subfield of the coefficient field. -/
def inverseFrobeniusFixedSubspace
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Submodule (⊥ : Subfield k) V where
  carrier := {v | C v = v}
  zero_mem' := C.map_zero
  add_mem' := by
    intro v w hv hw
    change C (v + w) = v + w
    rw [map_add, hv, hw]
  smul_mem' := by
    intro a v hv
    change C ((a : k) • v) = (a : k) • v
    have ha : (a : k) ^ p = (a : k) :=
      (Subfield.mem_bot_iff_pow_eq_self k p).mp a.property
    calc
      C ((a : k) • v) = C ((a : k) ^ p • v) := by rw [ha]
      _ = (a : k) • v := by rw [hC, hv]

theorem mem_inverseFrobeniusFixedSubspace
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) (v : V) :
    v ∈ inverseFrobeniusFixedSubspace C hC ↔ C v = v := Iff.rfl

/-- The prime-subfield fixed space is literally the additive kernel of
C minus the identity, rather than an abstract surrogate. -/
def inverseFrobeniusFixedKernelEquiv
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    inverseFrobeniusFixedSubspace C hC ≃+ (C - AddMonoidHom.id V).ker where
  toFun v := ⟨v.val, sub_eq_zero.mpr v.property⟩
  invFun v := ⟨v.val, sub_eq_zero.mp v.property⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl

variable [PerfectField k] [Module.Finite k V]

/-- Finite dimension of the ambient k-space DERIVES finite dimension
of the literal fixed space over the prime subfield. -/
theorem inverse_frobenius_fixed_module_finite
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Module.Finite (⊥ : Subfield k) (inverseFrobeniusFixedSubspace C hC) := by
  classical
  let W := inverseFrobeniusFixedSubspace C hC
  let b := Module.Free.chooseBasis (⊥ : Subfield k) W
  have hind : LinearIndependent k (W.subtype ∘ b) :=
    inverse_frobenius_fixed_independent C hC (W.subtype ∘ b)
      (fun i => (b i).property)
      (b.linearIndependent.map' W.subtype (Submodule.ker_subtype W))
  letI := hind.finite
  exact Module.Finite.of_basis b

/-- The actual F_p-dimension of the fixed group is at most the
k-dimension of the ambient space, for every Cartier-type operator. -/
theorem inverse_frobenius_fixed_finrank_le
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Module.finrank (⊥ : Subfield k) (inverseFrobeniusFixedSubspace C hC) ≤
      Module.finrank k V := by
  classical
  let W := inverseFrobeniusFixedSubspace C hC
  letI : Module.Finite (⊥ : Subfield k) W := inverse_frobenius_fixed_module_finite C hC
  let b := Module.Free.chooseBasis (⊥ : Subfield k) W
  have hind : LinearIndependent k (W.subtype ∘ b) :=
    inverse_frobenius_fixed_independent C hC (W.subtype ∘ b)
      (fun i => (b i).property)
      (b.linearIndependent.map' W.subtype (Submodule.ker_subtype W))
  rw [Module.finrank_eq_card_basis b]
  exact hind.fintype_card_le_finrank

/-- The literal additive fixed kernel is a finite group, even when k
and the underlying ambient space are infinite. -/
theorem inverse_frobenius_fixed_kernel_finite
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Finite (C - AddMonoidHom.id V).ker := by
  letI := Subfield.fintypeBot k p
  letI := inverse_frobenius_fixed_module_finite C hC
  letI := Module.finite_of_finite (⊥ : Subfield k)
    (M := inverseFrobeniusFixedSubspace C hC)
  exact Finite.of_equiv _ (inverseFrobeniusFixedKernelEquiv C hC).toEquiv

/-- Exact cardinality of the literal fixed group from its actual
prime-subfield dimension. -/
theorem inverse_frobenius_fixed_kernel_card
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Nat.card (C - AddMonoidHom.id V).ker =
      p ^ Module.finrank (⊥ : Subfield k) (inverseFrobeniusFixedSubspace C hC) := by
  letI := inverse_frobenius_fixed_module_finite C hC
  rw [← Nat.card_congr (inverseFrobeniusFixedKernelEquiv C hC).toEquiv,
    Module.natCard_eq_pow_finrank (K := (⊥ : Subfield k)), Subfield.card_bot k p]

/-- The sharp universal size bound p to the ambient dimension. No
invertibility, algebraic closedness or supplied fixed-space finiteness
is assumed. -/
theorem inverse_frobenius_fixed_kernel_card_le
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v) :
    Nat.card (C - AddMonoidHom.id V).ker ≤ p ^ Module.finrank k V := by
  rw [inverse_frobenius_fixed_kernel_card C hC]
  exact Nat.pow_le_pow_right (Fact.out : p.Prime).pos
    (inverse_frobenius_fixed_finrank_le C hC)

end Litt3.CartierAndSpin
