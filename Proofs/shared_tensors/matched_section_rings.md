# Proof: canonical intersection and exact primitive clump weight

[Statement](../../Theorems/shared_tensors/matched_section_rings.md).
Use the invariant line bundles L and Ω from the
[definitions](../../Definitions/canonical_tensors.md).

## 1. A primitive shared tensor

By [Krishnamoorthy, Proposition8.2](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf#page=32),
h0(L)<=1. Write A=direct-sum_(n>=0)H0(L^n); every nonzero graded piece
is one-dimensional. If positive weights occur, let d be their gcd.
Choose finitely many nonzero a_i in A_(n_i)
and integers e_i with sum e_i n_i=d. The rational shared tensor
\[
t=\prod_i a_i^{e_i}
\]
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

Now take L=Ω and assume A=k[s]. If tau is any nonzero common rational
tensor of weight m, then tau^d/s^m belongs to
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
\[
\operatorname{div}_Z(s)=f^*\operatorname{div}_X(s_X)
=g^*\operatorname{div}_Y(s_Y).
\]
Its support is nonempty because deg(s)>0 and g(Z)>=2, and is saturated
under both maps. Each positive multiplicity stratum is itself a clump.
By the same paper's Theorem9.6 there is at most one etale clump.
Thus the divisor is uniform, eS, and its support is the unique nonempty
clump. Counting degrees gives the three stated identities.

Conversely, suppose a nonempty clump S is given over k. Let D_X,D_Y
be its reduced images. Both ACTUAL maps are etale, so
\[
f^*D_X=g^*D_Y=S,\qquad
\frac{r_X}{h_X}=\frac{r_Y}{h_Y}=\frac{|S|}{2g(Z)-2}.
\]
Write r_X=m a,r_Y=m b with gcd(a,b)=1. The same ratio gives
h_X=h a,h_Y=h b, with h=gcd(h_X,h_Y). The coprime positive integers
d_0=m/gcd(m,h), e_0=h/gcd(m,h) are thus exactly the primitive solution
of e r_i=d h_i. All integral solutions are (d,e)=(d_0 n,e_0 n).

The line bundles L_i=O_i(e_0D_i) tensor omega_i^(-d_0) have degree zero
and canonically identified pullbacks. Their pair lies in
Pic0(X<-Z->Y), a finite group scheme by
[Krishnamoorthy, Lemma8.9](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf#page=34).
Hence both are torsion. Let their exact orders be q_i and put
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
\[
(\deg f)L_X=f_*g^*L_Y=0.
\]
Likewise (deg g)L_Y=0. Thus q_X divides deg f and q_Y divides deg g,
proving the claimed divisibility for q. In particular prime support
of these orders is controlled by the degrees of the ACTUAL legs.
It is not legitimate to discard their common-pullback equality.

In characteristic zero, Krishnamoorthy's Corollaries8.13 and9.2 give
A=k and no clumps. In positive characteristic the equivalence above
does not decide whether a clump exists on a given span.

## 4. Rational regularity and prime-to-characteristic weight

Every positive-weight common RATIONAL canonical tensor is regular,
even without assuming A!=k. Étaleness makes both its positive and
negative divisor supports saturated under the two fiber relations.
Its positive support is nonempty by its positive canonical degree.
A pole would therefore produce a second disjoint clump, contradicting
uniqueness. In particular, shared rational one-forms are regular and
form a k-space V of dimension at most one.

In the positive case the primitive canonical weight d is prime to p.
For if d=pm, the canonical Frobenius connection on omega^(pm) sends
s to a matched regular tensor of weight d+1. The weight restriction
in Section1 makes this zero. In a rational frame of omega^m, a
horizontal tensor has coefficient with zero differential, hence a
pth power in the actual endpoint field. Valuations make the root
regular. The two endpoint roots agree after pullback because their
pth powers agree. This contradicts primitivity of d. This elementary
argument is the prime-to-p step also used in the Cartier-generator
theorem; it does not require absence of shared one-forms.

The [saturated-divisor theorem](saturated_divisor_relations.md) uses
these two facts to compute the exact p-power root height. Its proof
also gives the differential description of first-power membership.
