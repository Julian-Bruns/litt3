# Two endpoint jets determine the character quotients without fixed denominators

Version3,26September2026. Retain the actual V4 same-source setup and
[coupled pole identities](klein_four_coupled_pole_derivatives.md).
Fix E, its partition into single and double triple-pole values, all
three character labels, and the actual labeled endpoint data at0 and
infinity. Put u=29-e. Denominators T_i are NOT fixed.

Consider two actual candidate systems, each satisfying the established
polynomial and endpoint conditions, with the same degree bounds d_i.
For each index i with
\[
c_i+u\ge12+2d_i,
\]
the rational quotient F_i/T_i is the same in the two systems.
If this holds for two indices and the remaining index satisfies
\[
2c_i+u\ge12+2d_i,
\]
then the coupled derivative identities force equality of that third
quotient as well. The corresponding assertion includes double-triple
fibers and zero-leading endpoint cases.

There is a stronger coupled criterion. Put j=j1+j2 and D=sum d_i.
If
\[
g>38+j-u-j2,
\]
then one individually fixed quotient suffices, provided every other
index satisfies the second inequality above. This conclusion does not
fix the denominators in advance: it uses their pairwise products in a
homogeneous quadratic relation for the cross differences.

Under the same strict genus inequality, there is also a conclusion
without any initially fixed quotient. All actual quotient triples with
the specified data lie in a single affine line over k(t), unless the
triple is already unique. The direction of this line is isotropic for
\[
q(x_1,x_2,x_3)=x_1x_2+x_1x_3+x_2x_3.
\]
If every index satisfies the second inequality above, every nonzero
such direction has all three coordinates nonzero. This is an affine
line over the FUNCTION FIELD k(t); it does not assert a one-dimensional
parameter space over k or that every point of the line is realizable.

All109 surviving degree87 allocations, all729 degree86 allocations,
and4559 of4616 degree85 allocations satisfy these criteria. Thus for
their fixed pole data and endpoint labels there is at most one triple
of rational quotients F_i/T_i.
They are defined over the compositum of M=F_(25^7) and the field of the
specified endpoint data, whenever an actual candidate exists.

Equality of quotients does not determine common polynomial factors of
(F_i,T_i), or construct the endpoint maps. This is stronger than fixing
the T_i in advance, but is not an actual-curve existence decision or a
solution of the original common-cover problem.

[Proof and exact integer scope](../../Proofs/cartier_and_spin/klein_four_quotient_jet_rigidity.md).
