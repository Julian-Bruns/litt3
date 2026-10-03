# Proof: the wild derivative forces the ordinary moving origin

Version4. [Statement](../../Theorems/cartier_and_spin/canonical_degree_ten_wild_spin_carrier_exclusion.md). The corrected Version2 necessary reduction passed [review](../../Research/audits/CANONICAL_DEGREE_TEN_WILD_SPIN_CARRIER_AUDIT_2026_10_03.md), while the original whole-profile PASS remains withdrawn. The exact coefficient normal form and actual completed-field comparison below passed [a fresh major review](../../Research/audits/CANONICAL_DEGREE_TEN_WILD_PRIMITIVE_LOCAL_NORMAL_FORM_AUDIT_2026_10_03.md). The preserved Version1 evidence is outside the workspace in the scope-retraction archive. Both original source maps remain in place. Use the accepted actual mixed-fiber obstruction; the two-point quotient Picard presentation may be used under its stated actual-atlas hypotheses.

## Exact canonical generators without a coefficient nonvanishing assumption

Let S=[Γ/G], and denote its reduced wild and tame branch divisors by Dw and Dt. Their genuine relations are5Dw=U and2Dt=U, with U the pullback of O_P1(1). The canonical Hurwitz divisor is
\[
K_S=-2U+8D_w+D_t=D_t-2D_w.
\]
The last equality uses5Dw=U; it is an identity in the actual Picard group, not a tame formula at the wild point.

The invariant canonical powers of orders TWO and FIVE each have a one-dimensional section space. Explicitly
\[
2K_S=D_w,\qquad5K_S=D_t
\]
in Pic(S); their nonzero sections have precisely those reduced stack zero divisors. One can also check their dimensions on the coarse line from floor(j/2)−ceil(2j/5)=0 for j=2,5. Choose arbitrary nonzero generators t2,t5 and normalize by the actual different section s:
\[
z=\phi^*t_2/s^2,\qquad F=\phi^*t_5/s^5.
\]
These are actual Y functions. No actual coefficient e2 or e5 is assumed nonzero.

Mixedness excludes a distinguished wild value: its five ramified points would already exhaust the degree-ten fiber. If the distinguished value were the tame cone, its forced order-one t5 section would make F have sole pole THREE atP, a Weierstrass gap. Thus the distinguished value is ORDINARY.

Let R1,R2 be the two distinct wild-fiber points onY, and let E be the five distinct tame-fiber points. The exact normalized divisors are
\[
\operatorname{div}(z)=R_1+R_2-2P,\qquad
\operatorname{div}(F)=E-5P.
\]
SinceP is Weierstrass, z is a hyperelliptic coordinate. Its zero fiber is a non-Weierstrass hyperelliptic pair. Choose y with y²=Φ(z), Φ monic squarefree of degree FIVE, and σ=dz/y with divisor2P. The full pole-five space gives
\[
F=A_2(z)+a y,\qquad a\ne0,\qquad\deg A_2\le2.
\]
The nonzero a follows from F's exact ODD pole five.

## Local different exponents force dF=c z³σ

The quotient t5²/t2⁵ has divisor2Dt−5Dw, so it is a coarseP¹ coordinate. Its actual pullback is, up to a nonzero scalar,
\[
\beta=F^2/z^5.
\]
At each Ri it has pole order FIVE. The Y→P¹ local extension is the same as the actual Γ→P¹ wild extension there, because q is étale and φ is unramified overRi. Its different exponent is EIGHT, hence
\[
\operatorname{ord}_{R_i}(d\beta)=8-2\cdot5=-2.
\]
In characteristic five,
\[
d\beta=2F\,dF/z^5.
\]
F is a unit and z has order one atRi. Therefore dF has order THREE at both Ri.

AtP the coarse value is ordinary and the actual local index is TWO, so dβ has order ONE. There F has pole five and z pole two; the same identity makes dF have pole exactly FOUR. It has no other poles. A rational canonical differential on genus two has divisor degree TWO, so the two order-three zeros exhaust its zero divisor. Consequently
\[
dF=c z^3\sigma,\qquad c\ne0.
\]
Differentiating its full pole-five expression gives
\[
A_2'(z)y+\frac a2\Phi'(z)=c z^3.
\]
The quadratic field basis1,y forces A2'=0. Since its degree is at most two, A2 is constant. Hence Φ'(z) is a nonzero scalar times z³. In any Weierstrass hyperelliptic coordinate this is the invariant assertion that the derivative of the monic quintic has exactly one TRIPLE root. Translation and scaling of z or y preserve this assertion.

## The six origins of the selected family

Write the original family quintic as
\[
\Phi_t(u)=u(u-1)(u-2)(u-3)(u-t)
=u^5-s u^4+s u^3-s u^2+t u,\qquad s=1+t.
\]
Its derivative is
\[
\Phi_t'(u)=s(u+1)^3-1.
\]
At the infinity origin it never has a triple root: when s≠0 its critical cubic is a translated cube MINUS a nonzero constant, and when s=0 it is constant−1.

At a finite Weierstrass origin w∈{0,1,2,3,t}, put z0=1/(u−w). With f_i the ith Hasse coefficient of Φ_t(w+h), the monic transformed quintic is
\[
\widetilde\Phi_w(z_0)=z_0^5+(f_2/f_1)z_0^4
 +(f_3/f_1)z_0^3+(f_4/f_1)z_0^2+(1/f_1)z_0.
\]
Here f1≠0 by squarefreeness. Set r=w+1. Direct polynomial identities give
\[
f_4=-s,\quad f_3=sr,\quad f_2=-sr^2,\quad f_1=sr^3-1.
\]
For a monic quintic z5+A4z4+A3z3+A2z2+A1z+A0, its nonconstant cubic derivative has a triple root exactly when
\[
A_3^2=A_4A_2,\qquad A_3^3=A_4^2A_1.
\]
These follow by comparing with a(z−b)³, with leading coefficient a≠0; if its cubic coefficient vanishes, a lower-degree nonzero derivative cannot have a triple root. Thus when s≠0 our transformed derivative has a triple root exactly when
\[
f_3^2=f_2f_4,\qquad f_3^3=f_2^2.
\]
The first identity is automatic. The difference in the second is
\[
f_3^3-f_2^2=s^2r^3(s-r).
\]
For w=0,1,2,3, r∈F5* and s−r=t−w≠0 on the smooth family, so this difference is NONZERO. For w=t, r=s and the difference is identically ZERO. If s=0 instead, all f2,f3,f4 vanish and the transformed derivative is the nonzero constant1/f1. Therefore the ONLY possible triple-root origin occurs at w=t. There, before monic scaling, the model and derivative are
\[
\Phi_t^{(P)}(z)=z-sz^2+s^2z^3-s^3z^4+(s^4-1)z^5,
\qquad (\Phi_t^{(P)})'=(1+sz)^3.
\]

Both selected endpoints have s≠0, so the ordinary moving origin genuinely satisfies this necessary derivative condition. The earlier Version1 incorrectly retained an f1 factor after clearing the common denominator f1³ in A3³=A4²A1, and consequently asserted a false degree-four parameter exception. That whole-profile conclusion is withdrawn. The distinguished point is ordinary and equals(t,0), with both original maps retained.

## The exact primitive coefficient normal form

For this additional normal form assume the actual different coefficient is primitive, Γ(a)=T, exactly as in the minimal-source carrier reductions. Retain the genuine invariant canonical generators t2,t5 whose normalized functions are z,F. Their exact pole orders are TWO and FIVE. Since dF=c z³σ, scale t5 to obtain
\[
F=b+y,\quad y^2=z^5+c_4z^4+c_0,
\quad c_4c_0\ne0.
\]
The nonzero c4 follows from the nonzero derivative; c0 is nonzero because the two wild points are a non-Weierstrass hyperelliptic pair overz=0. F is a unit at both those points, so b²−c0≠0. Scaling t5 does not assert anything about an actual characteristic coefficient.

The exact invariant section degree formula is
\[
d_j=\lfloor j/2\rfloor-\lceil2j/5\rceil.
\]
Below weight TEN, the only spaces are the one-dimensional spaces generated by t2,t2²,t5,t2³,t2t5,t2⁴,t2²t5, at weights2,4,5,6,7,8,9. Weight TEN has basis t2⁵,t5². The minimal polynomial has degree TEN by retained coefficient primitivity. Evaluating it at the different section and dividing by its tenth power gives a rational identity onY of the form
\[
1+A_2z+A_4z^2+A_6z^3+A_8z^4
-(B_5+B_7z+B_9z^2)F+UF^2+Vz^5=0.
\]
Every letter here is a constant coefficient of a genuine invariant section. This normalization does not assume Γ containsY: the quotients are G-invariant functions on the actual G-torsorT→Y.

Use the exact quadratic relation
\[
F^2=2bF+z^5+c_4z^4+c_0-b^2.
\]
The basis1,F overk(z) gives B7=B9=0 and B5=2bU. Its constant sector then gives
\[
A_2=A_4=A_6=0,\quad A_8=-c_4U,
\quad V=-U,\quad U=(b^2-c_0)^{-1}.
\]
Consequently all coefficient sections except e5,e8,e10 are zero, and with c=b²−c0 they are
\[
e_5=(2b/c)t_5,\qquad e_8=-(c_4/c)t_2^4,
\qquad e_{10}=(t_5^2-t_2^5)/c.
\]
Ifb=0, e5 also vanishes and the primitive polynomial is EVEN. The accepted actual carrier minus/tangent obstruction prohibits this, so b≠0 and e5≠0. The other two coefficients are already nonzero: c4≠0, and t5²,t2⁵ are independent invariant weight-ten sections.

## General weak local parameter criterion

The following elementary criterion records exactly the local comparison being used. Let k be algebraically closed of odd characteristicp, let h dividep−1, and let a completed local map with base coordinateβ have pole orderph and differentph+p−2. In the source field choose ψ=β^(1/h); this root exists there by valuation and Hensel, and its tame base extension has degreeh. The different tower gives source degreep and different2p−2 overk((ψ^-1)). Thus ord(dψ)=−2. In any source uniformizer t, its Laurent expansion has the form
\[
\psi=\alpha t^{-p}+\gamma t^{-1}+\text{regular},
\quad\alpha\gamma\ne0.
\]
Every other negative exponent between−p and−1 is ruled out by ord(dψ)=−2. Choose a nonzero c andλ so that
\[
c^{p-1}=-\alpha/\gamma^p,\qquad\lambda=-c\gamma.
\]
Then λ^p=cα. The expression cψ−((λ/t)^p−λ/t) is regular. The equation r^p−r equal to that regular expression has a solution r in the complete local ring by Hensel, since its derivative is−1 and the residue field is algebraically closed. Therefore w=λ/t+r lies in the source and satisfies
\[
w^p-w=c\psi.
\]
This AS extension has degreep, because its right side has a simple pole on the base, and hence equals the completed source extension. Since h dividesp−1, replacing ψ by any other hth root scales it by an element of Fp*, so the degreeph extension over the original β-base is Galois as well: every tame root conjugate preserves the same AS extension.

Its intrinsic local invariant is
\[
R=-\alpha/\gamma^p=c^{p-1}.
\]
It does not depend on the source uniformizer or the choice of ψ. Two such extensions over the SAME β-base are isomorphic exactly when these invariants agree. After identifying their unique tame h-fold subextensions, AS classes cψ coincide up toFp* exactly when c^(p−1) agrees; a difference with a nonzero simple-pole coefficient cannot be an AS coboundary. This criterion concerns actual completed fields, not merely their different exponents.

## The two wild source completions must coincide

Let r²=c0, and label the two wild points by y=r and y=−r atz=0. At the first,
\[
y=r+\frac{c_4}{2r}z^4+\frac1{2r}z^5+\text{higher terms},
\quad
\beta=\frac{(b+r)^2}{z^5}
+\frac{(b+r)c_4}{r z}+\text{regular}.
\]
Forp5,h1, the preceding invariant is therefore
\[
R_r=-\frac{r^5}{(b+r)^3c_4^5},\qquad
R_{-r}=\frac{r^5}{(b-r)^3c_4^5}.
\]
Both denominators are nonzero because F is a unit at the two wild points.

The equality Rr=R−r is NECESSARY for this actual carrier. Indeed at either wild point choose a source point over it. The original q:T→Y is étale, so its completed field is the completed Y field. The spin map φ is also étale there, since its entire different isqP and the wild points are disjoint fromP. Thus the same completed field is a completed Γ field. The actual Γ/B Galois cover identifies all of its wild completions over the fixed β-base. This proves the claimed equality without presuming a simultaneous Galois closure of the two endpoint maps.

Clearing the nonzero denominators gives
\[
(b+r)^3+(b-r)^3=b(2b^2+c_0)=0.
\]
The primitive coefficient argument already provedb≠0. Hence b²=2c0 and c=b²−c0=c0. This is the additional necessary constraint in the statement. It still allows nonzero b, so it is not an endpoint exclusion.

For the original actual forms θi, the accepted transported identity is φ*ξi=aθi with ξi a rational Γ differential. Since e9=0 and e10≠0, Trφ(1/a)=e9/e10=0 and consequently φ_*θi=0. Cartier commutes with separating trace, so φ_*C^jθi=0 for every defined iterate. This is an actual correspondence constraint, but no Jacobian or source descent is inferred from it.
