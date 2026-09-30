# Ramified canonical roots force cores in a parameterized contact range

Version3,2026-09-24. Work over an algebraically closed field of
characteristic p>0. Fix smooth projective connected curves X,Y of
genus at least two and nonzero regular weight-d canonical tensors s_X,s_Y
with divisors eD_X,eD_Y, where e,d>0 and D_X,D_Y are reduced.
Assume p does not divide d(e+d). Put

    c=gcd(d,e), d0=d/c, e0=e/c, N=d0+e0,
    q=min{j>=2: e+dj=0 mod p}, mu=d0(q-1).

Suppose mu>N, equivalently d(q-2)>e. Define

    C=2d*N*(N+mu)/(e0*(mu-N)).

For ANY finite reduced union of distinct jointly minimal images of
actual finite etale spans X<-Z_i->Y preserving these specified tensors,
the sums of projection degrees satisfy

    sum deg(Z_i/X)<=C(g(Y)-1),
    sum deg(Z_i/Y)<=C(g(X)-1).

More sharply, let h_X,h_Y be the degrees of connected canonical-root
components and L=lcm(h_X,h_Y). If the union uses m compatible orbits
of component pairs, replace d in C by mL. There are d/L such orbits,
and each single preserving image uses one, giving coefficient L.

All these preserving images are therefore finite in number. If a preserving
span exists, their composition-closed relation gives finite etale atlases
of X,Y to a common effective proper smooth DM curve. Thus every actual
tensor-preserving span has a core in its specified source field.
Neither a Galois leg nor a simultaneous Galois closure is assumed.

For every odd characteristic \(p\ge5\), taking \(d=p+2,e=2\)
satisfies the contact inequality. Thus every compatible reduced
section match of \(L^{p+2}\), where \(L^2=\omega\) is a spin line,
forces a core, in ANY endpoint genera. No Cartier vanishing,
Jacobian orthogonality, ordinarity, or restriction on the map degrees
modulo \(p\) is needed. In characteristic five, \(d=7,e=2\) gives
\(C=315/2\); for a genus-two \(Y\) the total degree toward \(X\)
is at most \(157\).

The positivity condition is essential to this argument. For example,
the genus-independent coreless exact-form examples with d=1,e=8 are
outside it. The theorem neither supplies a common tensor nor settles
the unmarked common-cover problem.

[Proof](../../Proofs/shared_tensors/ramified_root_contact_core.md).
