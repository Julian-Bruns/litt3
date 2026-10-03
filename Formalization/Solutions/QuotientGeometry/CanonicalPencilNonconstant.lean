import Solutions.QuotientGeometry.CanonicalPencilBinaryField

namespace Litt3.QuotientGeometry

theorem transcendental_of_outside_closed_constants
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (x : L) (hx : ¬∃ c : k, algebraMap k L c = x) : Transcendental k x := by
  intro halgebraic
  letI := IntermediateField.isAlgebraic_adjoin_simple halgebraic.isIntegral
  have hfield := IntermediateField.eq_bot_of_isAlgClosed_of_isAlgebraic
    (IntermediateField.adjoin k {x})
  have hxmem := IntermediateField.subset_adjoin k {x} (Set.mem_singleton x)
  rw [hfield] at hxmem
  exact hx hxmem

/-- With a nonconstant actual pencil ratio, the binary equation itself
forces the bracket to be nonzero. The global proper-curve basepoint-free
condition must still be used to prove this nonconstancy. -/
theorem canonical_pencil_bracket_nonzero_of_nonconstant_ratio
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (hs : Squarefree H)
    (A B : L) (hA : A ≠ 0) (hx : ¬∃ c : k, algebraMap k L c = B / A)
    (hidentity : (canonicalPencilBracket D A B) ^ 2 =
      H.eval₂ (algebraMap k L) ![A, B]) : canonicalPencilBracket D A B ≠ 0 := by
  intro hzero
  have htrans := transcendental_of_outside_closed_constants (B / A) hx
  have hp : binaryDehomogenization H ≠ 0 :=
    (binary_dehomogenization_squarefree H 6 hH hs).ne_zero
  have hprod : A ^ 6 * H.eval₂ (algebraMap k L) ![1, B / A] = 0 := by
    rw [← homogeneous_binary_fraction_evaluation H 6 hH A B hA,
      ← hidentity, hzero, zero_pow (by decide)]
  have heval := (mul_eq_zero.mp hprod).resolve_left (pow_ne_zero 6 hA)
  rw [← binary_dehomogenization_evaluation] at heval
  exact hp ((transcendental_iff.mp htrans) _ heval)

theorem canonical_pencil_nonconstant_binary_field_embedding
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (hs : Squarefree H)
    (A B : L) (hA : A ≠ 0) (hx : ¬∃ c : k, algebraMap k L c = B / A)
    (hidentity : (canonicalPencilBracket D A B) ^ 2 =
      H.eval₂ (algebraMap k L) ![A, B]) :
    ∃ φ : QuadraticFunctionField (binaryDehomogenization H) →ₐ[k] L,
      Function.Injective φ ∧
      φ (AdjoinRoot.root (quadraticFunctionPolynomial (binaryDehomogenization H))) =
        canonicalPencilY A (canonicalPencilBracket D A B) ∧
      φ (AdjoinRoot.of (quadraticFunctionPolynomial (binaryDehomogenization H))
        (algebraMap (Polynomial k) (RatFunc k) Polynomial.X)) = canonicalPencilX A B :=
  canonical_pencil_binary_squarefree_field_embedding D H hH hs A B hA
    (canonical_pencil_bracket_nonzero_of_nonconstant_ratio D H hH hs A B hA hx hidentity)
    hidentity

end Litt3.QuotientGeometry
