# Connecting classes: generation, equality cores and incidence descent

Version2,2026-09-08; consolidation by /root/library_generalization_cleanup_max.
Evidence remains separated. The strict descent theorem and its etale
consequences in §3 retain [PASS,2026-09-05](audits/105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP_AUDIT.md),
auditor /root/gluing_cohomology_rigidity; no breaking issues, with an
optional finite-flatness clarification now supplied in the linked
incidence proof. The generation/equality inputs in §§1–2 were NOT
re-audited there: they remain the author proof of2026-09-05.
The exact canonical field equality in §4 and Cech comparison in §5
are likewise author-only.
No fresh audit or common-cover exclusion is claimed.

Version2 also corrects the old inconsistent "current pair" numerical
sentence: deg L_Y is 2n(g(Y)−1)−d_X, not16n−N when d_X=3N.
The orientation-free formula in §3 replaces that specialization;
no new fixed-pair involution or exclusion is asserted.

## 1. Coefficient generation, with nonreduced fibers retained

Over algebraically closed k in ANY characteristic, let X,Y be smooth
projective connected curves, Γ an integral divisor dominating both
factors, O(Γ)=A⊠B, and deg A,deg B>0. Let P,Q have positive degree
on X,Y and let t be a unit of M|Γ for M=P⊠Q⁻¹. Put

    L_X=PA⁻¹,        L_Y=QB⁻¹,
    δ_X(t)∈H⁰(X,L_X)⊗H¹(Y,Q⁻¹B⁻¹),
    δ_Y(t⁻¹)∈H¹(X,P⁻¹A⁻¹)⊗H⁰(Y,L_Y).

These are the restriction connecting classes. They are nonzero:
H⁰(M)=H⁰(M⁻¹)=0, and the unused Kunneth summands vanish by the
negative degrees. Their respective coefficient spans U_X,U_Y
GENERATE L_X,L_Y, not merely their complete linear series.

To check the first assertion, restrict the divisor sequence to x×Y.
The fiber D_x=Γ∩(x×Y) is a nonempty Cartier divisor, possibly
nonreduced, and the sequence is

    0→(L_X)_x⊗Q⁻¹B⁻¹→P_x⊗Q⁻¹→M|D_x→0.

Exactness follows because Γ→X is finite flat: its finite module is
torsion-free over the smooth base curve. The restriction of t is a
nonzero unit on the ENTIRE finite scheme D_x. The fiber connecting
map is injective because H⁰(Y,Q⁻¹)=0. Naturality identifies its
nonzero value with (ev_x⊗1)δ_X(t), so U_X has no base point.
Nakayama gives generation; use t⁻¹ and interchange factors for U_Y.
In particular deg L_i≥0, and degree0 forces L_i≅O and a constant
coefficient map.

One unit-lifting calculation is used in both following proofs.
For a line bundle L on X×Y with H⁰(L)=0 and unit u of L|Γ,
take the extension 0→L→V→O(Γ)→0 with class−δ(u), adjusting
the sign to the Cech convention. A defining section F of Γ
lifts to s∈H⁰(V), since Fδ(u)=0 in the restriction sequence.
In local splittings write s=σ_i(F)+q_i. On overlaps,
q_j−q_i=−(σ_j−σ_i)F. Dividing by F computes the connecting
class of q_i|Γ; injectivity of that connecting map identifies it
with u (or its negative under the opposite sign convention).
Thus s is nowhere zero: its quotient is nonzero off Γ, and
its kernel component is a unit on Γ, including singular points.

## 2. The exact equality case gives a common projective line

For the same integral split divisor Γ, the following are equivalent:

- (A⊠B⁻¹)|Γ is trivial;
- F=a₀b₀+a₁b₁ for basepoint-free pairs a₀,a₁∈H⁰(X,A),
  b₀,b₁∈H⁰(Y,B);
- Γ is the FULL scheme-theoretic fiber product of nonconstant
  h_X:X→P¹,h_Y:Y→P¹ with h_X*O(1)=A,h_Y*O(1)=B.

For the nontrivial implication, the connecting class of the unit
is1⊗η∈H⁰(O_X)⊗H¹(Y,B⁻²). Let
0→B⁻¹→E→B→0 have class−η. The preceding unit-lifting calculation
gives a nowhere-zero section s of A⊠E with quotient F.
For each y, the evaluation H⁰(Y,E)→E_y must have rank2:
otherwise s_y is one section of the positive-degree A times a
fixed vector and has a zero on X. Two sections independent at
one point have a nowhere-zero constant wedge, since det E=O_Y.
They trivialize E. Its quotient to B and the section s give the
two basepoint-free pairs above.

Conversely set h_X=[a₀:a₁], h_Y=[−b₁:b₀]. Pulling back the
diagonal gives exactly F=0. On that fiber product the two line
bundles are pullbacks of the same O_(P¹)(1), proving triviality.
Their common rational subfield survives in the normalization.

For the canonical application let g(X),g(Y)≥2, let Z normalize Γ
with both projections finite etale of degrees d_X,d_Y, and set
s_X=g(X)−1,s_Y=g(Y)−1. Then deg A=d_Y,deg B=d_X and
s_Xd_X=s_Yd_Y. If a positive power of ω_X⊠ω_Y⁻¹ is trivial on Γ,
generation gives the usual nonnegative degree bounds. At equality

    d_Y=2ns_X,        d_X=2ns_Y,

the generated degree-zero L_i are trivial, so A≅ω_X^n,B≅ω_Y^n.
The equivalence just proved gives a NONCONSTANT core, with
deg h_X=d_Y,deg h_Y=d_X and h_X f=h_Y g.

These quotient maps are separable. In characteristic p, if
h_X*(u)=w^p, its differential vanishes on Z. Separability of Z/Y
then forces h_Y*(u)=v^p. The full fiber-product equation is
w^p−v^p=(w−v)^p, contradicting integrality of Γ. Repeat in the
other direction. No such core conclusion is proved here in the
strict positive-degree case.

## 3. Strict connecting data force non-Galois incidence descent

Return to general P,Q in §1 and assume BOTH deg L_X,deg L_Y>0.
The generated U_Y defines ρ_Y:Y→P(U_Y*). Factor it through
q:Y→D, where D is its smooth normalized image, and put
L₀=ρ₀*O(1). Thus L_Y=q*L₀ and U_Y⊂q*H⁰(D,L₀).
The finite nonconstant q is not assumed separable or Galois.

There is a line bundle T on D and an integral divisor Γ₀ on X×D
such that

    Q≅q*T⁻¹,        B≅q*(L₀⁻¹T⁻¹),
    Γ₀∈|A⊠(L₀⁻¹T⁻¹)|,        Γ=(1_X×q)*Γ₀.                    (1)

In particular the original divisor-family map factors through q.

For the proof descend the coefficients of δ_Y to δ₀ on D, and form

    0→P⁻¹⊠O_D→E₀→A⊠L₀⁻¹→0.

Kunneth identifies this entire extension space with
H¹(X,P⁻¹A⁻¹)⊗H⁰(D,L₀), since H⁰(X,P⁻¹A⁻¹)=0.
Pull back E₀ and tensor by Q. Its quotient becomes A⊠B and its
kernel P⁻¹⊠Q. The unit-lifting calculation of §1 applied to t⁻¹
gives a nowhere-zero section s.

For every d∈D, choose y over d. Restriction of s gives a
nowhere-zero section of E_(0,d), whose determinant has degree
−deg L_X<0. Thus 0→O_X→E_(0,d)→det E_(0,d)→0 gives h⁰=1.
Riemann–Roch also makes h¹ constant. Cohomology and base change
therefore make T=π_*E₀ a line bundle on D, with formation commuting
with base change. Evaluation π*T→E₀ is a line subbundle, since
its fiber generator is nowhere zero.

The original s consequently trivializes q*T⊗Q, giving the two
bundle identities in(1). Composing π*T→E₀ with its quotient
defines F₀ in A⊠L₀⁻¹T⁻¹. It cannot be zero, because
Hom(π*T,P⁻¹⊠O_D)=0. Its pullback is F, up to a nonzero scalar.
Since1×q is finite faithfully flat, integrality of Γ descends to
div(F₀)=Γ₀, proving(1).

If Z normalizes Γ and BOTH original maps f:Z→X,g:Z→Y are etale,
the [exact incidence-square proof, §1](MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md#1-the-exact-incidence-square-and-the-missing-second-leg)
now gives, for b=deg q,

    Z=Norm(Z₀×_D Y),          Z→Z₀→X finite etale,
    deg(Z/Z₀)=b,             b|d_X,          b|deg Q.              (2)

The fiber product is integral; q and Z₀→D are separable. Its
normalization retains the ORIGINAL etale Y-map, of degree d_Y.
If g(Y)≥2 and J(Y) is simple, b=1 or D=P¹.
For b>1 the given g cannot descend to Z₀, so(2) is not a
smaller-common-cover contradiction.

### Canonical symmetry and degree consequences

For P=ω_X^n,Q=ω_Y^n, a finite group G≤Aut(Y) fixing ρ_Y as a
map fixes its normalized image. Equation(1) makes Γ invariant
under1×G, so normalization lifts G faithfully to Aut_X(Z).
A nonidentity automorphism of a connected etale cover over X has
no geometric fixed point. Hence G acts freely and

    |G| divides d_X,          Z→Z/G→X is finite etale,

with the original Y-map still G-equivariant. No prime-to-
characteristic assumption on G is needed.

If Y is hyperelliptic of genus h and0<deg L_Y≤h, its coefficient
map factors through the hyperelliptic quotient. Otherwise a general
basepoint-free pair in U_Y has ratio outside the hyperelliptic
subfield. Together with the degree2 hyperelliptic function it
generates k(Y), giving a birational image of bidegrees2,deg L_Y
in P¹×P¹, of arithmetic genus deg L_Y−1<h: impossible, even
if the second map is inseparable. The involution therefore lifts
freely over X, and d_X is even. The exact orientation is

    0<deg L_Y=2n(g(Y)−1)−d_X≤g(Y).

In general b|gcd(d_X,2n(g(Y)−1)). If the original divisor-family
map is birational, its factorization through q forces b=1.
For hyperelliptic Y this also forces deg L_Y≥h+2. The remaining
degree h+1 cannot give a birational series: that requires at least
three sections, so Riemann–Roch makes it special, and the moving
part of a special hyperelliptic divisor is composed with the
degree2 pencil. These are restrictions on the actual quotient,
not automatic exclusions of a fixed pair.

## 4. The canonical unit recovers exactly the incidence field

Retain the canonical, strict-degree, actual bi-etale setup. The
canonical differential identification gives a specified unit τ of
(ω_X⊠ω_Y⁻¹)|Z; suppose τ^n descends to a unit on Γ. Use t=τ^−n
to define δ_Y. Let E⊂L=k(Y) be the field of the original
divisor-family image, and K_n⊂L the field of the projective
connecting coefficients. Then

    K_n=E                   for EVERY admissible strict-range n.   (3)

This is an author proof; it uses the DIFFERENTIAL origin of the
unit, not just an arbitrary P,Q trivialization.

The incidence quotient q₀:Y→D₀ gives B=q₀*B₀ and
Γ=(1×q₀)*Γ₀. Its normalization square has
Z→Z₀→X etale, maps q₀ and φ:Z₀→D₀ separable, and

    k(Z₀)⊗_E L=k(Z)                 as a field, E=k(D₀).

Thus the generic fiber C₀⊂X_E of Γ₀ is the finite etale
E-scheme Spec k(Z₀). Choose nonzero rational differentials α on X,
η on D₀ and a rational frame β of B₀. The ratio

    c=s*α/φ*η ∈ k(Z₀)×,         v₀=c^n α^−n∈H⁰(C₀,ω_X^−n|C₀)

is defined by separability. It is independent of the α frame.
On the pullback generic fiber C, the specified inverse canonical
unit divided by (q₀*η)^n is exactly the scalar extension of v₀:
the ratio f*α/g*q₀*η is r*c by the commutative square.

With F₀/β defining C₀, use the restriction sequence over E

    0→ω_X^−n A⁻¹ --F₀/β--> ω_X^−n→ω_X^−n|C₀→0.

The connecting image e₀ of v₀ lies in
H¹(X,ω_X^−n A⁻¹)⊗E and is nonzero because H⁰(X_E,ω_X^−n)=0.
After scalar extension to L this is the defining sequence for
δ_Y, with its line factor framed by (q₀*η)^n/(q₀*β).
Naturality identifies its projective coefficients with those of
e₀⊗_E L. Hence K_n⊂E. The strict descent theorem(1) gives the
opposite inclusion E⊂K_n. Equality identifies the smooth normalized
images; rational maps from smooth projective curves to the projective
coefficient space extend everywhere.

The reverse inclusion K_n⊂E itself needs no strictness. Equality
does: at the degree-zero endpoint the connecting map is constant,
whereas the incidence map is nonconstant; §2 handles that endpoint
by its common-P¹ theorem. Varying n may change the projective
embedding but gives no finer quotient in the strict range.

The [very-ample norm reconstruction](MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md#2-norm-coefficients-recover-the-exact-field-for-any-very-ample-bundle)
also recovers precisely E, without a degree-range restriction.
None of these field equalities constructs a map from Z₀ to the
fixed Y, bounds arbitrary gluing orders, or solves Litt's problem.

## 5. Frobenius recursion does not force inseparable coefficients

In characteristic p let H=O(Γ), let F define Γ, and suppose
t=τ^n descends to a unit of L|Γ with L=M^n. Local lifts s_i give
δ_n=[(s_j−s_i)/F]. Taking p-th powers of these lifts proves

    δ_(pn)=F^(p−1) Fr(δ_n),
    H¹(LH⁻¹) --Fr--> H¹(L^pH^−p) --F^(p−1)--> H¹(L^pH⁻¹).

Frobenius is p-semilinear; no extra sign occurs. Iterating gives
δ_(p^a n)=F^(p^a−1) Fr^a(δ_n), also for the inverse unit.
The premise is descent at exponent n, not at n/p. Rescaling F
changes both sides consistently; independently normalized units
give the projective identity.

If E_n is the coefficient field on Y and E_F the incidence field,
expansion gives E_(pn)⊂E_F E_n^p. The factor F^(p−1) can supply
separating coordinates; the coefficients need not all be p-th powers.
In the canonical strict range, §4 already gives E_n=E_F for every
admissible exponent.

For an exact countermodel take Γ the diagonal F=x−y on P¹×P¹,
with positive P_n=Q_n=O(n). Its inverse-unit connecting class is,
up to common scalar,

    δ_n=Σ_(j=1)^n y^(j−1)[x^−j]
       ∈H¹(O(−n−1))⊗H⁰(O(n−1)).

In characteristic5, expansion in this Cech quotient gives
(x−y)^4 Fr(δ₂)=δ₁₀. The coefficient maps are the degree1 and
degree9 Veronese maps, both separable with field k(y); the coordinate
y comes from F⁴. This disproves the purported purely inseparable
consequence of powering a unit, but is NOT a canonical genus-(9,25)
example.
