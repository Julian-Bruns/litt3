# One exact linear-system chart for every atlas point

Use the finite reduced intrinsic atlas scheme for a fixed V, with
n=4(g-1), equations

    H(b)p=I b,       ell(p,b)=1,

where H(b) is a 3n-by-n matrix homogeneous of degree five in b.
Signs are included in H. Its rank is n at every actual solution.
This holds also for nonacyclic V and nontrivial cubic determinant twists.

Extend the coefficient field by distinct constants c_0,...,c_(3n-1)
if necessary, and introduce an INDETERMINATE t. Put

    C(t)_(i,j)=c_j^i t^j,  0<=i<n, 0<=j<3n,
    A=C H(b),   d=det A,   v=adj(A) C I b.

Over the rational-function field in t, the entire normalized atlas
scheme is isomorphic to the system in b alone

    H(b)v=d I b,       ell(v,b)=d,       d!=0.

Reconstruction is p=v/d. No actual atlas is lost in d=0: d is a unit
on the base-changed finite atlas scheme. Thus emptiness of this ONE
system is equivalent to atlas emptiness, without a cover by matrix
minors or projective coordinate charts. All original equations and the
normalization remain, and all three normalized scales are retained.

The result applies uniformly to all18 fixed-X representatives (n=32).
It eliminates32 variables, but the residual equations can have degree161
in b. The t-degree of d is at most2544. Expanded determinants are NOT
a proposed practical solver; use factored matrices if exploring this form.
No runtime improvement or representative exclusion is claimed.

Version1,2026-09-08. Author proof; no independent audit claimed.
[Proof](../../Solutions/atlases/generic_atlas_compression.md).
