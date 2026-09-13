# Proof: free involutions and the projective Sylow group

[Statement](../../Theorems/quotient_geometry/hyperelliptic_etale_quotients.md).

Every finite subgroup H⊂PGL₂(k) has at most three conjugacy classes
of involutions. If a Sylow two-subgroup P is nontrivial, its center
contains an involution z. Its two fixed points are preserved by P.
After moving them to 0,∞, the diagonal subgroup of P is finite cyclic;
any remaining element x→a/x has order two and inverts that subgroup.
Thus P is cyclic or dihedral, including C₂×C₂, with at most three
involution classes. Every H-involution is conjugate into P, proving
the bound. If P is trivial there are no involutions. This uses no
classification of all finite projective groups and allows wild H.

Let tau be the hyperelliptic involution and
H=Aut(C)/⟨tau⟩⊂PGL₂(k). A fixed-point-free involution sigma projects
to a nonidentity involution beta. Over a beta-fixed point of P¹, the
fiber has one or two geometric points. A one-point fiber rules out
freeness. On a two-point fiber the lifts sigma and tau sigma have
opposite permutations, so at most one is free. A projective involution
therefore has at most one free lift. Lifting a conjugator in H shows
that conjugate projective involutions have conjugate free lifts.
Their quotient curves are isomorphic. The three-class bound for H
therefore gives at most three etale double-quotient classes of C.

More generally, a finite group G acting freely on C meets ⟨tau⟩
trivially, hence embeds in H. For every nonidentity sigma∈G, its
projectivity has a fixed point. The cyclic group ⟨sigma⟩ preserves
the fiber above it and acts freely there, so its order divides that
fiber's cardinality, at most two. Thus G is elementary abelian of
exponent two. The preceding Sylow argument bounds its order by four.
This applies to the deck group of every finite etale Galois quotient.

Finally an etale double of a genus-two curve is hyperelliptic of
genus three. The nonzero two-class defining it is the difference of
two Weierstrass points. Put these at 0,∞ and write the base as

    v²=u∏_(i=1)^4(u−a_i).

The double has u=s² and w=v/s, hence
w²=∏_(i=1)^4(s²−a_i), a squarefree degree-eight hyperelliptic model.
This proves the genus-three corollary.

The [bounded audit](../../Research/audits/HYPERELLIPTIC_QUOTIENT_BOUND_AUDIT_2026_09_13.md)
checks the Sylow argument, unique free lifts and the Galois bound.
