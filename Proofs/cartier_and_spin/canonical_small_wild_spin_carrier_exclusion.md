# Proof: exact canonical rings, one actual square-root extraction and an ordinary double cover

Version2. [Statement](../../Theorems/cartier_and_spin/canonical_small_wild_spin_carrier_exclusion.md). The earlier [independent review](../../Research/audits/CANONICAL_SMALL_WILD_SPIN_CARRIER_AUDIT_2026_10_03.md) is narrowed after the degree-ten dependency failed at the moving origin. The nonsquare argument and independent profile(20,20,2,31) argument remain intact. Reuse the [actual carrier mixed-fiber and minus obstructions](actual_spin_carrier_character_reduction.md) and [two-point quotient Picard presentation](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md). Both original finite étale maps stay onT.

## Profile(20,10,4,13): exact generators

With reduced branch stack divisors Dw,Dt and coarse lineU, the genuine relations are10Dw=4Dt=U. The canonical line is
\[
K=-2U+13D_w+3D_t=3D_w-D_t.
\]
Its invariant powers have coarse section degree
\[
d_j=\lfloor3j/10\rfloor-\lceil j/4\rceil.
\]
The invariant generators of weights FOUR, SEVEN and TEN have zero divisors2Dw,Dw+Dt,2Dt. Choose them arbitrarily, not as presumed nonzero characteristic coefficients, and write their actual normalized Y functions as F,H,G. The forced divisors give
\[
H^2=FG,\qquad\beta=G^2/F^5=H^4/F^7,
\]
after rescaling generators. The latter is the actual coarse quotient coordinate, with wild pole and tame zero.

Mixedness excludes the distinguished wild inertia ten. The distinguished stabilizer t is therefore1 or4. Let R1,R2 be the two distinct wild points; they are disjoint fromP. Let E be the complete unramified Y points above the tame value, excludingP when t4. Their number is five ift1 and three ift4. The exact divisors are
\[
\operatorname{div}F=2R_1+2R_2-4P,
\quad\operatorname{div}H=R_1+R_2+E-(7-2r)P,
\quad\operatorname{div}G=2E-(10-4r)P,
\]
where r=0 ift1 and r=1 ift4. Thus F is an invariant quadratic in a hyperelliptic coordinate of sole pole2P.

## If F is a square, an ACTUAL character cover lowers to degree ten

If F=f² in k(Y), put b=G/f5. Then b²=β, and C=k(b) is an ACTUAL rational subfield ofY of degree TWO over the coarse B=k(β). The actual equality ΓY=T and linear disjointness overB follow from the faithful G action: any element of the Galois group ofT overΓY would fixΓ and hence be trivial. Thus Γ2=Γ(b) is connected and has degree TWO overΓ insideT.

OnΓ the divisor of the pulled coarseβ has order−10 at every wild point and+4 at every tame point. All valuations are EVEN, so this connected quadratic Kummer cover Γ2→Γ is étale. Its coarse C→B is fully tamely ramified at the two branch values. The induced G action onΓ2 fixes b∈Y, and remains faithful since it already acts faithfully onΓ.

The new inertia orders are5 and2. In the local tower the new wild different is13−10+5=8. The map T→Γ2 has degree ten, retains the exact differentqP, genuine canonical N and all original sections, and both original maps remain onT. This is an actual reduction to the degree-ten carrier, not a contradiction: its earlier moving-origin exclusion had an algebra error. The corrected reduction forcesP=(t,0) and its new distinguished value ordinary. In particular the original distinguished-tame position cannot survive this square extraction. The following argument assumes F is NONSQUARE and proves that scoped alternative impossible.

A nonsquare invariant quadratic with divF=2R1+2R2−4P must have two simple roots at TWO distinct Weierstrass points. A double nonbranch root would make it a square, and a simple nonbranch root would give order-one zeros, contrary to its divisor. Thus R1,R2 are Weierstrass. Scale F=E2(z), a squarefree monic quadratic, and write
\[
y^2=\Phi(z)=E_2(z)J_3(z),\qquad\sigma=dz/y.
\]
The full pole bound and the simple zeros ofH atR1,R2 give
\[
H=E_2A_1+yB_1,
\]
with degA1≤1, degB1≤1. In the distinguished-tame case its smaller pole FIVE reduces both degree bounds to zero; retaining the larger bounds is harmless.

## The actual different forces H anti-invariant

At Ri, β has pole ten and different13, so dβ has order−7. At the unramified tame points its order is THREE. AtP its order is one ift1, seven ift4. The displayed divisors show exactly
\[
d\beta=c H^3\sigma/F^5,\qquad c\ne0.
\]
On the other hand differentiation of β=H4/F7 gives
\[
4F\,dH-7H\,dF=c F^3\sigma.
\]
All constants can be absorbed into the same nonzero c. Comparing the coefficient ofy after division byσ, using F=E2, gives
\[
2E_2'A_1+4E_2A_1'=0.
\]
For a linear A1, the quadratic leading coefficient is(4+4)a=3a, forcing its linear coefficient a to vanish. Then E2' is nonzero and its constant coefficient must vanish too. Hence A1=0, H=yB1 is anti-invariant, and G=J3 B1² is invariant.

The only possible odd characteristic weights below20 are7,11,15,17,19, each with a one-dimensional invariant section space; their generators are respectively H,HF,HF²,HG,HF³. The coefficient e19 vanishes. At t1 its ordinary target order must be at least one, whereas its generator has no ordinary zero. At t4 its local product of FOUR ramified quadratics forces order at least FOUR, greater than its generator's forced order ONE. These are elementary product-coefficient orders, not Newton identities.

All even coefficient functions, including the norm, are polynomials inF,G and hence hyperelliptically invariant. Characteristic evaluation has odd part
\[
H(a+bF+cF^2+dG)=0.
\]
The multiplier poles0,4,8,10 are distinct for ordinaryP, and0,4,8,6 are distinct for distinguished tameP. Thus every odd coefficient vanishes. The actual primitive polynomial is even, contradicting the retained actual minus/tangent obstruction. This closes the NONSQUARE-F branch of profile(20,10,4,13) for both distinguished cases. Its square branch remains an actual degree-ten reduction.

## Profile(20,20,2,31): one Weierstrass wild point

Now20Dw=2Dt=U and
\[
K=-2U+31D_w+D_t=11D_w-D_t.
\]
Its invariant canonical square has zero divisor2Dw. Normalize a nonzero generator to z, with divz=2R−2P. Its exact pole TWO makes it the hyperelliptic coordinate, so the unique wild pointR is a distinct Weierstrass point. Write
\[
y^2=\Phi(z)=zJ_4(z),\qquad\sigma=dz/y,
\]
with J4 squarefree of degree FOUR and J4(0)≠0.

The order-eleven canonical generator has zero divisorDw+Dt. Its normalized function H has divisorR+E−(11−2r)P, where the tame unramified point set E has size ten ift1 and eight ift2, and r is respectively0 or1. The distinguished wild value is impossible by mixedness. The full pole space therefore gives
\[
H=A_5(z)+yB_3(z),
\]
with degree bounds5and3; in the t2 case they shrink to4and2. Its exact odd pole implies B≠0.

The canonical weight-twenty space has dimension two. Its two cone-zero generators are z10 and H²/z. Thus an actual coarse coordinate is
\[
\beta=H^2/z^{11}.
\]
AtR it has pole TWENTY and local different31, so dβ has order−9. At each E point its order is ONE; atP it is one ift1 or three ift2. Exact divisors then give
\[
d\beta=c H\sigma/z^5,\qquad c\ne0.
\]
Differentiation, with11=1 in characteristic five, yields
\[
2z\,dH-H\,dz=c z^7\sigma.
\]
Its hyperelliptic odd part is2zA'−A=0, so A is a scalar multiple of z³; the only index0≤i≤5 with2i−1=0 modulo five is i=3. Its even part, after using Φ=zJ4, is
\[
2J_4B'+J_4'B=c z^5.
\]

## The forced supersingular elliptic quotient contradicts accepted ordinarity

The ACTUAL connected double cover Y' given by u²=z is étale: divz=2R−2P is even, and a square root onY would have sole poleP, impossible. In its field put v=y/u. Then v²=J4(z), giving an actual separating degree-two map fromY' to the smooth elliptic curve
\[
E_0:v^2=J_4(z).
\]
The preceding differential identity is precisely
\[
d(Bv)=\frac c2\,z^5\frac{dz}{v}.
\]
The invariant differential ω=dz/v is regular and nonzero. Cartier kills the exact left side, while C(z5ω)=z C(ω). Hence C(ω)=0: E0 is supersingular.

But Y' is an ACTUAL connected abelian étale cover ofY of exponent TWO. It is ordinary by the accepted [MAIN exponent-six ordinarity](../jacobians/ordinary_covers/main_exponent_six_ordinarity.md) or [BACKUP small-abelian ordinarity](../jacobians/ordinary_covers/backup_small_abelian_ordinarity.md), as appropriate. Separating pullback takes ω to a nonzero regular Cartier-zero form onY', contradicting Cartier injectivity there. This closes profile(20,20,2,31), with both possible distinguished values included.

The first row is independently accepted and the two degree-twenty rows are exhausted. The auxiliary double cover proves an endpoint obstruction and does not replace either original source map.
