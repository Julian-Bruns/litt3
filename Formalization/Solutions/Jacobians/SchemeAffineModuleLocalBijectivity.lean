import Mathlib.AlgebraicGeometry.AffineScheme
import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Topology.Sheaves.LocallySurjective

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})
  {M N : PresheafOfModules.{u} X.ringCatSheaf.val} (f : M ⟶ N)
  (h : ∀ U : X.Opens, IsAffineOpen U → Nonempty U →
    Function.Bijective ((f.app (op U)).hom))

include h

/-- Actual bijectivity on the ORIGINAL nonempty affine basis gives
true site-local injectivity, for ANY original scheme and ANY original
module PRESHEAVES. No sheaf condition or stalk presentation is assumed. -/
theorem actualSchemeModule_affine_locally_injective :
    PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X) f := by
  constructor
  intro U a b hab
  intro x hx
  obtain ⟨_, ⟨V, hV, rfl⟩, hxV, hVU⟩ :=
    X.isBasis_affineOpens.exists_subset_of_mem_open hx U.unop.2
  let i : V ⟶ U.unop := homOfLE hVU
  refine ⟨V, i, ?_, hxV⟩
  change M.map i.op a = M.map i.op b
  apply (h V hV ⟨⟨x, hxV⟩⟩).injective
  rw [PresheafOfModules.naturality_apply, PresheafOfModules.naturality_apply]
  have hab' : f.app U a = f.app U b := hab
  exact congrArg (fun z : N.obj U => N.map i.op z) hab'

/-- Actual surjectivity on the ORIGINAL nonempty affine basis gives
true site-local surjectivity, including arbitrary original opens. -/
theorem actualSchemeModule_affine_locally_surjective :
    PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X) f := by
  constructor
  intro U c
  intro x hx
  obtain ⟨_, ⟨V, hV, rfl⟩, hxV, hVU⟩ :=
    X.isBasis_affineOpens.exists_subset_of_mem_open hx U.2
  let i : V ⟶ U := homOfLE hVU
  refine ⟨V, i, ?_, hxV⟩
  change ∃ a : M.obj (op V), f.app (op V) a = N.map i.op c
  exact (h V hV ⟨⟨x, hxV⟩⟩).surjective (N.map i.op c)

end Litt3.Jacobians
