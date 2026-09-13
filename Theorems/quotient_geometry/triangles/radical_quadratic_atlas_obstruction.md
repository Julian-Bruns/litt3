# Radical quadratic obstructions and the active triangle boundary

Version2,2026-09-09. Author proof; no independent whole-theorem audit.

Let C/k be a smooth projective connected curve of genus>=2 in
characteristic5. Let f:C->P1 be an ACTUAL separable tame map, branched
only over0,1,infinity, with every point in fiber i of ramification index
e_i prime to5. Write D_i for its reduced fibers.

Choose rational a,b whose denominators divide N, with5 not dividing N.
Interpret them in k when differentiating, but as rational numbers in
the following orders:

    m0=e0(a+2)-2, m1=e1(b+2)-2,
    minf=einf(-a-b-2)-2.

Suppose these three numbers are nonnegative INTEGERS congruent to0 or1
modulo5. Put

    r=a(a-1)/t^2+b(b-1)/(t-1)^2+2ab/(t(t-1)),

and suppose r''-3r^2=0 in k(t).

Then C has a regular dormant projective connection r_C and a nonzero
chi-twisted regular quadratic q satisfying Bol_(r_C)(q)=0, where

    chi=O(m0 D0+m1 D1+minf Dinf) tensor omega_C^(-2),
    chi^N=O.

The quadratic is realized on the ACTUAL etale Kummer torsor of chi;
its divisor is the pullback of the displayed effective divisor. No
ramified auxiliary radical replaces an actual etale map.

Consequently, vanishing of every J(C)[4]-twisted dormant tangent
excludes every tame triangle atlas of type(2,4,8): take
(a,b,N)=(-1,-5/4,4). Vanishing of every J(C)[3]-twisted dormant tangent
excludes type(2,3,9): take(-1,-4/3,3).

For the explicit backup C_alpha BOTH vanishings hold. The existing
complete order-four tests and a new four-unit-minor cubic replay prove
the two additional exclusions(n;signature)=(16;2,4,8),(36;2,3,9).
The cubic test exhausts400 nontrivial oper/twist pairs; the five trivial
ones vanish by the already proved reduced dormant census.

## The different, active (2,4,6) case has an exact first-order test

Let g(C)=2, let eta be a nonzero rational differential, and define the
derivation delta(a)=da/eta on rational functions.
For any rational A with div(A eta^4)=2D, D reduced effective of degree4,
the following are equivalent:

* a rational f has precisely the complete tame fibers
  2D0,4D1,6D over0,1,infinity, with no other ramification;
  and A eta^4=2(df)^4/[f^2(f-1)^3];
* f has pole divisor EXACTLY6D and satisfies

                    (delta(f))^4=3A f^2(f-1)^3.           (A)

Such f has degree24 and lies in the23-dimensional H0(C,O(6D)).
Its pulled-back connection from r0=3/[t^2(t-1)] is regular ACTIVE
nilpotent, with normalized quartic A eta^4. Thus, on the backup C_alpha,
D ranges over the already complete85 active quartics, not the five
dormant connections. Equation(A) with the full pole condition is an
EXACT test, including sheetwise ramification and infinity.

On any connected component B of the fourth-root curve z^4=A, it also
gives an actual map to the fixed ordinary elliptic curve

    E: w^4=3t^2(t-1)^3,   t=f, w=delta(f)/z,
    pullback(dt/w)=z eta.

E is isomorphic to y^2=x^3+3x. The component B has genus5 or9 and
maps to E with degree12 or24, according as deg(B/C)=2 or4.
B->C is RAMIFIED. Neither an elliptic factor of J(B) nor equation(A)
is excluded here. In particular the dormant-tangent vanishings above
do not settle this active case.

Version1's two exclusions and certificates are retained unchanged.
This does not exclude arbitrary common covers or assert that every span
preserves a connection.
[Proof and certificate](../../../Proofs/quotient_geometry/triangles/radical_quadratic_atlas_obstruction.md).
