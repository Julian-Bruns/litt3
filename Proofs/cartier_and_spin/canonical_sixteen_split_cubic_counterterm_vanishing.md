# Proof: the actual paired fixed points remove both scalar errors

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_SIXTEEN_SPLIT_CUBIC_COUNTERTERM_VANISHING_FIDELITY_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. Accepted actual input and the only remaining error class

The [paired cubic theorem](canonical_split_paired_cubic_adjoint_counterterms.md) supplies the actual integral image C, exact conductor-adjoint R, the SAME sections ρ,a,b,Q, and the compatible original residue identities
\[
\mathcal DQ=(3/γ₂)a²/ρ,\qquad EQ=(3/γ₁)b²/ρ
\quad\text{on }C.
\tag{1}
\]
Its degree16 effective-divisor argument already proves both errors zero outside C∼8L. It remains to consider
\[
C\sim8L,\quad R\sim2L,\quad ε₁,ε₂\in k.
\tag{2}
\]
We do not assume either scalar zero. Choose the compatible rational representatives with pole bundles
\[
Q:\ 8D+24F_\infty,\quad ρ:\ 2D+6F_\infty,
\quad a,b:\ 5D+16F_\infty.
\tag{3}
\]
The actual prime C avoids D and contains no base fiber. In particular its defining representative Q has exact pole order8 at each D± and24 at generic infinity.

Put P₂=P(u−1), P₁=t³⁰P(v/t³−1), J₂=ρ𝒟a−a𝒟ρ and J₁=ρEb−bEρ. The accepted global pair is
\[
N₂:=a³-P₂ρ³=γ₂QJ₂+ε₂Q²,
\qquad N₁:=b³-P₁ρ³=γ₁QJ₁+ε₁Q².
\tag{4}
\]
The surface fields satisfy
\[
\mathcal Dt=v,\quad\mathcal Du=0,\quad\mathcal Dv=-3dt⁵,
\qquad Et=-tu,\quad Eu=2(u²+d),\quad Ev=-3uv,
\]
\[
\mathcal D⁵=0,\quad E⁵=d²E,\quad
\mathcal DP₂=EP₁=0.
\tag{5}
\]
These restricted identities follow by checking t,u,v; they are also checked explicitly in the [relative Cartier derivation](../../Research/notes/oct03_ten_hour/split_paired_cubic_cartier_identities.md). They are rational surface identities, not an assumed connection on O(R).

## 2. A logarithmic identity retaining nonzero scalar errors

For a derivation V with V⁵=cV and Vc=0, its logarithmic derivative ℓ=Vz/z satisfies
\[
(V⁴-c)ℓ=-ℓ⁵.
\tag{6}
\]
Indeed V−ℓ=zVz⁻¹, and expanding its fifth restricted power gives V⁵−V⁴ℓ−ℓ⁵. If VH=0, the three distinct roots Y³=H are V-constants in their separable auxiliary extension. Partial fractions applied to Vh/(h³−H) and hVh/(h³−H), followed by(6), therefore give
\[
(V⁴-c)\frac{Vh}{h³-H}
=-H\left(\frac{hVh}{h³-H}\right)^5.
\tag{7}
\]
The identity descends to the original field. The auxiliary roots in this verification supply no original endpoint leg.

Write f=ρ/Q,g=a/Q,j=b/Q and cᵢ=γᵢ⁻⁴. We prove the two EXACT shared-current identities
\[
\mathcal D⁴f=-c₂P₂g⁵,\qquad
(E⁴-d²)f=-c₁P₁j⁵
\tag{8}
\]
while both scalar errors are still allowed.

For ε₂=0, division of(4) gives γ₂𝒟(a/ρ)/((a/ρ)³−P₂)=f, and multiplication by a/ρ gives g. Formula(7) gives the first equation of(8). The same argument gives the second when ε₁=0.

If ε₂≠0, define the genuine nonzero section
\[
Q₂^*=N₂/(ε₂Q)=Q+(γ₂/ε₂)J₂\in H⁰(S,O_S(8L)).
\tag{9}
\]
Nonvanishing follows because a³=P₂ρ³ in k(S) would make P₂ a cube, contrary to valuation one along a fixed simple P-root divisor. Write f₂*=ρ/Q₂*,g₂*=a/Q₂*. The original whole identity gives
\[
γ₂\frac{\mathcal D(a/ρ)}{(a/ρ)³-P₂}=f-f₂^*,
\qquad
γ₂\frac{(a/ρ)\mathcal D(a/ρ)}{(a/ρ)³-P₂}=g-g₂^*.
\]
Thus(7) gives
\[
\mathcal D⁴(f-f₂^*)=-c₂P₂(g-g₂^*)⁵.
\tag{10}
\]
For ε₁≠0 the analogous genuine section Q₁*=N₁/(ε₁Q) and currents f₁*=ρ/Q₁*,j₁*=b/Q₁* give
\[
(E⁴-d²)(f-f₁^*)=-c₁P₁(j-j₁^*)⁵.
\tag{11}
\]
Its nonvanishing follows by the actual endpoint swap, or the same fixed-root valuation. No component of either auxiliary zero divisor is identified with an actual source.

## 3. Prime pole separation and the coincident-partner case

First suppose Q₂* has no C component. Equation(10) identifies A₂=𝒟⁴f+c₂P₂g⁵ with its starred expression. The unstarred expression has poles only on C,D,F∞; the starred expression has poles only on div(Q₂*),D,F∞. Since C is prime and not a component of the other divisor, A₂ has no nonboundary finite divisorial pole. The same argument applies to A₁=(E⁴−d²)f+c₁P₁j⁵ when Q₁* has no C component.

At each boundary use h=1/u as normal parameter. We have 𝒟h=0 and Eh=3(1+dh²), while each field's tangential coefficients have pole at most1. Each application lowers a boundary zero order by at most1. Formula(3) gives ord_D±f≥6 and ord_D±g,ord_D±j≥3; the polynomials Pᵢ have pole at most10. Consequently each Aᵢ has zero order at least2 along both boundaries.

At generic infinity s=t⁻¹, f has zero order at least18 and g,j at least8. The scaled field s²𝒟 is regular and tangent to infinity, so four iterations lower order by at most8. The scaled field s²E is regular and may be transverse, so four iterations lower order by at most12. Thus 𝒟⁴f has zero order at least10 and E⁴f at least6. The remaining polynomial terms Pᵢg⁵ or Pᵢj⁵ have zero order at least40−30=10. Both Aᵢ are therefore regular at infinity.

Since S is smooth and projective, a rational function without divisorial poles is constant. Its positive boundary zero order forces it to be zero. This proves(8) whenever its corresponding partner has no C component. This argument uses only the shared-current equations; no fourth-iterate assertion about E⁴j is needed.

If instead Qᵢ* contains C, the equal8L class makes Qᵢ*=νQ for a nonzero constant ν: the remaining effective divisor is linearly zero. For the second leg(9) gives J₂=(ε₂/γ₂)(ν−1)Q and N₂=ε₂νQ². Differentiating and using 𝒟P₂=0 gives
\[
\mathcal DN₂=(3a²/ρ)J₂+(3N₂/ρ)\mathcal Dρ.
\]
At generic actual C, the FIRST-order Q coefficient, using the ACTUAL residue(1), is 2ν=ν−1, hence ν=−1. The identical calculation uses E,b for the first leg. Therefore the difference currents in(10) or(11) are twice the original currents. Since 2⁵=2, that identity again proves the corresponding equation of(8). The coincident case has used the original actual source residue and is not absorbed into an invalid pole-separation shortcut.

This finishes(8) with no assumption on either scalar error, or on R's irreducibility, multiplicities or singularities.

## 4. The original first-leg infinity forces ε₂=0

Let p be either affine point
\[
t=v=0,\qquad u²=-d.
\tag{12}
\]
Both points are smooth because u≠0. They are NOT on actual C. Indeed every point of C₀ above t=0 belongs to H₁. Actual étaleness gives pole order3 for x₁+1 there, while t has simple zero. Thus v=t³(x₁+1) is a unit at every such point. This excludes both v=0 auxiliary points from the actual image, including when distinct normalization branches have a common image elsewhere. Hence Q(p)≠0, and f,g,j and their numerators are regular at p.

Both regular fields 𝒟 and E vanish at p. Their positive iterates on any regular function therefore evaluate to zero at p. Also P₁(p)=0: its global polynomial expansion in t,v has terms t^{30−3i}(v−t³)^i,0≤i≤10, all zero at(t,v)=(0,0). Conversely P₂(p)≠0 because u²=−d is a q₀ root and the fixed P roots are disjoint.

Evaluate the SECOND equation of(8): it gives −d²f(p)=0, hence ρ(p)=0. Evaluate the FIRST equation: c₂P₂(p)g(p)⁵=0, hence a(p)=0. Finally evaluate the ORIGINAL whole second-leg identity(4). Both N₂(p) and J₂(p) vanish, the latter because 𝒟 vanishes at p. Thus
\[
0=ε₂Q(p)².
\]
As ε₂ is a scalar and Q(p) is a unit, ε₂=0. Both original cubics and the toral restricted coefficient d² have been retained; a single endpoint identity would not supply this paired fixed-point argument.

## 5. Exact endpoint swap forces ε₁=0

Swap the two ACTUAL endpoint maps on their SAME source. The new coordinates are
\[
τ=t^{-1},\qquad u'=v/t³,\qquad v'=u/t³,
\]
and satisfy u'²−v'²=d(τ⁶−1). The original actual hypotheses persist, with κ'=κ⁻¹. Use the compatible balanced representatives
\[
Q'=t^{-24}Q,\quad ρ'=t^{-6}ρ,
\quad a'=t^{-16}b,\quad b'=t^{-16}a.
\tag{13}
\]
They have the same pole bundles as(3) in the τ-coordinate; on the actual source a'=ρ'y₁ and b'=τ¹⁰ρ'y₂. The new second-leg field is 𝒟'=t⁻²E. Its Wronskian satisfies
\[
ρ'\mathcal D'a'-a'\mathcal D'ρ'=t^{-24}J₁,
\]
because the additional derivative coefficient −16+6=−10 is zero in characteristic5. Moreover
\[
(a')³-P(u'-1)(ρ')³=t^{-48}N₁,
\qquad(Q')²=t^{-48}Q².
\]
Thus its whole second-leg identity has γ₂'=γ₁ and EXACT scalar error ε₂'=ε₁. The argument in Section4, now at the actual swapped first-leg infinity points, proves ε₂'=0. Therefore ε₁=0 too.

Both original endpoint maps have only been renamed. Neither source is replaced by an auxiliary denominator normalization, and no simultaneous Galois closure is presumed.

## 6. Scope

The balanced class remains C²=384,p_a(C)=177,g(C₀)=129,δ=48,R∼2L,degΔ=96. This theorem removes the scalar-error alternative for that actual source and supplies the zero-error identities for every actual disjoint degree16 packet. It does not force a particular conductor factorization, turn an auxiliary curve into an étale endpoint source, or close all remaining degree16 zero-error geometry. Higher positive-degree error sections cannot be declared zero merely because their values vanish at auxiliary points. The original unmarked common-cover problem remains unresolved.
