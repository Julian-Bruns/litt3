import Solutions.CartierAndSpin.SplitDerivationEvaluation
import Solutions.CartierAndSpin.SourceTraceDescent
import Definitions.CartierAndSpin.DifferentialEnergy

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- The actual extended derivation in the actual polynomial quotient
has precisely the root-sum differential trace. Neither connectedness
nor a power-basis choice is used. -/
theorem split_actual_source_differential_trace (D : Derivation R K K)
    (F : K[X]) (hsep : F.Separable) (node : ι → K) (hinj : Function.Injective node)
    (leading : K) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (D c))
    (phi : K[X]) (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F phi) :
    Algebra.trace K (AdjoinRoot F)
        ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) =
      splitDifferentialEnergy D univ node (fun i => phi.eval (node i)) := by
  classical
  let e := splitActualPolynomialQuotientEquiv F node hinj leading hleading hFsplit
  rw [split_algebra_trace_unit_inverse e]
  unfold splitDifferentialEnergy
  apply Finset.sum_congr rfl
  intro i hi
  let evaluation : AdjoinRoot F →ₐ[K] K := (Pi.evalAlgHom K (fun _ : ι => K) i).comp e.toAlgHom
  have hroot : evaluation (AdjoinRoot.root F) = node i := by
    change e (AdjoinRoot.mk F X) i = node i
    rw [splitActualPolynomialQuotientEquiv_mk, Polynomial.eval_X]
  have hDroot : e (E (AdjoinRoot.root F)) i = D (node i) := by
    change evaluation (E (AdjoinRoot.root F)) = D (node i)
    rw [separable_quotient_derivation_evaluation_root D F hsep E compatible evaluation, hroot]
  have hphi : e (unit : AdjoinRoot F) i = phi.eval (node i) := by
    rw [hunit]
    exact splitActualPolynomialQuotientEquiv_mk F node hinj leading hleading hFsplit phi i
  rw [hDroot, hphi]

end Litt3.CartierAndSpin
