import Solutions.QuotientGeometry.CanonicalPencil
import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.FieldTheory.RatFunc.Basic
import Mathlib.RingTheory.Algebraic.Basic

namespace Litt3.QuotientGeometry

theorem derivation_zero_of_algebraic_over_closed_constants
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (x : L) (hx : IsAlgebraic k x) : D x = 0 := by
  letI := IntermediateField.isAlgebraic_adjoin_simple hx.isIntegral
  have hfield := IntermediateField.eq_bot_of_isAlgClosed_of_isAlgebraic
    (IntermediateField.adjoin k {x})
  have hxmem := IntermediateField.subset_adjoin k {x} (Set.mem_singleton x)
  rw [hfield] at hxmem
  obtain ⟨c, hc⟩ := hxmem
  change algebraMap k L c = x at hc
  rw [← hc, D.map_algebraMap]

theorem transcendental_of_derivation_nonzero
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (x : L) (hx : D x ≠ 0) : Transcendental k x := by
  intro halgebraic
  exact hx (derivation_zero_of_algebraic_over_closed_constants D x halgebraic)

/-- A transcendental coordinate gives an actual injection of its
rational function field into the supplied ambient field. -/
noncomputable def transcendentalRationalMap
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (x : L) (hx : Transcendental k x) : RatFunc k →ₐ[k] L :=
  RatFunc.liftAlgHom (Polynomial.aeval x) (by
    intro p hp
    simp only [Submonoid.mem_comap, mem_nonZeroDivisors_iff_ne_zero]
    intro hzero
    exact (mem_nonZeroDivisors_iff_ne_zero.mp hp) ((transcendental_iff.mp hx) p hzero))

theorem transcendental_rational_map_injective
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (x : L) (hx : Transcendental k x) :
    Function.Injective (transcendentalRationalMap x hx) :=
  (transcendentalRationalMap x hx).injective

theorem transcendental_rational_map_polynomial
    {k L : Type*} [Field k] [Field L] [Algebra k L]
    (x : L) (hx : Transcendental k x) (p : Polynomial k) :
    transcendentalRationalMap x hx (algebraMap (Polynomial k) (RatFunc k) p) =
      Polynomial.aeval x p := by
  rw [transcendentalRationalMap, ← div_one (algebraMap (Polynomial k) (RatFunc k) p),
    ← map_one (algebraMap (Polynomial k) (RatFunc k)), RatFunc.liftAlgHom_apply_div,
    map_one, div_one]

theorem canonical_pencil_coordinate_transcendental
    {k L : Type*} [Field k] [Field L] [IsAlgClosed k] [Algebra k L]
    (D : Derivation k L L) (A B : L) (hA : A ≠ 0)
    (hbracket : canonicalPencilBracket D A B ≠ 0) :
    Transcendental k (canonicalPencilX A B) :=
  transcendental_of_derivation_nonzero D _
    (canonical_pencil_derivative_nonzero D A B hA hbracket)

end Litt3.QuotientGeometry
