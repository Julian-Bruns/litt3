# Proof: canonical intersection and exact primitive clump weight

[Statement](../../Theorems/common_covers/canonical_intersection.md).
The two subrings use the specified differential pullbacks.

## 1. A primitive shared tensor

Every nonzero weight space A_n is one-dimensional: the ratio of two
of its sections belongs to k(X) intersect k(Y)=k. If positive weights
occur, let d be their gcd. Choose finitely many nonzero a_i in A_(n_i)
and integers e_i with sum e_i n_i=d. The rational shared tensor

    t=product_i a_i^(e_i)

has weight d. For any nonzero a in A_n, write n=qd. The ratio t^q/a
has weight zero and belongs to both endpoint fields, so t^q=c a for
some c in k*. In particular t has no pole on either endpoint: a
positive power of a rational tensor is regular only if the tensor
itself is regular. Thus t is in A_d.

Its powers span every nonzero weight space, giving A=k[t] and the
Hilbert series. Distinct weights make t algebraically independent;
its weight and scalar ambiguity are unique. If no positive weight
occurs, A=k. This proof works for any pair of line bundles with a
specified pullback identification, and in every characteristic.
It uses no extraction of roots: t was constructed by integer powers.

The degree group is dZ, so no conclusion d=1 follows. For canonical
bundles the inherited Poisson bracket vanishes by the biderivation
rule and {t,t}=0, without making t central in either endpoint ring.

## 2. Shared sections and clumps

First note a useful rational strengthening of Section1. If tau is any
nonzero common rational tensor of weight m, then tau^d/s^m belongs to
both endpoint function fields and is a nonzero constant. For m>0 this
forces div(tau)=(m/d)div(s)>=0, so tau was regular and Section1 gives
d dividing m. For m<0 apply the same argument to tau^(-1); for m=0
use the coreless intersection directly. This proves the full rational
algebra k[s,s^(-1)] without any coprimality condition on divisor orders.

Write s=A theta_X^d=B theta_Y^d using the actual pullbacks. Then
delta^d=A/B. Conversely, any delta^m=A_m/B_m, with nonzero endpoint
functions, gives the common rational tensor A_m theta_X^m=B_m theta_Y^m.
The rational-weight conclusion therefore makes d the exact order of
[delta] in the displayed multiplicative quotient. This is equivalent
information in a useful scalar form, not a separate exclusion theorem.

For nonzero s=f*s_X=g*s_Y, etaleness gives

    div_Z(s)=f*div_X(s_X)=g*div_Y(s_Y).

Its support is nonempty because deg(s)>0 and g(Z)>=2, and is saturated
under both maps. Each positive multiplicity stratum is itself a clump.
The one-clump theorem therefore forces a uniform divisor eS and a
unique nonempty clump. Counting degrees gives all three identities
in the statement.

Conversely, suppose a nonempty clump S is GIVEN over Fbar5. Let D_X,D_Y
be its reduced images. Both ACTUAL maps are etale, so

    f*D_X=g*D_Y=S,
    r_X/h_X=r_Y/h_Y=|S|/(2g(Z)-2).

Write r_X=m a,r_Y=m b with gcd(a,b)=1. The same ratio gives
h_X=h a,h_Y=h b, with h=gcd(h_X,h_Y). The coprime positive integers
d_0=m/gcd(m,h), e_0=h/gcd(m,h) are thus exactly the primitive solution
of e r_i=d h_i. All integral solutions are (d,e)=(d_0 n,e_0 n).

The line bundles L_i=O_i(e_0D_i) tensor omega_i^(-d_0) have degree zero.
Every such bundle over Fbar5 is torsion, since its Jacobian point is
defined over a finite field. Let its exact order be q_i and put
q=lcm(q_X,q_Y). Triviality of L_i^q gives a regular section of
omega_i^(d_0q) with divisor e_0q D_i. Their pullbacks have the same
divisor on Z; their ratio is constant. Rescale one section to make
them equal. This constructs a positive shared tensor, hence A!=k.

## 3. Exact weight, endpoint roots, and both norm maps

Every positive shared tensor in the coreless setting has uniform
divisor on that unique clump. Its (d,e) therefore equals(d_0 n,e_0 n).
The endpoint divisor identities force L_i^n trivial, so q_i divides n.
Conversely the preceding construction works for n=q. The minimal
positive weight, hence primitive generator weight, is exactly d_0q.

Already L_i^(q_i)=O gives a regular tensor t_i of weight d_0q_i and
divisor e_0q_iD_i. The tensors s_i and t_i^(q/q_i) have identical
divisors, so differ by a scalar. This asserts an endpoint root, not a
root pulled back from the other endpoint.

The actual divisor/canonical equalities also give f*L_X=g*L_Y in J(Z).
If Hom(J(X),J(Y))=0, the reverse Hom group vanishes by Rosati adjunction.
Apply f_* to this equality:

    (deg f)L_X=f_*g*L_Y=0.

Likewise (deg g)L_Y=0. Thus q_X divides deg f and q_Y divides deg g,
proving the claimed divisibility for q. In particular prime support
of these orders is controlled by the degrees of the ACTUAL legs.
It is not legitimate to discard their common-pullback equality.

## Boundary

The external input is [Krishnamoorthy, Correspondences without a core](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
Theorem9.6 (unique clump). Proposition8.2 and Corollary8.10 give the
invariant-section context. Question9.7 leaves existence of a clump in
positive characteristic open. In characteristic zero, Corollaries8.13
and9.2 give A=k for a projective etale coreless span.

An arbitrary divisor is not a clump: its reduced support must pull back
to the SAME S under BOTH maps. The exact order formula only applies once
this compatibility exists. It does not produce it, determine p-ranks,
force d=1, or exclude a coreless span. Nor is the alternative A=k here
a constructed positive-characteristic example answering Question9.7.
