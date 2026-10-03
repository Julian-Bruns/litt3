import Theorems.Deformations.GroupAlgebraAugmentation
import Solutions.Deformations.GroupAlgebraModules

namespace Litt3.Deformations

open scoped MonoidAlgebra

section CommRing

variable {k G : Type*} [CommRing k] [Group G]

theorem group_algebra_augmentation_of (g : G) :
    groupAlgebraAugmentation (k := k) (G := G) (MonoidAlgebra.of k G g) = 1 := by
  simp [groupAlgebraAugmentation, MonoidAlgebra.of_apply]

theorem group_algebra_augmentation_surjective :
    Function.Surjective (groupAlgebraAugmentation (k := k) (G := G)) := by
  intro c
  exact ⟨algebraMap k k[G] c, (groupAlgebraAugmentation (k := k) (G := G)).commutes c⟩

/-- Every group-algebra element differs from its actual coefficient
sum by a left-ideal combination of actual augmentation generators. -/
theorem augmentation_displacement_mem (I : Ideal k[G])
    (generators : ∀ g, MonoidAlgebra.of k G g - 1 ∈ I) (r : k[G]) :
    r - algebraMap k k[G] (groupAlgebraAugmentation (k := k) (G := G) r) ∈ I := by
  apply MonoidAlgebra.induction_on r
  · intro g
    rw [group_algebra_augmentation_of, map_one]
    exact generators g
  · intro a b ha hb
    have heq : a + b - algebraMap k k[G]
        (groupAlgebraAugmentation (k := k) (G := G) (a + b)) =
        (a - algebraMap k k[G] (groupAlgebraAugmentation (k := k) (G := G) a)) +
        (b - algebraMap k k[G] (groupAlgebraAugmentation (k := k) (G := G) b)) := by
      rw [map_add, map_add]
      abel
    rw [heq]
    exact I.add_mem ha hb
  · intro c a ha
    have heq : c • a - algebraMap k k[G]
        (groupAlgebraAugmentation (k := k) (G := G) (c • a)) =
        algebraMap k k[G] c *
          (a - algebraMap k k[G] (groupAlgebraAugmentation (k := k) (G := G) a)) := by
      rw [map_smul, Algebra.smul_def, smul_eq_mul, map_mul, mul_sub]
    rw [heq]
    exact I.smul_mem (algebraMap k k[G] c) ha

theorem augmentation_ideal_le_of_generators (I : Ideal k[G])
    (generators : ∀ g, MonoidAlgebra.of k G g - 1 ∈ I) :
    groupAlgebraAugmentationIdeal (k := k) (G := G) ≤ I := by
  intro r hr
  have hz : groupAlgebraAugmentation (k := k) (G := G) r = 0 := hr
  have h := augmentation_displacement_mem I generators r
  simpa only [hz, map_zero, sub_zero] using h

end CommRing

section Field

variable {k G : Type*} [Field k] [Group G]

theorem group_algebra_augmentation_ideal_maximal :
    (groupAlgebraAugmentationIdeal (k := k) (G := G)).IsMaximal :=
  RingHom.ker_isMaximal_of_surjective
    (groupAlgebraAugmentation (k := k) (G := G)).toRingHom
    group_algebra_augmentation_surjective

variable {p : ℕ} [Fact p.Prime] [CharP k p] [Finite G]

theorem augmentation_generator_mem_maximal (group : IsPGroup p G)
    (I : Ideal k[G]) (maximal : I.IsMaximal) (g : G) :
    MonoidAlgebra.of k G g - 1 ∈ I := by
  letI : IsSimpleModule k[G] (k[G] ⧸ I) :=
    isSimpleModule_iff_isCoatom.mpr (Ideal.isMaximal_def.mp maximal)
  have htriv := simple_p_group_module_trivial (k := k) (M := k[G] ⧸ I) group
  have h := htriv g (I.mkQ 1)
  rw [← I.mkQ.map_smul, smul_eq_mul, mul_one] at h
  have hz : I.mkQ (MonoidAlgebra.of k G g - 1) = 0 := by
    rw [map_sub, h, sub_self]
  have hker : MonoidAlgebra.of k G g - 1 ∈ LinearMap.ker I.mkQ := hz
  simpa only [Submodule.ker_mkQ] using hker

/-- For every actual finite p-group over any characteristic-p
field, the entire augmentation ideal equals the actual Jacobson
radical. No Jennings or radical-identification hypothesis is used. -/
theorem p_group_augmentation_radical (group : IsPGroup p G) :
    Specifications.PGroupAugmentationRadical (k := k) (G := G) := by
  unfold Specifications.PGroupAugmentationRadical
  apply le_antisymm
  · rw [Ring.jacobson_eq_sInf_isMaximal]
    apply le_sInf
    intro I hI
    exact augmentation_ideal_le_of_generators I (augmentation_generator_mem_maximal group I hI)
  · rw [Ring.jacobson_eq_sInf_isMaximal]
    exact sInf_le group_algebra_augmentation_ideal_maximal

/-- The actual p-group algebra has exactly one maximal left
ideal, namely its entire augmentation ideal. -/
theorem p_group_maximal_left_ideal_unique (group : IsPGroup p G)
    (I : Ideal k[G]) (maximal : I.IsMaximal) :
    I = groupAlgebraAugmentationIdeal (k := k) (G := G) := by
  have haug := Ideal.isMaximal_def.mp
    (group_algebra_augmentation_ideal_maximal (k := k) (G := G))
  have hI := Ideal.isMaximal_def.mp maximal
  apply (haug.le_iff_eq hI.ne_top).mp
  exact augmentation_ideal_le_of_generators I (augmentation_generator_mem_maximal group I maximal)

end Field

end Litt3.Deformations
