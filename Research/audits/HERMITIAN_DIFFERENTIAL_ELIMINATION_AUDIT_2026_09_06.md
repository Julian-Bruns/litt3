# Differential elimination audit

Verdict: PASS. Auditor: `/root/differential_elimination_audit`.
Date: 2026-09-06. Scope: the proposed differential simplification in the
fixed geometric oper scalar construction. This does not re-audit the full
reconstruction, prove atlas nonexistence, or extend its scope to a universal
nonreduced oper family.

Inspected `Definitions/Def_scalar_hermitian_data.md` and
`Solutions/Sol_scalar_hermitian_reconstruction.md`, and the canonical
rank-reduction statement and its dependency list.

Write Dbar(z)=-rho32(delta z) for z in P48. In characteristic5,
delta(t48)=48 t47 delta(t)=-t31+O(t32), while
delta(t49 k[[t]]) is contained in t32 k[[t]]. Moreover delta preserves
Acal: delta(x)=y2 and delta(y)=F'/3. Applying these facts to the exact
affine-plus-gap reduction gives, for every rational z,

    Q(-delta z,z)=(Dbar rho48(z),rho48(z)).

The c48 correction has exactly the required sign. Consequently the fixed
invertible target change (q1,q2) -> (q1-Dbar q2,q2) transforms Q(w1,w2)
into (rho32(w1+delta w2),rho48(w2)).

If H S^[5]=[U,T;delta U,delta T], its determinant is1. Direct inversion
of its transpose gives, with W=kappa5(T+eta5 U)-U lambda5,

    zeta2=W-a eta,
    zeta1=-delta W-a lambda-b eta.

Here delta kills fifth powers and the base scalar a. No derivative of b
is introduced. Thus the transformed first40 equations are precisely

    lambda=-rho32(delta eta+(b/a)eta).

The remaining56 equations are rho48(W-a eta)=0 after substitution.
Lambda is unique, with no minor inversion or rank hypothesis. In
particular a=1,b=0 eliminates all40 extension variables globally within
the stated scalar parameter charts.

For the Frobenius columns v ell5 with v=(-delta U,U), the same identity
gives M1=Dbar M2. Hence the full and lower matrix ranks agree everywhere
in this construction, including the lower-rank loci. This rank equality
must not silently be asserted for every arbitrary-genus presentation in
the general rank-reduction theorem without a corresponding construction.

The identities are linear Laurent identities over the fixed base field
and extend to coefficient algebras with delta acting relatively. On the
existing scalar parameter charts, the first block has invertible linear
coefficient -a and its elimination therefore preserves the equation
scheme, including nilpotents. This does not remove the separate fixed
geometric oper restriction arising in construction of G.

Finite precision remains effective. One may differentiate rationally
before expanding. Alternatively remove aff(eta), retain the gap part and
positive coefficients through48, and use delta(t) through49 when computing
the derivative of that reduced part through31. Differentiating raw
Laurent factors each naively truncated at48 is not sufficient in general:
negative powers can require additional coefficients of delta(t). Existing
local regularity requirements on quotient/certificate charts remain
necessary and are not weakened by this elimination.
