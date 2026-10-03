import Mathlib.Algebra.CharP.Frobenius
import Mathlib.FieldTheory.Perfect
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Atlases

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]
  (p : ℕ) [ExpChar K p] [ExpChar A p] [PerfectRing K p]

instance perfect_iterateFrobenius_ringHomSurjective (n : ℕ) :
    RingHomSurjective (iterateFrobenius K p n) :=
  ⟨(bijective_iterateFrobenius K p n).surjective⟩

/-- The image of the actual power map, as a subspace over an arbitrary
perfect field. Scalar closure uses the inverse scalar Frobenius. -/
def perfectFrobeniusImage (n : ℕ) : Submodule K A :=
  LinearMap.range (LinearMap.iterateFrobenius K A p n)

/-- An exact consecutive rank equality for a specified p-power map.
The dimensions are those of actual semilinear images. -/
def PerfectFrobeniusRankPlateau (r e : ℕ) : Prop :=
  Module.finrank K (perfectFrobeniusImage (K := K) (A := A) p (r * e)) =
    Module.finrank K (perfectFrobeniusImage (K := K) (A := A) p (r * (e + 1)))

end Litt3.Atlases
