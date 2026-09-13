# Proof: weight compression, followed by a precise limit to endpoint sieving

[Statement](../../../Theorems/jacobians/theta_divisors/uniform_cartier_root_locus.md).
Author /root,2026-09-08, version2. Both actual etale legs are retained
in applications; the existence assertions below concern endpoint tensors.

## 1. Compressing the weight to a residue

Let s have weight d, divisor eD, er=2d. Choose1<=u<=4 with ud=1mod5,
write q=(ud-1)/5, and ue=5b+a with0<=a<=4. Since5 does not divide d,
neither e nor r is divisible by5; ar=2mod5, so a!=0. A leading zero
of order4mod5 has nonzero Cartier image. Thus Cartier-zero excludes
a=4 and r=3mod5, leaving exactly the stated values of a.

Divide s^u by the fifth power of the canonical section of O(bD).
This gives the specified section sigma with divisor aD of

    omega tensor L_s^5, L_s=omega^q(-bD), deg L_s=j=(ar-2)/5.

Its twisted Cartier image vanishes iff C_(C,q)(s^u)=0, by the product
rule. Put M=Fr_Pic(L_s), where coefficient Frobenius satisfies
V Fr_Pic=[5], Fr_Pic V=[5]. Then V(M)=O(aD)omega^(-1).

## 2. One prime-to5 point, with an exact converse

Write ell=[D-rO], mu=M-O(jO1). The relation just obtained is
V(mu)=a ell. Choose integers c,z with ac+5z=1. Set

    theta=c mu+z Fr_Pic(ell).

Then V(theta)=ell and a theta=mu. These formulas give an isomorphism
between the two parameter descriptions; they do not choose a division
point noncanonically. Since omega=O(2O),

    L_s=O(jO) tensor ell^(-b),
    M=O(jO1) tensor theta^(-5b)
     =O(jO1) tensor theta^a.

It follows that theta^(a+5b)=theta^(ue)=O. The integer ue is prime
to5, proving that an actual tensor selects a prime-to5 theta.

Conversely suppose theta is prime-to5 and(D,theta) lies in Z_r.
Put d0=r/gcd(r,2), e0=2/gcd(r,2) and N=ell^e0. Its order n is
prime to5. There is a unique tensor up to scalar of weight d=d0 n
and divisor eD, e=e0 n, because N^n=O. For u,q,b as in Section1,
V(theta^e)=N^n=O. But theta^e has prime-to5 order and ker V is a
5-group, so theta^e=O. Hence theta^(-5b)=theta^a and its compressed
section is exactly the specified section in Z_r, up to scalar. It is
Cartier-zero, proving the converse. Minimality of n proves the minimal
weight statement. The same calculation, or the generalized Cartier
product rule, handles larger p-prime powers.

V is an isomorphism on prime-to5 torsion, so a fixed ell has at most
one prime-to5 lift. Allowing the other24 lifts is a geometric relaxation,
not a source of actual root tensors.

## 3. The parameter space and the codimension bound

Ordinarity makes V an etale isogeny of degree25. Thus T_r is smooth
projective of dimension r over Sym^r(C). It is connected: restricting
to P -> P+(r-1)O gives the V-torsor along the Abel map. The Abel map
identifies H1_et(-,F5) of J(C) and C, using H1(O), Frobenius and the
Artin--Schreier sequence. No nonzero character of ker V becomes
trivial, so this restricted torsor, and hence T_r, is connected.

For r>=3 all degree-r line bundles have h0=r-1 and H1=0; the usual
Poincare family therefore realizes T_r as a P^(r-2)-bundle over J1.
Its tautological section line gives the specified section of O(D).
Taking its ath power, and using M=O(jO1)theta^a, gives the specified
line in H0(omega tensor V(M))=H0(O(aD)). Normalizations differ only by
a line from the base, which does not change any vanishing locus.

For r>=4 allowed, j>0. The twisted Cartier target has fiber
H0(omega_(C^(1)) tensor M) and constant rank j+1: its degree is j+2>2
and H1 vanishes by Serre duality. The domain has constant rank ar-1.
Cohomology and base change make these vector bundles, and Cartier is
a relative bundle map. Its restriction to the specified section line
is locally a column of j+1 equations. Krull's height bound gives the
claimed component dimensions, also after restricting to reduced D.
The cases r=1,2 have j=0 and are not included in this constant-rank claim.

## 4. Why the linear residue class really survives

Let r=5k+2, k>=1. Then a=1 and M=O(kO1)theta. Over J1 the Cartier
map is a map of bundles of ranks5k+1 and k+1:

    H0(C,omega_C tensor V(M)) -> H0(C^(1),omega_(C^(1)) tensor M).

At theta=0 it is SURJECTIVE. Indeed the Cartier sequence has kernel
B_C, and Serre duality with B_C^vee tensor omega_(C^(1))=B_C gives

    H1(B_C(kO1))=H0(B_C(-kO1))^*=0.

The last vanishing follows by injection into H0(B_C)=0 (ordinarity).
The self-duality is the standard perfect Cartier pairing: the local
pairing of exact forms df,dg is C(f dg). Changing a primitive by a
local fifth power does not affect it, and pairing complementary
exponents in a local parameter proves nondegeneracy.
Thus near theta=0 the Cartier kernel is a rank4k vector bundle.
Its projectivization is precisely Z_r there, of relative dimension4k-1.

There is a point of its theta=0 fiber whose zero divisor is REDUCED.
For k=1 use alpha=(u-b)du. Its divisor is D-5O, where D is the five
finite branch points plus the two distinct points over b, since
div(du) is the finite branch divisor minus3O. Also alpha is exact:
alpha=d(u^2/2-bu).

For k>=2 put n=5k-1>=9. A general f in L(nO) has exact pole order n
at O, hence df has pole order5k. At every finite point P, the map
L(nO)->O_P/m_P^3 is surjective, since deg(nO-3P)>2. The conditions
that df have order at least2 are two independent linear conditions
(the linear and quadratic Taylor coefficients;2!=0). Their incidence
over the one-dimensional curve has dimension less than L(nO).
A general f avoids it, so df has only simple zeros away from O.
Its zero divisor has degree5k+2. This supplies the required point.

The reduced-divisor condition is open in the projective kernel bundle.
Its image in J1 is therefore a nonempty open U_k; after restricting to
that image, each fiber contains a reduced divisor. Prime-to5 torsion
is Zariski dense in J1, so each such theta gives actual root tensors
by Section2. The orders of N=V(theta)^e0 are unbounded: a bounded-order
condition defines only finitely many points under the finite isogeny
[e0]V, and prime-to5 torsion remains dense after removing any finite set.
For completeness, density follows because the Zariski closure of the
prime-to5 torsion subgroup is an algebraic subgroup; it cannot be
proper while containing every prime-to5 multiplication kernel.

Finally, for k=1 the explicit tensor is s=alpha^2 eta^5, of weight7.
One has s^3=alpha*(alpha eta^3)^5, so C_(C,4)(s^3)=0. Its divisor
is2D, and gcd(7,2)=1 shows that it is not a proper tensor power.

## 5. The same weight-seven profile on both selected endpoints

Let g>=3 and div eta=(2g-2)O. Set n=5g-6. The same three-jet argument
works because n-3>2g-2. A general f in L(nO) has exact pole n and
df has exact pole n+1=5(g-1), since n=-1mod5. Its finite zeros are
simple and form a divisor D of degree(2g-2)+5(g-1)=7(g-1).
Consequently s=(df)^2 eta^5 has divisor2D and weight7. The identity

    s^3=df*((df)eta^3)^5

proves Cartier-zero. As before gcd(7,2)=1 rules out any proper tensor
power. This needs no ordinarity. It applies to the fixed genus-nine X
using its subcanonical point, and to the fixed hyperelliptic genus25 Y.
The genus-two construction was supplied separately in Section4.

Suppose two such tensors actually agree through a coreless bi-etale
span. The primitive shared canonical generator then has weight7:
otherwise the endpoint tensor would be a proper power. In the notation
of [coreless_connection_spectrum](../../projective_connections/coreless_connection_spectrum.md),
the intrinsic rational connection r_s has, at each zero, double-pole
coefficient E(E+2)/4, E=e/d=2/7=1 in F5. This is3/4!=0. A shared
regular connection cannot cancel it: its difference q with r_s has
poles only along the shared support; q s^N would be a shared regular
tensor of weight2+7N, whose shared space is zero. Thus q=0, a
contradiction to regularity. This proves the stated conditional claim.
It emphatically does not assert that an actual matching span exists.

## 6. The strategic boundary

The singleton locus can be finite; its completed backup exclusion is
unchanged. For r=4 a nonempty relaxed reduced locus has positive
dimension, but no existence is asserted. For the infinite progression
r=5k+2 actual prime-to5 root data DO exist, with unbounded minimal
weights, on every ordinary genus-two curve. Therefore no endpoint-only
Cartier-root elimination can remove all larger clumps.

Nothing here constructs a common source, either finite etale leg, or
a realized clump. The missing condition remains the simultaneous
realization on the SAME curve of the two specified endpoint divisors
and tensors. Keeping that condition is necessary, not optional.
