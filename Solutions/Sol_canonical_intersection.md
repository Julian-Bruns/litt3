# Proof: canonical intersection and exact primitive clump weight

[Statement](../Theorems/Thm_canonical_intersection.md).
Version2,2026-09-07; author prose, not independently audited.
The two subrings use the ACTUAL etale differential pullbacks.

## 1. Normality saturates precisely the generated degree group

Corelessness makes every graded component A_n at most one-dimensional:
the ratio of two nonzero sections of the same weight lies in
k(X) intersect k(Y)=k. Both full endpoint section rings are normal.
Indeed after choosing a rational frame, a section ring is the
intersection of k(C)[T] with weighted Gauss valuation rings enforcing
regularity of each homogeneous coefficient. These rings are integrally
closed. An element of Frac(A) integral over A lies in each endpoint
fraction field and is integral over each ring, hence belongs to both.
Thus A is normal, without a finite-generation assumption on A.

If positive degrees occur, let d be their gcd. Choose finitely many
nonzero a_i of degrees n_i and integers e_i with sum e_i n_i=d.
Then t=product a_i^(e_i) is a homogeneous element of Frac(A) of weight d.
For any nonzero a in A_n, n=q d, the degree-zero fraction t^q/a belongs
to both endpoint function fields, hence is a nonzero scalar. Thus t is
integral over A and belongs to A_d. Its powers and the one-dimensional
component bound give A=k[t] with the stated Hilbert series. Distinct
weights make its powers algebraically independent. Otherwise A=k.
This works when the characteristic divides q; separability is unnecessary.

The saturation is inside dZ, not all Z: no conclusion d=1 follows.
The inherited Poisson bracket is zero by the biderivation rule and
{t,t}=0, not because t is central in either larger ring.

## 2. Shared sections and clumps

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
