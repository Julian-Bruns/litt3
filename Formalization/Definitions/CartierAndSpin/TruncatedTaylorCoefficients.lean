import Definitions.CartierAndSpin.TruncatedFieldTaylor

namespace Litt3.CartierAndSpin

open Polynomial

variable (L : Type*) [Field L] (p e j : ℕ)

/-- A literal coefficient of the unique reduced polynomial representative
in the actual truncated Taylor algebra. -/
noncomputable def truncatedTaylorCoefficient : TruncatedFieldTaylor L p e →ₗ[L] L :=
  (Polynomial.lcoeff L j).comp
    (AdjoinRoot.modByMonicHom (Polynomial.monic_X_pow (p ^ e)))

end Litt3.CartierAndSpin
