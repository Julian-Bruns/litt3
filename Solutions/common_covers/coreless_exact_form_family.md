# Proof: exact local absorption separated from global disjointness

[Statement](../../Theorems/common_covers/coreless_exact_form_family.md).
User-supplied Pro construction, generalized by /root,2026-09-08.
The construction and parameter extension have a medium prose audit PASS;
the last two corollaries below are author arguments. No simultaneous
Galois closure of the TWO endpoint maps is assumed.

## 1. The seed and its differential

Directly in S one has x-y=z^5, z^2=3xy and

    (xy)^5-xy=2x^2+2y^2,
    z=4(x-y)/(xy)^2, w=(x+y)/z.

Thus S=k(x,y), and v=xy-u satisfies v^5-v=2y^2. The squarefree
degree-eight hyperelliptic model has genus3 and two points A,B at
infinity. Together with the two points R_+,R_- over z=0,

    div x=R_++R_-+3B-5A,
    div y=R_++R_-+3A-5B,
    dx=dy=4 dz/w, div(dx)=2A+2B.

For example w=z^4+4z^-4+... at A, giving x=z^5+2z^-3+...,
y=2z^-3+.... The projections have degree5, are tame of index3 at
the finite special zero, wild of index5 at the pole, and unramified
elsewhere. The different at the pole is12, from ord(dx)=2 and pole5.

## 2. Endpoint geometry for EVERY allowed a

E:k(x,u), u^5-u=2x^2 is a separable degree-five Artin--Schreier
cover of the x-line, since the pole order of 2x^2 is2. Its hyperelliptic
model has genus2, unique infinity O, ord_O(u)=-2, ord_O(x)=-5,
and div_E(dx)=2O (du=x dx). At P_c=(x=0,u=c), c in F5,
x is a parameter; u has order2 for c=0 and is a unit otherwise. Hence

    div_E(ux^2)=4P_0+2 sum_(c!=0) P_c-12O.

Since a=3n is odd and prime to5,

    gcd(a,4)=gcd(a,2)=1, gcd(a,12)=gcd(a,6)=3.

The Kummer extension r^a=ux^2 has degree a, total index a at the five
P_c, and three points of index n=a/3 above O; it is unramified elsewhere.
Tame pullback sends differential order m to e(m+1)-1. Thus all eight
points have order a-1, and there are no other zeros or poles of dx.
Its canonical degree is8(a-1), giving genus4a-3. Symmetry proves this
for Y. Both exact forms are nonzero, and match on the specified L.

## 3. All completed factors give BOTH etale maps

At A, y vanishes. Hensel's lemma supplies b in S_A with
b^5-b=2y^2. Then xy-b satisfies U^5-U=2x^2. That polynomial defines
a degree-five extension of k((1/x)), so this embedded extension equals
S_A. Every Artin--Schreier conjugate is also in S_A. At B exchange x,y.

Above x=0, all endpoint completions are the unique tame degree-a
extension. Above infinity they are the degree-five Artin--Schreier
extension followed by the unique tame degree-n extension. Elsewhere
they are trivial. Units have all prime-to5 roots in these complete
fields with algebraically closed residue field; consequently tame
extensions of each degree are unique as EMBEDDED subfields of a fixed
separable closure, not just abstractly isomorphic. This is also the
local content of [Stacks, Abhyankar's lemma](https://stacks.math.columbia.edu/tag/0EXT).

Over S_A the x radicand ux^2 has order -12. The y radicand vy^2 has
order12 if v specializes to0 and order6 on every other branch. All
these a-th-root factors therefore have tame degree n. At B the same
holds symmetrically. At each R_+,R_-, the orders are4 or2, so every
factor has tame degree a. At all other points both extensions split
locally. Thus the completed factors of SK_X/S and SK_Y/S are the SAME
fields: degree n at A,B, degree a at R_+,R_-, trivial elsewhere.

Their compositum L adds nothing locally. Its completed degree over the
x-base is5n at A,3n=a at B,a at R_+,R_-, and1 elsewhere. These equal
the degrees of the contained X-completions, proving every local
extension for Z->X trivial. Symmetry proves Z->Y etale. All statements
include n=1: degree-one tame extensions cause no exception.

## 4. Seed corelessness by strict rational-function degree descent

Suppose M=k(x) intersect k(y) is nonconstant. The involution
(z,w)->(-z,-w) exchanges x,y, so M_0=M^sigma is nonconstant and
its elements have the form R(x)=R(y) with the SAME R in k(T).
The derivation D with Dx=Dy=1 preserves M_0 and is nonzero there:
otherwise every such nonconstant R is a fifth power in k(T), and its
unique fifth root still gives an equality fixed by sigma. Indefinitely
repeating this contradicts positive rational-function degree.

By Luroth, M_0=k(q); write Dq=b(q)!=0. Pullback of beta=dq/b(q)
to the x-line is dx. This pullback is separable. The differential beta
has no zeros, since a zero pulls back to one, even with wild ramification.
Cartier naturality and injectivity of separable differential pullback
give Cartier(beta)=0. A zero-free rational differential has either a
double pole or two simple poles. Cartier-zero excludes simple poles.
Hence beta=dt for some rational coordinate t, after scaling, and there
exists R in k(T) with R(x)=R(y) and R'=1.

Choose such R of minimum degree and write R=T+P^5. Then

    P(x)-P(y)=-z,
    Dz=4w, Dw=z^7, D^4z=4z^5=4(x-y).

Four derivatives give P^(4)(x)-P^(4)(y)=x-y. Thus
R_1=T-P^(4) satisfies the same equality and R_1'=1, because the
fifth ordinary derivative of any rational function vanishes in char5.

P must have a pole at infinity: otherwise R has a simple pole there,
and R(x) has pole order5 at A, whereas any pole of R(y) has order
divisible by3. Write n_infinity>0 and n_c>0 for P's pole orders.
R has orders5n_infinity and5n_c. R_1 has no new finite poles, with
orders at most n_c+4<=5n_c, and infinity order at most
max(n_infinity-4,1)<5n_infinity. Summing yields strictly smaller
rational-function degree, a contradiction. Hence M=k.

## 5. The ACTUAL endpoint intersection remains k

The seed's degree-five minimal polynomial over k(x) is

    F_x(T)=T^5-2x^-5 T^2-x^-4 T-2x^-3.

It has F_x'=x^-5(T-x), F_x(x)=x^5 and discriminant -x^-20,
a square. The transitive monodromy is contained in A5 and contains
a3-cycle from the ramification pattern(3,1,1) over0. It is A5:
a proper subgroup of order divisible by15 would have order15 or30;
order15 contradicts the order-ten normalizer of a5-cycle, and order30
contradicts simplicity of A5. The y-leg is identical.

The normal closure of K_X/k(x) is obtained over the cyclic degree-five
Artin--Schreier field by adjoining a-th roots of (u+c)x^2, c in F5.
Its kernel is abelian of exponent dividing a, so its group is solvable.
Its intersection with the A5 Galois closure of S/k(x) is therefore
trivial over k(x). Consequently S and K_X are linearly disjoint;
the analogous statement holds for K_Y over k(y).

For h in K_X intersect K_Y inside L, its monic minimal polynomial
over S remains the one over k(x), by this linear disjointness; the
same polynomial is its minimal polynomial over k(y). Its coefficients
lie in their intersection k. Algebraic closedness gives h in k.

Also [SK_X:K_X]=5 and L=SK_X(s), with s^a in SK_X. Since roots of
unity are present, [L:SK_X] divides a; hence both leg degrees divide5a.

## 6. Author corollaries and what they do NOT repair

The case a=3 is also a GLOBAL sharpness example for
[shared_tensor_core](../../Theorems/common_covers/shared_tensor_core.md): simple zeros
force a core, but double zeros already need not, even for exact forms.
The common one-form generates the shared canonical ring, so its primitive
weight is1. By [coreless_connection_spectrum](../../Theorems/common_covers/coreless_connection_spectrum.md),
the a=3 example has NO common regular projective connection, whereas
the a=9 example DOES have such connections and a dormant one. Thus the
same construction works on both sides of that distinction; no universal
repair based on either exactness or connection existence follows.

For a=3 put h=x/r. Directly x=u h^3, r=u h^2, and
u^4-2u h^6-1=0. The pole divisor of h consists of the point above
P_0 and the three points above O, all simple. Thus deg h=4.
A degree-three pencil would generate the function field together with
h, since their degrees are coprime. Castelnuovo--Severi would then
give genus at most(3-1)(4-1)=6, contrary to genus9. These endpoints
are not the fixed trigonal genus-nine X.

Now let ell be prime and ell not divide5a. Connected cyclic etale
degree-ell endpoint covers exist from nonzero ell-torsion line bundles.
Their fields A'/K_X and B'/K_Y are each linearly disjoint from L,
because [L:K_X] and [L:K_Y] divide5a. In L'=LA'B', the two maps
from its smooth curve to the new endpoints are etale by base change.
If h lies in A' intersect B', its minimal polynomial over L is both
its polynomial over K_X and over K_Y, by the two disjointness statements.
Its coefficients lie in K_X intersect K_Y=k, so h in k. This proves
corelessness, with genus and zero counts multiplied as in the statement.
It does not presume that [L':L]=ell^2 rather than ell.

Therefore even matching genus225 or having a zero count divisible by7
is not, by itself, a viable repair of the false order-eight lemma.
The active root endpoints also have a SPECIFIC cyclic7 action ramified
at all zeros, and a genus29 endpoint; neither is supplied by this family.
No claim that imposing these extra data forces a core is justified.

[Exact arithmetic check](../../scripts/common_covers/coreless_exact_form_family_certificate.sage)
replays the field identities, fourth-derivative descent identity,
discriminant and elementary parameter formulas. The prose above, not
finite sampling, proves the assertions for all allowed n and all places.
