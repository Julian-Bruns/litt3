# Proof: fixed endpoint rigidity on the actual source

Version1,3 October2026. Root read both independent returned proofs; no numeric replay. Source hypotheses are those of the [canonical statement](../../Theorems/cartier_and_spin/canonical_ten_fixed_backup_endpoint_normal_form.md). The preserved arguments use two explicitly stated coordinate systems, not an implicit scalar identification.

## 1. Notation, hypotheses used and standard facts

Write K0=k(P¹), K=k(Gamma), L=k(T), and H=k(Y). The notation H here is a field, not a projective-kernel subgroup. Let pi:Gamma→P¹ be the quotient map. Its wild and tame branch values are denoted b5 and b2. The reduced different of phi is D_phi=q*P0. The points of Y are geometric points throughout.

For a separable map of smooth curves, if a rational parameter t has a pole of order e at a point with different exponent delta, then ord(dt)=delta−2e. At a finite value of t, ord(dt)=delta. For a tower, different exponents satisfy delta_total=delta_upper+e_upper delta_lower. These formulas follow by differentiating local parameters; the chain rule also proves the tower formula. The divisor identity is K_source ~ f*K_target+Diff(f). See [RH] for the general statement and its local justification.

For a genus-two hyperelliptic curve in odd characteristic, a Weierstrass point P satisfies K_Y~2P. A nonconstant function with pole divisor 2P is a hyperelliptic coordinate z. With P at infinity the equation is w²=H_P(z), where H_P is a squarefree quintic. In these coordinates

    L(5P)=<1,z,z²,w>,   L(6P)=<1,z,z²,z³,w>,
    div(dz/w)=2P.

One can check the bases directly on the affine coordinate ring k[z,w]/(w²−H_P(z)): functions regular away from P have the form A(z)+B(z)w, and their two summands have distinct even and odd pole orders, 2 deg(A) and 5+2 deg(B). Thus there is no cancellation of their highest poles.

No use is made of M^8≅omega_Gamma, a linearization of R, a descended X-map on C_W, or Gamma-linear independence of a constant module. In particular, the new descent in §2 is only the descent forced by the actual G-equivariant square already present in the packet; it is not a simultaneous Galois closure or an equality of the endpoint fields.

## 2. The induced degree-ten endpoint map

### Proposition 2.1 — The actual quotient square

There is a separable degree-ten map t:Y→P¹ such that pi phi=t q. Moreover,

    KH=L,   [H:K0]=10,   K and H are linearly disjoint over K0.

Every proper intermediate field for H/K0 would give a proper intermediate field for L/K. Consequently t is primitive.

**Proof.** The invariant field K^G=K0 lies in L^G=H, so it defines the claimed map. Since G acts faithfully on K, the subgroup of Gal(L/H)=G fixing KH is trivial. Hence KH=L by Galois correspondence. Counting degrees in L/K0 gives

    [L:K0]=[L:K][K:K0]=10N=N[H:K0].

Both L/K and K/K0 are separable, so H/K0 is separable. The equality [KH:K]=[H:K0]=10 gives linear disjointness. If K0⊊H'⊊H, base change by K preserves both nontrivial degrees, producing K⊊KH'⊊L. This contradicts primitivity of phi, supplied in the packet (and also implied by its full S_10 monodromy). ∎

### Proposition 2.2 — Exhaustive branch profiles

There are exactly three possibilities, according to the location of t(P0):

| Location of t(P0) | Profile over b5 | Profile over b2 | Additional ramification |
|---|---|---|---|
| b5 | (10), different 17 | (2,2,2,2,2) | none |
| b2 | (5,5), each different 8 | (4,2,2,2) | none |
| neither | (5,5), each different 8 | (2,2,2,2,2) | one index-2 point P0 over a third value |

In the last row, the third fiber has profile (2,1^8).

**Proof.** Choose a point of T over y in Y and x in Gamma. Since q is étale, its local ramification index is 1 and different exponent is 0. Therefore

    e_t(y)=e_phi e_pi(x),
    delta_t(y)=delta_phi+e_phi delta_pi(x).

Here (e_phi,delta_phi) is (2,1) precisely above P0 and is (1,0) elsewhere. Substitution of (e_pi,delta_pi)=(5,8),(2,1),(1,0), together with deg(t)=10, gives the table. There can be no other branch values: at such a point both phi and pi are unramified. The different totals are respectively 17+5, 16+6, and 16+5+1, all equal to 22, as required for a degree-ten map from a genus-two curve. ∎

The third row is essential. One cannot assume that the image of the different of phi lies in a branch orbit of pi.

## 3. Excluding the two coincident branch values

### Proposition 3.1 — P0 cannot map to b5

**Proof.** Take b5=infinity and b2=0. Let D be the reduced divisor of five points over 0. The first row of the table gives

    div(t)=2D−10P0,
    div(dt)=D−3P0.

As div(dt)~K_Y~2P0, we have D−5P0~0. Choose a function f with div(f)=D−5P0. Then t=c f² for a nonzero constant c. This is a factorization of the degree-ten map through a degree-five map followed by the degree-two square map, contradicting Proposition 2.1.

Notice that f is obtained from an exact divisor-class identity, not by integrating dt with an assumed pole bound. One also obtains div(df)=2P0 from dt=2c f df. Thus, independently, ordinarity of Y would exclude this case through its nonzero exact regular differential. The primitivity argument already suffices. ∎

### Proposition 3.2 — P0 cannot map to b2

**Proof.** Put b5=0 and b2=infinity. Let W=A1+A2 be the two distinct points over the wild value, and let E1=P1+P2+P3 be the remaining three points over the tame value. Set D=2P0+E1. Then

    div(t)=5W−2D,
    div(dt)=8W−3D+P0.

Using K_Y~2P0 yields the two principal divisor classes

    5W−2D ~ 0,    8W−3D−P0 ~ 0.

Twice the second minus three times the first gives W−2P0~0. Choose z with div(z)=W−2P0. Since W consists of distinct points, it is a nonbranch hyperelliptic fiber. In a model w²=H_P0(z), the points of W are (0,±w0), with w0≠0.

Define f=z⁵/t. Direct valuation calculations give

    div(f)=2E1−6P0,
    ord_A1(df)=ord_A2(df)=3.

Indeed df=−z⁵t^(−2)dt, so the latter orders are 5−10+8=3. Thus f belongs to L(6P0) and has **exact** pole order 6 at P0. Write f=A(z)+b w with deg(A)≤3. Exact pole order 6 forces the z³ coefficient of A to be nonzero.

But

    df=(A'(z)w + b H_P0'(z)/2) dz/w.

Modulo z³ at both points of W, the two formal square roots of H_P0 are opposite units. Subtracting the two numerator congruences shows that z³ divides A'(z). Since deg(A')≤2, A'=0, contradicting its nonzero quadratic leading term. ∎

No fifth-power polar ambiguity is suppressed: the exact pole order of f came from its divisor. In characteristic 5 a cubic has a nonzero derivative at its leading term, whereas a fifth-degree term would require separate treatment.

## 4. The surviving normal form

Normalize b5=infinity and b2=0. Proposition 3 leaves t(P0) finite and nonzero. Write W=A1+A2 for the two wild points and D for the reduced five-point zero divisor of t.

### Theorem 4.1 — Divisor and contact normal form

There exist hyperelliptic coordinates z,w with P0 at infinity, and constants A_*,B_*,C_* all nonzero, such that

    w²=A_* z⁵+B_* z⁴+C_*,
    t=(w+d)²/z⁵,
    d²≠C_*.

Scaling t is allowed in this formula. The hyperelliptic fiber z=0 is W. Before a translation of the hyperelliptic coordinate, the derivative of the quintic must be a nonzero cubic with a triple root.

**Proof.** The last row of Proposition 2.2 gives

    div(t)=2D−5W,
    div(dt)=D+P0−2W.

Since P0 is Weierstrass,

    D−2W−P0 ~ 0,    2D−5W ~ 0.

Their integer combination gives W−2P0~0, and then D−5P0~0. Choose z and g with

    div(z)=W−2P0,    div(g)=D−5P0.

The divisor of t equals that of g²/z⁵, so t=c g²/z⁵. Absorb c into g over the algebraically closed field. This step proves the pole bound of g before differentiating; it is not an inference from rational exactness.

Write g=A(z)+b w in L(5P0), where deg(A)≤2. Since g has exact pole order 5, b≠0. At both points of W, g is a unit, and

    dt=2g dg/z⁵,    ord_W(dt)=−2.

Consequently dg vanishes to order 3 at each point of W. Applying the two-branch argument of Proposition 3.2 gives z³|A'(z), so A is constant, and z³|H_P0'(z). A quintic in characteristic 5 has derivative of degree at most 3. It cannot have zero derivative, since a polynomial with zero derivative over k is a fifth power and would not be squarefree. Thus H_P0'=4B_* z³ with B_*≠0, giving the asserted form. Its leading coefficient A_* is nonzero, and C_*≠0 because W is not a branch fiber. Divide g by b and rescale t to obtain g=w+d. Its nonvanishing at W is exactly d²≠C_*. ∎

### 4.2. Check of the reduced endpoint profile

Conversely, this normal form, with A_*B_*C_*≠0 and d²≠C_*, defines a separable degree-ten map on the genus-two curve. Its zeros are the five distinct roots of H(z)=d², each with multiplicity 2. Distinctness follows from H'=4B_*z³ and H(0)≠d². Its poles are 5W. Since

    dt=4B_* (w+d) z^(−2) dz/w,

its differential divisor is D+P0−2W. Its third ramification point is P0, of index 2, over t=A_*.

This is only a check of an endpoint map and its ramification profile. It supplies no Gamma, T, G, original X-maps, sections, or coefficient module.

## 5. Exhausting the Weierstrass points of the specified Y

Use coefficient triples (a0,a1,a2) for a0+a1 alpha+a2 alpha², with alpha³=−alpha−1. These are **not** the F_25 integer codes used for X.

Let F(u)=u(u−1)(u−2)(u−3)(u−alpha). At the original infinity, use H_infinity=F. At a finite branch root r, use

    Z=1/(u−r),  Wv=v/(u−r)³,
    H_r(Z)=Z⁶ F(r+1/Z).

This sends precisely the Weierstrass point (r,0) to infinity. The new polynomial is a squarefree quintic. A further hyperelliptic coordinate with the same pole divisor is an affine change of Z, so the property “the derivative has a triple root” is invariant under all remaining coordinate freedom.

If H_r'=c3 Z³+c2 Z²+c1 Z+c0, with c3≠0, a triple root requires, and is equivalent to,

    Delta=c2²−3c3c1=0,
    Epsilon=c2³−2c3²c0=0.

This follows by expanding c3(Z−c)³; the candidate root is c=c2/(2c3). All six derivatives have degree 3. The exact calculation is:

| P0 | Delta | Epsilon, as a coefficient triple |
|---|---|---|
| original infinity | 0 | (2,4,2) |
| (0,0) | 0 | (3,0,4) |
| (1,0) | 0 | (3,3,1) |
| (2,0) | 0 | (3,4,0) |
| (3,0) | 0 | (3,2,2) |
| (alpha,0) | 0 | (0,0,0) |

Every displayed nonzero triple is nonzero in F_125, since 1,alpha,alpha² is a basis. The cubic alpha³+alpha+1 has no root in F_5 and is irreducible. Thus the table excludes five points over the **algebraic closure**, not merely over the coefficient field.

At r=alpha the unique triple root is

    c=3+alpha+4alpha².

With z=Z−c and w=Wv, direct expansion gives

    w²=A_*z⁵+B_*z⁴+C_*,
    A_*=1+4alpha,
    B_*=3alpha+2alpha²,
    C_*=4+2alpha+4alpha².

All three are nonzero. Hence:

### Corollary 5.1

Every packet source must have P0=(alpha,0), and, up to scaling t,

    z=1/(u−alpha)−(3+alpha+4alpha²),
    w=v/(u−alpha)³,
    t=(w+d)²/z⁵.

The calculation is short enough to verify by hand using the displayed substitution. `src/verify.py` reproduces every coefficient, checks the criterion and the translated equation, and compares them with `evidence/checks.json`.

## 6. Matching the two wild local extensions

The equality of the two local extensions is stronger than equality of their indices and differents.

### Lemma 6.1 — The local coefficient invariant

Let K_loc=k((t^(−1))) and L_loc=k((z)), with

    t=c5 z^(−5)+c1 z^(−1)+O(1),    c5 c1≠0.

For a cyclic degree-five extension of lower break 1, write its reduced Artin–Schreier class as lambda t, with lambda determined up to F_5^*. Then

    lambda⁴=−c5/c1⁵.

Two such extensions over the same K_loc are isomorphic only if the displayed fourth powers agree; conversely that equality identifies their reduced Artin–Schreier classes.

**Proof.** Artin–Schreier theory gives a generator x with x⁵−x in K_loc [AS]. Subtracting fifth-power differences removes principal-part terms of exponent divisible by 5; regular terms can be removed in k[[t^(−1)]] by the simple-root lifting property of X⁵−X, since k is algebraically closed. A reduced principal part has largest exponent n not divisible by 5. Its lower break is n: the generator has valuation −n in L_loc, and choosing integers a,b with 5a−nb=1 gives a uniformizer t^(−a)x^b; the action x↦x+1 changes this uniformizer first in degree n+1. Therefore break 1 leaves exactly lambda t.

The generator has valuation −1, so x=kappa z^(−1)+O(1). Comparing z^(−5) and z^(−1) in x⁵−x=lambda t gives kappa⁵=lambda c5 and −kappa=lambda c1. Eliminating kappa gives the formula.

For completeness, the ambiguity is exactly F_5^*: in the same extension a second Artin–Schreier generator with class lambda' t differs from jx by an element of K_loc, for some j in F_5^*. A nonzero multiple of t cannot equal h⁵−h in K_loc, because a pole of h gives a pole of order divisible by 5, and a regular h gives no pole. Thus lambda'=j lambda. The fourth roots of unity in k are exactly F_5^*. ∎

The Laurent shape in this lemma also directly implies cyclicity and lower break 1. Write Z=1/z. In t(Z+delta)−t(Z), the reduction modulo 1/Z is c5 delta⁵+c1 delta, with five distinct constant roots. Its derivative is c1+O(1/Z²), a unit. Lifting these five roots produces five distinct automorphisms Z↦Z+delta(Z^(−1)); the four nonidentity ones have nonzero constant translation term. Their action on z first changes its degree-two coefficient. This gives the claimed cyclic degree-five group and break without an additional classification assumption.

### Proposition 6.2 — The parameter is forced

For the actual source, d²=2C_*.

**Proof.** Let v0²=C_* and let the points of W have w=±v0. Expanding the hyperelliptic equation gives

    t=(d±v0)² z^(−5)
      + B_* (d±v0)/(±v0) z^(−1) + O(1).

The two completions of Y over infinity must be isomorphic over k((t^(−1))). Indeed q is étale, phi is unramified at these points, and all completions of the Galois cover Gamma/P¹ above infinity are isomorphic over the base, by Galois transitivity of valuations [IN]. No relation between original X-fields is involved in this argument.

Lemma 6.1 therefore equates

    v0⁵/(d+v0)³ = −v0⁵/(d−v0)³.

The denominators are nonzero by d²≠C_*. Clearing them yields

    (d−v0)³+(d+v0)³ = d(2d²+C_*) = 0.

If d=0, then t=(A_*z⁵+B_*z⁴+C_*)/z⁵ belongs to k(z). This factors the degree-ten map through the hyperelliptic degree-two map and a degree-five rational map, contradicting Proposition 2.1. Thus 2d²+C_*=0, equivalently d²=2C_* in characteristic 5. ∎

This leaves two signs, exchanged by w↦−w. Neither lies in F_125: the exact arithmetic check gives (2C_*)^62=−1. Both exist over the algebraic closure and must be retained. Excluding them on account of their field of definition would be an invalid bounded search.

The conclusion is a necessary classification of the endpoint map. It does not establish that an appropriate G-cover Gamma exists or that it extends to the entire source packet.

## 7. The native different and a G-stable generic isotropic space

### Proposition 7.1 — An explicit rational representative

Put

    r=(w+d)/z²,    a0=1/r.

In the rational frame dt of omega_Gamma, the packet's actual different coefficient a is a nonzero **constant** multiple of a0. In any other rational frame it changes by the corresponding K-scalar. Moreover,

    C_* t⁵ a0^10 − 2d t³ a0⁵ − B_*t a0² + t−A_* = 0,          (7.1)

and a0 is primitive over both k(t) and K after the specified base change.

**Proof.** First r²=tz and w=r z²−d, so z=r²/t and w=r⁵/t²−d. These identities show H=k(t,r)=k(t,a0). Eliminating z,w from w²=A_*z⁵+B_*z⁴+C_* gives

    (t−A_*)r^10−B_*t r⁸−2d t³r⁵+(d²−C_*)t⁵=0.

Use d²−C_*=C_* and divide by r^10 to obtain (7.1). The degree is 10 because [H:k(t)]=10 and H=k(t,a0). Linear disjointness from §2 gives primitivity over K as well.

Now let eta_Y=dz/w, whose divisor is 2P0. Let e be the rational frame of omega_T corresponding to phi*(dt²) under the **given** canonical comparison, and write q*(dt)=a e. The different identity gives

    div(a)=D_phi−phi*div_Gamma(dt).

Consequently div(a²e)=2D_phi=div(q*eta_Y). There is a constant c0≠0 such that q*eta_Y=c0 a²e. On Y, dt=4B_* r eta_Y, so

    a e = 4B_* r c0 a²e.

Thus a=(4B_*c0)^(-1) a0. The constant is retained; it is not silently assigned a preferred native value. No root identification M^8=omega_Gamma or linearization of R was used. ∎


## Equivalent fixed normalization

### Explicit coordinate change

Set

    d=4-alpha,      c=d^4,
    rho^2=d^5,
    x=(4-u)/(u-alpha),
    w=rho v/(u-alpha)^3.                         (4.1)

Direct substitution gives the fixed Y in the form

    w^2=(c-1)x^5+c x^4-1.                        (4.2)

One may take rho=4+2alpha+2alpha^2; the exact check is included. Also

    c=2+4alpha,    c-1=1+4alpha.

These are expressions in F125, not in the input beta field. The verification JSON uses separately labelled F125 codes.

Equation (4.2) can also be checked without field reduction. Write

    g(u)=u(u-1)(u-2)(u-3)=(u^5-u)/(u-4).

In the coordinate z=1/(u-alpha), its translated quintic at z=d^{-1} has coefficients

    A0=d^4-1, B0=d^3, C0=-d^{-5}.

Rescaling x=d(z-d^{-1}) and w=rho v z^3 gives (4.2).

The point P0 is now the unique point at infinity. The wild canonical fiber is x=0 with w=+2 and w=-2.


## 7. The actual different polynomial and generic trace flag

Retain the given genuine canonical comparison. The differential eta0 from Proposition 2.3 is kappa dx/w for a fixed nonzero scalar kappa, since both have divisor 2P0. In the invariant rational frame e=kappa pi^*df of omega, the actual different coefficient is

    a=eta0/df=x^2/[4c(w+b)].                     (7.1)

Indeed its coefficient in the frame pi^*df was eta0/df=kappa x^2/[4c(w+b)], and passing to e divides that coefficient by kappa. Thus no given comparison or scalar transport has been changed or discarded. This is a function on the original Y, pulled to T; consequently it is G-invariant as a rational coefficient in the frame e. Constant multiples of df have the same divisor, so all later divisor calculations are unchanged. It is not a new independent function or a replacement covering parameter.

### Proposition 7.1. Primitive polynomial

The coefficient a is primitive over k(Gamma) and satisfies

    -c^10 f^5 a^10+2b c^5 f^3 a^5
       -c^3 f a^2+f-(c-1)=0.                    (7.2)

**Proof.** From (5.1) and (7.1),

    x=1/(c^2 f a^2),
    w+b=-1/(c^5 f^2 a^5).                       (7.3)

Thus k(f,a)=k(Y), so Proposition 2.1 implies k(Gamma)(a)=k(T). Substitution of (7.3) into (4.2) gives (7.2). Equivalently, for w^2=A0x^5+B0x^4+C0 the same calculation gives

    (b^2-C0)B0^10 f^5 a^10+2b B0^5 f^3 a^5
      -B0^3 f a^2+f-A0=0.

Using b^2=2C0 specializes it to (7.2). Since the extension has degree ten and the leading coefficient is nonzero, this is its minimal polynomial up to normalization. ∎


## Provenance

Original reports and minimal checks are preserved outside litt3 at ../litt3-computation-data/pro_replies/canonical_identity_frontier_2026_10_03/{adjoint_isotropy,no_defect_orthogonal_row}/. Both proofs were read; scalar, divisor and SAME-local-field scopes agree. The small exact table was trusted after reading its algorithm, not rerun. References [RH],[AS],[IN] mean Stacks tags0C1B,09I7,09E3 respectively. The geometric/local arguments are proved above, not imported from those general foundations.
