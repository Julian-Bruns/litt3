# Exact intrinsic tensor on the actual genus-two Hermitian quotient

Author implementation,2026-09-07. Fresh bounded audit PASS, no material
objections; [metadata](audits/GENUS_TWO_INTRINSIC_TENSOR_AUDIT_2026_09_07.md).
This
exports the intrinsic equations, not a common-cover exclusion. No solver
is run by this script and no comparison with the genus-nine coefficient
tensor is asserted.

Source: [genus_two_intrinsic_tensor.sage](../scripts/genus_two_intrinsic_tensor.sage).
Output: [genus_two_intrinsic_tensor.json](computations/genus_two_intrinsic_tensor.json).
The [oper identification](GENUS_TWO_HERMITIAN_OPERS.md) supplies the
actual atlas-induced potential. The governing criterion is
[intrinsic_atlas_incidence](../Theorems/Thm_intrinsic_atlas_incidence.md).

## Coordinates, horizontal equation, and frames

Let k=F5[a]/(a²+4a+2), beta=a, z=1/(t−beta), w=vz³. Then

    w²=F=1+beta z+beta⁵z⁵,
    q=z²/w, eta=dz/w, delta=w d/dz.

The unique point O at infinity has semigroup<2,5> and gaps1,3.
The differential eta has divisor2O. Set theta=O(O), V=W(O), and
M=omega²=O(4O). The separating-coordinate potential transforms as
r_z=z^-4 r_t(beta+1/z), because a fractional linear change has zero
Schwarzian. Passing to the theta frame gives delta²f=P f, where

    P=F r_z−2beta²/F
     =(3a+2)z³+(2a+1)z²+(3a+2)z+3a+4.

For completeness, writing formally u=sqrt(w)f in u''=r_z u gives
delta²f=(F r_z−w w''/2+(w')²/4)f; since F'=beta and F''=0,
the correction is −2beta²/F. This scalar expression is rational even
though the temporary half-density symbol need not be a function.

The pole-bounded kernels on L(14O) and L(29O) have dimensions4 and10.
The script chooses f1,f2 from these kernels and verifies the polynomial
identity f1 delta f2−f2 delta f1=1. Thus

    H=[f1,f2;delta f1,delta f2]

is an affine horizontal frame, with determinant1 and entry poles≤32.
These are sections of W(3O),W(6O), respectively. The bounds arise
from5n−1 in the scalar realization; the frame is certified explicitly
rather than trusting a randomly chosen section to be nowhere zero.

Every transition uses the convention: local frame = affine frame times
the displayed matrix. The oper transition, in theta coordinates, is

    T_op=[q,0;delta q,q^-1].

Hence B0=H^-1 q^-5 T_op is the transition lattice for F*V. The factor
q^-5 comes from V=W(O). Apply the rational Cartier projector Car_q
entrywise, then take the unique fifth roots to obtain G0. On Laurent
series, this keeps q-exponents divisible by5 and takes their fifth roots;
B0 itself is not required to have only such exponents.

The script directly verifies B0^-1 G0^[5] is integral with unit
determinant. Therefore projection produces the same local lattice, not
an unverified change of bundle. Normalize

    epsilon=q²detG0, G=G0 diag(epsilon^-1,1).

Then detG=q^-2, and direct Laurent checks give poleG≤7,poleG^-1≤5.
All entries are rational: Cartier is a finite rational differential
operator, its image is k(C)^5, and the fifth root is unique. Laurent
series are used solely to compute the needed local coefficients.

Put d=2beta^-5 and c=−d=4a. Since delta q=d q^-2+O(q^-1), the
correct fixed nonsplit extension is

    G_K=[1,c/q;0,q²], kappa=c/q³.

In fact q T_op^-T has upper entry −q delta q, whose difference from
c/q is regular. Thus J=j0=H^T identifies K with(F*V)^vee M.
Independently, the script checks the local matrix
J_O=q⁴(G^[5])^T J G_K is integral with unit determinant.
These checks fix the extension and determinant scalars explicitly.

## Finite Čech quotients and their certified cutoffs

For a rank-r bundle with transition L, suppose entries of L have poles
at most A and entries of L^-1 poles at most B. Then q^B k[[q]]^r
is contained in the local lattice. After subtracting affine monomials,
the ambient principal parts have exponents−1,−3,1,...,B−1 in each
component. Quotient them by the reduced columns of q^jL for
0≤j<A+B. Higher powers already vanish in the ambient quotient.
This computes the full Čech quotient, including every local-lattice
relation; it is not merely a list of selected principal parts.

For B=H1(V^vee), use G^-T with bounds(A,B)=(5,7). The ambient space
has dimension16 and its relation space dimension12, leaving4.
For H=H1(Hom(V,K)), use G^-T tensor G_K with bounds(6,10).
Column-major vectorization of2×2 matrices fixes the tensor ordering.
The inverse bound10 is7+3, because G_K^-1 has a q^-3 entry. This
gives an ambient44-space and a32-dimensional relation space, leaving12.

An affine row p represents Hom(V,M) iff q⁴pG is regular. Since
p=q^-4p_O G^-1, each affine component has pole≤9. Linear regularity
conditions on two copies of L(9O) give dimension4, the full space A.

The scalar quotient for H1(omega) uses transition q^-2 and leaves
the gap q^-3. In particular[kappa] is nonzero. No arbitrary scalar
normalization of this one-dimensional target is substituted for kappa.

## Tensor and signs

An extension alpha is a row cocycle in the affine frame of V, with

    G_E=[1,alpha G;0,G].

Inverse transpose, fifth power, twist byM, and reorder(Vdual,O).
Its off-diagonal block is −q^-4 alpha^[5]T. Therefore

    D(alpha)=−J^-1 alpha^[5]T,
    I(alpha)=e alpha, e=(1,0)^T.

The exported coefficient vectors T_ij are the H-classes of
J^-1 alpha_j^[5]T p_i. The complete affine equations are

    I alpha + sum_(i,j) p_i alpha_j^5 T_ij =0,
    sum_(i,j) p_i ell_ij alpha_j=1.

Here ell_ij[kappa]=[alpha_j,1 p_i,2−alpha_j,2 p_i,1] inH1(omega),
because u_p=(p2,−p1)^T in the specified determinant convention.
The script checks rankI=4 and rankell=4. It also checks that every
basis vector of the12-dimensional B relation space is killed byI,
by all four contracted D maps, and by all four ell pairings. Thus
changing any alpha representative does not change these operations.

There are192 field entries in the12×4×4 tensor,8 variables and13
equations. The output records the alpha and p bases, H relations,
horizontal frame, I, tensor, and ell for reproducibility.

## Exact precision and verification scope

The initial expansion solves s=q²(beta⁵+beta s⁴+s⁵), s=1/z, with
unit derivative. Its residual is zero modulo q^precision; uniqueness
of this formal solution certifies the coefficients. Every subsequent
operation uses exact finite-field Laurent arithmetic with propagated
absolute precision. Frobenius multiplies the certified exponent cutoff
by5; Cartier root divides it with ceiling. The generic fifth-power
series operation is bypassed where it would lose valid precision.

Every reduction checks its input pole≤160, checks sufficient precision
both before and after affine subtraction, and verifies that the only
remaining nonpositive terms are the two gaps. Thus all requested
coefficients, through9 at most, are certified independently of any
rerun. Affine reducers through pole160 are ample; actual maximum input
pole and minimum remaining precision margin are exported. Equality
on rerunning at a higher precision is an additional check, not the
argument for exactness. The infinite local-lattice tail is excluded by
the explicit A+B cutoff above.

At precision500 and650 all bases and tensor coefficients agree exactly.
The maximum input pole was56, and the minimum remaining absolute
precision margins were75 and105, respectively.

The known actual Hermitian atlas proves geometric nonemptiness for this
oper. No solver is part of the tensor-construction script. Subsequent
bounded algebra and actual coordinate points are recorded below.

## Complete certified solution

All four linear restrictions lie in the ORIGINAL thirteen-generator
ideal, with explicit polynomial multipliers:

    b0+(2a+1)b2−(2a+2)b3,
    b1+(2a+1)b2−(2a+1)b3,
    p0+(2a+1)p3,
    p1−a p2+p3.

The two b restrictions are constant left-annihilator consequences of
the rank-ten 12×16 tensor matrix. After these substitutions, the N rows
contain each lp_i b2^5 and lp_i b3^5. Multiplying by the fifth power of
the bilinear normalization and subtracting lp_i(n^5−1) gives the two
p restrictions. Full polynomial expansion verifies the original-ideal
certificates; no candidate Groebner basis or radical argument is used.

[The minimal generator](../scripts/genus_two_linear_certificates.sage)
reproduces both the [b certificates](computations/genus_two_linear_certificates.json)
and [p certificates](computations/genus_two_p_linear_certificates.json).
The expensive prototype solver and duplicate certificate algorithms
were retired to the recoverable Trash folder
`/Users/julian/.Trash/litt3-genus-two-pilot.pOxZIW`.

The reduced system is now solved completely, not just bounded:
eleven simple projective fixed points, each with three normalizations,
give exactly33 reduced geometric solutions. The theorem
[genus_two_atlas_dynamics](../Theorems/Thm_genus_two_atlas_dynamics.md)
contains the exact statement and independent audit; its proof gives
necessity, all charts, and reconstruction. The
[dynamics script](../scripts/genus_two_atlas_dynamics.sage) verifies the
identities in the entire33-dimensional coordinate algebra, and
[the export](computations/genus_two_intrinsic_solutions.json) retains
all roots and multiplicities.

This successful small simplification does not transfer by constant
annihilators to large genus: the audited general theorem
[cartier_jet_tensor_surjectivity](../Theorems/Thm_cartier_jet_tensor_surjectivity.md)
proves that their tensor image is full when g−1≥p. Moreover,
[acyclic_atlas_towers](../Theorems/Thm_acyclic_atlas_towers.md) supplies
actual large-genus atlases with both acyclicity and full tensor image.
