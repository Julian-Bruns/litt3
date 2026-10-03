import Definitions.Deformations.HermitianLeadingForms

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- An invertible odd leading Hermitian form has even size. This
target is independent of the original cyclic order or any enumeration. -/
def OddLeadingHermitianSize (N : ℕ) (A : Matrix ι ι (Polynomial k)) : Prop :=
  IsTruncatedHermitian N A →
    ∀ e, e < N → Odd e →
      Matrix.det (polynomialCoefficientMatrix A e) ≠ 0 →
        Even (Fintype.card ι)

end Litt3.Deformations.Specifications
