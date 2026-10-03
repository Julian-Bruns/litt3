import Solutions.CartierAndSpin.SeparableResidueTrace

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K : Type*} [Field K]

/-- The complete top-coefficient trace-dual formula in the original
separable source quotient, arbitrary degree and leading coefficient.
The source may be unsplit or disconnected. -/
theorem separable_quotient_residue_trace_coefficient (F J : K[X]) (hF : F ≠ 0)
    (hsep : F.Separable) (derivativeUnit : (AdjoinRoot F)ˣ)
    (hunit : (derivativeUnit : AdjoinRoot F) = AdjoinRoot.mk F F.derivative)
    (hdegree : J.degree < F.natDegree) :
    Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.mk F J * (↑derivativeUnit⁻¹ : AdjoinRoot F)) =
      J.coeff (F.natDegree - 1) / F.leadingCoeff := by
  classical
  let L := AlgebraicClosure K
  let cmap : K →+* L := algebraMap K L
  let mappedF := F.map cmap
  let mappedJ := J.map cmap
  let node := fun i : mappedF.roots.toFinset => (i : L)
  have hFmap : mappedF ≠ 0 := Polynomial.map_ne_zero hF
  have hsepmap : mappedF.Separable := hsep.map
  have hsplitmap : mappedF.Splits := IsAlgClosed.splits mappedF
  have hleading : mappedF.leadingCoeff ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hFmap
  have hnodal : mappedF = C mappedF.leadingCoeff * Lagrange.nodal univ node :=
    separable_split_nodal_factorization mappedF hsepmap hsplitmap
  have hcard : Fintype.card mappedF.roots.toFinset = F.natDegree := by
    rw [Fintype.card_coe, Multiset.toFinset_card_of_nodup (Polynomial.nodup_roots hsepmap),
      ← hsplitmap.natDegree_eq_card_roots]
    exact Polynomial.natDegree_map_eq_of_injective cmap.injective F
  have hdegreeMap : mappedJ.degree < (univ : Finset mappedF.roots.toFinset).card := by
    rw [card_univ, hcard]
    exact lt_of_le_of_lt Polynomial.degree_map_le hdegree
  let f := polynomialQuotientCoefficientMap (L := L) F
  let unitMap := Units.map f.toMonoidHom derivativeUnit
  have hunitMap : (unitMap : AdjoinRoot mappedF) = AdjoinRoot.mk mappedF mappedF.derivative := by
    change f (derivativeUnit : AdjoinRoot F) = _
    rw [hunit, polynomialQuotientCoefficientMap_mk, Polynomial.derivative_map]
  let e := splitActualPolynomialQuotientEquiv mappedF node Subtype.val_injective
    mappedF.leadingCoeff hleading hnodal
  have hsplittrace : Algebra.trace L (AdjoinRoot mappedF)
      (AdjoinRoot.mk mappedF mappedJ * (↑unitMap⁻¹ : AdjoinRoot mappedF)) =
      mappedJ.coeff (F.natDegree - 1) / mappedF.leadingCoeff := by
    rw [← Algebra.trace_eq_of_algEquiv e, split_product_algebra_trace]
    have hsum : (∑ i, e (AdjoinRoot.mk mappedF mappedJ *
        (↑unitMap⁻¹ : AdjoinRoot mappedF)) i) =
        splitPolynomialResidueSum univ node mappedJ mappedF := by
      unfold splitPolynomialResidueSum
      apply sum_congr rfl
      intro i _
      let evaluation : AdjoinRoot mappedF →+* L :=
        (Pi.evalRingHom (fun _ : mappedF.roots.toFinset => L) i).comp e.toRingHom
      change evaluation (AdjoinRoot.mk mappedF mappedJ *
        (↑unitMap⁻¹ : AdjoinRoot mappedF)) = _
      rw [map_mul, map_units_inv]
      change e (AdjoinRoot.mk mappedF mappedJ) i /
        e (unitMap : AdjoinRoot mappedF) i = _
      rw [hunitMap, splitActualPolynomialQuotientEquiv_mk,
        splitActualPolynomialQuotientEquiv_mk]
    rw [hsum]
    calc
      splitPolynomialResidueSum univ node mappedJ mappedF =
          splitPolynomialResidueSum univ node mappedJ
            (C mappedF.leadingCoeff * Lagrange.nodal univ node) :=
        congrArg (fun denominator : L[X] =>
          splitPolynomialResidueSum univ node mappedJ denominator) hnodal
      _ = mappedF.leadingCoeff⁻¹ * mappedJ.coeff (F.natDegree - 1) := by
        rw [splitPolynomialResidueSum_scale,
          splitPolynomialResidueSum_nodal_eq_coefficient univ node mappedJ
            Subtype.val_injective.injOn hdegreeMap, card_univ, hcard]
      _ = _ := by rw [div_eq_mul_inv, mul_comm]
  apply cmap.injective
  rw [← polynomial_quotient_trace_coefficient_extension F hF]
  change Algebra.trace L (AdjoinRoot mappedF)
    (f (AdjoinRoot.mk F J * (↑derivativeUnit⁻¹ : AdjoinRoot F))) =
    cmap (J.coeff (F.natDegree - 1) / F.leadingCoeff)
  rw [map_mul, polynomialQuotientCoefficientMap_mk]
  have hinverse : f (↑derivativeUnit⁻¹ : AdjoinRoot F) =
      (↑unitMap⁻¹ : AdjoinRoot mappedF) := by
    change (↑(Units.map f.toMonoidHom derivativeUnit⁻¹) : AdjoinRoot mappedF) = _
    rw [map_inv]
  rw [hinverse, hsplittrace, map_div₀, ← coeff_map,
    ← leadingCoeff_map_of_injective cmap.injective]

end Litt3.CartierAndSpin
