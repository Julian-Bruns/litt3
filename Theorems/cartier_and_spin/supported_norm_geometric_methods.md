# Geometric support tests without restricting the coefficient field

Version1,30 September2026. On the fixed curve X:y^3=P(x), with its
unique infinity O and twelve marked points Z over A=0, retain the
following independent methods for rational functions regular away from O.

1. If g has pole order less than40, its zeros are in Z, and the constant
   dt coefficient of dlog(g) vanishes for t=x^3/y, then g belongs to k[x].
   This uses the uniform infinity Cartier criterion and cubic characters.
2. Removing common polynomial content removes complete cubic fibres
   from the zero divisor. A primitive supported function occupies at
   most two sheets in each marked fibre.
3. In a geometric section subspace V of L(nO), supported sections of exact pole n
   can be decided by exact marked-jet kernels: subdivisors of degree
   dim(V)-1 give candidate kernels; lines are checked directly and larger
   kernels are exhausted by further marked-jet hyperplanes. Matrices over
   a field containing Z compute
   the full geometric kernels by scalar extension.

These are reusable geometric tests, independently of knowing the marked
relation lattice. The old fixed-pole searches are superseded; their
independent audits remain as provenance. The
[exact marked lattice](marked_divisor_relation_lattice.md) now gives the
sharp supported-function bound, and the
[actual two-map congruence lattice](actual_norm_congruence_lattice_bound.md)
gives the stronger necessary bound for actual norms. Those bounds do not
depend on the retained low-pole searches.

For actual comparisons the full normal form of both finite etale maps
from the same source is required. Polynomial norms alone do not imply
descent of the comparison function or existence of a common cover.

[Proof and retained evidence](../../Proofs/cartier_and_spin/supported_norm_geometric_methods.md).
