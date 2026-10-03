import Definitions.Deformations.RegularFunctionTensor
import Solutions.Deformations.RegularFunctionRepresentation

namespace Litt3.Deformations

open scoped MonoidAlgebra TensorProduct

variable {k G V : Type*} [CommRing k] [Group G] [Finite G]
    [AddCommGroup V] [Module k V]

@[simp] theorem regular_function_tensor_equiv_tmul (r : k[G]) (v : V) (g : G) :
    regularFunctionTensorEquiv (r ⊗ₜ[k] v) g = r g⁻¹ • v := by
  classical
  change ((TensorProduct.equivFinsuppOfBasisLeft
    (Finsupp.basisSingleOne : Module.Basis G k k[G])) (r ⊗ₜ[k] v)) g⁻¹ = _
  rw [TensorProduct.equivFinsuppOfBasisLeft_apply_tmul_apply]
  rfl

/-- The actual tensor/function equivalence intertwines the full actual
group-algebra action, not just dimensions or individual invariant spaces. -/
theorem regular_function_tensor_equiv_smul (r : k[G]) (x : k[G] ⊗[k] V) :
    regularFunctionTensorEquiv (r • x) =
      (regularFunctionRepresentation (k := k) (G := G) (W := V)).asAlgebraHom r
        (regularFunctionTensorEquiv x) := by
  induction r using MonoidAlgebra.induction_on with
  | hM g =>
    rw [Representation.asAlgebraHom_of]
    induction x using TensorProduct.induction_on with
    | zero => simp
    | tmul a v =>
      ext h
      simp [TensorProduct.smul_tmul', smul_eq_mul, MonoidAlgebra.of_apply,
        mul_inv_rev]
    | add x y hx hy => simpa only [smul_add, map_add] using congrArg₂ (· + ·) hx hy
  | hadd r s hr hs =>
    simpa only [add_smul, map_add, LinearMap.add_apply] using congrArg₂ (· + ·) hr hs
  | hsmul c r hr =>
    rw [smul_assoc, map_smul, hr, map_smul, LinearMap.smul_apply]

/-- A genuine full group-algebra module equivalence from extension of
scalars to the regular function representation. -/
noncomputable def regularFunctionTensorModuleEquiv :
    k[G] ⊗[k] V ≃ₗ[k[G]]
      (regularFunctionRepresentation (k := k) (G := G) (W := V)).asModule where
  toFun x := (regularFunctionRepresentation (k := k) (G := G) (W := V)).asModuleEquiv.symm
    (regularFunctionTensorEquiv x)
  invFun y := regularFunctionTensorEquiv.symm
    ((regularFunctionRepresentation (k := k) (G := G) (W := V)).asModuleEquiv y)
  left_inv _ := by simp
  right_inv _ := by simp
  map_add' _ _ := by simp
  map_smul' r x := by
    apply (regularFunctionRepresentation (k := k) (G := G) (W := V)).asModuleEquiv.injective
    simpa using regular_function_tensor_equiv_smul r x

/-- A coefficient basis extends to an actual group-algebra basis.
It may have any cardinality. -/
noncomputable def regularFunctionModuleBasis {ι : Type*} (b : Module.Basis ι k V) :
    Module.Basis ι k[G]
      (regularFunctionRepresentation (k := k) (G := G) (W := V)).asModule :=
  (b.baseChange k[G]).map regularFunctionTensorModuleEquiv

theorem regular_function_module_free [Module.Free k V] :
    Module.Free k[G]
      (regularFunctionRepresentation (k := k) (G := G) (W := V)).asModule :=
  Module.Free.of_basis (regularFunctionModuleBasis (Module.Free.chooseBasis k V))

end Litt3.Deformations
