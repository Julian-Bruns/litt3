import Theorems.Deformations.TameAveraging
import Mathlib.Tactic.Abel
import Mathlib.Algebra.CharP.Basic
import Mathlib.Algebra.Module.NatInt

namespace Litt3.Deformations

open scoped BigOperators

section AdditiveAveraging

variable {G K : Type*} [Group G] [Fintype G] [AddCommGroup K]
variable [DistribMulAction G K]

omit [Group G] [DistribMulAction G K] in
theorem order_smul_divideByOrder
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (x : K) :
    Fintype.card G • divideByOrder (G := G) invertibleOrder x = x :=
  (Equiv.ofBijective _ invertibleOrder).apply_symm_apply x

omit [Group G] [DistribMulAction G K] in
theorem divideByOrder_add
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (x y : K) :
    divideByOrder (G := G) invertibleOrder (x + y) =
      divideByOrder (G := G) invertibleOrder x +
      divideByOrder (G := G) invertibleOrder y := by
  apply invertibleOrder.1
  simp only [nsmul_add, order_smul_divideByOrder]

theorem divideByOrder_smul
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (g : G) (x : K) :
    divideByOrder (G := G) invertibleOrder (g • x) =
      g • divideByOrder (G := G) invertibleOrder x := by
  apply invertibleOrder.1
  dsimp only
  rw [order_smul_divideByOrder]
  change g • x = Fintype.card G • actionAddHom g
    (divideByOrder (G := G) invertibleOrder x)
  rw [← (actionAddHom g).map_nsmul, order_smul_divideByOrder]
  rfl

theorem sum_action_invariant (x : K) (h : G) :
    h • (∑ g : G, g • x) = ∑ g : G, g • x := by
  change actionAddHom h (∑ g : G, g • x) = _
  rw [map_sum]
  change (∑ g : G, h • (g • x)) = _
  simp only [smul_smul]
  exact Fintype.sum_equiv (Equiv.mulLeft h)
    (fun g : G => (h * g) • x) (fun g : G => g • x) (fun _ => rfl)

end AdditiveAveraging

section TorsorAveraging

variable {G K A : Type*} [Group G] [Fintype G]
variable [AddCommGroup K] [DistribMulAction G K]
variable [AddTorsor K A] [MulAction G A]
variable (action_affine : ∀ (g : G) (x : K) (a : A),
  g • (x +ᵥ a) = (g • x) +ᵥ (g • a))

include action_affine

omit [Fintype G] in
theorem action_vsub (g : G) (a b : A) :
    g • (a -ᵥ b : K) = g • a -ᵥ g • b := by
  apply (vadd_right_injective (g • b))
  dsimp only
  rw [vsub_vadd, ← action_affine, vsub_vadd]

theorem torsor_sum_transform (a : A) (h : G) :
    h • (∑ g : G, (g • a -ᵥ a : K)) +
      Fintype.card G • (h • a -ᵥ a : K) =
        ∑ g : G, (g • a -ᵥ a : K) := by
  change actionAddHom h (∑ g : G, (g • a -ᵥ a : K)) + _ = _
  rw [map_sum]
  change (∑ g : G, h • (g • a -ᵥ a : K)) + _ = _
  simp_rw [action_vsub action_affine, smul_smul]
  have hreindex := Fintype.sum_equiv (Equiv.mulLeft h)
    (fun g : G => ((h * g) • a -ᵥ a : K))
    (fun g : G => (g • a -ᵥ a : K)) (fun _ => rfl)
  calc
    (∑ g : G, ((h * g) • a -ᵥ h • a : K)) +
        Fintype.card G • (h • a -ᵥ a : K) =
      ∑ g : G, (((h * g) • a -ᵥ h • a) + (h • a -ᵥ a) : K) := by
        rw [Finset.sum_add_distrib]
        simp
    _ = ∑ g : G, ((h * g) • a -ᵥ a : K) := by
        apply Finset.sum_congr rfl
        intro g _
        exact vsub_add_vsub_cancel _ _ _
    _ = ∑ g : G, (g • a -ᵥ a : K) := hreindex

/-- Actual torsor averaging is fixed for every group element. This
works for arbitrary additive groups with uniquely divisible group
order, without linearity or a perfect-field assumption. -/
theorem averageTorsorPoint_fixed
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (a : A) (h : G) :
    h • averageTorsorPoint (G := G) invertibleOrder a =
      averageTorsorPoint (G := G) invertibleOrder a := by
  let S : K := ∑ g : G, (g • a -ᵥ a : K)
  let d : K := divideByOrder (G := G) invertibleOrder S
  have hd : Fintype.card G • d = S :=
    order_smul_divideByOrder invertibleOrder S
  have hs := torsor_sum_transform action_affine a h
  change h • (d +ᵥ a) = d +ᵥ a
  rw [action_affine]
  apply (vsub_left_injective a)
  dsimp only
  simp only [vadd_vsub_assoc, vsub_self, add_zero]
  apply invertibleOrder.1
  dsimp only
  rw [nsmul_add]
  change Fintype.card G • actionAddHom h d +
    Fintype.card G • (h • a -ᵥ a : K) = Fintype.card G • d
  rw [← (actionAddHom h).map_nsmul, hd]
  exact hs

theorem tame_torsor_has_fixed_point
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) :
    HasFixedPoint (G := G) (A := A) := by
  let a : A := Classical.choice (inferInstance : Nonempty A)
  exact ⟨averageTorsorPoint invertibleOrder a,
    averageTorsorPoint_fixed action_affine invertibleOrder a⟩

end TorsorAveraging

section ObstructionAveraging

variable {G K O A : Type*} [Group G] [Fintype G]
variable [AddCommGroup K] [AddCommGroup O]
variable [DistribMulAction G K] [DistribMulAction G O]
variable [AddTorsor K A] [MulAction G A]
variable (R : K →+ O) (c : A → O)
variable (affine : IsAffineObstruction R c)
variable (equivariant : ∀ (g : G) (a : A), c (g • a) = g • c a)

include affine equivariant

omit [DistribMulAction G K] in
/-- The value of the COMPLETE affine obstruction at the actual averaged
point is the average of all its equivariant values. Only injectivity
of group-order multiplication on the obstruction group will be needed
to test zero. -/
theorem obstruction_average_identity
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (a : A) :
    Fintype.card G • c (averageTorsorPoint (G := G) invertibleOrder a) =
      ∑ g : G, g • c a := by
  let S : K := ∑ g : G, (g • a -ᵥ a : K)
  let d : K := divideByOrder (G := G) invertibleOrder S
  have hd : Fintype.card G • d = S :=
    order_smul_divideByOrder invertibleOrder S
  have hpoint : c (averageTorsorPoint (G := G) invertibleOrder a) =
      R d + c a := affine d a
  rw [hpoint, nsmul_add, ← R.map_nsmul, hd]
  change R (∑ g : G, (g • a -ᵥ a : K)) + Fintype.card G • c a = _
  calc
    R (∑ g : G, (g • a -ᵥ a : K)) + Fintype.card G • c a =
      ∑ g : G, (R (g • a -ᵥ a) + c a) := by
        rw [Finset.sum_add_distrib, map_sum]
        simp
    _ = ∑ g : G, c (g • a) := by
        apply Finset.sum_congr rfl
        intro g _
        have H := affine (g • a -ᵥ a) a
        rw [vsub_vadd] at H
        exact H.symm
    _ = ∑ g : G, g • c a := by
        apply Finset.sum_congr rfl
        intro g _
        exact equivariant g a

omit [DistribMulAction G K] in
theorem obstruction_average_zero
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x))
    (injectiveOrderO : Function.Injective
      (fun y : O => Fintype.card G • y))
    (a : A) (ha : c a = 0) :
    c (averageTorsorPoint (G := G) invertibleOrder a) = 0 := by
  apply injectiveOrderO
  dsimp only
  rw [obstruction_average_identity R c affine equivariant invertibleOrder,
    ha]
  simp

omit [DistribMulAction G K] in
/-- Under the source's bijectivity hypothesis on the obstruction
group, the full obstruction value at the averaged point is literally
the uniquely divided orbit sum, not merely equal after multiplication
by the group order. -/
theorem obstruction_average_value
    (invertibleOrderK : Function.Bijective
      (fun x : K => Fintype.card G • x))
    (invertibleOrderO : Function.Bijective
      (fun y : O => Fintype.card G • y)) (a : A) :
    c (averageTorsorPoint (G := G) invertibleOrderK a) =
      divideByOrder (G := G) invertibleOrderO (∑ g : G, g • c a) := by
  apply invertibleOrderO.1
  dsimp only
  rw [obstruction_average_identity R c affine equivariant invertibleOrderK,
    order_smul_divideByOrder]

theorem obstruction_average_invariant_value
    (action_affine : ∀ (g : G) (x : K) (a : A),
      g • (x +ᵥ a) = (g • x) +ᵥ (g • a))
    (invertibleOrderK : Function.Bijective
      (fun x : K => Fintype.card G • x))
    (invertibleOrderO : Function.Bijective
      (fun y : O => Fintype.card G • y)) (a : A) :
    invariantObstructionValue c equivariant
      (averageTorsorPoint invertibleOrderK a)
      (averageTorsorPoint_fixed action_affine invertibleOrderK a) =
    ⟨divideByOrder (G := G) invertibleOrderO (∑ g : G, g • c a), by
      intro h
      rw [← divideByOrder_smul, sum_action_invariant]⟩ := by
  apply Subtype.ext
  exact obstruction_average_value R c affine equivariant
    invertibleOrderK invertibleOrderO a

/-- Full-point existence is equivalent to invariant existence. This
retains all noninvariant choices on the left. -/
theorem invariant_zero_iff
    (action_affine : ∀ (g : G) (x : K) (a : A),
      g • (x +ᵥ a) = (g • x) +ᵥ (g • a))
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x))
    (injectiveOrderO : Function.Injective
      (fun y : O => Fintype.card G • y)) :
    InvariantZeroCriterion (G := G) c := by
  constructor
  · rintro ⟨a, ha⟩
    exact ⟨averageTorsorPoint invertibleOrder a,
      averageTorsorPoint_fixed action_affine invertibleOrder a,
      obstruction_average_zero R c affine equivariant invertibleOrder
        injectiveOrderO a ha⟩
  · rintro ⟨a, _, ha⟩
    exact ⟨a, ha⟩

end ObstructionAveraging

section ResidualCriterion

variable {G K O Q A : Type*} [Group G] [Fintype G]
variable [AddCommGroup K] [AddCommGroup O] [AddCommGroup Q]
variable [DistribMulAction G K] [DistribMulAction G O]
variable [AddTorsor K A] [MulAction G A]
variable (R : K →+ O) (c : A → O)
variable (affine : IsAffineObstruction R c)
variable (equivariant : ∀ (g : G) (a : A), c (g • a) = g • c a)
variable (response_equivariant : ∀ (g : G) (x : K), R (g • x) = g • R x)
variable (action_affine : ∀ (g : G) (x : K) (a : A),
  g • (x +ᵥ a) = (g • x) +ᵥ (g • a))

include affine action_affine

omit [Fintype G] in
/-- Two fixed origins differ by an actual invariant response. Thus an
exact quotient detector gives the same residue at both origins. -/
theorem invariant_residual_independent
    (P : invariantSubgroup G O →+ Q)
    (image_in_kernel : ∀ x : invariantSubgroup G K,
      P (invariantResponse R response_equivariant x) = 0)
    (a b : A) (ha : ∀ g : G, g • a = a) (hb : ∀ g : G, g • b = b) :
    P (invariantObstructionValue c equivariant a ha) =
      P (invariantObstructionValue c equivariant b hb) := by
  let x : invariantSubgroup G K := ⟨b -ᵥ a, by
    intro g
    rw [action_vsub action_affine, hb, ha]⟩
  have heq : invariantObstructionValue c equivariant b hb =
      invariantResponse R response_equivariant x +
        invariantObstructionValue c equivariant a ha := by
    apply Subtype.ext
    have H := affine (b -ᵥ a) a
    rw [vsub_vadd] at H
    exact H
  rw [heq, P.map_add, image_in_kernel, zero_add]

/-- The residual of the averaged COMPLETE obstruction is independent
of every original torsor choice, including noninvariant choices. -/
theorem averaged_residual_independent
    (P : invariantSubgroup G O →+ Q)
    (image_in_kernel : ∀ x : invariantSubgroup G K,
      P (invariantResponse R response_equivariant x) = 0)
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (a b : A) :
    P (invariantObstructionValue c equivariant
      (averageTorsorPoint invertibleOrder a)
      (averageTorsorPoint_fixed action_affine invertibleOrder a)) =
    P (invariantObstructionValue c equivariant
      (averageTorsorPoint invertibleOrder b)
      (averageTorsorPoint_fixed action_affine invertibleOrder b)) := by
  exact invariant_residual_independent R c affine equivariant response_equivariant
    action_affine P image_in_kernel _ _ _ _

/-- An exact invariant image gives an iff criterion for ALL original
torsor points; a chosen scalar equation alone does not suffice. -/
theorem averaged_residual_zero_iff
    (P : invariantSubgroup G O →+ Q)
    (image_in_kernel : ∀ x : invariantSubgroup G K,
      P (invariantResponse R response_equivariant x) = 0)
    (kernel_in_image : ∀ y : invariantSubgroup G O, P y = 0 →
      ∃ x : invariantSubgroup G K, invariantResponse R response_equivariant x = y)
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x))
    (injectiveOrderO : Function.Injective
      (fun y : O => Fintype.card G • y)) (a : A) :
    P (invariantObstructionValue c equivariant
      (averageTorsorPoint invertibleOrder a)
      (averageTorsorPoint_fixed action_affine invertibleOrder a)) = 0 ↔
      ∃ b, c b = 0 := by
  let a₀ := averageTorsorPoint (G := G) invertibleOrder a
  have ha₀ : ∀ g : G, g • a₀ = a₀ :=
    averageTorsorPoint_fixed action_affine invertibleOrder a
  constructor
  · intro h
    obtain ⟨x, hx⟩ := kernel_in_image
      (invariantObstructionValue c equivariant a₀ ha₀) h
    have hxval : R (x : K) = c a₀ := congrArg Subtype.val hx
    refine ⟨(-(x : K)) +ᵥ a₀, ?_⟩
    rw [affine, R.map_neg, hxval, neg_add_cancel]
  · rintro ⟨b, hb⟩
    let b₀ := averageTorsorPoint (G := G) invertibleOrder b
    have hb₀ : ∀ g : G, g • b₀ = b₀ :=
      averageTorsorPoint_fixed action_affine invertibleOrder b
    have hzero : c b₀ = 0 := obstruction_average_zero R c affine equivariant
      invertibleOrder injectiveOrderO b hb
    have hind := invariant_residual_independent R c affine equivariant
      response_equivariant action_affine P image_in_kernel a₀ b₀ ha₀ hb₀
    change P (invariantObstructionValue c equivariant a₀ ha₀) = 0
    rw [hind]
    have hzval : invariantObstructionValue c equivariant b₀ hb₀ = 0 :=
      Subtype.ext hzero
    rw [hzval, P.map_zero]

end ResidualCriterion

section PositiveCharacteristic

/-- Characteristic-`p` vector groups satisfy the tame-order hypothesis
whenever `p` does not divide the group order. No obstruction or response
is required to be linear over the coefficient field. -/
theorem vector_group_order_bijective
    (k : Type*) [Field k] (p : ℕ) [CharP k p]
    {V : Type*} [AddCommGroup V] [Module k V]
    (q : ℕ) (prime_to_characteristic : ¬ p ∣ q) :
    Function.Bijective (fun x : V => q • x) := by
  have hq : (q : k) ≠ 0 :=
    (CharP.cast_eq_zero_iff k p q).not.mpr prime_to_characteristic
  have hu : IsUnit (q : k) := isUnit_iff_ne_zero.mpr hq
  simpa only [Nat.cast_smul_eq_nsmul k] using
    (hu.smul_bijective : Function.Bijective (fun x : V => (q : k) • x))

end PositiveCharacteristic

end Litt3.Deformations
