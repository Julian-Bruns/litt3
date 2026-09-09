# Proof: apply the root-contact inequality to the three allowed residues

[Statement](../Theorems/Thm_genus_two_clump_connection_reduction.md).
Author /root,2026-09-08. This is an elementary consequence, not a new
audit of the earlier canonical/connection-spectrum inputs.

The canonical-intersection theorem gives a primitive generator s of
weight d with uniform zero multiplicity e. On Y, degree comparison is
er=2d. The Cartier-generator theorem gives 5 not dividing d and
e+d not zero modulo5. Consequently 5 divides neither e nor r, and
r is not3 modulo5. Thus r is1,2 or4 modulo5.

If r=1mod5, then e/d=2mod5 and the least contact q>=2 with
e+dq=0mod5 is3. The positivity condition in ramified_root_contact_core
is d(q-2)>e, which here is d>e, or r>2. Therefore every r=6,11,16,...
would force a core. Only r=1 remains in this residue class.

If r=2mod5, then e/d=1mod5, q=4, and positivity is 2d>e,
equivalently r>1. This holds for every r=2,7,12,..., so all are excluded.
The arbitrary-gcd version is essential: no assumption is made that
d,e are coprime or that the primitive weight equals r or r/2.

Thus a non-singleton clump has r=4mod5. Then e/d=2/r=3=-2mod5.
The exact regularity criterion in coreless_connection_spectrum supplies
the shared regular connection r_s. That theorem proves it nilpotent,
and dormant exactly in the Cartier-zero branch. If the common spectrum
is a line, r_s is still an actual shared nilpotent member of it.

For the specified high-degree C_t, family_small_torsion_specialization
incorporates the independently certified singleton Cartier-zero exclusion
and the bounded-torsion nonzero-Cartier exclusion. It removes r=1.
If there is no clump, canonical_intersection instead gives A=k, and
coreless_connection_spectrum says the common connection space is empty
or one dormant point. Nothing in this argument removes the empty case.
