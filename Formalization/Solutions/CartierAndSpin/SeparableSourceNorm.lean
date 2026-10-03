import Solutions.CartierAndSpin.NormBaseChange
import Solutions.CartierAndSpin.SplitProductNorm
import Solutions.CartierAndSpin.SourceTraceDescent
import Mathlib.Algebra.CharP.Reduced

namespace Litt3.CartierAndSpin

open Polynomial Finset

section Split

variable {L ι : Type*} [Field L] [Fintype ι]

/-- Every norm in the literal split source algebra is its coordinate product. -/
theorem split_actual_source_norm_eval (F P : L[X]) (node : ι → L)
    (hinj : Function.Injective node) (leading : L) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node) :
    Algebra.norm L (AdjoinRoot.mk F P) = ∏ i, P.eval (node i) := by
  rw [← Algebra.norm_eq_of_algEquiv
    (splitActualPolynomialQuotientEquiv F node hinj leading hleading hFsplit),
    split_product_algebra_norm]
  apply prod_congr rfl
  intro i hi
  exact splitActualPolynomialQuotientEquiv_mk F node hinj leading hleading hFsplit P i

/-- Norm against an inseparable p-th root in a monic split separable source.
The sign remains literal, so the statement also covers characteristic two. -/
theorem split_source_norm_inseparable_root (F : L[X]) (node : ι → L)
    (hinj : Function.Injective node) (hFsplit : F = Lagrange.nodal univ node)
    (p : ℕ) [Fact p.Prime] [CharP L p] (f c : L) (hc : c ^ p = -f) :
    Algebra.norm L (AdjoinRoot.mk F (X ^ p + C f)) =
      ((-1 : L) ^ Fintype.card ι * F.eval c) ^ p := by
  classical
  have hsplit : F = C (1 : L) * Lagrange.nodal univ node := by
    simpa using hFsplit
  rw [split_actual_source_norm_eval F (X ^ p + C f) node hinj 1 one_ne_zero hsplit]
  have hpoint (i : ι) : (X ^ p + C f).eval (node i) = (node i - c) ^ p := by
    simp only [eval_add, eval_pow, eval_X, eval_C, sub_pow_char, hc, sub_neg_eq_add]
  simp_rw [hpoint]
  rw [prod_pow]
  congr 1
  have heval : F.eval c = ∏ i, (c - node i) := by
    rw [hFsplit]
    simp [Lagrange.nodal, eval_prod]
  rw [heval]
  have hneg (i : ι) : node i - c = (-1 : L) * (c - node i) := by ring
  simp_rw [hneg]
  rw [prod_mul_distrib, prod_const, card_univ]

end Split

section Unsplit

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

/-- The actual unsplit determinant norm is the p-th power of a signed
evaluation at any inseparable p-th root in a splitting extension. -/
theorem separable_source_norm_inseparable_root (F : K[X]) (hmonic : F.Monic)
    (hsep : F.Separable) (hsplit : (F.map (algebraMap K L)).Splits)
    (p : ℕ) [Fact p.Prime] [CharP L p] (f : K) (c : L)
    (hc : c ^ p = -algebraMap K L f) :
    algebraMap K L (Algebra.norm K (AdjoinRoot.mk F (X ^ p + C f))) =
      ((-1 : L) ^ F.natDegree * (F.map (algebraMap K L)).eval c) ^ p := by
  classical
  let G := F.map (algebraMap K L)
  let node := fun i : G.roots.toFinset => (i : L)
  have hGmonic : G.Monic := hmonic.map _
  have hGsep : G.Separable := hsep.map
  have hGsplit : G = Lagrange.nodal univ node := by
    have h := separable_split_nodal_factorization G hGsep hsplit
    simpa only [hGmonic.leadingCoeff, C_1, one_mul] using h
  have hcard : Fintype.card G.roots.toFinset = F.natDegree := by
    rw [Fintype.card_coe, Multiset.toFinset_card_of_nodup (nodup_roots hGsep),
      ← hsplit.natDegree_eq_card_roots]
    exact Polynomial.natDegree_map_eq_of_injective (algebraMap K L).injective F
  rw [← polynomial_quotient_norm_coefficient_extension F hmonic.ne_zero]
  have hmap : polynomialQuotientCoefficientMap (L := L) F
      (AdjoinRoot.mk F (X ^ p + C f)) =
      AdjoinRoot.mk G (X ^ p + C (algebraMap K L f)) := by
    change polynomialQuotientCoefficientMap F
      ((AdjoinRoot.root F) ^ p + algebraMap K (AdjoinRoot F) f) =
      (AdjoinRoot.root G) ^ p + algebraMap L (AdjoinRoot G) (algebraMap K L f)
    rw [map_add, map_pow, polynomialQuotientCoefficientMap_root,
      (polynomialQuotientCoefficientMap F).commutes]
    rfl
  rw [hmap, split_source_norm_inseparable_root G node Subtype.val_injective hGsplit
    p (algebraMap K L f) c hc, hcard]

end Unsplit

end Litt3.CartierAndSpin
