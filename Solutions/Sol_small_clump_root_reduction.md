# Proof: endpoint torsion, small divisors, and the root Cartier test

[Statement](../Theorems/Thm_small_clump_root_reduction.md).
Author /root,2026-09-07. Independent prose audit PASS by
`/root/audit_small_clump_roots`,2026-09-07; linked from the statement.

The exact primitive-weight formula in `canonical_intersection` supplies
coprime d_0,e_0 with e_0 r=16d_0. Thus

    d_0=r/gcd(r,16),       e_0=16/gcd(r,16).

Put alpha=[D_X-rO] and q_X=ord(e_0 alpha), using K_X=16O. That theorem
gives q_X|deg(f), and s_X=t_X^m up to scalar for an endpoint tensor
t_X of weight b_X=d_0 q_X with divisor e_0 q_X D_X. Both statements
use f*L_X=g*L_Y and BOTH norm maps, not isolated Jacobian data.

The primitive weight d=d_0 lcm(q_X,q_Y) is prime to5 by `cartier_generator`.
Hence q_X has prime divisors only2,3. Since e_0 is a power of2 and
e_0 q_X alpha=0, alpha is genuinely mixed2/3-primary. The independently
audited `cyclic_cubic_low_abel_torsion` places it in

    J(X)(F_(25^684))[216].

For r=1,2,3, e_0 is16,8,16, respectively. It kills the entire
two-primary component of alpha, whose order divides8. Therefore
q_X=ord(e_0 alpha) is one of1,3,9,27. Initially this gives weights
1,3,9,27 for r=1,2, and3,9,27,81 for r=3.

Weight1 is impossible. A uniform one-form root of a shared tensor
must be a Cartier eigenform, possibly with eigenvalue zero, by the
one-endpoint power test in `cartier_generator`. The nonzero-eigenvalue
forms on fixedX have simple zeros by `fixed_x_cartier_eigenforms`, and
the same is true of uniform Cartier-zero forms by Section2 of
`fixed_x_orbifold_bound`. The shared-simple-root theorem then forces
a core, contrary to hypothesis.

For r=3 and b_X=3, q_X=1, so16 alpha=0. The audited pure two-primary
W3 theorem gives alpha=0. As D_X is reduced, it is a full UNRAMIFIED
native cubic fiber x*(c), c finite. Up to scalar the weight3 root is

    t_X=(x-c)^16 theta^3,       theta=dx/y^2.

The exact all-c certificate in `two_primary_w3` proves C_(X,1)(t_X^2)
nonzero. The full primitive weight is a multiple of3, hence does not
divide4. The arbitrary-root power rule in `cartier_generator` would
force this same image to vanish. This excludes the remaining weight3
case with r=3 and proves the table. Every retained weight is divisible
by3; the identical rule proves the displayed necessary root test.

Finally all retained classes alpha are nonzero, since q_X>1. Every
such class in W_r has a unique effective degree-r representative by
the audited low-pencil theorem (r<=3). Since alpha is F_(25^684)-rational,
uniqueness makes D_X rational over that field. The finite group
J(X)(F_(25^684))[216] therefore gives finitely many possible D_X.
Each t_X is unique up to scalar from its divisor. The defining
one-dimensional Riemann--Roch space is over the same finite field,
so it admits a nonzero section there by flat scalar base change.

This finite set may be impractically large. No vanishing test on its
retained members, no clump-existence theorem, and no restriction on
larger clump images has been proved. All original etale maps remain
in place; no root was assumed to descend through the second endpoint.
