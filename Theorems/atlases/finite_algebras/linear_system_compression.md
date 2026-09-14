# A single inverse chart for finite linear systems

Let K be any field and Z the finite K-scheme defined by

    H(b)p=f(b),       ell(p,b)=1,

where H is an n-by-k polynomial matrix, p has k coordinates, and ell
is homogeneous linear in p. Assume H has rank k at every geometric
point of Z. The scheme Z may be empty or nonreduced.

Use Gabizon–Raz's matrix T_u, with an independent indeterminate u:

    (T_u)_(j,i)=u^(ij),   1<=j<=k, 1<=i<=n,
    A=T_u H(b),   d=det A,   v=adj(A) T_u f(b).

Over K(u), projection onto b induces an isomorphism

    Z_(K(u)) ~= {H(b)v=d f(b), ell(v,b)=d, d invertible}.

Its inverse is p=v/d. The element d is a unit on the entire
base-changed scheme, so this one chart preserves its full scheme
structure. The bound deg_u(d)<=nk(k+1)/2 is uniform.

For the intrinsic atlas equations, n=12(g-1), k=4(g-1), f(b)=I b,
and H has degree five in b. Their finite reduced solution scheme
satisfies the rank hypothesis for every V and cubic determinant twist.
Thus the displayed chart eliminates all quotient coordinates while
retaining the normalization and all three normalized scales.

On the fixed genus-nine curve this covers all18 oper representatives:
k=32, n=96, and the remaining equations have b-degree at most161.
The u-degree bound is50,688. This is an exact elimination statement;
expanded determinants need not make a practical solver.

Version2, 2026-09-14.
[Source and finite-scheme argument](../../../Proofs/atlases/finite_algebras/linear_system_compression.md).
