# Fixed stable bundle inside the projective extension space

2026-09-07. Bounded author proof, not independently audited.
[Statement](../Theorems/Thm_extension_fiber_geometry.md).
This is geometry of one fixed-bundle extension fibre, not an exclusion of
an atlas or of an actual two-map common cover. The original problem is
unsolved.

Let C be a smooth projective connected curve over an algebraically closed
field k, of genus g>=2. Let W be stable of rank two, with det W identified
with O_C, and let deg L=ell>2g. Put A=H0(WL), E=H1(L^-2), and let
U be the open subset of P(A) of nowhere-zero sections. Write

    f: U -> P(E),    [u] |-> [eta_u].

Here eta_u is defined by the exact sequence in
[the extension conventions](../Definitions/Def_rank_two_extension_space.md).
The map is regular, for instance by its constant-rank kernel-line
construction in [the extension pencil proof](../Solutions/Sol_rank_two_extension_pencil.md).

## Statement

The map f is a locally closed immersion. If char k !=2, its tangent and
normal bundles fit into a natural exact sequence

    0 -> T_U -> f* T_P(E) -> H1(End_0 W) tensor O_U -> 0.       (1)

In particular the normal bundle is constant of rank 3g-3. The image is
closed in the open subset of projective extension space parametrizing
stable middle bundles. The proof uses an actual universal extension and
does not assume that the stable coarse moduli space has a universal bundle.

## Scheme-theoretic immersion, including nonreduced tests

On C x P(E) there is a universal extension

    0 -> L^-1 tensor O_P(E)(1) -> V -> L -> 0.               (2)

It is obtained from the tautological section of E tensor O_P(E)(1).
Let S be the open subset where the middle bundle is stable, and let p be
projection to S. Locally on S represent Rp_*Hom(W,V) by a two-term
complex of vector bundles K0 -> K1. Such a complex exists, commutes with
arbitrary base change, and has amplitude [0,1]: one can construct it
directly using a sufficiently positive fixed divisor on C, pushing the
restriction sequence to that divisor. This is also an instance of
[perfectness and base change, Stacks 0A1H](https://stacks.math.columbia.edu/tag/0A1H).

Two stable bundles of the same rank and slope have a nonzero homomorphism
only when they are isomorphic, and their Hom space then has dimension one.
Consequently every geometric fibre of K0 -> K1 has kernel dimension at
most one. Define F in S by the minors imposing kernel dimension at least
one. Its local determinantal definitions glue (equivalently use Fitting
ideals of the cokernel, with the rank shift). On F the matrix has constant
rank rank(K0)-1 *scheme-theoretically*: an appropriate minor of that size
is a unit locally, and all larger minors vanish in O_F. Elementary row
and column operations then put it in a block matrix with an identity block
and a zero block. Its kernel M is therefore a line bundle, its formation
commutes with arbitrary base change, and

    M = p_*Hom(W,V_F).

The evaluation map W tensor M -> V_F is an isomorphism. Indeed it is an
isomorphism on each geometric fibre by stability, hence everywhere, by
the determinant criterion for a map between vector bundles. The inclusion
in (2) now supplies a line subbundle

    O_F(1) tensor M^-1 -> A tensor O_F,

and hence a morphism F -> U. Its section is nowhere zero on every curve
fibre because the quotient in (2) is a line bundle.

Conversely a family in U gives the middle bundle W tensored by a base
line bundle, so factors through the indicated determinantal scheme F.
These constructions are inverse as families: the projective extension
class is unaffected by changing identifications of either end by a unit,
and stability says that identifications of the middle bundle differ only
by a scalar. More explicitly, after trivializing the base line bundles,
both composites recover precisely the original injection and extension;
these local identities descend. Thus U is isomorphic to F as a scheme,
not just on geometric points. This proves the locally closed immersion.

The scalar line M is retained throughout. In particular no square root of
O_S(1) or universal bundle on a coarse moduli space is presumed. Over F,
evaluation and determinants themselves give M^2 = O_F(1).

## Tangent and normal sequence in characteristic different from two

Let T=O_U(-1), with its universal inclusion L^-1 T -> W on C x U.
Evaluation on that section gives the exact sequence of vector bundles

    0 -> L^-2 T^2 -> End_0 W -> WL T^-1 -> 0.              (3)

The right map sends a trace-zero endomorphism a to a(u). In a local
frame with u the first basis vector, a trace-zero matrix has the form
((a,b),(c,-a)); evaluation returns (a,c), and its kernel consists of
the upper-right entries. This identifies the kernel with L^-2 T^2.

Stability and char k !=2 give H0(End_0 W)=0. Stability and ell>2g give
H1(WL)=0 by Serre duality. Pushing (3) to U gives

    0 -> A T^-1 -> E T^2 -> H1(End_0 W) tensor O_U -> 0.   (4)

Let e be the universal extension section in E T^2. It never vanishes,
since H0(WL^-1)=0, so its connecting class is nonzero. The extension
construction gives f*O_P(E)(1)=T^2. The two Euler sequences are therefore

    0 -> O_U -> A T^-1 -> T_U -> 0,
    0 -> O_U --e--> E T^2 -> f*T_P(E) -> 0.

The connecting map in (4) sends the radial section u to +/-2e. To see
the factor, use determinant-compatible local splittings of
0 -> L^-1 -> W -> L -> 0: a lift of u through evaluation in (3) is the
diagonal trace-zero matrix diag(1,-1); conjugating by the upper-triangular
extension transition changes its upper-right entry by twice that
extension cocycle. The sign depends on the Cech convention.

More generally, lift a first-order variation v of u to local trace-zero
endomorphisms a_i with a_i(u)=v. The changes of frames 1+epsilon a_i
identify the varied injection with the original one; their differences
a_i-a_j are the kernel cocycle of (3). This identifies the induced map
A/ku -> E/ke with df, up to the same harmless global sign. Quotienting
(4) by the radial and extension lines proves (1), since 2 is a unit.
Equivalently the last map is the Kodaira-Spencer map for the middle
bundle. Scalar changes act trivially on End_0 W, so this is a constant
normal bundle without a residual scalar or Brauer twist.

Because both U and P(E) are smooth, the locally closed immersion is
regular. Formula (1) is its actual normal bundle, not merely a count of
expected dimensions. In characteristic two the immersion proof still
works, but the displayed normal formula must not be imported: scalars
lie in End_0 W, and the factor two in the radial computation vanishes.

## Application and limitations

For g=9 and ell=24, dim A=32, dim E=56, and h1(End_0 W)=24.
Thus U is a smooth open part of P31 immersed in P55 with normal rank24.
For any linear P31 in P55, its inverse image is locally defined on U by
24 equations. At every point of this inverse image its local dimension
is at least 31-24=7, by the height bound for an ideal with 24 generators.
No nonemptiness follows: the closure can meet the linear space entirely
on the inadmissible boundary. No smoothness follows: the 24 equations
need not have independent differentials. If they do at a point, the
intersection is smooth of dimension exactly seven near that point.

This can strengthen a weak-incidence dimension statement *at admissible
solutions*. It does not establish admissible solutions, generic
transversality, Frobenius-line preservation, a full atlas, or an exclusion.

## Exact dual transversality test

Fix J subset E containing eta_u and put K=J^perp in H=H0(L^2 omega).
The inclusion defining the normal map sends b in L^-2 to the trace-zero
endomorphism v |-> b det(u,v)u. Under the trace pairing on End_0 W,
its Serre dual is therefore

    q_u:H0(End_0 W omega)->H,   phi |-> det(u,phi(u)).

This follows directly from Tr(phi(u tensor det(u,-)))=det(u,phi(u));
there is no factor2, unlike the radial calculation above. Thus the
intersection with P(J) is transverse exactly when q_u modulo K is
injective. If its kernel has dimension d, the intersection tangent
dimension is dim P(J)-(3g-3)+d, hence7+d in the fixed case. The full
q_u is injective by dualizing(3) and using H0(WL^-1 omega)=0. Stability
does NOT imply injectivity modulo K: one can choose K containing a
nonzero q_u(phi), which already annihilates eta_u.

For the actual Bol subspace K=ker Q, the remaining condition is precisely

    Q(det(u,phi(u)))=0 ==> phi=0,
    phi in H0(End_0 W omega).

Both maps must undergo the same coefficient-Frobenius transport. This
is a concrete criterion, not a proved vanishing for the Bol subspace.

## Frobenius thickening in the weaker equations

Let char k=p>0. Let J0 be a vector space with an injective linear map
J0^(1)->E, and denote its image by J. Write F:P(J0)->P(J) for relative
Frobenius followed by this identification. On the admissible locus put

    Z=U x_P(E) P(J),    Omega=U x_P(E) P(J0),

where the second map uses F. Since f is an immersion, Z is a locally
closed subscheme of P(J), and associativity of fibre products gives

    Omega = F^-1(Z)  scheme-theoretically.                 (5)

The constant-rank pencil equations N(u)c=0 describe the graph of f on
U, including nonreduced bases: its kernel is a line subbundle. Thus(5)
also describes exactly the weaker equations N(u)F(b)=0, not only their
geometric points.

On a compatible affine chart, if Z has ideal (h_i), Omega has equations
h_i(b_1^p,...,b_m^p)=(h_i^[-1](b))^p. Here [-1] raises COEFFICIENTS to
their unique p-th roots. Consequently Omega_red is the coefficient-
Frobenius inverse twist of Z_red. If Z is smooth of codimension c at a
point, its completed preimage ring at the unique geometric preimage is

    k[[z_1,...,z_m]]/(z_1^p,...,z_c^p).

This follows by taking p-th roots of the coefficients of a formal
coordinate system defining the smooth Z. Its transverse length is p^c,
although its support has dimension m-c. In genus9, at a transverse
admissible linear-section point, m=31,c=24 and this length is5^24.
Neither existence of such a point nor transversality of all points is
asserted. Away from the admissible locus the graph argument must not
be used to discard boundary components.

This distinguishes repeated Frobenius equations from distinct geometric
candidates. It does not automatically give low-degree generators of the
radical. In particular the original full normalized atlas scheme is
already reduced; the thickening concerns ONLY its weaker N-equations.
