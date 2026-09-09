# Proof: trace, affine descent, and a characteristic subgroup chain

[Statement](../Theorems/Thm_spin_section_neutral_galois_groups.md).
Author /root,2026-09-08. The action on pulled-back spin sections is the
canonical deck action, not a projectively chosen lift.

Put E=H0(C,A)=H0(T,q^*A). G acts trivially on this space. Serre duality
identifies the dual of

    q^*:H1(C,A)->H1(T,q^*A)

with the trace on the complementary canonical line. Because A is spin
and q is etale, that complementary line is A on C and q^*A on T.
The trace on the whole global section space is multiplication by deg(q),
under the displayed pullback identification. Consequently q^* on H1
is an isomorphism if p does not divide |G|, and is ZERO if p divides |G|.
Both H1 spaces have dimension r by spin Serre duality.

The kernel of this H1 pullback has a direct descent interpretation:

    ker(q^*:H1(C,A)->H1(T,q^*A)) = Hom_groups(G,E_add). (1)

Indeed H1(C,A) classifies additive A-torsors. A class killed by q admits
a trivialization upstairs. Differences between that trivialization and
its deck transforms are global sections of q^*A, hence elements of E.
They form a homomorphism because G acts trivially on E. Changing the
trivialization by a global section does not change this homomorphism.
Conversely a homomorphism gives a translation descent datum on the
trivial q^*A-torsor, and finite etale descent supplies an A-torsor on C.
It is trivial precisely when the homomorphism is a coboundary; here every
coboundary is zero. This proves (1), equivalently the first part of the
Cartan--Leray five-term exact sequence, without averaging by |G|.

The right side of (1) has k-dimension

    r * dim_Fp Hom(G,Fp).

If p divides |G|, the left side is all of H1(C,A), of dimension r>0.
Thus dim_Fp Hom(G,Fp)=1. For a prime-to-p group the dimension is zero.

For any subgroup H<=G put C_H=T/H. All the maps are etale, and

    H0(C,A) -> H0(C_H,A|_(C_H)) -> H0(T,q^*A)

are injective with isomorphic composite. Each is therefore an isomorphism;
the pulled-back line is still a spin. Applying the preceding argument to
T->C_H proves the asserted dimension formula for EVERY subgroup H.

Let p^a be the p-part of |G|. If a>0, the one-dimensional space Hom(G,Fp)
gives a unique kernel G_1 of index p; it is characteristic in G. Whenever
p divides |G_i| the same subgroup result gives its characteristic index-p
kernel G_(i+1). After a steps N=G_a is characteristic in G and prime to p.
The quotient P=G/N is a p-group, and

    Hom(P,Fp)=Hom(G,Fp)

has dimension one. Thus P has a unique maximal subgroup. Any element
outside that subgroup generates P, since a proper cyclic subgroup would
be contained in a maximal subgroup. Therefore P is cyclic. A Sylow
p-subgroup of G maps isomorphically to P, proving both formulations.
No classification of finite simple groups or normal-complement theorem
is needed.

Finally U=T/G_1 is the unique degree-p intermediate cover (every subgroup
of index p here contains N and comes from the unique index-p subgroup
of the cyclic quotient). Its spin section space is still E, so the trace
argument makes H1(C,A)->H1(U,q_U^*A) zero. Applying the natural spin
primitive exact sequence to h proves existence of a global regular
primitive of q_U^*h. Only sections inherited from C are claimed to have
this property, not all of K(U,q_U^*A).

For prime-to-p |G|, injectivity on H1 instead makes a primitive obstruction
vanish downstairs whenever it vanishes upstairs. These statements also
explain why a surviving cyclic p-part cannot simply be discarded.

The application uses the actual containment of both endpoint fields in
S_n: since T_n is normal over one endpoint, T_n/S_n is Galois. Its entire
spin-section space descends and the common spin is effective. Nothing
asserts normality of S_n over both endpoints.

Background: [finite-etale trace](https://stacks.math.columbia.edu/tag/03SH)
and its Serre-dual interpretation; (1) is proved directly above by
descent of additive torsors. No scheme-theoretic ramification argument
is replaced by a condition on just the covering degree.
