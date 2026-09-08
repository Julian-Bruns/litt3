# Radical quadratics force a twisted dormant tangent

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

Version1,2026-09-08. Author proof and exact no-solver rank replay;
no independent whole-theorem audit claimed. This does not exclude
arbitrary common covers or assert that every span preserves a connection.
[Proof and certificate](../Solutions/Sol_radical_quadratic_atlas_obstruction.md).
