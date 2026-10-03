# Proof: the two boundary values of the retained residue disagree

Version1, 3 October2026. [Independent whole audit PASS](../../Research/audits/CANONICAL_FOURTEEN_SPLIT_DISJOINT_INFINITY_RESIDUE_AUDIT_2026_10_03.md), with no mathematical correction. Both actual source legs are retained.

## 1. The actual audited normal form and its retained residue

Assume the theorem's actual TWO-map source exists. Use [the audited degree-fourteen disjoint normal-form proof](canonical_fourteen_split_disjoint_cubic_adjoint_normal_form.md), including its actual normalization-duality construction and infinity jet lemma. Its actual conic image C⊂S has normalization C₀, and its residual divisor R=C−6L is effective with
\[
RF=2,\quad RD_\pm=0,\quad
R|F_\infty=P_++P_-,\qquad P_\pm=(U=0,V=\pm\sqrt{-d}).
\]
R has no fiber or boundary component. The actual fourteen normalized infinity points have smooth DISTINCT images, all with U a unit. Its proof also retains, before deriving the cubic-Wronskian identity, the EXACT residue equation
\[
\mathcal DQ=\lambda\rho y_2^2\quad\text{on the actual }C,
\qquad\lambda\ne0,
\]
where Q defines C, ρ defines R and 𝒟(t)=v,𝒟(u)=0,𝒟(v)=−3dt⁵. The constant is global: residue(Ω/Q) and θ₂/ρ have identical divisors on the actual smooth normalization, so their quotient is a global unit. Both actual endpoint maps and actual cubic functions are kept.

On F∞ use z=U+V, U=(z+d/z)/2 and V=(z−d/z)/2. In the balanced rational R frame, its infinity defining section is ρ∞=αU, α≠0. The defining Laurent section q=Q∞ has exact poles7 at both z=0 and z=∞ and FOURTEEN simple roots. The ratio h=a∞/ρ∞ is regular on the affine conic with poles at most3 at each boundary. At every actual infinity root, h equals the actual unit s¹⁰y₂. These conclusions, including the distinct roots and pole orders, are exactly the audited normal form's scope; no arbitrary polynomial solution is imported.

## 2. Scaling the residue preserves its constant at every actual root

We spell out the balanced frame weights. In the accepted blowup basis,
\[
R=2B+6F-\sum(a_i-6)E_i,
\qquad D=2B+3F-\sum E_i.
\]
Consequently R−D=3F−Σ(aᵢ−7)Eᵢ. All exceptional components Eᵢ are in finite fibers. Near infinity a compatible rational frame for R therefore has polar representative D+3F∞. The respective rational weights of ρ,a,Q are3,13,21, because a has10F beyond R and Q has18F beyond R.

Let s=t⁻¹ and write
\[
\rho=t^3 r(s,U,V),\quad a=t^{13}b(s,U,V),\quad
Q=t^{21}q(s,U,V),\qquad H=s^{10}y_2.
\]
These expressions are in the SAME balanced R frame. At its finite infinity points r(0)=αU, b(0)/r(0)=h and q(0) is the above Laurent q. The scaled derivation Δvec=s²𝒟 has
\[
\Delta_{\rm vec}(s)=-sV,\quad\Delta_{\rm vec}(U)=-3UV,\quad
\Delta_{\rm vec}(V)=-3(U^2+ds^6),
\qquad\delta=\Delta_{\rm vec}|F_\infty=-3Uz\partial_z.
\]
Since 𝒟(t)=t³V, direct differentiation gives
\[
t^{-23}\mathcal DQ=\Delta_{\rm vec}q+21Vq.
\]
The right side of the actual residue equation scales with the SAME weight23:
\[
t^{-23}\lambda\rho y_2^2=\lambda rH^2.
\]
Every actual infinity point is a q-zero. The q-multiple21Vq therefore vanishes there. A different rational R frame multiplies Q and ρ by the same function; its derivative contributes another Q-multiple, also zero on C. Thus neither the balanced frame nor any further regular local frame changes λ or introduces a nonconstant factor at these roots. Specializing the exact actual equation gives
\[
\delta q=\lambda\alpha U h^2
\quad\text{at ALL fourteen actual simple roots of }q.
\]
U is a unit there by the actual endpoint pole orders. Since δq=−3Uzq′, we conclude
\[
zq'(z)=\beta h(z)^2\quad\text{at all fourteen roots},
\qquad\beta=-\lambda\alpha/3\ne0.
\]
The use of the SAME constant at every root is indispensable and follows from the exact residue, not from an auxiliary differential equation with a freely chosen factor.

## 3. The residue interpolation has inconsistent boundary values

The Laurent function f=zq′−βh² has poles at most7 at z=0 and z=∞ and no other poles: differentiation by z∂z preserves the Laurent degree of q, and h² has poles at most6. It vanishes at each of the fourteen SIMPLE roots of q. Hence f/q has no finite pole. At either boundary q has exact pole7 and f has pole at most7, so f/q is regular there also. It is a regular function on P¹ and therefore a constant μ.

At z=∞ the nonzero leading term of q is q₊z⁷; at z=0 it is q₋z⁻⁷, with q₊q₋≠0. Since h² has strictly smaller pole orders,
\[
\mu=\lim_{z\to\infty}\frac{zq'-\beta h^2}{q}=7,
\qquad
\mu=\lim_{z\to0}\frac{zq'-\beta h^2}{q}=-7.
\]
In characteristic5,7=2 and−7=3. They differ, a contradiction.

Thus the entire audited actual degree-fourteen disjoint normal form is impossible. Its nonempty auxiliary Laurent equations cause no conflict: they omitted precisely this exact-residue interpolation at the fourteen actual source points. This is an actual-source exclusion preserving BOTH étale legs, not an emptiness claim for arbitrary conic or polynomial models.

The [focused derivation note](../../Research/notes/oct03_ten_hour/split_fourteen_infinity_residue_gate.md) records the new implication and its independent frame check. The useful antecedent normal-form proof is retained unchanged. Common-infinity, nonsplit and higher-degree results have their separate scope, and the unmarked common-cover problem remains open.
