import Theorems.CartierAndSpin.CanonicalWeightedSquareSupport
import Solutions.CartierAndSpin.OneVariableSquarePencils

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]

/-- The full nonconstant algebraic weighted-support clause, with the
actual terminal Frobenius root and actual nonzero universal differential.
No square hypothesis on the weight, separability hypothesis on q, or
Frobenius-root decomposition is assumed. -/
theorem canonical_weighted_square_support
    (p : ℕ) [Fact p.Prime] [CharP k p] [CharP L p] (hpodd : Odd p)
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (g q : L) (hg : g ≠ 0)
    (hq : q ∉ Set.range (algebraMap k L)) :
    CanonicalWeightedSquareSupport (k := k) p g q := by
  have hqtrans := transcendental_of_not_constant q hq
  obtain ⟨e, r, hr, hdr, hterminal, hdepth⟩ :=
    primitive_function_root_exists hfg htrdeg q hqtrans
  have hrtrans : Transcendental k r := by
    intro halgebraic
    exact hqtrans (hr ▸ halgebraic.pow (p ^ e))
  have hrnonconstant : r ∉ Set.range (algebraMap k L) := by
    rintro ⟨c, rfl⟩
    exact hrtrans (isAlgebraic_algebraMap (R := k) (A := L) c)
  have hpgt : 2 < p := by
    have hpge := (Fact.out : p.Prime).two_le
    have hpne : p ≠ 2 := by
      intro h
      rw [h] at hpodd
      obtain ⟨n, hn⟩ := hpodd
      omega
    omega
  have htwo : (2 : k) ≠ 0 := by
    intro h
    have hdvd := (CharP.cast_eq_zero_iff k p 2).mp h
    exact hpgt.not_ge (Nat.le_of_dvd Nat.zero_lt_two hdvd)
  have hsupport := one_variable_frobenius_weighted_square_pencil_finite
    p e hpodd hfg htrdeg r hrnonconstant (-g) (neg_ne_zero.mpr hg) htwo
  have hnonzero : ∀ theta : k, g * (algebraMap k L theta - q) ≠ 0 := by
    intro theta
    refine mul_ne_zero hg ?_
    intro hz
    exact hq ⟨theta, sub_eq_zero.mp hz⟩
  have heq : nonzeroWeightedSquareSupport (k := k) g q =
      {theta : k | IsSquare ((-g) * (r ^ (p ^ e) - algebraMap k L theta))} := by
    ext theta
    simp only [nonzeroWeightedSquareSupport, Set.mem_setOf_eq]
    rw [show (-g) * (r ^ (p ^ e) - algebraMap k L theta) =
      g * (algebraMap k L theta - q) by rw [hr]; ring]
    exact and_iff_left (hnonzero theta)
  refine ⟨e, r, hr, hdr, hterminal, hdepth, ?_, ?_⟩
  · rw [heq]
    exact hsupport.1
  · rw [heq]
    exact hsupport.2

/-- The exact constant-ratio boundary: it is empty when the weight is
nonsquare, and the complement of the zero-product parameter when square. -/
theorem nonzero_weighted_square_support_constant (g : L) (hg : g ≠ 0) (c : k) :
    nonzeroWeightedSquareSupport (k := k) g (algebraMap k L c) =
      {theta : k | theta ≠ c ∧ IsSquare g} := by
  ext theta
  have hzero : g * (algebraMap k L theta - algebraMap k L c) ≠ 0 ↔ theta ≠ c := by
    rw [mul_ne_zero_iff, sub_ne_zero, (algebraMap k L).injective.ne_iff]
    exact and_iff_right hg
  change (IsSquare _ ∧ _ ≠ 0) ↔ _
  rw [hzero]
  constructor
  · rintro ⟨hsquare, htheta⟩
    refine ⟨htheta, ?_⟩
    have hneq : -theta ≠ -c := fun h => htheta (neg_injective h)
    apply (constant_weighted_square_iff g (-c) (-theta) hneq).mp
    simpa only [map_neg, sub_neg_eq_add, neg_add_eq_sub] using hsquare
  · rintro ⟨htheta, hsquare⟩
    refine ⟨?_, htheta⟩
    have hneq : -theta ≠ -c := fun h => htheta (neg_injective h)
    have h := (constant_weighted_square_iff g (-c) (-theta) hneq).mpr hsquare
    simpa only [map_neg, sub_neg_eq_add, neg_add_eq_sub] using h

end Litt3.CartierAndSpin
