import Solutions.CartierAndSpin.LaurentDerivation
import Solutions.CartierAndSpin.LaurentTwistedEndpoint
import Solutions.CartierAndSpin.DifferentialEnergy
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

/-- The actual split source equation implies the claimed local bound
for its corrected energy in every odd characteristic. There is no
hypothesis on the number of roots, source degree beyond p, or tau order. -/
theorem split_source_laurent_twisted_endpoint_bound
    (s : Finset ι) (node : ι → LaurentSeries k) (hinj : Set.InjOn node s)
    (F H : (LaurentSeries k)[X]) (p r : ℕ) [CharP k p]
    (q tau leading : LaurentSeries k) (hp : p = 2 * r + 1) (hr : 1 ≤ r)
    (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hnodes : ∀ i ∈ s, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (((r : ℤ) + 1 : ℤ) : WithTop ℤ)) :
    ((1 - (r : ℤ) : ℤ) : WithTop ℤ) ≤
      (splitDifferentialEnergy (laurentDerivation k) s node (fun i => node i ^ p + q) -
        4 * laurentDerivation k q *
          laurentDerivation k ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau)).orderTop := by
  letI : CharP (LaurentSeries k) p :=
    charP_of_injective_algebraMap (algebraMap k (LaurentSeries k)).injective p
  rw [split_source_twisted_power_square (laurentDerivation k) s node hinj F H p
    q tau leading (by omega) hdegree htau hleading hFsplit hsource]
  apply laurent_orderTop_sum_bound
  intro i hi
  exact laurent_twisted_square_endpoint_bound p r hp hr (node i) q (hnodes i hi) hq

end Litt3.CartierAndSpin
