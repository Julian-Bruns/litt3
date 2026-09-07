# Eliminate the constant common kernel while retaining the atlas residual

Let k have characteristic different from2. Let A0,A1 be alternating m-square
matrices, with m even, let C be another m-square matrix, beta a column,
and kappa a nonzero scalar. The matrices may depend polynomially on
parameters b. Consider

    A0 v=A1 v=0,       C v=beta,       beta^T v=kappa.       (1)

Assume every solution under consideration has
dim(ker A0 intersect ker A1)=1. This holds at EVERY actual solution of
the acyclic atlas system. In that application m=32, kappa=2,
beta=G^T b, and C is the actual projected R matrix; it is not omitted.

1. CORANK-TWO CHART. Set A=A0+t A1, D=A1, and let P be the Pfaffian
   adjugate of A, so AP=PA=Pf(A)I. For a coordinate column e_j put

       u=P D e_j,            h=beta^T u.

   On h!=0 the following equations are exact:

       Pf(A)=0,       D u=0,       kappa C u=h beta.         (2)

   They reconstruct v=kappa u/h. Conversely, every solution of (1)
   with corank A=2 belongs to one such chart. Equations (2) themselves
   force corank A=2 and a one-dimensional COMMON CONSTANT kernel.
   They do not merely assert that A0+t A1 is singular for each t.

   The same h is the Pfaffian of the bordered alternating matrix

       [ A        beta   D e_j ]
       [-beta^T     0      0   ].                           (3)
       [-(D e_j)^T  0      0   ]

   For m=32, u has degree16 in the entries of the alternating pencil.
   Thus (2) removes all32 v variables, using one Pfaffian equation,
   at most32 constant-kernel equations and32 ACTUAL R equations.
   The open condition h!=0 must be retained.

2. ALL STRATA HAVE A BOUNDED SMALL KERNEL. If the common constant kernel
   has dimension1 and the normal corank of A0+t A1 is c, then

       c is even,           2<=c,           m>=3c-2.        (4)

   For m=32 this gives c in{2,4,6,8,10}; no lower-corank assumption is
   permitted. Any16 distinct t in F25 contain a maximum-rank member
   at every actual genus-nine atlas point.

3. EXACT HIGHER-CORANK CHARTS. For such a member, choose an invertible
   principal block M of size m-2d, where 1<=d<=5 in genus9, and write

       A=[M B;-B^T E],  p=Pf(M),  K=[-M^# B;p I_(2d)].

   Require p!=0 and p E+B^T M^# B=0. Put F=D K. For any choice J of
   2d-1 rows of F, let w be their signed maximal-minor kernel vector,
   and set u=K w, h=beta^T u. The exact remaining equations are

       F w=0,             kappa C u=h beta,             h!=0.       (5)

   They reconstruct v=kappa u/h. The union of these charts and choices
   covers every solution of (1) having common constant kernel dimension1.
   Their cofactors have size at most9 by9 after the alternating block
   reduction. Both nonzero conditions p and h are essential. The large
   number of possible minor charts is not a claimed runtime improvement.

For the fixed acyclic atlas these are exact equations on b alone, with
one inverse variable if one wants an affine equation for the open condition.
Their union is the actual finite reduced atlas projection; no R residual,
normalization, extension-field point, or higher-corank stratum is discarded.
Neither these equations nor the remaining five rank strata are proved empty.

Status: author proof,2026-09-07; no independent audit claimed. Exact tests
change the full saved genus-two tensor into two alternating blocks and
reconstruct ALL33 known normalized atlas points by (2). Scaling b by2
preserves a normalized common-kernel solution but fails R; all33 such
weak points are rejected by (2). A size32 example attains c=10 and is
reconstructed by (5), showing that the larger strata cannot be suppressed
by the abstract matrix argument.
[Proof](../Solutions/Sol_alternating_constant_kernel_elimination.md).
