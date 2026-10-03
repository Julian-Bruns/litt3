# Independent review: actual Taylor algebra and connection descent

Reviewer: Cartier/spin owner, independently reading the root owner's
three complete source modules on 3 October 2026. No owner source was
edited during this review. The actual truncated-ODE construction is
separate and has focused audit `20261003T071523Z` (300 declarations,
standard three logical axioms only, zero forbidden dependencies or
source changes).

## Reviewed sources

| Module | SHA256 |
|---|---|
| `Solutions.SharedTensors.TaylorPBasisPolynomials` | `979e548dd88a480e1b9c23709f2b98b81b69187c087ee5548ae3b908e13f3e25` |
| `Solutions.SharedTensors.TaylorPBasisAlgebra` | `7bec1e5b1edb2002e308005d197d8acfeaa477635d8ed1e4946b44a7d2797089` |
| `Solutions.SharedTensors.TaylorPBasisConnection` | `a31376c1df98d81bf7e5fc506de61434e4fcc46781acb114e697d0fefdd32345` |

All three full files were read, including the literal coefficient
arguments, minimal-polynomial evaluation, power-basis lift, full tensor
map, genuine equal-dimension argument, derivation intertwining and
flatness descent. The exact source scope is an arbitrary field `K` in
prime characteristic `p`, with an actual full single-parameter
`PowerPBasis K p` over the literal subfield `frobeniusSubfield K p`.
For the connection theorem the actual derivation over that subfield is
normalized by `D b.parameter = 1`. No perfectness of `K`, constant-field
presentation, finite generation, or one-variable hypothesis is needed.

## Mathematical readback

`pBasisTaylorPolynomial` is the actual polynomial obtained by replacing
the original parameter `t` by `t+X` in the full original p-basis
expansion of `f`. The coefficients are the original basis coordinates,
coerced from the actual pth-power subfield into `K`. Its constant is
exactly `f`; its coefficient at `p-1` is exactly the top original basis
coordinate. Terms with smaller exponents cannot contribute at that
index. The proved top-obstruction equivalence is therefore precisely
the equality `rationalCartierCoefficient K p b f = f`, using the actual
Frobenius injection and `pRootCoefficient_pow`; it is not a substituted
logarithmic-solution assertion.

The Taylor field map is genuine. The true original minimal polynomial
is `X^p-C(t^p)` over the actual pth-power subfield, as already proved
from the literal full p-basis. The element `t+epsilon` in the actual
quotient `AdjoinRoot (X^p)` annihilates this polynomial by the symbolic
characteristic-p power identity and the literal relation
`epsilon^p=0`. `PowerBasis.lift` consequently gives an algebra
homomorphism from the original field. This constructs the map on the
entire field, including all inverses, rather than merely on parameter
polynomials.

The scalar-extension map is the actual tensor-product algebra lift
`K tensor_(K^p) K -> K[epsilon]/epsilon^p`. Its inverse-side nilpotent
candidate is the difference `1 tensor t - t tensor 1`; its image is
the original quotient's epsilon. Evaluating arbitrary quotient
representatives at this difference proves surjectivity on the whole
algebra. Equal dimensions are independently derived from the actual
base-changed p-basis and the true monic-quotient power basis; both have
rank `p`. Thus injectivity and the full algebra equivalence are
conclusions, without a determinant certificate or assumed tensor
presentation.

The connection is exactly the original linear operator `D-f` over
the true pth-power field. Derivation compatibility uses actual
`map_aeval` for the two full algebra maps and their normalized parameter
derivatives. The full tensor identity then follows by tensor induction,
including all sums, and identifies the actual base-changed connection
with `partial-Taylor(f)` in the original truncated quotient.

Finally, `descended_connection_kernel` invokes the actual unit solution
from the independently constructed truncated ODE, with its obstruction
discharged by the exact Taylor coefficient lemma. If the original
connection had no nonzero kernel, its injectivity follows by applying
it to the difference of any two field elements. Field-extension
flatness preserves that actual injection after scalar extension. The
genuine Taylor equivalence transports the constructed unit into the
kernel of the actual base-changed operator, contradicting injectivity
and the unit's nonzero value in the proved nontrivial quotient. The
result is an actual original-field `u != 0` with `D u=f*u`.

## Review outcome and limits

Accepted as a complete proof of the exact scalar-extension/descent
bridge just stated. No kernel, singular matrix, nilpotent connection,
p-curvature formula or logarithmic converse is an input. The argument
is uniform in every prime `p`, includes characteristic two, and depends
on no sampled arithmetic or matrix oracle. Its algebraic closure use
is confined to the independently proved coefficient identity used by
the truncated ODE; it does not introduce a simultaneous cover closure.

The bridge itself does not assert a geometric common-cover conclusion,
an actual global regular logarithmic primitive, or Picard/sheaf
identification. The terminal universal-differential converse follows
by the separate normalized-coordinate comparison. Its one-variable
wrapper derives the p-basis and coordinate from actual finite generation
and transcendence degree one over perfect constants.

The owner reported build success for all three roots. Focused audit
`../litt3-computation-data/formalization-20261003/verification/20261003T072958Z/report.json`
passed for 329 transitive Litt3 theorem declarations, with only
`Classical.choice`, `Quot.sound` and `propext`, zero forbidden
dependencies and zero source changes. The terminal original universal
differential converse additionally passed focused audit
`20261003T073045Z` (410 declarations, the same clean trust result).
