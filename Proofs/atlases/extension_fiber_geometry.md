# Proof: the fixed-bundle fiber and its normal space

[Statement](../../Theorems/atlases/extension_fiber_geometry.md).
Put A=H0(WL), E=H1(L^-2), and T=O_U(-1). The tautological injection
L^-1 T -> W has quotient L T^-1, so its extension class is a section
e of E T². Stability and deg L>0 give H0(WL^-1)=0; hence e never
vanishes and defines f:U->P(E), with f*O_P(E)(1)=T².
The connecting sequence also gives
ker[E -> H1(WL^-1)]=k eta_u on each admissible fiber; this kernel
is a line subbundle in families, so its pencil equations give the graph.

This is the fixed-bundle fiber construction from the geometry of
stable pairs. Over C compare Thaddeus,
[*Stable pairs, linear systems and the Verlinde formula*,
(3.20)](https://arxiv.org/pdf/alg-geom/9210007): his pair is
(E,phi)=(W L,u), with determinant Lambda=L². The direct argument
below also handles positive characteristic and nonreduced bases.

## The universal Hom line identifies the fiber

On the stable-middle open S subset P(E), let V be the universal extension

    0 -> L^-1 O_S(1) -> V -> L -> 0.

Locally, Rp_*Hom(W,V) is represented by a two-term vector-bundle
complex K0->K1 compatible with arbitrary base change
([Stacks0A1H](https://stacks.math.columbia.edu/tag/0A1H)).
Between stable bundles of the same rank and slope, a nonzero map is
an isomorphism and the Hom space is one-dimensional. Thus the kernel
dimension is at most one at every geometric point.

Let F subset S be the closed determinantal locus where that kernel
is nonzero. On F a maximal nonzero minor is locally invertible and
the next minors vanish. Row and column reduction therefore makes
the kernel M a line bundle, with arbitrary base change, and evaluation
gives an isomorphism W tensor M ~= V_F. The universal subline then
defines O_F(1) M^-1 -> A O_F, hence a map F->U.

Conversely a family in U has middle bundle W tensored by a base
line, so factors through F. Both composites recover the injection
and projective extension class; changes of middle-bundle identification
are scalar by stability. Hence F~=U as schemes, proving the immersion
and closedness in S. The line M is part of this construction;
no universal bundle on a coarse moduli space is used.

## Evaluation gives the normal bundle and its dual

Assume char k!=2 and H1(WL)=0. Evaluation on the universal section
gives an exact sequence

    0 -> L^-2 T² -> End_0 W -> WL T^-1 -> 0,              (1)

where a maps to a(u). In a frame beginning with u, evaluation of
[a b;c -a] is (a,c), and its kernel is the upper-right entry.
Since H0(End_0 W)=0, pushing (1) to U gives

    0 -> A T^-1 -> E T² -> H1(End_0 W) O_U -> 0.          (2)

The connecting map sends the radial section u to +/-2e:
a lift is diag(1,-1), whose change under an extension transition
is twice the extension cocycle. For a variation v of u, local lifts
a_i(u)=v identify its connecting cocycle a_i-a_j with the derivative
of the extension class. Quotienting (2) by the radial lines in the
two Euler sequences gives

    0 -> T_U -> f* T_P(E) -> H1(End_0 W) O_U -> 0.

The scalar line acts trivially on End_0 W. Thus this is the actual
constant normal bundle, of rank3g-3. The immersion is regular since
U and P(E) are smooth. The vanishing H1(WL)=0 holds for
deg L>=2g-2: its Serre dual is a stable bundle of nonpositive slope.

Fix eta_u in J subset E. The kernel inclusion in (1) sends b to
[v -> b det(u,v)u]. The trace identity
Tr(phi(u tensor det(u,-)))=det(u,phi(u)) makes the dual normal map

    q_u:H0(End_0 W omega)->E^vee,   phi |-> det(u,phi(u)).

Thus transversality with P(J) is equivalent to injectivity of q_u
modulo J^perp. If that map has kernel dimension d, the intersection
tangent dimension is dim P(J)-(3g-3)+d. In the fixed genus-nine case,
ell=24, dim A=32 and dim E=56, giving7+d. The local dimension is
at least7 wherever the intersection exists, by its24 defining equations;
independent differentials give smooth dimension7. For the Bol subspace
the test is precisely Q(det(u,phi(u)))=0 implies phi=0.
Neither nonemptiness nor this injectivity is a conclusion.

## The weak incidence is a Frobenius inverse image

In characteristic p, let Frob:P(J0)->P(J) be relative Frobenius
followed by a fixed linear identification J0^(1)~=J subset E.
Put Z=U x_P(E) P(J). Because f is an immersion, associativity gives

    U x_P(E) P(J0) = Frob^-1(Z)

scheme-theoretically. This is the admissible weak pencil incidence:
its constant-rank kernel line is exactly the graph of f.

Locally an equation h_i for Z pulls back to
h_i(b^p)=(h_i^[-1](b))^p, where [-1] takes coefficientwise pth roots.
Hence the reduced inverse image is the inverse coefficient-Frobenius
twist of Z_red. At a smooth codimension-c point of Z in P(J),
taking roots of a formal coordinate system gives the completed ring

    k[[z_1,...,z_m]]/(z_1^p,...,z_c^p).

Its transverse length is p^c; in the transverse genus-nine case it
is5^24. This thickness concerns the weak incidence. The full
normalized atlas scheme has its separately proved reduced structure.

Bounded scope audit: PASS, /root/audit_extension_fiber_scope,2026-09-14;
positive degree for the immersion and H1(WL)=0 for the normal formula.
