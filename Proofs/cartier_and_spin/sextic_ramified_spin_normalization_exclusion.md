# Proof: exact discrepancy weights and two local spectral contradictions

Version1. [Statement](../../Theorems/cartier_and_spin/sextic_ramified_spin_normalization_exclusion.md). [Independent whole-implication review: PASS](../../Research/audits/SEXTIC_RAMIFIED_SPIN_NORMALIZATION_EXCLUSION_AUDIT_2026_10_02.md). The independently reviewed [sextic reduction](sextic_ramified_spin_spectral_reduction.md) and [six-torsion endpoint theorem](../jacobians/torsion/family_six_torsion_abel_exclusion.md) are reused, preserving all actual maps. The new local contradictions are computation-free joint deductions with the root researcher.

Write N=M¹⁶ωΓ^-1, with its genuine canonical G linearization, and B=Γ/G=P¹. In degree six the actual projective kernel is trivial. The local ramification of Γ→B is tame, since every inertia order divides six. The Hurwitz ledger gives exactly three possible signatures:
\[
(2,2,2,3),\qquad(3,3,6),\qquad(2,6,6).
\]
For completeness, the exact Γ Hurwitz area is1/6; solving Σ(1−1/m)−2=1/6 with m|6 yields the three displayed signatures. Their coarse uniform fibers contribute respectively3·3+4=13,2·4+5=13,3+2·5=13 to the different of Y→B. Together with the special profile(2,1⁴), contributing one, this is the required total fourteen.

## The root-stack line and its section dimensions

Use the tame coarse root stack, equivalently the effective quotient stack[Γ/G]. The orbifold degree of N is degΓN/|G|=1/6. At each cone of order m write its local weight w in{0,...,m−1}, meaning an invariant local section has minimal vanishing order w upstairs. If N has coarse line degree d0, then
\[
d_0=\tfrac16-\sum w/m\in\mathbf Z,
\qquad d_j=\tfrac j6-\sum\{jw/m\}\in\mathbf Z.
\]
Its invariant sections are the sections of O(dj) onP¹ after factoring the forced fractional cone zeros. Thus H0(Nj)^G≠0 iff dj≥0.

The divisor of e6 is the ordinary point β=0, so6w≡0(modm). The divisor of e3 is exactly half of the infinity cone: this follows from β=e6/e3² and its already established exact divisor. Hence3w≡m/2 at infinity and3w≡0 at every other cone. In particular infinity has order2or6, as already proved in the sextic reduction.

One has H0(N)^G=H0(N²)^G=0. Indeed the ratio of any invariant section t to s, or to s², descends to H0(Y,O(P)) or H0(Y,O(2P)), both constants since P is non-Weierstrass. A nonzero constant would make s or s² descend to Γ, impossible respectively by odd vanishing order or by the mixed target fiber. On the other hand e4 is nonzero: at the ramified target point it is the product of the FOUR unit companion values. Its ratio g has exact pole4P. Therefore d1,d2<0 and d4≥0. Since degorbN4=2/3, necessarily d4=0. Thus e4 has only its forced cone zeros and no additional coarse zero.

For A=e4³/e3⁴, its exact order at a cone is
\[
\operatorname{ord}A=\bigl(3(4w\bmod m)-4(3w\bmod m)\bigr)/m.
\]
There are no other zeros or poles. The pullback is g³/f⁴.

## Complete elementary weight enumeration

In signature(2,2,2,3), infinity is an order-two cone with weight1; the other two order-two weights are0. Integrality of d0 forces the order-three weight2. The divisor of A is twice the order-three cone minus twice infinity. Consequently A is a square up to a constant.

In signature(3,3,6), infinity is the order-six cone. Its weight is1,3or5. The other two weights lie in{0,1,2}. The conditions d0 integral, d1<0 and d4=0 leave EXACTLY
\[
(w_6,w_{3a},w_{3b})=(3,1,1),(3,0,2),(3,2,0),(5,0,1),(5,1,0).
\]
The first has divisor[B3a]+[B3b]−2[∞], hence is nonsquare quadratic. The middle two have twice a single finite zero and twice the infinity pole, hence are squares. The last two have one finite simple zero and one simple infinity pole, hence are linear. To verify completeness directly: w6=1 permits(0,0),(1,2),(2,1), the first violating d1<0 and the latter two giving d4<0; w6=3 permits exactly the three listed pairs; w6=5 permits the two listed pairs or(2,2), which gives d4<0.

In signature(2,6,6), if infinity has order two, its weight is1 and the other weights are even. Integrality, d1<0 and d4=0 leave(1,0,4),(1,2,2),(1,4,0). The outer alternatives are squares; the middle is the nonsquare quadratic with its two finite order-six cone zeros. If infinity has order six, the order-two weight is0 and the other order-six weight is even. The possibilities before the section exclusions are(w∞,wother)=(1,0),(3,4),(5,2); the first violates d1<0, the middle is a square, and the last is linear. This exhausts every assignment. In fact EVERY square assignment also has d2=0 and is already excluded by H0(N²)^G=0; the direct square-function argument below is an independent geometric exclusion.

## Exclude squares and linear functions

If A is a square in k(B), then g³/f⁴ is a square in k(Y). Since f⁴ is already a square, g³ is a square and hence g is a square: if g³=v² then g=(v/g)². A square root of g has sole pole2P, impossible since P is non-Weierstrass.

If A is linear, write A=c(β−b). Its finite zero is a cone distinct from β=0, so b,c are nonzero. The six-torsion endpoint exclusion proves that this forces divf=3ιP−3P and6[P−O]=0, impossible on either selected endpoint. Only the two nonsquare quadratic assignments remain at this stage.

## The actual plane spectral equation is birational to Y

In either remaining case let A=c(β−b1)(β−b2), with c≠0 and distinct b1,b2, both nonzero. Define
\[
D_i=f-1-g-b_i f^2,\qquad
F(f,g)=g^3-cD_1D_2.
\]
The characteristic polynomial evaluated at s gives1−f+g+h=0, hence h=f−1−g. Since β=h/f², the identity g³/f⁴=A is exactly F(f,g)=0.

Both f and g are actual functions onY, with degrees three and four. Therefore[k(Y):k(f,g)] divides both three and four, and is ONE. Thus the plane component F=0 containing their image has normalization exactlyY. At any smooth point of this plane equation there is only one point ofY above it, and the implicit local parameter and vanishing multiplicities compute the ACTUAL Y valuations.

## Signature(3,3,6): the required triple zero cannot occur

In this remaining assignment β∞ is the order-six cone. The spectral reduction gives div0(f)=3R. At f=0 the plane equation becomes
\[
J(g)=g^3-c(1+g)^2=0.
\]
Every root has g≠−1, since J(−1)=−1. The partial derivative F_f(0,g)=2c(1+g) is therefore nonzero. The plane curve is smooth there, with g−g(R) as local parameter. The order of f is exactly the multiplicity of that root in J, because the implicit equation expresses f as a unit times J(g).

But J cannot have a triple root in characteristic five. If J=(g−a)³, coefficient comparison gives c=3a, −2c=3a² and c=a³. Since c≠0, a≠0; the first two force a=−2 and c=−6, whereas the third forces c=−8. Their difference is two, nonzero in characteristic five. Thus ord_Rf≤2, contradicting ord_Rf=3. This excludes the whole(3,3,6) signature.

## Signature(2,6,6): the two distinct finite cones would coincide

In this remaining assignment β∞ has order two, and the finite positions b1,b2 are the two order-six cones. OnY each corresponding fiber is a SINGLE point R_i of index six. The function f is a unit atR_i: its zeros lie over infinity and its sole pole isP over β=0. Hence from g³/f⁴=c(β−b1)(β−b2) one obtains ord_(R_i)g=2.

At R_i one has g=0 and D_i=0, while D_j=(b_i−b_j)f²≠0 for j≠i. Therefore
\[
F_g(R_i)=cD_j(R_i)\ne0.
\]
The plane curve is smooth there, with f−f(R_i) a local parameter. Substituting g=0 gives F(f,0)=−c(f−1−b1f²)(f−1−b2f²). The second factor is a unit atR_i, so the zero order of g is exactly the multiplicity of f(R_i) as a root of f−1−b_i f².

For that order to be TWO, the quadratic must have a double root. Its discriminant is1−4b_i, so b_i=1/4. This holds for BOTH i=1,2 and contradicts b1≠b2. Thus the whole(2,6,6) signature is excluded as well.

Every signature and weight assignment has now been excluded. All uses of plane equations concern the actual birational image of the sameY and actual source functions; no abstract separable substitute for the common-cover maps is introduced.
