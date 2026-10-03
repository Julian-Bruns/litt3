import Solutions.CartierAndSpin.FiniteRootPolynomial
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Conductor

namespace Litt3.CartierAndSpin

open Polynomial

variable {R ι : Type*} [CommRing R] [Fintype ι]

/-- The actual quotient by the actual monic split polynomial, evaluated in
the actual integral product algebra. Faithfulness is proved separately. -/
noncomputable def integralSplitQuotientMap (w : ι → R) :
    AdjoinRoot (finiteRootPolynomial w) →ₐ[R] (ι → R) :=
  AdjoinRoot.liftAlgHom (finiteRootPolynomial w) (Algebra.ofId R (ι → R)) w (by
    change aeval w (finiteRootPolynomial w) = 0
    ext i
    simpa only [aeval_fn_apply, aeval_def, Algebra.algebraMap_self, eval₂_id, Pi.zero_apply]
      using finiteRootPolynomial_eval_at_member w i)

end Litt3.CartierAndSpin
