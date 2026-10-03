import Solutions.CartierAndSpin.SourceTraceDescent

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K : Type*} [Field K]

/-- Separability makes the derivative an actual unit in the actual source
quotient, including disconnected source algebras. -/
theorem separable_quotient_derivative_isUnit (F : K[X]) (hsep : F.Separable) :
    IsUnit (AdjoinRoot.mk F F.derivative) := by
  obtain ⟨a, b, hab⟩ := hsep
  have h := congrArg (AdjoinRoot.mk F) hab
  rw [map_add, map_mul, map_mul, AdjoinRoot.mk_self, mul_zero, zero_add, map_one] at h
  exact isUnit_iff_exists_inv.mpr ⟨AdjoinRoot.mk F b, by rw [mul_comm]; exact h⟩

theorem polynomialQuotientCoefficientMap_mk {L : Type*} [Field L] [Algebra K L]
    (F P : K[X]) :
    polynomialQuotientCoefficientMap (L := L) F (AdjoinRoot.mk F P) =
      AdjoinRoot.mk (F.map (algebraMap K L)) (P.map (algebraMap K L)) := by
  simp [polynomialQuotientCoefficientMap, AdjoinRoot.mapAlgHom, AdjoinRoot.map]
  rw [← Polynomial.eval₂_map]
  change aeval (AdjoinRoot.root (F.map (algebraMap K L)))
    (P.map (algebraMap K L)) = _
  exact AdjoinRoot.aeval_eq _

/-- Genuine low-degree trace-dual interpolation in the actual separable
polynomial quotient, with arbitrary leading coefficient and actual roots.
Neither irreducibility nor splitting over K is assumed. -/
theorem separable_quotient_low_residue_trace (F J : K[X]) (hF : F ≠ 0)
    (hsep : F.Separable) (derivativeUnit : (AdjoinRoot F)ˣ)
    (hunit : (derivativeUnit : AdjoinRoot F) = AdjoinRoot.mk F F.derivative)
    (hdegree : J.degree < ↑(F.natDegree - 1)) :
    Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.mk F J * (↑derivativeUnit⁻¹ : AdjoinRoot F)) = 0 := by
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
  have hdegreeMap : mappedJ.degree < ↑(Fintype.card mappedF.roots.toFinset - 1) := by
    rw [hcard]
    exact lt_of_le_of_lt Polynomial.degree_map_le hdegree
  let f := polynomialQuotientCoefficientMap (L := L) F
  let unitMap := Units.map f.toMonoidHom derivativeUnit
  have hunitMap : (unitMap : AdjoinRoot mappedF) = AdjoinRoot.mk mappedF mappedF.derivative := by
    change f (derivativeUnit : AdjoinRoot F) = _
    rw [hunit, polynomialQuotientCoefficientMap_mk, Polynomial.derivative_map]
  let e := splitActualPolynomialQuotientEquiv mappedF node Subtype.val_injective
    mappedF.leadingCoeff hleading hnodal
  have hsplittrace : Algebra.trace L (AdjoinRoot mappedF)
      (AdjoinRoot.mk mappedF mappedJ * (↑unitMap⁻¹ : AdjoinRoot mappedF)) = 0 := by
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
      _ = 0 := splitPolynomialLowResidueVanishing univ node mappedJ mappedF.leadingCoeff
        Subtype.val_injective.injOn (by simpa using hdegreeMap)
  apply cmap.injective
  rw [map_zero, ← polynomial_quotient_trace_coefficient_extension F hF]
  change Algebra.trace L (AdjoinRoot mappedF)
    (f (AdjoinRoot.mk F J * (↑derivativeUnit⁻¹ : AdjoinRoot F))) = 0
  rw [map_mul, polynomialQuotientCoefficientMap_mk]
  have hinverse : f (↑derivativeUnit⁻¹ : AdjoinRoot F) =
      (↑unitMap⁻¹ : AdjoinRoot mappedF) := by
    change (↑(Units.map f.toMonoidHom derivativeUnit⁻¹) : AdjoinRoot mappedF) = _
    rw [map_inv]
  rw [hinverse]
  exact hsplittrace

end Litt3.CartierAndSpin
