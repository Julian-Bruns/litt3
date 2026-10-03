import Solutions.QuotientGeometry.BinaryDegreeBounds
import Solutions.QuotientGeometry.QuadraticFunctionFields

namespace Litt3.QuotientGeometry

/-- The source binary sextic hypotheses themselves prove irreducibility
of the actual quadratic function-field polynomial. -/
theorem binary_squarefree_sextic_quadratic_polynomial_irreducible
    {k : Type*} [Field k] (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (hs : Squarefree H) :
    Irreducible (quadraticFunctionPolynomial (binaryDehomogenization H)) :=
  quadratic_function_polynomial_irreducible _
    (binary_dehomogenization_squarefree H 6 hH hs)
    (binary_dehomogenization_natDegree_pos H 6 (by decide) hH hs)

/-- Original squarefree binary sextic data give the actual function-field
injection reconstructed from the pencil. Dehomogenized squarefreeness and
nonconstancy are proved, rather than introduced as additional inputs. -/
theorem canonical_pencil_binary_squarefree_field_embedding
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k)
    (hH : H.IsHomogeneous 6) (hs : Squarefree H)
    (A B : L) (hA : A ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0)
    (hidentity : (canonicalPencilBracket D A B) ^ 2 =
      H.eval₂ (algebraMap k L) ![A, B]) :
    ∃ φ : QuadraticFunctionField (binaryDehomogenization H) →ₐ[k] L,
      Function.Injective φ ∧
      φ (AdjoinRoot.root (quadraticFunctionPolynomial (binaryDehomogenization H))) =
        canonicalPencilY A (canonicalPencilBracket D A B) ∧
      φ (AdjoinRoot.of (quadraticFunctionPolynomial (binaryDehomogenization H))
        (algebraMap (Polynomial k) (RatFunc k) Polynomial.X)) = canonicalPencilX A B :=
  canonical_pencil_quadratic_field_embedding D H hH
    (binary_dehomogenization_squarefree H 6 hH hs)
    (binary_dehomogenization_natDegree_pos H 6 (by decide) hH hs)
    A B hA hbracket hidentity

end Litt3.QuotientGeometry
