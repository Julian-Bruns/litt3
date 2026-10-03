import Theorems.QuotientGeometry.RefinementAlgebra
import Mathlib.FieldTheory.Fixed
import Mathlib.GroupTheory.GroupAction.Quotient
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- This is the field-theoretic core of the finite-orbit argument in a
core-preserving refinement. The action is on an actual field, and its
invariant subfield is explicitly identified with the constants. -/
theorem finite_invariant_field_triviality
    {K L G : Type*} [Field K] [Field L] [Algebra K L] [IsAlgClosed K]
    [Group G] [Finite G] [MulSemiringAction G L]
    (hconstants : ∀ (g : G) (k : K), g • algebraMap K L k = algebraMap K L k)
    (hfixed : ∀ x : L, (∀ g : G, g • x = x) → ∃ k, algebraMap K L k = x) :
    Function.Surjective (algebraMap K L) := by
  let constants : K →+* FixedPoints.subfield G L :=
    { toFun := fun k => ⟨algebraMap K L k, fun g => hconstants g k⟩
      map_one' := Subtype.ext (map_one (algebraMap K L))
      map_mul' := fun x y => Subtype.ext (map_mul (algebraMap K L) x y)
      map_zero' := Subtype.ext (map_zero (algebraMap K L))
      map_add' := fun x y => Subtype.ext (map_add (algebraMap K L) x y) }
  have hsurjective : Function.Surjective constants := by
    intro x
    obtain ⟨k, hk⟩ := hfixed x.val x.property
    exact ⟨k, Subtype.ext hk⟩
  let equivalence : K ≃+* FixedPoints.subfield G L :=
    RingEquiv.ofBijective constants ⟨constants.injective, hsurjective⟩
  have hcoefficient : (algebraMap K L).comp equivalence.symm.toRingHom =
      algebraMap (FixedPoints.subfield G L) L := by
    ext a
    exact congrArg Subtype.val (equivalence.apply_symm_apply a)
  letI : Algebra.IsIntegral K L := ⟨fun x => by
    obtain ⟨p, hp, hx⟩ := FixedPoints.isIntegral G L x
    refine ⟨p.map equivalence.symm.toRingHom, hp.map _, ?_⟩
    rw [Polynomial.eval₂_map, hcoefficient]
    exact hx⟩
  exact IsAlgClosed.algebraMap_bijective_of_isIntegral.2

theorem finite_invariant_field_triviality_target :
    Targets.FiniteInvariantFieldTriviality := by
  intro K L G instK instL instAlgebra instClosed instGroup instFinite instAction hconstants hfixed
  exact finite_invariant_field_triviality hconstants hfixed

theorem perfect_group_abelian_hom_trivial
    {G A : Type*} [Group G] [CommGroup A]
    (hperfect : commutator G = ⊤) (f : G →* A) (g : G) : f g = 1 := by
  apply MonoidHom.mem_ker.mp
  apply Abelianization.commutator_subset_ker f
  rw [hperfect]
  trivial

theorem perfect_group_abelian_hom_triviality_target :
    Targets.PerfectGroupAbelianHomTriviality := by
  intro G A instG instA hperfect f g
  exact perfect_group_abelian_hom_trivial hperfect f g

/-- A surjective abelian quotient of a perfect group is the trivial
group. Neither finite group enumeration nor a presentation is required. -/
theorem perfect_group_surjective_abelian_quotient_subsingleton
    {G A : Type*} [Group G] [CommGroup A]
    (hperfect : commutator G = ⊤) (f : G →* A) (hsurjective : Function.Surjective f) :
    Subsingleton A := by
  refine ⟨fun a b => ?_⟩
  obtain ⟨g, rfl⟩ := hsurjective a
  obtain ⟨h, rfl⟩ := hsurjective b
  rw [perfect_group_abelian_hom_trivial hperfect f g,
    perfect_group_abelian_hom_trivial hperfect f h]

/-- Killing generators that normally generate G kills any actual group
homomorphism. The target group need not be abelian or finite. -/
theorem normally_generating_elements_kill_hom
    {G A : Type*} [Group G] [Group A] (generators : Set G)
    (hgenerate : Subgroup.normalClosure generators = ⊤)
    (f : G →* A) (hkill : ∀ g ∈ generators, f g = 1) (g : G) : f g = 1 := by
  have hkernel : Subgroup.normalClosure generators ≤ f.ker :=
    Subgroup.normalClosure_le_normal fun h hh => MonoidHom.mem_ker.mpr (hkill h hh)
  apply MonoidHom.mem_ker.mp
  apply hkernel
  rw [hgenerate]
  trivial

/-- The genuine-ramification group criterion uses the action on the
whole coset fiber: normal generation forces any action fixing every
fiber point under each generator to be trivial. -/
theorem normally_generating_elements_fixed_action
    {G X : Type*} [Group G] [MulAction G X] (generators : Set G)
    (hgenerate : Subgroup.normalClosure generators = ⊤)
    (hfixed : ∀ g ∈ generators, ∀ x : X, g • x = x) :
    ∀ (g : G) (x : X), g • x = x := by
  have hkill : ∀ g ∈ generators, MulAction.toPermHom G X g = 1 := by
    intro g hg
    apply Equiv.ext
    exact hfixed g hg
  intro g x
  exact congrArg (fun permutation : Equiv.Perm X => permutation x)
    (normally_generating_elements_kill_hom generators hgenerate
      (MulAction.toPermHom G X) hkill g)

/-- An intermediate coset quotient unramified under all normally
generating inertia elements is trivial. H need not be normal. -/
theorem normally_generating_elements_fixed_cosets_subgroup_top
    {G : Type*} [Group G] (H : Subgroup G) (generators : Set G)
    (hgenerate : Subgroup.normalClosure generators = ⊤)
    (hfixed : ∀ g ∈ generators, ∀ x : G ⧸ H, g • x = x) : H = ⊤ := by
  apply top_unique
  intro g _hg
  rw [← MulAction.stabilizer_quotient H]
  exact normally_generating_elements_fixed_action generators hgenerate hfixed g _

end Litt3.QuotientGeometry
