import Mathlib.Algebra.Field.Subfield.Basic
import Mathlib.LinearAlgebra.LinearIndependent.Lemmas
import Mathlib.LinearAlgebra.Finsupp.LinearCombination

namespace Litt3.CartierAndSpin

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- Fixed vectors of a semilinear additive operator descend their
linear independence from the ACTUAL equalizer subfield of any field
endomorphism. Neither scalar surjectivity nor operator invertibility is
needed, and no characteristic or finite dimension is assumed. -/
theorem field_endomorphism_fixed_fin_independent
    (sigma : k →+* k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v)
    (n : ℕ) (v : Fin n → V) (hfixed : ∀ i, C (v i) = v i)
    (hind : LinearIndependent (sigma.eqLocusField (RingHom.id k)) v) :
    LinearIndependent k v := by
  classical
  induction n with
  | zero => exact linearIndependent_empty_type
  | succ n ih =>
    have htail := ih (Fin.tail v) (fun i => hfixed i.succ)
      (linearIndependent_fin_succ.mp hind).1
    apply linearIndependent_fin_succ.mpr
    refine ⟨htail, ?_⟩
    intro hmem
    obtain ⟨c, hc⟩ := (Submodule.mem_span_range_iff_exists_fun k).mp hmem
    have hr : ∑ i, sigma (c i) • Fin.tail v i = v 0 := by
      calc
        ∑ i, sigma (c i) • Fin.tail v i = ∑ i, C (c i • Fin.tail v i) := by
          apply Finset.sum_congr rfl
          intro i _
          rw [hC]
          change sigma (c i) • v i.succ = sigma (c i) • C (v i.succ)
          rw [hfixed i.succ]
        _ = C (∑ i, c i • Fin.tail v i) := (map_sum C _ _).symm
        _ = v 0 := by rw [hc, hfixed 0]
    have hcoeff (i : Fin n) : sigma (c i) = c i :=
      htail.eq_coords_of_eq (hr.trans hc.symm) i
    let cp : Fin n → sigma.eqLocusField (RingHom.id k) := fun i => ⟨c i, hcoeff i⟩
    apply (linearIndependent_fin_succ.mp hind).2
    apply (Submodule.mem_span_range_iff_exists_fun
      (sigma.eqLocusField (RingHom.id k))).mpr
    refine ⟨cp, ?_⟩
    change ∑ i, c i • Fin.tail v i = v 0
    exact hc

/-- Arbitrary indexed, including infinite, fixed families for a genuine
field-endomorphism semilinear operator. -/
theorem field_endomorphism_fixed_independent
    (sigma : k →+* k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a • v) = sigma a • C v)
    {ι : Type*} (v : ι → V) (hfixed : ∀ i, C (v i) = v i)
    (hind : LinearIndependent (sigma.eqLocusField (RingHom.id k)) v) :
    LinearIndependent k v := by
  classical
  apply linearIndependent_iff_finset_linearIndependent.mpr
  intro s
  let e := (Fintype.equivFin s).symm
  apply (linearIndependent_equiv e).mp
  apply field_endomorphism_fixed_fin_independent sigma C hC
  · intro i
    exact hfixed (e i).val
  · exact ((linearIndependent_iff_finset_linearIndependent.mp hind) s).comp e e.injective

end Litt3.CartierAndSpin
