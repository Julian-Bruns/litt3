import Solutions.SharedTensors.TaylorPBasisPolynomials
import Solutions.CartierAndSpin.TruncatedPolynomialDerivation
import Mathlib.RingTheory.TensorProduct.Maps
import Mathlib.LinearAlgebra.TensorProduct.Basis
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.SharedTensors

open Polynomial Module TensorProduct
open Litt3.CartierAndSpin

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual parameter plus the genuine nilpotent in the literal
truncated polynomial algebra. -/
noncomputable def pBasisTaylorParameter (b : PowerPBasis K p) :
    TruncatedPolynomialAlgebra K p :=
  algebraMap K _ b.parameter + AdjoinRoot.root ((X : K[X]) ^ p)

theorem pBasisTaylorParameter_minpoly (b : PowerPBasis K p) :
    aeval (pBasisTaylorParameter b)
      (minpoly (frobeniusSubfield K p) b.parameter) = 0 := by
  letI : Nontrivial (TruncatedPolynomialAlgebra K p) :=
    AdjoinRoot.nontrivial ((X : K[X]) ^ p) (by
      rw [degree_X_pow]
      exact_mod_cast (Fact.out : p.Prime).ne_zero)
  letI : CharP (TruncatedPolynomialAlgebra K p) p :=
    CharP.of_ringHom_of_ne_zero (algebraMap K _) p (Fact.out : p.Prime).ne_zero
  have hnil : AdjoinRoot.root ((X : K[X]) ^ p) ^ p = 0 := by
    rw [← AdjoinRoot.mk_X, ← map_pow, AdjoinRoot.mk_self]
  rw [p_basis_minpoly]
  simp only [map_sub, map_pow, aeval_X, aeval_C]
  rw [pBasisTaylorParameter, add_pow_char, hnil, add_zero, ← map_pow]
  have hcoeff : algebraMap (frobeniusSubfield K p) (TruncatedPolynomialAlgebra K p)
      (frobeniusImageEquiv K p b.parameter) =
      algebraMap K (TruncatedPolynomialAlgebra K p) (b.parameter ^ p) := by
    rw [← frobeniusImageEquiv_coe]
    rfl
  rw [hcoeff, sub_self]

/-- Taylor substitution is an actual algebra homomorphism from the
ORIGINAL field, over its literal subfield of p-th powers. -/
noncomputable def pBasisTaylorHom (b : PowerPBasis K p) :
    K →ₐ[frobeniusSubfield K p] TruncatedPolynomialAlgebra K p :=
  b.toPowerBasis.lift (pBasisTaylorParameter b) (pBasisTaylorParameter_minpoly b)

theorem pBasisTaylorHom_parameter (b : PowerPBasis K p) :
    pBasisTaylorHom b b.parameter = pBasisTaylorParameter b :=
  b.toPowerBasis.lift_gen _ _

/-- The genuine scalar extension of the original p-basis field maps to
the literal truncated polynomial algebra by the actual Taylor map. -/
noncomputable def pBasisTaylorTensorHom (b : PowerPBasis K p) :
    K ⊗[frobeniusSubfield K p] K →ₐ[K] TruncatedPolynomialAlgebra K p :=
  Algebra.TensorProduct.lift (Algebra.ofId K _) (pBasisTaylorHom b)
    (fun _ _ => Commute.all _ _)

theorem pBasisTaylorTensorHom_tmul (b : PowerPBasis K p) (a c : K) :
    pBasisTaylorTensorHom b (a ⊗ₜ[frobeniusSubfield K p] c) =
      algebraMap K _ a * pBasisTaylorHom b c := rfl

/-- The nilpotent difference of the two ORIGINAL parameter images. -/
noncomputable def pBasisTaylorTensorEpsilon (b : PowerPBasis K p) :
    K ⊗[frobeniusSubfield K p] K :=
  1 ⊗ₜ b.parameter - b.parameter ⊗ₜ 1

theorem pBasisTaylorTensorHom_epsilon (b : PowerPBasis K p) :
    pBasisTaylorTensorHom b (pBasisTaylorTensorEpsilon b) =
      AdjoinRoot.root ((X : K[X]) ^ p) := by
  simp only [pBasisTaylorTensorEpsilon, map_sub, pBasisTaylorTensorHom_tmul,
    map_one, one_mul, mul_one, pBasisTaylorHom_parameter, pBasisTaylorParameter]
  exact add_sub_cancel_left _ _

theorem pBasisTaylorTensorHom_surjective (b : PowerPBasis K p) :
    Function.Surjective (pBasisTaylorTensorHom b) := by
  intro a
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective a
  refine ⟨aeval (pBasisTaylorTensorEpsilon b) P, ?_⟩
  rw [← Polynomial.aeval_algHom_apply, pBasisTaylorTensorHom_epsilon,
    AdjoinRoot.aeval_eq]

/-- The Taylor homomorphism is an isomorphism of the ENTIRE actual
scalar extension. Equality of dimensions follows from the original
p-basis and the literal monic quotient, without determinant computation. -/
theorem pBasisTaylorTensorHom_bijective (b : PowerPBasis K p) :
    Function.Bijective (pBasisTaylorTensorHom b) := by
  letI : Module.Finite K (K ⊗[frobeniusSubfield K p] K) :=
    Module.Finite.of_basis (b.basis.baseChange K)
  letI : Module.Finite K (TruncatedPolynomialAlgebra K p) :=
    Module.Finite.of_basis (AdjoinRoot.powerBasisAux' (monic_X_pow p))
  have hdim : Module.finrank K (K ⊗[frobeniusSubfield K p] K) =
      Module.finrank K (TruncatedPolynomialAlgebra K p) := by
    rw [Module.finrank_eq_card_basis (b.basis.baseChange K),
      Module.finrank_eq_card_basis (AdjoinRoot.powerBasisAux' (monic_X_pow p))]
    simp
  have hs := pBasisTaylorTensorHom_surjective b
  exact ⟨(LinearMap.injective_iff_surjective_of_finrank_eq_finrank
    (f := (pBasisTaylorTensorHom b).toLinearMap) hdim).mpr hs, hs⟩

noncomputable def pBasisTaylorTensorEquiv (b : PowerPBasis K p) :
    K ⊗[frobeniusSubfield K p] K ≃ₐ[K] TruncatedPolynomialAlgebra K p :=
  AlgEquiv.ofBijective (pBasisTaylorTensorHom b) (pBasisTaylorTensorHom_bijective b)

end Litt3.SharedTensors
