# Proof: Pfaffian columns, a normal-rank bound, and exact residual charts

[Statement](../Theorems/Thm_alternating_constant_kernel_elimination.md).
The alternating matrices come from `acyclic_alternating_atlas`. The
one-dimensional common kernel at actual atlas points is the swapped
cup-product assertion in `compact_etale_atlas_system`.

## 1. A Pfaffian column that detects a CONSTANT kernel

For an alternating matrix A of even size, its Pfaffian adjugate P satisfies
AP=PA=Pf(A)I. On Pf(A)=0, a nonzero P implies corank A=2, because its
entries are the signed principal Pfaffians of size m-2. Conversely, at
corank2, P has rank2 and image ker A. In a basis x,y of that kernel it
has the form

    P=q(x y^T-y x^T),         q!=0.                        (6)

These assertions follow either by reducing an alternating form to
symplectic blocks or from its exterior-power formula. They hold in the
stated characteristic, including characteristic five.

Suppose (1) holds and corank A=2. The vector v spans the common kernel
of A and D. Let y complete it to a basis of ker A. Then Dy!=0; otherwise
the common kernel would have dimension2. Since D is alternating,

    PD=q v y^T D

is a nonzero rank-one matrix with image kv. Its contraction beta^T PD
is also nonzero because beta^T v=kappa!=0. Therefore some column
u=PD e_j has h=beta^T u!=0. That column is a nonzero multiple of v, so
Du=0 and kappa C u=h beta follow immediately.

Conversely assume (2) and h!=0. Then P and u are nonzero, so corank A=2.
The identity AP=0 gives Au=0, and Du=0 is explicitly required. The
reconstructed v=kappa u/h satisfies both kernel equations, beta^T v=kappa,
and Cv=beta. Moreover PD!=0 means D does not annihilate all of ker A.
Its kernel inside the two-dimensional ker A is therefore precisely ku.
This proves the asserted common CONSTANT kernel and not just singularity
over k(t).

The bordered Pfaffian identity in (3) is

    Pf([A beta q;-beta^T 0 0;-q^T 0 0])=beta^T P q.        (7)

For invertible A it follows from the alternating Schur complement. Both
sides are polynomials in all entries, so it holds universally. Take
q=D e_j. The determinant of the bordered matrix is consequently h^2.

At m=32, P has degree15 in A, so u=PD e_j has degree16 in the pencil
entries. In the atlas those entries are linear in gamma=b^[5]. The
Pfaffian equation has gamma-degree16 and the Du equations have
gamma-degree17. Taking coefficientwise fifth roots of these necessary
equations gives degrees16 and17 in b over the perfect coefficient field.
The R equations retain their displayed mixed Frobenius form; they cannot
be replaced by a singular-pencil condition or an untested proportionality.

## 2. A direct bound on all possible normal-corank strata

This argument works directly over the field and does not import a
characteristic-zero canonical-form hypothesis. Let the homogeneous
alternating pencil define

    O_(P1)^m --A--> O_(P1)(1)^m,

and let K be its kernel bundle, of rank c. The quotient E=O^m/K is a
vector bundle: the image of a map of bundles on a smooth curve is
torsion free. Its rank is r=m-c. Global sections of K are EXACTLY
the constant vectors killed by both A0 and A1, so h0(K)=1.

Write e=deg E=-deg K. Riemann--Roch on P1 gives

    c-e=chi(K)<=h0(K)=1,     hence e>=c-1.                 (8)

Because A is alternating and kills K, it induces a generically
nondegenerate alternating map E->E^vee(1). Its determinant is a nonzero
section of a line bundle of degree r-2e. Therefore

    r>=2e>=2c-2,

and m=r+c>=3c-2. Alternating rank is even. Since m is even and a common
kernel exists, c is an even integer at least2. For m=32 this proves
c<=10 and r>=22.

In minimal-index language, h0(K)=1 means exactly one zero minimal index;
every other index is positive. The elementary degree proof above keeps
all such possibilities. It does not assert that the sole remaining
Kronecker block has one preferred index or that c=2.

A maximum-rank member has a nonzero principal Pfaffian of degree r/2
in the two pencil coordinates. After setting the first coordinate to1,
this is a nonzero polynomial of degree at most(m-2)/2. Thus any m/2
distinct finite parameters include a point where it is nonzero, and
where the rank is the normal rank. The field F25 supplies16 distinct
parameters for m=32. No single sampled pencil member is presumed to
have maximum rank throughout parameter space.

## 3. Pfaffian Schur reduction on every allowed stratum

At a maximum-rank member of corank2d, some principal submatrix M of
size m-2d is invertible. In the associated partition

    A=[M B;-B^T E],

put p=Pf(M), P=M^#, and K=[-PB;p I]. Then the polynomial identity

    A K=[0;p E+B^T P B]                                   (9)

holds. On p!=0, K has independent columns. The Schur condition
p E+B^T P B=0 is equivalent to corank A=2d, and makes those columns
a basis of ker A, scaled by p. Thus common constant kernels are
precisely K times ker F, where F=DK has2d columns.

At an actual point ker F has dimension1, so F has rank2d-1. Select
that many independent rows. The signed maximal-minor vector w of the
resulting(2d-1) by2d matrix is nonzero and spans its kernel. The remaining
equations Fw=0 test that it is the kernel of ALL rows. This step is what
excludes polynomial pencil kernels that have no constant common vector.

If h=beta^T K w!=0, the same scalar calculation as in Section1 gives
v=kappa K w/h and shows that kappa C K w=h beta is equivalent to all
the actual R equations. Conversely, at every actual point some row
choice has such a nonzero w and h, since beta does not annihilate the
unique common-kernel line.

The open condition h!=0 already implies w!=0, so no separate nonzero
maximal minor of F is required. The condition p!=0 remains necessary
for the Schur chart. Both may be enforced using one equation z p h=1.
At m=32, d<=5, so these final cofactors have size at most9 by9.

These are exact pointwise conditions and exact local graph descriptions.
On each chart the exhibited u is unimodular after localizing at h, and
the common-kernel matrix has rank m-1 at every residue field. Its kernel
is consequently the free line generated by u locally: a nonzero maximal
minor gives the usual split linear solve. This proves uniqueness over
base rings as well. The displayed rational reconstruction and projection
are inverse morphisms on the chart, not an enumeration confined to the
coefficient field's rational points. For the actual atlas they therefore
cover its finite reduced projection, as in `rooted_atlas_projection`.

This is a bounded mathematical elimination lemma. Enumerating all
possible principal and row minors can itself be expensive. No assertion
that these equations have a small expanded representation, low solver
degree, or a fast elimination algorithm is made.

## 4. Two necessary safeguards

The three-square alternating pencil

    K1(t)=[0 t 1;-t 0 0;-1 0 0]

has normal kernel generated by(0,1,-t), and has no nonzero constant
kernel. Two such blocks give an even-size pencil with identically zero
Pfaffian and still no constant common kernel. The test Du=0 in Section1
retains the distinction that the binary Pfaffian coefficients alone lose.

At the other extreme, take one zero1-square block, nine K1 blocks and
a constant nonsingular alternating4-square block. This has size32,
normal corank10 and constant common kernel dimension1. Choose beta to
evaluate the zero block, kappa=1 and C=beta beta^T. It satisfies the
full abstract normalized linear system. Its Pfaffian adjugate of size32
is identically zero, so the corank-two chart cannot cover it. The
ten-coordinate Schur chart reconstructs it exactly. This is a matrix
example, not an assertion that a genus-nine atlas realizes that stratum.

## 5. Test against the ACTUAL positive genus-two atlas

The exact script `scripts/alternating_kernel_genus_two_check.sage` reads
the audited intrinsic12 by4 by4 tensor. Its first four output coordinates
are I=identity and its final eight are N. Solving the constant linear
conditions for an alternating row map gives dimension2. The two maps
stack to an invertible8-square matrix, checked exactly. Thus this is a
complete row change of the original N equations, not a guessed comparison
with a different scalar implementation.

Let ell be the saved invertible normalization matrix. In the script
beta=ell b, C is minus ell times the first four tensor rows, and kappa=1.
These choices convert the ORIGINAL intrinsic equations exactly into (1).

All33 known normalized geometric points lie in F_(5^6) after the specified
embedding of F25. They are reconstructed from the independently certified
degree11 polynomial and cube normalizations in `genus_two_atlas_dynamics`.
The script checks every original equation first. At each point both
alternating blocks have rank2, their stacked matrix has rank3, and at
least one Pfaffian column chart reconstructs the original p vector.
The bordered Pfaffian is h and its determinant is h^2 in every selected
chart, both checked exactly.

As a negative control, replace b by2b and normalize the kernel vector by
v/2. The N equations and bilinear normalization still hold, whereas the
R equations fail because C scales by2^5 and beta by2. All33 such weak
points are rejected by the retained R residual. This checks precisely
the condition whose omission would produce false atlas candidates.

The complete test, including the varying-kernel and sharp-corank matrix
examples, takes less than one second excluding Sage startup. Its external report is
`/Users/julian/Documents/litt3-computation-data/orbit11-structure/constant_kernel_genus_two_check.json`.
No atlas solver or large-field tensor was built. No orbit, including
orbit0011, was excluded. The unmarked two-leg common-cover problem is
still unsolved.
