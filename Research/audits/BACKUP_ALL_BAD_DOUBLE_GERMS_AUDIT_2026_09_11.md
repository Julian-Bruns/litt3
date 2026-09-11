# Audit: all twelve bad active doubles at the backup

Verdict: PASS for the proposed one-leg theorem in
`Solutions/Sol_backup_active_double_germs.md` (the canonical location).

Auditor: `/root/audit_backup_all_bad_double_germs`.
Date: 2026-09-11. This is a bounded mathematical and exact-arithmetic
audit, not Lean verification. No coefficient correction was found.

## Scope and inherited inputs

The general classification of active genus-two connections by the fifteen
branch-pair quartics, together with the split dormant-pair construction,
is used in its recorded canonical scope. The actual abelian-cover/Picard
presentation of `bad_double_abelian_a3_family` is an established input.
This audit checks their application to the complete backup table, the
new degree-one cover polynomials, all twelve actual injections and germs,
and both all-level balanced-cover formulas. It does not newly audit every
upstream theorem or promote an author-proof dependency to a broader status.

The conclusion is exactly ten A3 germs and two A1 germs among the twelve
bad active double-cover pairs on the specified backup. It is not a
common-cover exclusion, a forced domination statement, a non-balanced
cover formula, or a higher-Witt obstruction calculation.

## 1. Exhaustion and the actual active datum

The backup parameter is alpha^3+alpha+1=0 over F5. I inspected and reran
the complete 85-connection, 1,275-twist calculation. For every nonsplit
branch-pair class it verifies that the critical quartic has four simple
roots, is coprime to the scalar K, and has nonzero branch scalar c. The
quotient-algebra tests include every geometric root, not just F125 roots.
The five geometric dormant roots are also all retained, with all ten
unordered pairs for the split active connections.

The rerun reproduces the table exactly, apart from runtime: all 85
endpoint active connections are ordinary; 79 have no bad double twist;
six have two bad twists, each of defect one. The sole additional mixed
datum is source R0=u-alpha with h=3alpha. Its two bad cover polynomials
are u(u-2) and (u-1)(u-3). Its defining formula J(h)=0, K(h)!=0 and the
original normalized quartic Cartier identity were checked again in the
independent replay, not merely read from a stored scalar label.

The actual coefficient is A=cS0 in a branch case and
A=K(h)R0(u-h)^2 in a mixed case. In the u-coordinate its quartic is
a=A/F^2. Passing from the tangent frame d/du to eta^(-1)=v d/du changes
the Frobenius source-to-target coefficient by v^4=F^2, so the actual
normal injection is multiplication by A in this frame. Thus the initial
cochains A b_j^5 used in the calculation are the actual Hodge-projection
map. No polynomial has been substituted only because it has a convenient
rank or the same zero divisor.

## 2. The degree-one covers have the claimed exact Cech model

For the actual double kappa^2=R, ell^2=S=F/R, v=kappa ell, the two affine
opens are the complement of the two infinity points and the complement
of the fiber u=0. Their intersection is the Laurent-polynomial algebra
with the four components 1,kappa,ell,v. The factors R and S are squarefree
and coprime, so this is the actual smooth affine fiber product, not an
unnormalized singular model.

The potentially delicate case is deg(R)=1. At either infinity the
valuations are then

    ord(u,kappa,ell,v,eta)=(-2,-1,-4,-5,2),

instead of (-2,-2,-3,-5,2) in degree two. A tangent coefficient in the
eta^(-1) frame must have order at least two. Both valuation lists give
the same integral cutoffs

    1: j<=-1; kappa: j<=-2; ell: j<=-3; v: j<=-4.

Likewise the regular-function cutoffs are respectively 0,-1,-2,-3 in
both cases. The tangent basis is therefore exactly

    v/u, v/u^2, v/u^3, ell/u, kappa/u, ell/u^2,

and the H1(O) basis is v/u,v/u^2,ell/u in both cases. The order-four
character action preserves the pair of infinity points. Since four is
invertible, componentwise projection preserves simultaneous regularity
at those two points; cross-character cancellation cannot enlarge these
regular submodules. This proves exactness of the cutoffs, with no series
precision parameter and no extra exception at degree-one R.

## 3. Picard coordinates and coefficient Frobenius

The independent replay computed the H1(O) Frobenius matrix directly from
fifth powers in the actual nested quadratic algebra. All twelve matrices
are invertible. Hence the required three actual Artin--Schreier directions
span H1(O), and the normal-basis/Picard argument of the canonical family
theorem applies to each of these curves.

That argument is local for an ordinary curve and its actual abelian
torsor: it does not depend on deg(R)=2. Through degree four the torsor
normal-generator transitions give exp(sum chi_i log(1+e_i)); its tangent
map to the smooth three-dimensional Picard space is invertible. The
augmentation uses the trace/normal-generator identification, not the
constant function. The source and target are the actual twisted tangent
cohomology groups, free of rank six, and the six fixed cochains remain
bases by reduction and Nakayama.

On the relative Frobenius pullback the curve functions have fifth powers
while X,Y,Z are fixed. This distinction was respected in the independent
calculation: its direction displacement was sum d_i b_i^5, not
(sum d_i b_i)^5. One tested direction was (1,alpha,alpha^2), so this check
was not confined to coefficients in F5.

The same actual-cover presentation gives the full completed scalar
relation. Only its four-jet is identified through Picard here. Since both
resulting singularity types are determined by this four-jet, an arbitrary
full formal extension of the invertible four-jet coordinate change is
sufficient; no claim that the full formal Picard family itself consists
of actual finite-cover characters is needed.

## 4. Independent arithmetic and both elimination steps

The new replay script is `scripts/audit_backup_bad_double_jets.py`.
It imports neither jet producer. Instead of sparse four-component
dictionaries it uses the nested Sage algebra

    k[u,u^-1][K]/(K^2-R)[L]/(L^2-S),

forms the initial images and relative Frobenius functions by direct fifth
powers, and applies the exact infinity projection. It then obtains the
scalar as the quotient of the full 6-by-6 determinant and the independently
selected good 5-by-5 determinant, with the row/column permutation sign.
It does not reuse the producer's Schur-vector recurrence.

All twelve constant matrices and second semilinear ranks agree and have
rank five. Independent rows and columns are allowed: a nonzero 5-by-5
minor supplies invertible formal row/column elimination regardless of
whether their index sets coincide. No self-adjoint presentation is needed.

For each case, eight separately computed directional evaluations replay every
coefficient of the full 6-by-6 matrix through degree four. The three axis
and three pair-sum values recover the entire Hessian. Each rank-two case
has an additional replay on its independently recovered radical. Thus
106 complete matrix directional jets were checked, including all twelve
constant matrices, all Hessians and all ten radical quartics. They agree
exactly with the saved outputs. The two mixed Hessian determinants are
(0,0,3) and (3,4,2), in the basis (1,alpha,alpha^2), both nonzero.

The hyperelliptic involution ell -> -ell fixes kappa and negates every
Picard cocycle. Its exceptional source and target characters agree in
all twelve pivot choices. The determinant quotient is consequently even.
The replay also checks the character parity of every stored matrix
coefficient and vanishing of all stored linear and cubic scalar terms.
This is a geometric reason for the full cubic vanishing, not inference
from a few directions.

For the ten rank-two Hessians, all ten radical quartics in the proposed
table agree with the independent determinant computation and are nonzero.
Because the cubic scalar part vanishes, solving the transverse critical
equations gives transverse corrections of order at least three. Their
effect on the quadratic part starts in order six, so the corrected
radical quartic is exactly the one computed. The determinant quotient
already includes every invertible-block Schur correction. The two kinds
of correction have therefore both been accounted for.

Formal splitting uses only invertibility of two. The residual one-variable
series has a nonzero quartic leading term, and a formal fourth root of
its unit factor exists because four is invertible. This gives UV+W^4.
For the two rank-three Hessians, successive formal completion of squares
gives a nondegenerate ternary quadratic form, hence UV+W^2 over k. This
Morse step also requires only invertibility of two, not factorials of
unbounded order in characteristic five.

## 5. Every balanced level and the scope of the bound

For q=5^n, the balanced truncation ideal is the intrinsic Frobenius-power
ideal m^[q]. Every formal coordinate automorphism preserves it, as does
the inverse automorphism. Consequently the actual balanced-cover defect
is the truncated hypersurface length after either formal normal form.

For UV=W^2, the semigroup consists of pairs (a,b)>=0 with a=b mod 2.
The quotient by U^q,V^q,W^q retains a,b<2q with at least one of a,b<q.
Writing q=2m+1 gives

    2q^2-((m+1)^2+m^2)=(3q^2-1)/2.

For UV=W^4 the canonical A3 count applies, giving (7q^2-3)/4. As a
separate algebraic check, the replay constructs the six actual polynomial
quotient ideals and computes their vector-space dimensions by Groebner
bases, rather than reusing the semigroup count:

| Exponent | q=5 | q=25 | q=125 |
|---|---:|---:|---:|
|2|37|937|23437|
|4|43|1093|27343|

Pullback of global sections of the actual etale-compatible defect bundle
is injective under every further actual etale cover. This gives the
stated dominating-source lower bounds. No arbitrary source is asserted
to dominate one of these towers, and there is no implication about a
second endpoint or higher inverse-Cartier lifting from these Picard jets.

## Replay receipt

Command:

    sage -python scripts/audit_backup_bad_double_jets.py --output Research/computations/backup_all_bad_double_jet_audit.json

Final execution time: 3.053 seconds. Every assertion passed. The receipt
records all thirteen input hashes, every case, and the six quotient lengths.

Receipt SHA256:

    d78dd02c43487f95a857a7e63ac000ebf29a9a7bd0090538b06902922497896a

Replay script SHA256:

    bdbf60a6e7c931a8a849192881e6da4d14ce95d1e83557c756385f817c4a36d8

The complete active-twist replay is separately saved as
`Research/computations/backup_active_twist_table_audit_replay.json`.
It took 0.382 seconds and reproduced the same 79/6 histogram and all
twelve bad records. The original table hash is
`b93b779cdf75822193a361f53b0aae88bf76353fdbd4f3230d6540b445ea9908`.

No canonical theorem, library status, main strategy, or existing proof
was changed by this audit.
