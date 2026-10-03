import Solutions.CartierAndSpin.FiniteFunctionDegree
import Solutions.CartierAndSpin.FunctionSquarePencils
import Solutions.CartierAndSpin.FrobeniusSquarePencils
import Solutions.CartierAndSpin.ConstantSquarePencils

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]

/-- Over an algebraically closed constant field, genuine nonconstancy
implies transcendence; no derivative nonvanishing is required. -/
theorem transcendental_of_not_constant (r : L)
    (hr : r ∉ Set.range (algebraMap k L)) : Transcendental k r := by
  intro halgebraic
  letI := IntermediateField.isAlgebraic_adjoin_simple halgebraic.isIntegral
  have hfield := IntermediateField.eq_bot_of_isAlgClosed_of_isAlgebraic
    (IntermediateField.adjoin k {r})
  have hmem := IntermediateField.subset_adjoin k {r} (Set.mem_singleton r)
  rw [hfield] at hmem
  exact hr hmem

/-- The full constant-parameter weighted square support in an actual
one-variable function field is finite, with its exact actual degree
bound. Finite function degree is a conclusion of finite generation and
transcendence degree one, rather than an extra hypothesis. -/
theorem one_variable_weighted_square_pencil_finite
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (r : L)
    (hr : r ∉ Set.range (algebraMap k L))
    (g : L) (hg : g ≠ 0) (htwo : (2 : k) ≠ 0) :
    let support : Set k := {theta | IsSquare (g * (r - algebraMap k L theta))}
    support.Finite ∧ support.ncard ≤
      1 + (Module.finrank (IntermediateField.adjoin k {r}) L).factorization 2 := by
  have htrans := transcendental_of_not_constant r hr
  letI := one_variable_finite_function_degree hfg htrdeg r htrans
  exact function_weighted_square_pencil_finite r htrans g hg htwo

/-- The canonical inseparable-ratio variant, still in the same actual
one-variable field and with arbitrary fixed nonzero weight. -/
theorem one_variable_frobenius_weighted_square_pencil_finite
    (p e : ℕ) [Fact p.Prime] [CharP k p] [CharP L p]
    (hpodd : Odd p)
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (r : L)
    (hr : r ∉ Set.range (algebraMap k L))
    (g : L) (hg : g ≠ 0) (htwo : (2 : k) ≠ 0) :
    let support : Set k := {theta | IsSquare (g * (r ^ (p ^ e) - algebraMap k L theta))}
    support.Finite ∧ support.ncard ≤
      1 + (Module.finrank (IntermediateField.adjoin k {r}) L).factorization 2 := by
  have htrans := transcendental_of_not_constant r hr
  letI := one_variable_finite_function_degree hfg htrdeg r htrans
  exact frobenius_function_weighted_square_pencil_finite p e hpodd r htrans g hg htwo

end Litt3.CartierAndSpin
