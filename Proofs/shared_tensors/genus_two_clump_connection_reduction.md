# Proof: one root-contact inequality and its small exceptions

[Statement](../../Theorems/shared_tensors/genus_two_clump_connection_reduction.md).
Version2,2026-09-15. The geometric inputs retain their recorded scopes.

The canonical-intersection theorem gives a primitive generator s of
weight d with uniform zero multiplicity e. On Y, degree comparison is
er=2d. The all-characteristic Cartier-generator theorem gives p not
dividing d and e+d nonzero modulo p. Since p is odd, neither e nor
r is divisible by p, and r is not -2 modulo p.

Let q be the least integer at least2 with e+dq=0 modulo p.
The excluded residues imply 2<=q<=p-1 and

    q=-2/r modulo p.

The ramified-root theorem would force a core whenever
d(q-2)>e, equivalently r(q-2)>2. Therefore a coreless span satisfies

                         r(q-2)<=2.

If r>=3 this forces q=2, hence r=-1 modulo p. Only r=1,2
need separate consideration. For r=2, q=p-1, so the inequality
holds only at p=3; this already has r=-1 modulo p. For r=1,
p=3 is excluded by r!=-2 modulo p. At p>=5 one has q=p-2,
and the inequality is p-4<=2, so only p=5 remains. This proves
the stated restriction in every odd characteristic. The argument
uses the arbitrary-gcd root theorem, without assuming d,e coprime
or fixing their endpoint torsion.

In characteristic five every non-singleton clump therefore has
r=4 modulo5. Then e/d=2/r=3=-2 modulo5.
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
