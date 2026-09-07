# Proof: a harmonic four-point quotient and two different cubic covers

[Statement](../Theorems/Thm_nonliftable_hermitian_atlas_family.md).
We work over k=bar(F5); the group and quotient coordinates can all be
defined over F25. Uppercase X,Y,Z denote the coordinates on H, not the
fixed genus-nine counterexample candidate.

## 1. The complete quotient, including its branch positions

Let D be the projective diagonal C3 x C3 in G. The map

    H -> B: [X:Y:Z] |-> [A:B:C]=[X^3:Y^3:Z^3]

is its degree-nine quotient onto the conic A^2+B^2+C^2=0. It ramifies
with index3 precisely at the six coordinate-zero points of this conic.
Indeed, away from those points it is the coordinate Kummer torsor;
at one of them the other coordinates are units and the vanishing
coordinate has a simple zero on the smooth conic.

The remaining C3 cycles A,B,C. Put

    s=A+B+C, c=ABC, Delta=(A-B)(B-C)(C-A),
    a=c/s^3, b=Delta/s^3.

On the conic, AB+BC+CA=3s^2. The cubic discriminant identity gives

    Delta^2=s^6+3c^2,       hence b^2=1+3a^2.                 (1)

These are the full invariant functions: A/s,B/s,C/s are the three
roots of T^3-T^2+3T-a, and b is its discriminant square root. Their
splitting field over k(a,b) has degree at most3; the cyclic action is
faithful, so the degree is exactly3.

Choose beta^2=3 in F25, and put z=(b-1)/a, t=z/beta. Solving(1) gives

    a=beta*t/(t^2-1),       b=(4t^2-1)/(t^2-1).               (2)

The six coordinate-zero points have a=0 and descend to t=0,infinity.
The cyclic permutation's two fixed points on the conic have s=0:
they are [1:zeta:zeta^2] and [1:zeta^2:zeta]. They descend to t=1,-1.
They are disjoint from the coordinate-zero points. The conic quotient
is unramified elsewhere (a tame cyclic action can ramify only at fixed
points). Thus H->P1_t is Galois of degree27, with inertia3 at precisely
the four stated points. Both stages show the completed extensions are
the actual tame cubic extensions, not just an admissible signature.

The effective quotient stack is consequently the root stack with these
four cubic stabilizers. All generators preserve the Hermitian equation,
and G has order27. Projectively it is the indicated semidirect product;
its determinant character has kernel

    G0=<diag(zeta,zeta^2,1), cyclic permutation> = (C3)^2.

This kernel is contained in PSU. Its nonidentity elements have three
distinct norm-one eigenvalues, and their orthogonal eigenlines are not
isotropic. Thus G0 acts freely on H, as in the direct clock-and-shift
proof of `hermitian_genus_two_test`.

The function (XYZ)/s transforms by the determinant character and its
cube is a. Since beta has order8, beta^3 is a cube root of beta. Therefore

    w=(XYZ)/(beta^3 s),        w^3=t/(t^2-1).                 (3)

The degree-three subfield k(t,w) is the quotient by G0. Eliminating t
from w^3 t^2-t-w^3=0, using z_Q=2w^3 t-1, gives z_Q^2=1-w^6.
It follows in particular that H->Q is finite etale of degree9.

## 2. The second cubic curve and connectedness

Take the other Kummer cover

    u^3=t(t-1)/(t+1).                                       (4)

Its valuations at t=0,1,-1,infinity are1,1,-1,-1. It is connected,
tame, and totally ramified with index3 at all four points and nowhere
else. Riemann--Hurwitz gives genus2. Equivalently its field is

    t^2-(1+u^3)t-u^3=0,
    v=2t-(1+u^3),          v^2=u^6+u^3+1.                   (5)

The checked family `cubic_genus_two_common_covers` already gives
smoothness and ordinarity of C, Cartier-zero Q, and their nonsimple
Jacobians. Its normalized parameter4 at lambda3 changes to1 under
u->-u, giving precisely C up to scaling. The matrices are[0 2;2 0]
for C and zero for Q. We retain these exact checks in the small test,
but do not re-promote the known common-cover consequence as a new result.

Here is also a direct proof that Cartier is zero on ALL of H. In the
chart Z=1, a basis of its regular differentials is

    x^i y^j dx/y^5,             i,j>=0, i+j<=3.

The equation x^6+y^6+1=0 gives

    y=-(1/y)^5-(x/y)^5 x.

Expanding y^j in each basis differential writes it as a sum of fifth
powers times x^(i+r) dx, with0<=r<=j and i+r<=3. Cartier kills every
such term. This verifies the asserted vanishing directly in k(H).

Let T be the normalization of H x_(P1_t) C. It is connected. Otherwise
the two Galois function-field extensions, of groups G and C3, would have
nontrivial intersection, forcing k(C) into k(H). This would give a
separable map H->C. Pullback of regular differentials is injective and
commutes with Cartier; zero Cartier on H would then force zero Cartier
on C, contrary to the invertible matrix above. Thus the fields are
linearly disjoint, and the composite has group G x C3 over k(t).

At each branch point both completed fields are the unique tame cubic
extension of k((t-t0)), up to fixed-base isomorphism. Their tensor
product splits into cubic-field factors, so the normalization maps
are unramified there. They are etale away from the branch points too.
Therefore BOTH T->H and T->C are finite etale, of degrees3 and27.
In particular T is a smooth projective connected curve of genus28.
This is equivalently the actual fiber product over the common root stack.

Composing with H->Q gives T->Q finite etale of degree27. Its group is
G0 x C3=(C3)^3, since k(Q) is the index-three character subfield of k(H).
The other leg T->C has group G. This also proves the stated two-Galois-leg
common-cover example; no simultaneous closure was presumed before the
common quotient and field compositum were explicitly constructed.

## 3. Nonliftability and the family

The connected G-torsor T->C and its G-equivariant map to H give a
finite etale atlas C->[H/G]->[H/PGU]. The induced PGU-torsor is the
extension of this torsor's structure group, so its geometric monodromy
is exactly G, up to conjugacy. Its image under PGU/PSU=C3 is nontrivial:
for example diag(zeta,1,1) has nontrivial determinant-square character.
The character-line criterion in `hermitian_atlas_extension_criterion`
therefore makes tau nontrivial and forbids a PSU lift of THIS atlas.

For a connected degree-d etale cover C'->C, the index of the new
monodromy in G divides d: it is the index of U ker(rho) in pi_1(C),
where U has index d and rho surjects onto G. It also divides |G|=27.
If3 does not divide d, that index is1. The pullback atlas remains
connected in its G-presentation and nonliftable. Independently,
Norm_(C'/C)(pullback tau)=tau^d confirms that tau cannot become trivial.

For every d=2^r, a line bundle of exact order d on J(C) defines a
connected cyclic etale cover of degree d (all these orders are prime
to5). Its genus is d+1. In particular d=8 gives genus-nine examples,
and d unbounded gives the claimed family. None is identified with the
fixed genus-nine X, and this construction does not test all the other
possible atlas structures of its members.

The elliptic quotient of C from `cubic_genus_two_common_covers` pulls
back to a positive-dimensional proper abelian subvariety of J(C') for
every member of the family. Thus none of their Jacobians is absolutely
simple; this limitation is part of the statement, not an omitted condition.

## Exact arithmetic check

`scripts/hermitian_twisted_genus_two_check.sage` verifies(1)-(2), both
Kummer valuation lists including infinity, the two Cartier matrices,
the order27 projective group, exponent3, and its abelian PSU kernel of
order9. The report is
`Research/computations/nonliftable_hermitian_atlas_family_check.json`.
All checks pass. They are reproducible exact identities, not a sample
of points, and do not replace the global connectedness/etaleness proof.
