# Bounded effective atlases give finitely many partners

Let k be algebraically closed, X/k a fixed smooth projective connected
curve with g(X)>=2, and B>=1 an integer. Only finitely many isomorphism
classes of smooth proper effective DM curves S admit a representable
finite etale atlas X -> S of degree at most B.

For any fixed h>=2, only finitely many isomorphism classes of genus-h
smooth projective curves Y admit a representable finite etale atlas
to any such S. If n=deg(X/S), the degree of Y -> S is necessarily
(h-1)n/(g(X)-1).

Wild inertia and non-Galois atlases are allowed. The theorem neither
supplies the bound B nor turns a coreless span into an orbifold atlas.

## Explicit count and avoidance in characteristic five

In characteristic five, write g=g(X), take B>=2, and set

    D=(B-1)!, G=1+(g-1)D, L=B^2,
    M=floor((h-1)B/(g-1)),
    K=D*(D!)^(2g)*3^(4G^2 L)*(M!)^(2G+L).

If M>=1, the number of genus-h partners through these bounded atlases
is at most K. If M=0, there are no such partners.
If ALL effective orbifold atlas degrees of X are bounded by B, the
same K bounds all its genus-h CORED finite-etale common-cover partners.

In particular suppose X is defined over F_q, with q a power of5, and
use h=2 and M>=1. For any prime r>max(K,120), let t have degree r over
F_q. Then the ordinary genus-two curve

    Y_t: v^2=u(u-1)(u-2)(u-3)(u-t)

has no CORED common finite-etale cover with X. Choosing the least such
prime and the first monic irreducible degree-r polynomial in a fixed
coefficient order is a deterministic finite prescription, not a practical
computation. No claim about coreless covers or simplicity of J(Y_t) follows.

Version2,2026-09-07. Original finiteness audit PASS,
`/root/x_elliptic_quotient_maps`,2026-09-05. Effective count and parameter
selection independently audited PASS, `/root/audit_effective_cored_partner_bound`,
2026-09-07; [audit metadata](../Research/audits/EFFECTIVE_CORED_PARTNER_BOUND_AUDIT_2026_09_07.md)
is reference-only. [Proof](../Solutions/Sol_bounded_atlas_partner_finiteness.md).
