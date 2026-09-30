# Frobenius and Cartier constraints on a primitive invariant

ID: `cartier_generator`. Version4.

Let k be algebraically closed of characteristic p>0, and let
X←Z→Y be an actual coreless finite étale span of smooth projective
connected hyperbolic curves. Suppose its matched canonical ring is
A=k[s], with primitive weight d>0. Use the
[twisted Cartier operators](../../Definitions/canonical_tensors.md) C_n,
from weight pn+1 to weight n+1, with inverse-Frobenius scalar convention.

The [canonical-ring theorem](../shared_tensors/matched_section_rings.md)
gives \(p\nmid d\). Choose 1<=r<=p−1 with rd≡1 mod p, and put
n=(rd−1)/p. The complete Cartier alternative is

    C_n(s^r)=0                  if d does not divide p−1;
    C_n(s^r)=c s, c∈k           if d divides p−1.

In the second case r=p−(p−1)/d and n=d−1; c may be zero. Every
eligible exponent is r+pq, q>=0, and

    C_(n+qd)(s^(r+pq))=s^q C_n(s^r).                       (1)

Every positive zero multiplicity e of s satisfies e+d≠0 mod p.
For a uniform clump divisor eS, an endpoint image of size t and
canonical degree h=2g−2 satisfy et=dh. If p does not divide h, then
p divides neither e nor t, and t≠−h mod p. At p=5 this excludes
image sizes0,4 mod5 in genus9 and0,2 mod5 in genus25.

There is also a bounded test on just one endpoint. If s_X=v^m,
where v has weight b and d=bm, choose 1<=a<=p−1 with ab≡1 mod p,
put n_b=(ab−1)/p, and write mr=a+pj. Then j>=0 and

    C_n(s_X^r)=v^j C_(n_b)(v^a).                            (2)

Thus when d does not divide p−1, the fixed root test
C_(n_b)(v^a)=0 is necessary independently of m.
If s_X=beta^d for a regular one-form beta, then

    C(beta)=0                   if d does not divide p−1;
    C(beta)=c beta              if d divides p−1.

The same applies at either endpoint; the root need not descend through
the other map. For p>=5, if every Cartier eigenform on an endpoint
(including eigenvalue zero) with uniform positive zero multiplicity
has simple zeros, no nonzero matched weight-M tensor can be the
M-th power of a regular one-form on that endpoint.

These assertions do not produce an invariant, force d to divide p−1,
or assert that its Cartier image is nonzero.
[Proof and sources](../../Proofs/cartier_and_spin/cartier_generator.md).
