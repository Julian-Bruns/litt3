# Proof: elliptic isogenies and an exact section count

[Statement](../../Theorems/connections/ordinary_dihedral_spin_growth.md).
Author /root2026-09-08. This checks the boundary of a proposed spin-growth
obstruction; the constructed covers have just one specified endpoint.

Put E:v^2=G(x), and choose an elliptic origin at any point P_j=(j,0).
The hyperelliptic involution of E is then [-1]. The curve E is ordinary:
the coefficient of x^4 in G^2 is3. The curve Y is ordinary because its
Cartier determinant is3(t+1)^4, as checked symbolically in
family_singleton_root_exclusion. All branch points below are distinct.

## 1. A fixed etale double with elliptic quotient

Let T_0 be the smooth model of

    v^2=G(x), r^2=x-t, y=vr.

The two quadratic classes are independent, so this is a connected
biquadratic cover of P1. Its inertia over0,1,2,3 changes only v; its
inertia over t and infinity changes only r. The involution
j:(v,r)->(-v,-r) therefore acts freely, and its quotient is Y.
Consequently T_0->Y is etale of degree2 and g(T_0)=3.

The other map q_0:T_0->E is the double cover r^2=x-t. It branches at
the two points over x=t and at the two points at infinity of the quartic
model E: x has a simple pole at each infinity. Its branch divisor has
degree4. Write B_0 for its double-cover line, of degree2, so
q_(0*)O=O_E directsum B_0^-1. (The notation B_0 denotes a line bundle,
not a curve or the reduced branch divisor.)

The three nontrivial characters of the biquadratic cover give the
differential spaces of Y, E, and r^2=x-t. The last curve has genus0,
and 2+1=3 accounts for all differentials on T_0. Cartier preserves this
decomposition, since both character values +/-1 belong to F_5.
It is bijective on the Y and E summands. Thus T_0 is ordinary.

## 2. The connected Galois tower

Let v_n:E_n=E^(5^n)->E be the iterated Verschiebung isogeny. Because
E is ordinary, it is etale with cyclic geometric kernel C_(5^n).
Define T_n=T_0 x_E E_n. The ramified quadratic field k(T_0)/k(E) is
linearly disjoint from the odd-degree extension k(E_n)/k(E). Thus this
fiber product is connected and smooth. It is etale cyclic of degree5^n
over T_0, and T_(n+1)->T_n is etale cyclic of degree5.

The automorphism j of T_0 lifts to

    (P,r) -> (-P,-r) on T_n,

because x(v_n(-P))=x(v_n(P)). It fixes y=v(v_n(P))r and hence Y.
It has order2 and conjugates the kernel translations by inversion.
Together they give2*5^n automorphisms over Y, equal to the map's degree.
This proves the stated Galois group, without a normality assumption
about any unrelated second endpoint. Riemann--Hurwitz gives g=2*5^n+1.

An etale p-group cover of an ordinary curve is ordinary: the
Deuring--Shafarevich formula gives f(T_n)-1=5^n(f(T_0)-1), and the
same formula for g follows from etale Riemann--Hurwitz. Here both equal
2*5^n. A primary statement of the formula is Proposition1.4 of
[Yang, p-groups, p-rank, and semi-stable reduction](https://www.kurims.kyoto-u.ac.jp/~yuyang/papersandpreprints/PSS.pdf).

## 3. The spin space, not merely a lower bound

Fix i in {0,1,2,3} and P_i=(i,0) on E. Both maps are unramified at
the two points of T_0 over P_i, since r^2=i-t has two nonzero roots.
As divisors on T_0,

    f_0^*W_i=q_0^*P_i.

Set N=5^n, M_n=v_n^*O_E(P_i), and let q_n:T_n->E_n be the double
cover. Base change of the preceding identity gives f_n^*L=q_n^*M_n.
Also q_(n*)O=O_(E_n) directsum B_n^-1, where B_n=v_n^*B_0 has
degree2N and M_n has degreeN. The projection formula now gives

    h0(T_n,f_n^*L)
      =h0(E_n,M_n)+h0(E_n,M_n B_n^-1)=N+0.

For N>=5 the degree-N line on the elliptic curve is globally generated,
as is its pullback. This proves the final assertion as well. Notice that
the count concerns the pulled-back CLASSICAL spin line, not Raynaud's
theta divisor or the Cartier kernel on a root cover.
