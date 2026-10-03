import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.QuotientGeometry

/-- A genuine monic polynomial quotient embeds into its injective
coefficient base change. No field or irreducibility assumption is needed. -/
theorem monic_adjoin_root_map_injective
    {R S : Type*} [CommRing R] [CommRing S]
    (f : R →+* S) (hf : Function.Injective f) (q : Polynomial R) (hq : q.Monic) :
    Function.Injective (AdjoinRoot.map f q (q.map f) dvd_rfl) := by
  apply (injective_iff_map_eq_zero (AdjoinRoot.map f q (q.map f) dvd_rfl)).mpr
  intro x hx
  induction x using AdjoinRoot.induction_on with
  | ih r =>
    have hmk : AdjoinRoot.map f q (q.map f) dvd_rfl (AdjoinRoot.mk q r) =
        AdjoinRoot.mk (q.map f) (r.map f) := by
      rw [AdjoinRoot.map, AdjoinRoot.lift_mk, ← Polynomial.eval₂_map,
        ← AdjoinRoot.algebraMap_eq, ← Polynomial.aeval_def, AdjoinRoot.aeval_eq]
    rw [hmk, AdjoinRoot.mk_eq_zero, Polynomial.map_dvd_map f hf hq] at hx
    exact AdjoinRoot.mk_eq_zero.mpr hx

end Litt3.QuotientGeometry
