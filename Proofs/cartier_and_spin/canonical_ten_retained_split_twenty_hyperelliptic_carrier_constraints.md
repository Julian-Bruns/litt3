# Proof: the actual split-twenty carrier and its bounded native differential system

Version1, 3 October2026. [Fresh independent whole scoped review](../../Research/audits/CANONICAL_TEN_RETAINED_SPLIT_TWENTY_HYPERELLIPTIC_CARRIER_CONSTRAINTS_FIDELITY_AUDIT_2026_10_03.md): PASS, no required mathematical repairs. Original audited input pins and executed-evidence provenance are preserved; only this status banner changes at integration.

Use the accepted [primitive twenty-sheet](canonical_ten_primitive_twenty_bridge_exclusion.md), [large pair-block](canonical_ten_pair_block_twenty_bridge_exclusion.md), and [quadratic block](canonical_ten_twenty_bridge_quadratic_resolvent_reduction.md) arguments only at their involution-independent field/conductor interfaces identified below. The uniqueness, fixed-X norm obstructions and whole-product local dichotomy come from the specified sections of [the nonsplit bridge proof](canonical_ten_nonsplit_twenty_bridge_exclusion.md); its nonsplit involution and source quotient are not imported. The [fixed BACKUP quotient and endpoint](canonical_ten_fixed_backup_endpoint_normal_form.md) supply the actual native Y/f comparison.

## 1. The genuinely involution-independent block reduction

Set F=k(t), A=k(Γ) and K=k(T). Tower degrees and the canonical identity give
\[
[A:F]=2e,\qquad 2g(\Gamma)-2=16e,\qquad
u_E=16,\qquad u_A=8.
\]
These are exactly the numerical inputs of the accepted primitive and pair-block proofs, even though their original geometric application was nonsplit. Their SINGLE normal closure is that of E/F. They use the actual component K/A of degree ten and S10 monodromy, K=AE, K/E étale, and these normalized genera. They do not use an involution, either original X-map, or an identification of E with an étale double.

In the primitive sector the actual ten-subset resolvent lies inside A and its normal closure over E is étale. Its wild-safe conductor factor is 1−252/184756. Since the different of E/F has degree360, its normalized canonical degree is at least −2+18(1−252/184756)>8, contradicting its inclusion in A. The large binary pair-block sectors have the same actual étale-normal-closure construction and factor15/16, giving −2+18·15/16=119/8>8. The central pair kernel remains, and itself preserves two blocks of size ten.

The accepted intersection argument leaves only block sizes two or ten. Consequently there is an ACTUAL field R⊂E∩A with
\[
[R:F]=2,\qquad [E:R]=10,\qquad [A:R]=e,
\qquad E\otimes_R A=K.
\]
The last tensor is a field: it maps onto K and both have dimension ten over A. Thus T is the WHOLE connected normalized product over R. Its E/R monodromy is S10. Hurwitz for Γ/R gives g(R)≤9.

The three possible two-block kernels are diagonal S10, equal-sign, and full product. The character argument in §1 of the accepted nonsplit proof shows that the block field is the unique quadratic F-subfield of E in all three cases; that argument is purely group-theoretic. It transfers without a free involution. Also the whole tensor equality implies E∩A=R, rather than merely R⊂E∩A.

Here and below R denotes both this embedded field and its smooth projective curve. It is a degree-two cover of P1_t, hence hyperelliptic when its genus is positive. Its own quadratic deck involution is available. There is no assertion that it extends to E, fixes an original X-field, or replaces the missing nonsplit free involution.

## 2. The original spin line is the actual hyperelliptic pencil pullback

The t-map on E is unramified over zero and infinity: every zero and pole is simple. Ramification indices in E/R/F multiply. Therefore R/F and E/R are unramified at those two fibers. Write
\[
D_0=\operatorname{div}_{R,0}(t),\qquad
D_\infty=\operatorname{div}_{R,\infty}(t).
\]
Each consists of two distinct points, has degree two, and D0∼D∞. For π:E→R and ψ:Γ→R,
\[
H_1=\pi^*D_0,\qquad H_2=\pi^*D_\infty.
\]
The actual source-section equalities imply
\[
\phi^*S_1=p^*H_1=\phi^*\psi^*D_0.
\]
Pullback of divisors under a surjective finite map is injective coefficientwise. Hence S1=ψ*D0, likewise S2=ψ*D∞, and
\[
M\simeq\psi^*\mathcal O_R(D_0).
\]
This is a proved identification using the original sections, rather than a chosen square root of the canonical line. At this point it does not yet imply M8=ωΓ; that conclusion uses the genus-nine step below.

## 3. Every block genus below nine is excluded

Suppose g(R)<9. The accepted absolute simplicity of J(X), of dimension nine, gives both Jacobian Hom groups between X and R zero. For the actual correspondence through E, Nm_h1∘π*:J(R)→J(X) therefore vanishes. Choosing either point r over t=0 calibrates its constant degree-ten fiber class: π*r consists of ten h1-infinity points, so
\[
\operatorname{Nm}_{h_1}\mathcal O_E(\pi^*a)
\simeq\mathcal O_X(10O)\qquad(a\in R).
\]
A ramified uniform π-fiber of common index j∈{2,5,10} cannot lie over t=0, since that fiber is unramified. Its reduced source points therefore have finite h1-images. Its norm would give a finite effective divisor B of degree10/j with jB∼10O. For even j this yields a finite effective degree-five divisor with twice its class10O, excluded by the fixed two-torsion and pole-five-gap obstruction. For j=5 the accepted mixed polynomial norm excludes the finite effective degree-two divisor with five times its class10O. These are exactly the fixed-X obstructions proved in §3 of the accepted nonsplit bridge proof; no new certificate is needed.

The whole normalized product and T/E étale allow the local dichotomy in §5 of that proof to be applied directly over R. The proof uses only these completed fields and φ's at-most-one-fold condition. A ramified fiber is either one simple π-fold, with ψ wholly unramified, or a uniform common Galois completed field of degree j∈{2,5,10}. The latter is excluded above. Thus ψ is everywhere unramified, and
\[
16e=e(2g(R)-2),
\]
contradicting g(R)<9.

Necessarily g(R)=9. Hurwitz now gives ψ:Γ→R finite étale of degree e without any additional Jacobian hypothesis. The same local dichotomy implies that π:E→R has only single simple tame folds, one above each of160 distinct branch values, and is otherwise unramified. Indeed
\[
\deg\operatorname{Diff}(\pi)=320-10\cdot16=160.
\]
There is no wild or uniform ramified π-fiber in this boundary. Both t-end fibers remain unramified. The hyperelliptic canonical identity ωR≅O_R(8D0) and the proved original spin identification yield the exact, previously unavailable identities
\[
\boxed{M^8\simeq\omega_\Gamma,\qquad
\omega_E\simeq\pi^*\omega_R^2.}
\]
The second equality also follows from div(θ1)=16H1=π*(16D0). It carries no unresolved two-torsion choice.

## 4. The actual original Y-field descends to E

This is stronger than descending a line or a coefficient. Choose a rational differential ηR with div(ηR)=8D0. Its actual differential pullback has divisor
\[
\operatorname{div}_E(\pi^*\eta_R)
=8H_1+\operatorname{Diff}(\pi).
\]
Define the rational differential on the actual E by
\[
\zeta_E=\frac{(\pi^*\eta_R)^2}{\theta_1}.
\]
The numerator is a quadratic differential and the quotient is a one-form. Its divisor is2Diff(π), so it is holomorphic. Because ψ is étale and T is the whole product, different commutes with this base change:
\[
\operatorname{Diff}(\phi)=p^*\operatorname{Diff}(\pi).
\]
Consequently p*ζE and q*ηY have exactly the SAME divisor2Diff(φ)=2q*P0. Their ratio is a nowhere-vanishing rational function on the projective T, hence a constant. Absorb that nonzero constant in ζE. We have proved
\[
q^*\eta_Y=p^*\zeta_E.
\]
This reasoning uses actual differential pullbacks and exact divisors; it does not identify an unspecified canonical frame with the native invariant df-frame.

In the accepted fixed Y-coordinate write
\[
w^2=(c-1)x^5+cx^4-1,\qquad c(c-1)\ne0,
\qquad \eta_Y\sim dx/w.
\]
Both choices of the fixed endpoint parameter b are harmless here. For η=dx/w, the characteristic-five Cartier formula gives
\[
\mathcal C_Y(\eta)
=(-2c)^{1/5}\eta+(2c(c-1))^{1/5}x\eta.
\]
Indeed the coefficients of x4 and x9 in the square of the quintic are −2c and2c(c−1). Thus η and C_Yη are linearly independent. Cartier commutes with separable differential pullback; applying it to the actual equality above shows q*C_YηY also comes from E. Dividing these two descended differentials proves q*x∈k(E). Their nonzero linear x-coefficient is explicit. Since dx/w itself comes from E and dx is nonzero, w=dx/η belongs to E too, after the harmless constant normalization. Therefore
\[
\boxed{k(Y)\subset k(E).}
\]
The map q factors through an ACTUAL finite étale E→Y, of degree160. This is a proved Y-leg descent in this particular retained boundary. Both original X-legs already remain finite étale on that SAME E. No original X-map has been put on R or Γ.

## 5. Actual group and native quotient consequences

Since T/Y is G-Galois and Y⊂E, put H=Gal(T/E). Then |H|=e. The faithful original G-action preserves Γ, and
\[
\Gamma^H=\Gamma\cap E=R.
\]
Thus ψ:Γ→R is the ACTUAL Galois étale H-cover. If f is the original coordinate of Γ/G=P1_f, then
\[
f\in k(R),\qquad [R:k(f)]=160,\qquad E=R\,k(Y).
\]
For the last equality, RY⊂E and Γ·RY=T=ΓY. The degree of RY/R is at least[T:Γ]=10 and at most[Y:k(f)]=10, hence is ten and RY=E. In particular the WHOLE R×_{P1_f}Y is connected with normalization E. This native parameter f is distinct from the spin parameter t; their relation is not presumed.

The native R→P1_f map has the exact uniform profiles inherited from Γ/G through the étale H-quotient:32 points of index five and different eight at the one wild value,80 points of index two at the one tame value, and no other ramification. The ordinary third value carrying the fold of Y/f is unramified on R/f. Its different degree336 agrees with genus nine. The actual π:E→R is therefore the base change of the FIXED degree-ten Y/f map; its160 simple folds lie over the160 R-points above that ordinary third value.

As a further necessary native divisor description, write D for the reduced80-point tame fiber and W for the reduced32-point wild fiber, taking the native tame/wild values to be zero/infinity. Then
\[
\operatorname{div}(f)=2D-5W,\qquad
\operatorname{div}(df)=D-2W,\qquad
W\sim2K_R,\qquad D\sim5K_R.
\]
The last two are integer combinations of the first two divisor identities. They are actual constraints, not a proposed realization. No equality f∈k(t), lift of the hyperelliptic involution, or relation between its action and either original X-leg is asserted.

## 6. The reduced Y-cover must be nongalois

If H were normal in G, G/H would act faithfully on R with order160 and quotient P1_f. A positive-genus hyperelliptic curve has a unique hyperelliptic involution, central in its automorphism group. Quotienting by it maps any finite order160 automorphism group to a subgroup of PGL2(k) of order160 or80. Neither order occurs in characteristic five. Here is an elementary check avoiding a finite-subgroup classification.

For such a PGL2 subgroup J of order N∈{80,160}, its Sylow-five groups have order five and their number is1 or16. Each fixes exactly one point of P1. The stabilizer of that point equals its Sylow normalizer and has order5m with m dividing four: after moving the point to infinity its translations form a one-dimensional F5-space, and an affine multiplier preserving that space lies in F5×. Thus one Sylow would force N≤20 and is impossible.

With sixteen Sylows, their fixed points form a single orbit of size sixteen. Its inertia has order5 for N80 and10 for N160. The lower ramification groups are I0 of that order, I1=C5 and I2=1; the different exponent is respectively8 or13. All other point stabilizers are cyclic of order a power of two and give tame branch contributions N(1−1/mj), mj≥2. Hurwitz for P1→P1/J leaves a tame different remainder
\[
2N-2-16\delta=30\quad(N=80),
\qquad 110\quad(N=160).
\]
For N80 even one tame orbit contributes at least40. For N160 two tame orbits contribute at least160, while one would require160(1−1/mj)=110, or mj=16/5, impossible. A positive remainder cannot be supplied by zero tame orbits. This proves the claim.

Therefore H is not normal in G. Equivalently the actual degree160 cover E→Y is necessarily nongalois. In particular e>1. This excludes the entire e=1 retained split boundary, and more generally every instance whose descended Y-cover would be Galois. It does not assert that H's normal core is trivial.

## 7. The native quotient is not a rational function of the spin parameter

Suppose f∈F=k(t). In the original G-Galois Γ/k(f), F is then an intermediate field. Put J=Gal(Γ/F). It has order2e and contains H with index two, so H is normal in J. The original action of J on T fixes Y; because H is normal in J it induces an actual order-two action on E=T^H. Its nonidentity element σ preserves R=Γ^H and induces the hyperelliptic involution δ of R/F. It fixes both t and the actual Y-field.

For any holomorphic ηR on a positive-genus hyperelliptic curve, δ*ηR=−ηR. Apply σ to the proved equality
\[
q_E^*\eta_Y=\frac{(\pi^*\eta_R)^2}{\theta_1}.
\]
Here qE:E→Y is the actual descended map; rescale ηR by a square root of the nonzero comparison constant to write this equality literally. This is available over k and does not change its divisor or anti-invariance. The left side is σ-invariant and its numerator is σ-invariant. Thus σ*θ1=θ1. Scalar-one θ recognition makes σ fix the first original X-map. Since σ fixes t, the original comparison also gives σ*θ2=θ2, so the second original X-map is fixed. The two actual X-fields jointly generate E, forcing σ to be the identity. Its nontrivial action on R contradicts this.

Therefore
\[
\boxed{f\notin k(t),\qquad R=k(t,f),\qquad E=k(t,Y).}
\]
The middle equality uses[R:F]=2; the last uses E=RY and f∈Y. This excludes every rational-native-parameter case in the retained split boundary. The argument proves the needed action only under f∈F, using the actual original Galois group; it never presumes that the hyperelliptic involution lifts in the surviving case.

Equivalently, no element of the original normalizer N_G(H)/H induces the hyperelliptic involution on R. The stabilizer of the actual function t in G is exactly H, since G fixes f and R=k(t,f); its orbit has160 elements. None of these assertions identifies an original X-leg on R.

## 8. Further exact endpoint field and trace restrictions

The joint index-one identity also improves to
\[
E=k(t,x_1)=k(t,x_2),\qquad E=R(x_i).
\]
Indeed the quadratic relation gives[E:k(t,x1)]≤2. The cubic element y1 has degree one or three over k(t,x1), hence belongs to that field. If the index were two its involution would fix the first original X-map and t, thus θ1 and then θ2. The accepted scalar-one θ recognition would make it fix the second X-map as well. Both X-fields generate E, a contradiction. The second endpoint argument is symmetric. This is an actual field proof, not a degree assumption.

For each i, the differential trace along π kills the three-dimensional subspace
\[
\left\langle\theta_i,x_i\theta_i,x_i^2\theta_i\right\rangle.
\]
At both points of D0 for i1, and both points of D∞ for i2, π is unramified and the ten branches have zero orders at least16,13,10 respectively. Their traces therefore have those lower bounds at BOTH distinct R-points. Each total exceeds deg(ωR)=16, so the holomorphic trace is zero. This does not prove the induced Jacobian correspondence zero: characteristic-five isogenies can have a nontrivial differential kernel. No Hom vanishing at genus nine is used.

## 9. Intrinsic native sections and complete bounded differential spaces

The actual native profile already proved in §5 supplies reduced disjoint divisors W,D of degrees32 and80, with
\[
\operatorname{div}(f)=2D-5W,\qquad \operatorname{div}(df)=D-2W.
\tag{1}
\]
The native completed local types and connected fixed Y/f product remain actual inputs, alongside BOTH original degree20 étale X-legs. They are not inferred from the polynomial equations below.

Define intrinsic tensor differentials
\[
\mathfrak a=\frac{(df)^2}{f}\in H^0(R,\omega_R^2),\qquad
\mathfrak b=\frac{(df)^5}{f^2}\in H^0(R,\omega_R^5).
\tag{2}
\]
Equations(1) give \(\operatorname{div}(\mathfrak a)=W\) and \(\operatorname{div}(\mathfrak b)=D\). Both are reduced, their supports are disjoint, and neither section is zero. As tensor identities,
\[
f=\mathfrak b^2/\mathfrak a^5,\qquad
df=\mathfrak b/\mathfrak a^2.
\tag{3}
\]
These use the ACTUAL native \(f\), not an independently chosen canonical root.

### Complete bounded polynomial spaces

Since the degree-two map is unramified at infinity, choose a squarefree degree20 polynomial \(g(t)\) and a hyperelliptic coordinate \(y\) with
\[
k(R)=k(t,y),\qquad y^2=g(t),\qquad
\eta=dt/y,\qquad \operatorname{div}(\eta)=8D_\infty,
\tag{4}
\]
where \(D_\infty\) is the reduced two-point infinity fiber. The choice of \(y\) is unrelated to either original endpoint coordinate. Characteristic five is different from two, so the smooth hyperelliptic presentation exists; squarefreeness retains smoothness. The degree20 model accounts for every finite branch value because infinity is unramified.

Write \(\mathfrak a=a\eta^2\), \(\mathfrak b=b\eta^5\). The COMPLETE Riemann–Roch spaces in these frames have the unique forms
\[
a=A(t)+yB(t),\quad \deg A\le16,\quad\deg B\le6,
\]
\[
b=C(t)+yJ(t),\quad \deg C\le40,\quad\deg J\le30.
\tag{5}
\]
Indeed a regular coefficient away from infinity lies in \(k[t,y]\). At the two infinity points \(t\) has pole1 and \(y\) pole10 with opposite leading signs. Bounds at BOTH points preclude cancellation of an excessive polynomial or \(y\)-polynomial leading term. The spaces have dimensions \(17+7=24\) and \(41+31=72\), agreeing with Riemann–Roch for \(2K_R\) and \(5K_R\). Bounds remain valid when a leading term cancels at one infinity point.

### The exact characteristic-five differential system

Equation(3), in the chosen frames, is
\[
f=b^2/a^5,\qquad df=(b/a^2)\eta.
\]
Differentiating the first equality in characteristic five and using the second gives
\[
2b\,db/a^5=(b/a^2)\eta,
\qquad db=3a^3\eta.
\tag{6}
\]
There is no derivative of \(a^5\). The coefficient3 is \(1/2\) in characteristic five and its sign is fixed by the intrinsic definitions(2); no new phase is chosen.

Using \(dy=g'(t)dt/(2y)\), expansion in the basis \(1,y\) gives the TWO polynomial identities
\[
\boxed{C'=4A^2B+3gB^3,}
\]
\[
\boxed{gJ'+\tfrac12g'J=3A^3+4AgB^2.}
\tag{7}
\]
For example, the polynomial part of \(3a^3/y\) is \(3(3A^2B+gB^3)\), explaining the coefficient4. The coefficient of \(1/y\) is \(3(A^3+3AgB^2)\), also giving4. These are identities in \(k[t]\), with the ordinary characteristic-five derivatives, not coefficient Frobenius substitutions.

The first identity has degree at most38 on both sides. The second has degree at most48: derivative of the possible degree30 leading term of \(J\), and derivative of the degree20 leading term of \(g\), vanish in characteristic five. This is consistent with, but does not decide, the equations. A primitive of \(C'\) may include an arbitrary bounded fifth-power polynomial; no uniqueness of \(C\) is claimed.

### The nonrational-native-parameter condition and scope boundary

The already proved \(f\notin k(t)\) supplies another exact inequality. The denominator in \(b^2/a^5\) is \(A^5+y g^2B^5\). Rationalizing it, its odd numerator coefficient is
\[
\boxed{2CJ A^5-(C^2+gJ^2)g^2B^5\ne0.}
\tag{8}
\]
The denominator norm is nonzero, since \(a\) is a nonzero function on the integral quadratic field. Hence(8) is equivalent to the nonzero odd part of this particular native \(f\).

The reduced, disjoint zero divisors of the GLOBAL sections \(a\eta^2\), \(b\eta^5\) must still have degrees32 and80, including their infinity contributions. Equations(5)–(8) alone do not imply the required completed \(C_5\) local type, the fixed native \(Y\)-cover base-change condition, the original \(X\)-maps, their theta comparison or joint field generation. In particular an abstract solution is not a common-cover construction. The system supplies a bounded algebraic target for the remaining actual genus-nine carrier; no emptiness, existence or finite solution count is asserted.

## Reviewed evidence and exact source boundary

The original [actual-carrier note](../../Research/notes/oct03_ten_hour/retained_split_twenty_carrier_geometry.md) and [whole seven-check audit](../../Research/notes/oct03_ten_hour/retained_split_twenty_carrier_geometry_audit.md) establish §§1–8. The [necessary differential note](../../Research/notes/oct03_ten_hour/retained_split_twenty_hyperelliptic_differential_normal_form.md) and [whole five-check audit](../../Research/audits/RETAINED_SPLIT_TWENTY_HYPERELLIPTIC_DIFFERENTIAL_NORMAL_FORM_AUDIT_2026_10_03.md) establish §9. Their original reviewed pins remain in the reports. Only canonical exposition and local-link transport are new here; there is no numerical replay or new source converse.

A surviving packet still has the actual original \(T\), the connected native product, the nongalois étale \(Y\)-cover, both original étale \(X\)-legs, completed local inertia and the stated different/fold conditions. The equations in §9 alone prove none of these. In particular they do not replace the missing original endpoint maps by separable maps or one-leg Jacobian data. The remaining actual genus-nine carrier and the unmarked common-cover problem remain unresolved.

## Four fresh canonical fidelity and scope tasks

1. Compare §§1–8 and clauses1–3 with the complete pinned carrier note/audit, preserving the ORIGINAL spin sections, whole connected product, different base change, coefficientwise divisor pullback, actual \(Y\)-field descent and nongalois/normalizer conclusions. Do not re-audit settled foundations.
2. Check that clause4 and §9 reproduce the complete necessary differential note/audit, including BOTH coefficient spaces, characteristic-five constants, degree-drop strata, nonrationality and tensor-divisor conditions. No integrability or source converse may be added.
3. Check every new canonical statement hypothesis against the accepted actual source packet and the proof: no free involution on \(E\), no Jacobian Hom vanishing at genus nine, no original \(X\)-leg on \(R\), and no discarded finite-group kernel.
4. Check local links and original evidence provenance, and distinguish the completed reductions/subcase exclusions from the unresolved actual carrier and unmarked problem. Require only a static faithful extraction review, not computations or foundational replay.
