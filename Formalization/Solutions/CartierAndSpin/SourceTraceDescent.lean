import Solutions.CartierAndSpin.SourceCoefficientMoments
import Solutions.CartierAndSpin.TraceBaseChange
import Mathlib.FieldTheory.Separable
import Mathlib.FieldTheory.AlgebraicClosure
import Mathlib.Algebra.CharP.Algebra
import Theorems.CartierAndSpin.SourceTraceDescent

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K ι : Type*} [Field K] [Fintype ι]

theorem split_source_ideal_eq_nodal (F : K[X]) (node : ι → K) (leading : K)
    (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node) :
    Ideal.span ({F} : Set K[X]) = Ideal.span {Lagrange.nodal univ node} := by
  rw [hFsplit]
  exact Ideal.span_singleton_mul_left_unit
    ((isUnit_iff_ne_zero.mpr hleading).map Polynomial.C) _

/-- The actual source quotient by F itself, with the leading coefficient
normalization removed. Its product decomposition is constructed. -/
noncomputable def splitActualPolynomialQuotientEquiv (F : K[X]) (node : ι → K)
    (hinj : Function.Injective node) (leading : K) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node) :
    AdjoinRoot F ≃ₐ[K] (ι → K) :=
  (Ideal.quotientEquivAlgOfEq K
    (split_source_ideal_eq_nodal F node leading hleading hFsplit)).trans
    (splitPolynomialQuotientEquiv node hinj)

theorem splitActualPolynomialQuotientEquiv_mk (F : K[X]) (node : ι → K)
    (hinj : Function.Injective node) (leading : K) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node) (P : K[X]) (i : ι) :
    splitActualPolynomialQuotientEquiv F node hinj leading hleading hFsplit
      (AdjoinRoot.mk F P) i = P.eval (node i) := by
  rw [splitActualPolynomialQuotientEquiv, AlgEquiv.trans_apply]
  change splitPolynomialQuotientEquiv node hinj
    (Ideal.quotientEquivAlgOfEq K _ (Ideal.Quotient.mk _ P)) i = _
  rw [Ideal.quotientEquivAlgOfEq_mk, splitPolynomialQuotientEquiv_mk]

/-- Both coefficient-moment families in the actual quotient K[W]/F,
with no leading normalization and no connectedness requirement. -/
theorem split_actual_source_coefficient_moments (node : ι → K)
    (hinj : Function.Injective node) (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau leading : K) (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree)
    (htau : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ j < p,
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j * (↑unit⁻¹ : AdjoinRoot F)) = 0 ∧
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j *
          (↑unit⁻¹ : AdjoinRoot F) ^ 2) =
            (j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau := by
  classical
  have hH : H ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := by
      rw [hsource, hzero, mul_zero, zero_add, Polynomial.natDegree_C]
    omega
  obtain ⟨unit, hunit⟩ := source_phi_isUnit (AdjoinRoot.mkₐ F) F (X ^ p + C q) H
    tau htau hsource (AdjoinRoot.mk_self (f := F))
  refine ⟨unit, hunit, ?_⟩
  let e := splitActualPolynomialQuotientEquiv F node hinj leading hleading hFsplit
  have hroot (i : ι) : e (AdjoinRoot.root F) i = node i := by
    change e (AdjoinRoot.mk F X) i = node i
    rw [splitActualPolynomialQuotientEquiv_mk, Polynomial.eval_X]
  have hphi (i : ι) : e (unit : AdjoinRoot F) i = node i ^ p + q := by
    rw [hunit]
    change splitActualPolynomialQuotientEquiv F node hinj leading hleading hFsplit
      (AdjoinRoot.mk F (X ^ p + C q)) i = _
    rw [splitActualPolynomialQuotientEquiv_mk]
    simp only [Polynomial.eval_add, Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval_C]
  intro j hj
  constructor
  · rw [split_algebra_trace_unit_inverse e, show
      (∑ i, e (AdjoinRoot.root F) i ^ j / e (unit : AdjoinRoot F) i) =
      ∑ i, node i ^ j / (node i ^ p + q) by simp_rw [hroot, hphi]]
    exact split_inseparable_source_moment_zero univ node hinj.injOn F H p q tau leading
      (by omega) hH hleading hFsplit hsource j hj
  · rw [split_algebra_trace_unit_inverse_power e, show
      (∑ i, e (AdjoinRoot.root F) i ^ j / e (unit : AdjoinRoot F) i ^ 2) =
      ∑ i, node i ^ j / (node i ^ p + q) ^ 2 by simp_rw [hroot, hphi]]
    exact split_inseparable_source_inverseSquare_moment univ node hinj.injOn F H p
      q tau leading hp hH htau hleading hFsplit hsource j hj

omit [Fintype ι] in
open scoped Classical in
theorem separable_split_nodal_factorization (F : K[X]) (hseparable : F.Separable)
    (hsplit : F.Splits) :
    F = C F.leadingCoeff *
      Lagrange.nodal univ (fun i : F.roots.toFinset => (i : K)) := by
  classical
  unfold Lagrange.nodal
  change F = C F.leadingCoeff * ∏ i : F.roots.toFinset, (X - C (i : K))
  rw [Finset.prod_coe_sort F.roots.toFinset (fun a : K => X - C a)]
  change F = C F.leadingCoeff *
    (F.roots.toFinset.val.map (fun a : K => X - C a)).prod
  rw [Multiset.toFinset_val, (Polynomial.nodup_roots hseparable).dedup]
  exact (Polynomial.C_leadingCoeff_mul_prod_multiset_X_sub_C
    hsplit.natDegree_eq_card_roots.symm).symm

omit [Fintype ι] in
/-- Both complete coefficient-moment families in the original actual
separable source algebra, with no splitting assumption. Scalar extension
is proved using its concrete quotient power basis and descended injectively. -/
theorem source_coefficient_moments (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau : K) (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hseparable : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ j < p,
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j * (↑unit⁻¹ : AdjoinRoot F)) = 0 ∧
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j *
          (↑unit⁻¹ : AdjoinRoot F) ^ 2) =
            (j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau := by
  classical
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, Polynomial.natDegree_zero] at hdegree
    omega
  let L := AlgebraicClosure K
  let cmap : K →+* L := algebraMap K L
  let mappedF := F.map cmap
  let mappedH := H.map cmap
  letI : CharP L p := charP_of_injective_algebraMap cmap.injective p
  let nodes := fun i : mappedF.roots.toFinset => (i : L)
  have hFmap : mappedF ≠ 0 := Polynomial.map_ne_zero hF
  have hsepmap : mappedF.Separable := hseparable.map
  have hsplitmap : mappedF.Splits := IsAlgClosed.splits mappedF
  have hdegreeMap : p ≤ mappedF.natDegree := by
    dsimp only [mappedF]
    rw [Polynomial.natDegree_map_eq_of_injective cmap.injective]
    exact hdegree
  have htauMap : cmap tau ≠ 0 := by
    intro hzero
    exact htau (cmap.injective (hzero.trans cmap.map_zero.symm))
  have hleading : mappedF.leadingCoeff ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hFmap
  have hnodal : mappedF = C mappedF.leadingCoeff * Lagrange.nodal univ nodes :=
    separable_split_nodal_factorization mappedF hsepmap hsplitmap
  have hsourceMap : mappedF = (X ^ p + C (cmap q)) * mappedH + C (cmap tau) := by
    have h := congrArg (fun P : K[X] => P.map cmap) hsource
    simpa only [Polynomial.map_add, Polynomial.map_mul, Polynomial.map_pow,
      Polynomial.map_X, Polynomial.map_C] using h
  obtain ⟨unitMap, hunitMap, hmomentsMap⟩ := split_actual_source_coefficient_moments
    nodes Subtype.val_injective mappedF mappedH p (cmap q) (cmap tau)
      mappedF.leadingCoeff hp hdegreeMap htauMap hleading hnodal hsourceMap
  obtain ⟨unit, hunit⟩ := source_phi_isUnit (AdjoinRoot.mkₐ F) F (X ^ p + C q) H
    tau htau hsource (AdjoinRoot.mk_self (f := F))
  refine ⟨unit, hunit, ?_⟩
  let f := polynomialQuotientCoefficientMap (L := L) F
  have hunitExtension : Units.map f.toMonoidHom unit = unitMap := by
    apply Units.ext
    rw [Units.coe_map, hunit, hunitMap]
    change f ((AdjoinRoot.root F) ^ p + algebraMap K (AdjoinRoot F) q) =
      (AdjoinRoot.root mappedF) ^ p + algebraMap L (AdjoinRoot mappedF) (cmap q)
    rw [map_add, map_pow, polynomialQuotientCoefficientMap_root, f.commutes]
    rfl
  have hinverse : f (↑unit⁻¹ : AdjoinRoot F) = (↑unitMap⁻¹ : AdjoinRoot mappedF) := by
    change (↑(Units.map f.toMonoidHom unit⁻¹) : AdjoinRoot mappedF) = _
    rw [map_inv, hunitExtension]
  have hcoeff (j : ℕ) : cmap ((H %ₘ (X ^ p + C q)).coeff (p - j)) =
      (mappedH %ₘ (X ^ p + C (cmap q))).coeff (p - j) := by
    have h := congrArg (fun P : L[X] => P.coeff (p - j))
      (Polynomial.map_modByMonic (p := H) cmap
        (Polynomial.monic_X_pow_add_C q (by omega : p ≠ 0)))
    simpa only [Polynomial.coeff_map, Polynomial.map_add, Polynomial.map_pow,
      Polynomial.map_X, Polynomial.map_C] using h
  intro j hj
  constructor
  · apply cmap.injective
    rw [map_zero, ← polynomial_quotient_trace_coefficient_extension F hF]
    change Algebra.trace L (AdjoinRoot mappedF)
      (f ((AdjoinRoot.root F) ^ j * (↑unit⁻¹ : AdjoinRoot F))) = 0
    rw [map_mul f, map_pow f, polynomialQuotientCoefficientMap_root, hinverse]
    exact (hmomentsMap j hj).1
  · apply cmap.injective
    rw [← polynomial_quotient_trace_coefficient_extension F hF]
    change Algebra.trace L (AdjoinRoot mappedF)
      (f ((AdjoinRoot.root F) ^ j * (↑unit⁻¹ : AdjoinRoot F) ^ 2)) =
      cmap ((j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau)
    rw [map_mul f, map_pow f, map_pow f, polynomialQuotientCoefficientMap_root,
      hinverse, map_div₀ cmap, map_mul cmap, map_natCast cmap, hcoeff]
    exact (hmomentsMap j hj).2

omit [Fintype ι] in
theorem sourceCoefficientMoments (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) :
    Specifications.SourceCoefficientMoments F H p q tau := by
  intro hp hdegree htau hseparable hsource
  exact source_coefficient_moments F H p q tau hp hdegree htau hseparable hsource

end Litt3.CartierAndSpin
