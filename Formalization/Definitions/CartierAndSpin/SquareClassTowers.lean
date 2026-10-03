import Mathlib.Algebra.QuadraticAlgebra.Basic
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.Algebra.Algebra.Tower
import Mathlib.Algebra.Group.Even

namespace Litt3.CartierAndSpin

universe u v

variable {ι : Type*}

/-- Genuine independence in K*/K*², stated without constructing a
quotient or assuming any extension degree. Every nonempty subproduct
must fail the actual field square test. -/
def SquareClassIndependent {K : Type u} [Field K] (s : Finset ι) (a : ι → K) : Prop :=
  ∀ t : Finset ι, t ⊆ s → t.Nonempty → ¬ IsSquare (∏ i ∈ t, a i)

/-- An actual field embedded in L, with its proved degree and its exact
base square-class kernel. This is construction data, not an assumption
that the requested square-pencil degree bound holds. -/
structure SquareClassTower (K : Type u) (L : Type v) [Field K] [Field L] [Algebra K L]
    (s : Finset ι) (a : ι → K) where
  carrier : Type u
  [field : Field carrier]
  [algebra : Algebra K carrier]
  [finite : FiniteDimensional K carrier]
  embedding : carrier →ₐ[K] L
  degree : Module.finrank K carrier = 2 ^ s.card
  square_kernel : ∀ b : K, IsSquare (algebraMap K carrier b) →
    ∃ t : Finset ι, t ⊆ s ∧ IsSquare (b * ∏ i ∈ t, a i)

end Litt3.CartierAndSpin
