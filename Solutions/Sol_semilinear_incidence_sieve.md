# Proof: semilinear image pruning without losing solutions

[Statement](../Theorems/Thm_semilinear_incidence_sieve.md).

Since J1 is a subspace of E, the first inclusion holds. If Jn is contained
in J(n-1), the corresponding tensor subspaces and their N-kernels are
nested; applying R proves J(n+1) is contained in Jn. Finite dimension
gives termination. For a solution of (1), induction gives e in Jn;
then a tensor e^[p] lies in the restricted N-kernel, so (1) puts e in
J(n+1). This proves the asserted necessity and the zero-space certificate.
Kernels, images, inclusions and coefficient Frobenius twists commute with
perfect scalar extension, proving the algebraic-closure assertion.

For computation, choose basis columns C_n for Jn and form block matrices

    NN=[N_i C_n^[p]]_i,       RR=[R_i C_n^[p]]_i.

Then J(n+1)=image(RR restricted to ker NN). Its dimension also equals
rank([NN;RR])-rank(NN). Both independent descriptions are checked in
the implementation. This is not the assertion that a general tensor
in ker NN is decomposable; hence a positive fixed point is only a bound.

In the fixed-oper computation `wronskian_linear_sieve.sage`, all32
64x56 N_i are built from exact polynomial Wronskians and the perfect
residue pairing. All2048 fifth-power expansions are verified. The R_i
were independently built from the fixed Laurent principal-part formula.
At both stages NN has rank64 and the stacked matrix has rank96, giving
32. Explicit kernel images and nesting verify the fixed space, not just
reported ranks. The output includes the stable basis and both tensors:
`Research/computations/wronskian_linear_sieve.json`.

The weaker test `wronskian_universal_image.sage` verifies dimension45
for the span of the images of ALL32 R_i, together with11 independent
annihilator rows killing every matrix. That is not a sample assertion.

Finally `wronskian_stable_identification.sage` computes every image of
delta^2-P on the24 monomials of L32, verifies that all poles are<=64,
and proves the image rank24. After the fixed Serre residue change of
coordinates its row space equals the annihilator of the stable32-space.
Its output is `Research/computations/wronskian_stable_identification.json`.
This last equality is fixed-oper computational evidence, not a substitute
for a general cohomological explanation or an atlas exclusion.
