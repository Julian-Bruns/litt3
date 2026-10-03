# Proof: the actual paired Cartier quartet survives variable cubic errors

Version1, 3 October2026. Fresh independent [whole or canonical scope/fidelity audit](../../Research/audits/CANONICAL_SPLIT_ALL_DEGREE_PAIRED_CARTIER_QUARTET_FIDELITY_AUDIT_2026_10_03.md): **PASS**, no mathematical correction. Original component evidence and audited input hashes are preserved. No numerical replay at integration.

## 1. Accepted actual sections and uniform quotient orders

The [paired cubic theorem](canonical_split_paired_cubic_adjoint_counterterms.md) supplies C normalized by the actual C₀, its exact conductor-adjoint R=C−6L, SAME sections rho,a,b,Q and the WHOLE original identities
\[
N₂:=a³-P₂\rho³=\gamma₂QJ₂+\varepsilon₂Q²,
\quad
N₁:=b³-P₁\rho³=\gamma₁QJ₁+\varepsilon₁Q²,
\tag{3}
\]
where J₂=rho Da−aD rho,J₁=rho Eb−bE rho, epsilonᵢ are regular sections of A=C−8L, and gamma₁=−kappa⁻¹gamma₂. On actual C its residue is
\[
\mathcal DQ=(3/\gamma₂)a²/\rho,
\qquad EQ=(3/\gamma₁)b²/\rho.
\tag{4}
\]
Neither error is assumed constant or zero. All quotient and product calculations use compatible rational representatives; derivatives of a common R frame cancel in each Wronskian.

The fields satisfy D⁵=0,E⁵=d²E,DP₂=EP₁=0. These identities are checked on t,u,v; in particular Eu=2(u²+d),E⁴u=4u⁵+d²u and E⁵u=d²Eu.

The R frame cancels from f=rho/Q,g=a/Q,j=b/Q. Their divisor identities are
\[
\operatorname{div}(f)=R-C+6D+18F_\infty,
\]
\[
\operatorname{div}(g)=\operatorname{div}_0(a)-C+3D+8F_\infty,
\quad
\operatorname{div}(j)=\operatorname{div}_0(b)-C+3D+8F_\infty.
\tag{5}
\]
Here div₀ means the effective zero divisor of a genuine section. The actual C avoids D and contains no base fiber. Therefore the currents have finite nonboundary poles only on C and uniform bounds
\[
\operatorname{ord}_{D_\pm}f\ge6,\quad
\operatorname{ord}_{D_\pm}g,j\ge3,
\quad\operatorname{ord}_{F_\infty}f\ge18,
\quad\operatorname{ord}_{F_\infty}g,j\ge8.
\tag{6}
\]
These statements permit arbitrary effective R boundary or end-fiber components and do not assume a boundary-only pole representative of R.

## 2. Exact logarithmic currents with arbitrary error sections

For a derivation V with V⁵=cV,Vc=0, its logarithmic derivative ell=Vz/z obeys
\[
(V⁴-c)\ell=-\ell⁵.
\tag{7}
\]
The gauge equality V−ell=zVz⁻¹ and the restricted-power expansion (V−ell)⁵=V⁵−V⁴ell−ell⁵ prove this identity. If VH=0, adjoin the three distinct V-constant roots Y³=H. Partial fractions give
\[
\frac{Vh}{h³-H}=\sum_{Y³=H}\frac{V(h-Y)/(h-Y)}{3Y²},
\quad
\frac{hVh}{h³-H}=\sum_{Y³=H}\frac{V(h-Y)/(h-Y)}{3Y}.
\]
Formula(7) gives the EXACT paired relations
\[
(V⁴-c)\frac{Vh}{h³-H}
=-H\left(\frac{hVh}{h³-H}\right)^5,
\]
\[
(V⁴-c)\frac{hVh}{h³-H}
=-H³\left(\frac{Vh}{h³-H}\right)^5.
\tag{8}
\]
The coefficients are fixed by V and the identities descend to the original field. Scaling both currents by gamma introduces gamma⁻⁴. The auxiliary roots used to verify(8) receive no original endpoint map.

For a nonzero second error define the genuine nonzero section
\[
\widetilde Q₂=N₂/Q=\gamma₂J₂+\varepsilon₂Q
\in H⁰(S,O(2C-8L)),
\]
\[
f₂^*=\varepsilon₂\rho/\widetilde Q₂,
\qquad g₂^*=\varepsilon₂a/\widetilde Q₂.
\tag{9}
\]
Its nonvanishing follows because a³=P₂rho³ would make P₂ a cube in k(S), contradicted by a valuation-one fixed simple P-root prime. The first-leg denominator is likewise nonzero, by the actual endpoint swap.

Dividing(3), with h=a/rho, gives EXACT algebraic differences
\[
\gamma₂\frac{\mathcal Dh}{h³-P₂}=f-f₂^*,
\qquad
\gamma₂\frac{h\mathcal Dh}{h³-P₂}=g-g₂^*.
\tag{10}
\]
No derivative of a variable epsilon has been omitted. Formula(8) applies to these differences. The first leg gives the same two difference relations for f−f₁*,j−j₁*, using E,P₁ and gamma₁. If an error is zero, both corresponding unstarred relations follow directly.

The starred quotient bundles are the SAME as the originals:
\[
A+R-(2C-8L)=-6L,
\]
\[
A+(3D+10F_\infty+R)-(2C-8L)=-3D-8F_\infty.
\]
Since their numerators are genuine sections, poles of individual rational epsilon or R representatives create no additional finite geometric prime pole. Away from D,F∞ their only possible poles lie on their denominator divisor.

## 3. Prime pole separation and the coincident component

Let the shared and companion defects be
\[
A₂=\mathcal D⁴f+c₂P₂g⁵,\quad
B₂=\mathcal D⁴g+c₂P₂³f⁵,
\]
\[
A₁=(E⁴-d²)f+c₁P₁j⁵,\quad
B₁=(E⁴-d²)j+c₁P₁³f⁵.
\tag{11}
\]
If Qtilde₂ has no C component, the difference-current equations equate A₂,B₂ to their starred expressions. Their unstarred finite nonboundary poles can only lie on C, while the starred expressions are regular at its generic point. Both derivations and Pᵢ are regular on every finite nonboundary chart, including reducible-fiber nodes. The possible C pole is removed. The first-leg argument is identical. Closed intersections of the auxiliary and actual divisors do not invalidate this prime valuation argument.

If instead Qtilde₂ contains C, global divisibility writes Qtilde₂=QK₂ for a regular section K₂ of A. Then
\[
N₂=Q²K₂,\qquad J₂=(K₂-\varepsilon₂)Q/\gamma₂.
\]
Differentiate N₂ and use the exact identity
\[
\mathcal DN₂=(3a²/\rho)J₂+(3N₂/\rho)\mathcal D\rho.
\]
Comparing its FIRST-order Q coefficient at generic actual C, using(4), gives2K₂=K₂−epsilon₂ on C. Derivatives of K₂ multiply Q² and do not enter this coefficient. Thus K₂+epsilon₂ restricts to zero on C. Since H⁰(A−C)=H⁰(−8L)=0 by negative fiber degree, K₂=−epsilon₂ GLOBALLY. Its starred currents are minus the originals. Their differences are twice the originals and2⁵=2, so the corresponding two defects vanish exactly. The first-leg coincident case uses E,b and its ORIGINAL actual residue. No invalid pole separation on a shared C component is used.

## 4. Global residual bounds force shared defects zero and companion defects constant

At either boundary, h=1/u satisfies Dh=0 and Eh=3(1+dh²); tangential field coefficients have pole at most1. Each derivative lowers a positive boundary order by at most1. The Pᵢ have pole at most10. Therefore(6) gives
\[
\operatorname{ord}_{D_\pm}A_i\ge2,
\qquad\operatorname{ord}_{D_\pm}B_i\ge-1.
\tag{12}
\]
At infinity s²D is regular and tangent, lowering order by at most2 per application. The regular s²E lowers order by at most3. These rough bounds already make both Aᵢ regular, with orders at least10 and6 for their fourth-derivative terms; the polynomial terms have order at least40−30=10. They also make D⁴g and both companion polynomial terms regular, the latter having order at least90−90=0.

The remaining E⁴j is regular by an exact fourth-iterate cancellation. Complete at generic F∞ with s=t⁻¹,V=v/t³ and coefficient field k(V,U₀),U₀²=V²+d. E fixes V,U₀ and U=U₀+O(s⁶). Write E=E₀+E₁, E₀=U₀s⁻²partial_s, with E₁ raising valuation by at least3. A fourfold word containing E₁ lowers order by at most6, so is regular on j of order at least8. The remaining word acts on sⁿ by
\[
E₀⁴(sⁿ)=U₀⁴n(n-3)(n-6)(n-9)s^{n-12}.
\]
Its coefficient is zero in characteristic5 for n=8,9,10,11; for n≥12 its exponent is nonnegative. Termwise application proves regularity of E⁴j. No degree16 or scalar-error assumption occurs here.

After prime pole separation each Aᵢ is a global regular function and vanishes on D, hence is zero. Each Bᵢ has poles bounded by D only. H⁰(O(D)) consists of constants: an effective divisor linearly D has intersection−3 with each D± and contains both; subtraction leaves a linearly trivial effective divisor, hence zero. Thus Bᵢ are constants. This covers distinct auxiliary denominators, while the coincident and zero-error cases already gave zero defects.

## 5. Original finite auxiliary points remove B₂ and force genuine section zeros

Let p be either smooth affine point t=v=0,u²=−d. Actual C avoids p. Indeed an original source point over t=0 lies on reduced H₁, where t has zero order1 and actual x₁+1 pole order3; v=t³(x₁+1) is a unit. Normalization surjectivity excludes any hidden actual image point. Thus Q is a unit at p.

Both fields vanish at p, so positive iterates of a regular function evaluate to zero there. P₁(p)=0 from its global expansion in t,v, while P₂(p) is a unit by P/q₀ coprimality. The now proved A₁=0 yields−d²f(p)=0; A₂=0 then yields g(p)=0. Thus the genuine rho and a coefficients vanish at p. Consequently B₂(p)=0 and its constancy gives B₂=0.

Evaluating the ORIGINAL full second cubic, not an auxiliary one, now gives epsilon₂(p)=0. These are genuine regular-section zeros in a local compatible frame, even for variable epsilon₂. The same actual argument after the endpoint swap gives R through the two infinity auxiliary points and the proper first-extension and epsilon₁ zeros there.

## 6. Exact endpoint swap removes B₁

Swap the original actual maps on their SAME source, with tau=t⁻¹,u'=v/t³,v'=u/t³. With the SAME rational R frame choose
\[
\rho'=\rho,\quad Q'=t^{-18}Q,\quad
a'=t^{-10}b,\quad b'=t^{-10}a,
\quad\mathcal D'=t^{-2}E.
\tag{13}
\]
They represent the proper swapped bundles with F₀ as infinity. The relative derivative coefficient10 is zero, so J₂'=t⁻¹²J₁,N₂'=t⁻³⁰N₁. The original residue gives gamma₂'=gamma₁. Thus
\[
f'=t^{18}f,\quad g'=t⁸j,\quad
P₂'=t^{-30}P₁,\quad c₂'=c₁.
\tag{14}
\]
For EVERY rational z the exact noncommuting operator identity is
\[
(t^{-2}E)⁴(t⁸z)=(E⁴-d²)z.
\tag{15}
\]
Put T_k=E−ku. Iteration gives the product T₂T₄T₁T₃. Using Eu=2(u²+d), with multiplication-operator derivatives retained,
\[
T₁T₃=E²+uE+2u²+4d,
\quad T₄T₁T₃=E³+2uE²+dE+2du.
\]
Left multiplication by T₂ cancels E³,E terms. The E² coefficient is4(u²+d)+d−4u²=0, and the constant is4d(u²+d)−4du²=4d²=−d². This proves(15).

The swapped companion polynomial term is c₁t⁻⁹⁰P₁³t⁹⁰f⁵=c₁P₁³f⁵. Hence its B₂' is EXACTLY the original B₁. Applying Section5 to the swapped actual packet proves B₂'=0, therefore B₁=0. This completes the full quartet. Since Q⁵ is annihilated by either derivation, multiplication by Q⁵ gives the asserted numerator form.

For clarity the general swapped error representative is epsilon₂'=t⁶epsilon₁ in A'=R−2D−6F₀. Its zero divisor is unchanged geometrically:
\[
\operatorname{div}(t⁶\varepsilon₁)+A'
=\operatorname{div}(\varepsilon₁)+R-2D-6F_\infty.
\tag{16}
\]
This validates the infinity error zeros without evaluating an unscaled old coefficient. No auxiliary denominator normalization receives an endpoint map.

## 7. Degree17 and exact scope

For r=17 a nonzero error has effective zero divisor Z of class A, ZF=1,ZD±=0. The accepted paired theorem classifies it as either a nonboundary section disjoint from both boundaries with no vertical components, or one boundary plus components of reducible fibers meeting that side. In particular Z contains neither smooth F₀ nor F∞. The two distinct genuine zeros of epsilon₂ on F₀ would give ZF₀≥2, contrary to1; hence epsilon₂=0. The swapped argument proves epsilon₁=0. Combining this with the accepted degree≤15 assertion and [degree16 theorem](canonical_sixteen_split_cubic_counterterm_vanishing.md) gives zero errors through degree17.

Higher variable errors are not declared zero from point evaluations. The full quartet is a necessary exact operator system in the original compatible frames, not a covariant operator on an unidentified coefficient bundle. The known fixed-P commuting elimination remains identically zero, and arbitrary solutions do not realize original endpoint maps. General zero-error conductor geometry, higher-degree actual sources, common infinity, nonsplit packets and the original unmarked common-cover problem remain separate.

The new [shared-current source](../../Research/notes/oct03_ten_hour/split_variable_error_shared_cartier_auxiliary_vanishing.md) has fresh [whole PASS](../../Research/notes/oct03_ten_hour/split_variable_error_shared_cartier_auxiliary_vanishing_audit.md), and the new [full companion source](../../Research/notes/oct03_ten_hour/split_variable_error_full_paired_cartier_quartet.md) has fresh [whole PASS](../../Research/notes/oct03_ten_hour/split_variable_error_full_paired_cartier_quartet_audit.md). Their receipts pin the inspected mathematical inputs. This canonical pair changes no shared state or library and is frozen pending focused extraction fidelity review.
