# Ramified canonical roots force cores in a parameterized contact range

Version1,2026-09-08. Work over an algebraically closed field of
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

More sharply, within one compatible orbit of pairs of connected
canonical-root components of degrees h_X,h_Y, the same bounds replace
d in C by lcm(h_X,h_Y). Every single preserving image belongs to one
such class. For an unrestricted union the coefficient is d.

All these preserving images are therefore finite in number. Their
composition-closed relation gives actual finite etale atlases of X,Y
to a common effective proper smooth DM curve. In particular EVERY
actual tensor-preserving span has a CORE in its specified source field.
Neither a Galois leg nor a simultaneous Galois closure is assumed.

In characteristic5, d=7,e=2 gives C=315/2. Thus every compatible
reduced spin-section match of degree7 forces a core. This conclusion
does NOT require Cartier vanishing, Jacobian orthogonality, ordinarity,
or a restriction on the map degrees modulo5. For a genus-two Y the
total degree toward X is at most157.

The positivity condition is essential to this argument. For example,
the genus-independent coreless exact-form examples with d=1,e=8 are
outside it. The theorem neither supplies a common tensor nor settles
the unmarked common-cover problem.

Fresh medium prose audit PASS for the base spin case and the full
general component-orbit extension, /root/audit_equivariant_root_contact,
2026-09-08. This is not Lean verification.
[Audit metadata](../../Research/audits/EQUIVARIANT_ROOT_CONTACT_AUDIT_2026_09_08.md)
is reference-only; the classwise lcm versus total d clarification is
incorporated in the proof.
[Proof](../../Solutions/common_covers/ramified_root_contact_core.md).
