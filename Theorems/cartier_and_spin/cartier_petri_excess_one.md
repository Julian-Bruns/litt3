# Three Cartier-kernel forms and the first complementary direction

Version1. Independently audited.

Let k be algebraically closed of characteristic p>2, let
B_C=F_(C/k)*O_C/O_(C^(1)), and write
K_C=H0(C^(1),B_C). The canonical alternating pairing gives

    mu_C: wedge^2 K_C -> H0(C^(1),omega_(C^(1))).

Suppose dim K_X=3 and mu_X is injective. Consider BOTH actual
finite etale maps X<-f-Z-g->Y from the same smooth projective
connected source, with Hom(JX,JY)=0 and p not dividing deg(f).
Suppose a(Z)=4. The f-trace-zero complement to f^*K_X in K_Z
is a line k*eta. Then

    Tr_(g^(1)) mu_Z(f^*K_X,eta) != 0
        implies generic_(L,M) h0(B_Z tensor f^(1)*L tensor g^(1)*M)=0.

More precisely, this nonzero-trace condition is equivalent to the
existence of an invertible FIRST-ORDER cup-product matrix at (O,O)
in the two-map parameter family. If the generic defect is positive,
it is1 and all three indicated second traces vanish. The first
traces of these mixed products vanish automatically.

No restriction on deg(g), ordinariness, joint minimality, genus-two,
nonhyperellipticity or marking hypothesis is used in this test. When
Y is ordinary, eta has both traces zero. If Y is nonordinary, then
a(Y)=1, eta is a g-pullback, and the displayed nonzero-trace condition
cannot hold. Its failure does not imply positive generic defect:
higher-order escape remains possible. The trace condition is not
proved for an arbitrary span with ordinary Y.

## The fixed genus-nine curve satisfies the kernel hypothesis

For the [fixed curve X](../../Definitions/fixed_pair.md),

    a(X)=3, p-rank(X)=6, and a_e(X)=3 for every e>=1.

Its three Cartier--Petri products are independent. In fact Cartier
is injective on their span, so these products are not Cartier-killed.
Thus the test above applies to any hypothetical Hom-zero span from
this X with 5 not dividing deg(f) and a(Z)=4.

[Human-readable proof](../../Proofs/cartier_and_spin/cartier_petri_excess_one.md).

Neither the pairing test nor generic vanishing itself excludes a
common cover. Both candidate common-cover problems remain open.
