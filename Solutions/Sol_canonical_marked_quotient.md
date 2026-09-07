# Proof: the canonical quotient of a reduced canonical marking

[Statement and audit scope](../Theorems/Thm_canonical_marked_quotient.md).
Original author: /root,2026-09-06. The finite-groupoid construction is
due to /root/finite_correspondence_groupoid_envelope. Write
c_p=4p/(p-4), with p>=5, and use div(s)=dD, D reduced, g(C)=g>=2.

## 1. Finiteness in EVERY weight

If p divides d, the canonical Frobenius connection on omega_C^d gives

    eta=(nabla s)/s.

This is a global regular one-form: locally s=x^d u(dx)^d, so
eta=du/u at a zero, and frame changes contribute d-th powers whose
derivatives vanish. It commutes with actual etale pullback.

If eta=0, ker(d:k(C)->Omega)=k(C)^p gives a unique regular tensor
s0 of weight d/p with s0^p=s and div(s0)=(d/p)D. Its exact preserving
relation is the same. Repeat horizontal extraction as necessary.
If instead eta!=0, put t=s/eta^d. Then

    dt/t=eta!=0, div(t)=d(D-div(eta)),
    deg(t)<=2d(g-1).

Thus t is separating. Every s-preserving image lies in the generically
reduced fiber product C x_(P1,t) C, so the SUM of all its etale-image
degrees is at most deg(t). For two endpoints, equality of tensor
pullbacks makes their eta forms simultaneously zero or simultaneously
nonzero; in the latter case the two separating functions also agree.
This proves finiteness of cross-images as well. If roots were first
extracted, use the reduced weight, which only improves the bound.

When the remaining weight is prime to p, the
[etale-root bound](Sol_etale_root_contact_bound.md) bounds each jointly
minimal self-image degree by c_p d(g-1), and likewise bounds cross-image
degrees for two fixed endpoints. A hyperbolic curve has finitely many
etale covers of bounded degree. For each such source W, its bounded-degree
maps to the other endpoint form a finite set: their Hom scheme is finite
type and has tangent space H0(W,h^*T_target)=0 by negative degree.
Hence there are finitely many exact preserving joint images in this case
too. A fixed scalar multiplier is handled by rescaling one tensor.

No inseparable root torsor is treated as etale. The nonhorizontal bound
2d(g-1) is at most c_p d(g-1).

## 2. Construct the quotient, then bound its WHOLE relation

Let F_s be ALL normalized jointly minimal exact s-preserving self-images.
It contains the diagonal and is closed under transpose and normalized
composition. Equality survives joint minimalization by injectivity of
separable tensor pullback, and both new maps remain etale by the tower
formula for differents.

The [finite-groupoid theorem](Sol_finite_correspondence_groupoid.md)
therefore gives an effective proper smooth DM curve S_s with

    C x_(S_s) C=disjoint_union_(Gamma in F_s) R_Gamma.

Tensor equality is effective descent data for s, giving beta on S_s.
The reduced divisor also descends to D_S, with div(beta)=dD_S.
Any effective atlas C->T to which s descends has self-relation a subunion
of F_s and factors uniquely C->T->S_s.

The nonhorizontal case in section1 already bounds the whole relation;
horizontal p-th roots do not change it. For the prime-to-p case, put
n=deg(C/S_s), L=omega_(S_s)(-D_S), and take the mu_d root torsor
trivialized by beta. Choose a component T->S_s of degree h|d and a
component C' of C x_(S_s) T of degree c over C. Then

    deg(C'/T)=n c/h,  g(C')-1=c(g-1).

The tautological form on the effective stack T becomes a simple-zero
one-form on C'. Its rational differential on the coarse curve satisfies
the [atlas contact corollary](Sol_contact_degree_bound.md#3-orbifold-atlases-use-the-same-reduced-union),
which bounds the WHOLE reduced self-fiber product. Hence

    n c/h<=c_p c(g-1),  so n<=c_p h(g-1)<=c_p d(g-1).  (1)

These component degrees account for possibly disconnected root torsors.

## 3. Different endpoints and scalar multipliers

Given one exact preserving span between(C,s) and(Y,t) of the same
weight, take ALL preserving images between the four ordered endpoint
pairs on C disjoint_union Y. Section1 makes each set finite. They form
a groupoid whose quotient is connected because the given cross-span is
surjective over both endpoints. Each endpoint alone is a surjective
atlas with its full self-relation, so this quotient identifies S_s with
S_t and their descended tensors. The cross-relation is exactly C x_S Y,
with distinct reduced component images by effectivity. This also supplies
a core, without presuming a Galois leg.

A span satisfying f^*s=lambda g^*s is exact between(C,s) and(C,lambda s).
Rescaling does not change the exact self-relation. The identified
quotients therefore give an automorphism of S_s preserving the line
k beta. Conversely any such automorphism yields its twisted fiber product
and actual etale self-spans.

Put G=Aut(S_s,k beta). Its multiplier character is injective: if phi
fixes beta, all components of C x_(S_s,phi) C belong to F_s, which already
identifies their endpoints. Hence phi is generically identity. The
generic isomorphism extends uniquely over normal curve atlases because
the relevant Isom space is finite and proper; extensions agree on
overlaps. Effectivity then makes phi identity globally.

The groupoid theorem proves Aut(S_s) finite. Thus G is a finite subgroup
of k^*, hence cyclic of prime-to-p order. The quotient

    S_[s]=[S_s/G]

is effective: a nonidentity automorphism cannot be generically trivial.
Its self-relation is precisely the union of the G-twisted fiber products.

## 4. Refinements and powers

For any connected finite etale a:C'->C and s'=a^*s, section3 applied
to C<-C'->C' (identity second leg) gives S_(s')=S_s with descended tensors.

For ANY r>=1, the equality(f^*s)^r=(g^*s)^r says their rational ratio
is a constant r-th root of unity. Section3 therefore identifies the
exact relation and quotient as

    S_(s^r)=[S_s/G[r]],  |G[r]|=gcd(|G|,r).            (2)

In particular p-th powers leave S_s unchanged. Conversely every
multiplier in G[r] fixes s^r, so no preserving image was lost.

The equivalence

    f^*(s^r) proportional to g^*(s^r)
       iff f^*s proportional to g^*s

proves that S_[s] is unchanged by all positive powers, scalars and connected
etale endpoint refinements. Thus an ACTUAL tensor root on such a refinement
has the same line quotient. Roots on ramified covers are not included.

## 5. Terminating composition closure and its Galois envelope

Let B=floor(c_p d(g-1)). Given finitely many actual exact preserving
self-spans, normalize their joint images, discard repetitions and close
under diagonal, transpose and normalized composition. Every new image
belongs to F_s and contributes a positive integer to its total degree,
which is at most B by(1). From an initial distinct-image total b0, at most
B-b0 successful image additions are possible. A round with no additions
certifies closure, and the groupoid theorem constructs the quotient
for those seeds. It need not equal S_s unless the seeds generate F_s.
This is a mathematical termination bound, not a claimed cover-enumeration
implementation.

NOW take the Galois closure W->S_s in the finite-etale covering category.
If n=deg(C/S_s), its faithful transitive monodromy G0<=S_n gives

    deg(W/C)<= (n-1)! <= (B-1)!.

The finite etale cover W->C is a curve scheme. Write C=W/A. Components
of C x_(S_s) C are quotients of W by A intersect hAh^(-1). Thus W
dominates every exact self-image and is Galois and etale over both copies
of C. This envelope is a CONSEQUENCE of the finite relation.
The line-preserving analogue uses S_[s] and atlas degree n|G|; the
displayed factorial bound concerns exact preservation.

## 6. Markings over Fbar_p and the fixed-genus partners

Over Fbar_p, every reduced effective D of degree2g-2 makes
omega_C(-D) torsion: its Jacobian point is defined over a finite field.
A trivialization at its order d supplies div(s)=dD; section1 includes
any p-primary part of d.

An actual span preserves D iff it preserves k s, since the quotient of
the two tensor pullbacks has divisor zero and is constant. Consequently

    S_(C,D)=S_[s]

is independent of tensor, trivialization and weight. For two choices,
take a common power; equal divisors give scalar-proportional tensors,
and section4 applies. The quotient is also unchanged by etale refinement.

For two marked endpoints of canonical degree, take a common multiple
of their torsion orders. If the same-source pullback markings agree,
the corresponding tensor pullbacks differ only by a constant, so their
line quotients agree and the span has a core. Over general algebraically
closed k this requires the degree-zero bundles to be TORSION.

Fix(C,D), let S=S_(C,D), and let D_S be its descended reduced marking.
The marked partners are exactly representable finite etale curve atlases
Y->S with D_Y the pullback of D_S: a connected component of C x_S Y
gives the converse span. For genus g(Y)=h>=2 their degree is forced to be

    deg(Y/S)=(h-1)deg(C/S)/(g-1).

The finitely generated pi1(S) has finitely many subgroups of that index,
so there are finitely many marked partners of genus h. This is the
post-audit immediate consequence recorded in the canonical statement.

Reducedness and degree2g-2 are essential. A uniform tensor zero order
e!=d, a shared Tango line, or a root on a ramified cover does not supply
this marking. No shared tensor or canonical-sized marking is known for
an arbitrary unmarked common cover; the original problem remains open.
