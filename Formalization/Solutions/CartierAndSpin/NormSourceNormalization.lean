import Solutions.CartierAndSpin.NormFrobeniusRemainder

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Multiplication of the source polynomial by a nonzero scalar leaves
the actual quotient norm unchanged, via the literal quotient equivalence. -/
theorem polynomial_quotient_norm_nonzero_scalar (F P : K[X]) (a : K) (ha : a ≠ 0) :
    Algebra.norm K (AdjoinRoot.mk (C a * F) P) =
      Algebra.norm K (AdjoinRoot.mk F P) := by
  let e : AdjoinRoot (C a * F) ≃ₐ[K] AdjoinRoot F :=
    Ideal.quotientEquivAlgOfEq K (Ideal.span_singleton_mul_left_unit
      ((isUnit_iff_ne_zero.mpr ha).map C) F)
  have he : e (AdjoinRoot.mk (C a * F) P) = AdjoinRoot.mk F P := by
    exact Ideal.quotientEquivAlgOfEq_mk _ _ _
  rw [← he]
  exact (Algebra.norm_eq_of_algEquiv e _).symm

/-- The actual leading-coefficient normalization and its norm and
separability bridges, without any monic input on the source polynomial. -/
theorem source_monic_normalization (F : K[X]) (hF : F ≠ 0) (hsep : F.Separable) :
    let G := C F.leadingCoeff⁻¹ * F
    G.Monic ∧ G.Separable ∧ F = C F.leadingCoeff * G ∧
      ∀ P : K[X], Algebra.norm K (AdjoinRoot.mk G P) =
        Algebra.norm K (AdjoinRoot.mk F P) := by
  dsimp only
  have hv : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hF
  have hscaled : F = C F.leadingCoeff * (C F.leadingCoeff⁻¹ * F) := by
    rw [← mul_assoc, ← C_mul, mul_inv_cancel₀ hv, C_1, one_mul]
  refine ⟨?_, ?_, hscaled, ?_⟩
  · rw [mul_comm]
    exact monic_mul_leadingCoeff_inv hF
  · apply hsep.of_dvd
    exact ⟨C F.leadingCoeff, by rw [mul_comm]; exact hscaled⟩
  · intro P
    exact polynomial_quotient_norm_nonzero_scalar F P F.leadingCoeff⁻¹ (inv_ne_zero hv)

/-- The forward norm/remainder implication for every nonzero separable
polynomial, retaining its actual leading coefficient. -/
theorem nonmonic_source_norm_frobenius_remainder (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (hnot : ∀ a : K, a ^ p ≠ f)
    (F : K[X]) (hF : F ≠ 0) (hsep : F.Separable)
    (hnorm : ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p) :
    ∃ H : K[X], ∃ tau : K, tau ≠ 0 ∧
      F = (X ^ p + C f) * H + C tau := by
  let G := C F.leadingCoeff⁻¹ * F
  obtain ⟨hmonic, hseparable, hscaled, hnormeq⟩ := source_monic_normalization F hF hsep
  have hnormG : ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk G (X ^ p + C f)) = a ^ p := by
    rw [hnormeq]
    exact hnorm
  obtain ⟨H, tau, htau, hsource⟩ :=
    source_norm_frobenius_remainder p hp f hnot G hmonic hseparable hnormG
  refine ⟨C F.leadingCoeff * H, F.leadingCoeff * tau,
    mul_ne_zero (leadingCoeff_ne_zero.mpr hF) htau, ?_⟩
  calc
    F = C F.leadingCoeff * G := hscaled
    _ = (X ^ p + C f) * (C F.leadingCoeff * H) + C (F.leadingCoeff * tau) := by
      rw [hsource, mul_add, ← C_mul]
      ring

/-- The converse for a nonmonic separable source, with no division by
the source degree and no irreducibility assumption. -/
theorem nonmonic_source_frobenius_remainder_norm (p : ℕ) [CharP K p]
    (hp : p.Prime) (f : K) (F H : K[X]) (tau : K) (htau : tau ≠ 0)
    (hF : F ≠ 0) (hsep : F.Separable)
    (hsource : F = (X ^ p + C f) * H + C tau) :
    ∃ a : K, a ≠ 0 ∧
      Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p := by
  let G := C F.leadingCoeff⁻¹ * F
  obtain ⟨hmonic, hseparable, _hscaled, hnormeq⟩ := source_monic_normalization F hF hsep
  have hsourceG : G = (X ^ p + C f) * (C F.leadingCoeff⁻¹ * H) +
      C (F.leadingCoeff⁻¹ * tau) := by
    dsimp only [G]
    rw [hsource, mul_add, C_mul]
    ring
  have h := source_frobenius_remainder_norm p hp f G
    (C F.leadingCoeff⁻¹ * H) (F.leadingCoeff⁻¹ * tau)
    (mul_ne_zero (inv_ne_zero (leadingCoeff_ne_zero.mpr hF)) htau)
    hmonic hseparable hsourceG
  rw [hnormeq] at h
  exact h

end Litt3.CartierAndSpin
