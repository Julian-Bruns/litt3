# A canonical linear sieve for a semilinear incidence problem

Let k be perfect of characteristic p>0. Let A,E,B be finite-dimensional
k-spaces, and N:A tensor E^[p]->B and R:A tensor E^[p]->E be linear maps.
Consider pairs (a,e) satisfying

    N(a tensor e^[p])=0,       e=R(a tensor e^[p]).           (1)

Define subspaces intrinsically by

    J_0=E,
    J_(n+1)=R(ker(N restricted to A tensor J_n^[p])).        (2)

Then J_(n+1) is contained in J_n, the sequence stabilizes after at most
dim E strict decreases, and every solution e of (1) belongs to every J_n.
The construction commutes with perfect coefficient-field extensions.
In particular J_infinity=0 excludes all solutions with e!=0 over the
algebraic closure. A positive stable space does NOT assert existence.
The tensor in (1) uses the SAME a for N and R; (2) deliberately relaxes
decomposability, producing a necessary condition only.

For the first new F25 oper in `fixed_x_oper_enumeration`, use A=S_U,
E=P48, the64-row pencil Ntilde of `rank_two_extension_pencil`, and R of
`wronskian_matrix_pencil`. An exact all-basis computation gives

    56 ->32 ->32.

Thus every untwisted atlas for this oper has its eta in a fixed32-dimensional
subspace, independent of the quotient direction. Both maps retain their
shared U. This eliminates24 linear eta coordinates, but does not exclude
the oper. The weaker unrestricted universal R-image has dimension45.

Under the fixed residue pairing, the annihilator of this stable32-space
is EXACTLY the image of

    delta^2-P : L(32O) -> L(64O).

For this oper that map has rank24 and zero kernel. This equality is
certified finite linear algebra, not an asserted equality for every oper.

Status: author proof plus exact complete-basis certificates; not separately
audited. Data and reproduction are linked in the proof.
[Proof](../Solutions/Sol_semilinear_incidence_sieve.md).
