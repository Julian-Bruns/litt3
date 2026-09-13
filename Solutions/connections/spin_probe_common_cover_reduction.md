# Proof: two spin probes, actual field recovery, and descent of the common datum

[Statement](../../Theorems/connections/spin_probe_common_cover_reduction.md).
Author /root,2026-09-08. All field containments are inside the specified
common source and its finite etale extensions. Put m=p+2.

## 1. Two degree-two refinements supply the probes

The superelliptic curve X has a unique point O at infinity and

    theta=dx/y^(a-1),  div(theta)=(2g(X)-2)O,
    ord_O(x)=-a.

These follow from tame ramification at the simple finite roots of F,
total ramification at infinity, and Riemann--Hurwitz. Thus
A_X=O_X((g(X)-1)O) is a spin line with a section e satisfying e^2=theta.
The inequality g(X)-1>=a makes both e and xe regular sections of A_X.
On Y use the specified effective spin A_Y=L_0 and section e_Y with
e_Y^2=eta. Fix the displayed spin identifications.

For i=X,Y, the quotient N_i=L_i A_i^(-1) is a two-torsion line with
the square trivialization induced by the two spin identifications.
Its mu_2-torsor is finite etale (or use the identity if N_i is trivial).
Pull both torsors back to Z and take a connected component of their
fiber product. This gives V->Z of degree1,2, or4. Both original maps
remain finite etale and their embedded endpoint-field intersection
remains k: enlarging the ambient field does not change that intersection.

The tautological trivializations identify the pulled-back L_i with A_i
COMPATIBLY with squaring to omega_V. Consequently H0(V,L_V) contains
sections e_X, xe_X, e_Y whose squared differentials, and mixed product,
are precisely the pulled-back theta, x theta, and eta. These identities
persist on every T_n. A choice of sign in a torsor trivialization has no
effect on the squared forms or on the ratio x.

## 2. Both embedded endpoint fields lie in the spin quotient

Apply spin_series_etale_reduction starting from the actual span through V.
For n>=8 it supplies an etale phi:T_n->S and a compatible spin M on S,
with phi^*M=L_n and ALL spin sections descending. Hence theta and
x theta descend to regular differentials on S. Their ratio puts the
specified x in k(S). If beta is the descended theta, then

    z=dx/beta in k(S)

pulls back to y^(a-1). It is nonzero because the maps are separable.
Since y^a=F(x), the rational function F(x)/z in k(S) pulls back to y.
Thus the full embedded k(X), not just its rational x-subfield, lies
in k(S).

Likewise eta descends. Cartier naturality under separable pullback
makes Cartier(eta) descend too. By hypothesis they span H0(Y,omega_Y).
The elementary recovery argument of cartier_endpoint_recovery puts
k(Y) in k(S): canonical ratios give a hyperelliptic coordinate u and
the differential du/v then gives v. No assertion that e_Y descended
to the ORIGINAL spin on Y is needed; its square is the fixed form eta.

These two field inclusions extend to actual maps S->X,Y. Their composites
with phi are the original maps from T_n. Each is finite etale because
it is intermediate in an etale extension. Their field intersection is
still k, so the new common span is coreless.

## 3. Removing the remaining spin ambiguity

Field recovery alone would not identify M with the common spin: etale
pullback can kill a nontrivial two-torsion difference. We now remove it.

The common canonical tensor s_i=h_i^2 of weight m descends to S through
either endpoint. The two descended tensors agree, since they agree
after pullback along phi. They have divisor2D_S with D_S nonempty reduced,
because S->X,Y are etale. The intrinsic spin normal form therefore gives

    L_S=O_S(D_S) tensor omega_S^(-(m-1)/2),

its canonical spin isomorphism, and the common h_S in K(S,L_S).
This construction commutes with etale pullback, so phi^*L_S=L_n with
the original compatible square isomorphism. It also identifies L_S
with BOTH endpoint pullbacks and h_S with BOTH pulled-back sections.

The effectivity assertion of spin_primitive_matching_defect applies to
the actual coreless span X<-S->Y and gives H0(S,L_S)!=0. Choose 0!=u in
that space. Its pullback, viewed in H0(T_n,L_n), equals phi^*v for some
v in H0(S,M), by completeness. Under the fixed identification of the
two pullback lines, these are the same section. The rational isomorphism
L_S->M sending u to v therefore pulls back to the fixed global
isomorphism phi^*L_S->phi^*M. Its divisor is zero after finite pullback,
so is zero on S. It is a global isomorphism. The compatibility of its
square with omega_S follows after the faithfully flat etale pullback.

Thus M is the canonical common spin itself, h_S descends in that spin,
and its section space is the entire section space upstairs. By definition
of S as the ratio field of that complete space, its complete spin map
is birational and base-point-free.

For the specified characteristic-five family, Section4 of
family_small_torsion_specialization verifies independence of eta and
Cartier(eta) at every Weierstrass point; one may always use W=infinity.
The X-side uses only its degree-ten trigonal presentation, not any of
its coefficients, Jacobian decomposition, or finite oper enumeration.

The result replaces a hypothetical span by a more structured ACTUAL span.
It does not make a finite simultaneous Galois closure, and strict growth
of spin sections remains compatible with increasing genus and degree.

## Immediate additional consequence (author, beyond the version1 audit)

Each phi_n is also GALOIS. Indeed T_n is Galois over one of the original
endpoints, and S_n now contains that endpoint field. An extension normal
over a field remains normal over every intermediate field. This statement
is about T_n/S_n; it does NOT say S_n is Galois over both endpoints.
