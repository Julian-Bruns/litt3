# Task 03: exclude the no-highpoint branch

## Status

Open. The proposed residual family has two independent gaps:

1. no proof extracts that family from every no-highpoint profile pair; and
2. no normalization-aware elimination of the full family is present.

The old resultant tests are not active proofs: their sources are absent, and
a singular point of the plane image can be a common zero of the equation and
a partial derivative even when every branch of the normalization is
unramified.

## Profile input

Work over \(k=\overline{\mathbb F}_5\). Let \((C,x,r)\) be the profile-4 pair
defined in Task 02, with incidence matrix

\[
M=\begin{pmatrix}0&1&3\\1&2&1\\3&1&0\end{pmatrix},
\]

and assume that the six high points

\[
P_0,P_1,P_\infty,Q_0,Q_1,Q_\infty
\]

are pairwise distinct.

The theorem to prove is:

> **No-highpoint exclusion.** No such profile-4 pair exists.

The residual construction below is one possible route, not an established
normal form.

## Candidate residual family

On \(\mathbb P^1_X\times\mathbb P^1_R\), define

\[
\begin{aligned}
P(X,R)= {}&R^4X^4-R^4X^3-R^3X^4+2R^3X-2R^2X\\
          &+2RX^3-2RX^2+R+X-1,
\end{aligned}
\]

\[
L=4XR+4X+4R+2,\qquad D=X(X-1)R(R-1).
\]

The line \(L=0\) is the graph

\[
R=\frac{4X+2}{X+1},
\]

which sends \(X=0,1,\infty\) to \(R=2,3,4\). For

\[
A(X,R)=\sum_{0\le i,j\le32}a_{ij}X^iR^j,
\]

put

\[
H_A=L^{31}P-DA.                                           \tag{1}
\]

File `170` proves the six boundary restrictions of (1) and the two necessary
corner conditions

\[
a_{0,32}=2,\qquad a_{32,0}=2.
\]

It does not prove the remaining branch opens, distinctness, integrality, or
genus conditions.

## Correct ramification condition

Suppose \(H_A=0\) is geometrically integral and let
\(\nu:C_A\to\Gamma_A\) be its normalization. A valid residual candidate must
make the two coordinate functions on \(C_A\) separable degree-\(35\) profile
maps of genus \(11\). Riemann--Hurwitz then leaves no ramification away from
the three order-\(31\) boundary branches.

This condition is intrinsic to \(C_A\). On the smooth affine image locus
where \(DF\ne0\), with \(F=LP\), candidate ramification points can be written

\[
\begin{aligned}
N_R&=F\,\partial_R(DA)-DA\,\partial_RF,\\
N_X&=F\,\partial_X(DA)-DA\,\partial_XF.
\end{aligned}
\]

There the \(X\)-projection ramifies at \(H_A=N_R=0\), and the
\(R\)-projection ramifies at \(H_A=N_X=0\). At a singular image point both
partials vanish automatically, so these equations must be pulled back to the
normalization or analyzed branch by branch. Merely finding a nonconstant
resultant does not eliminate a candidate.

Do not impose \(N_R=N_X=0\) as polynomial identities. Conversely, demanding
that both plane common-zero loci be empty is a stronger sufficient
restriction and cannot classify candidates with interior singular images
unless those images are first proved smooth there.

## Complete residual route

A proof through (1) must establish both statements:

1. **Residual extraction.** Every no-highpoint profile-4 pair can be put in
   the form (1), with all boundary branches, open conditions, and degree
   bounds justified. In particular, prove rather than assume that the six
   cross-values \(r(P_i)\) and \(x(Q_j)\) can be the fixed values
   \(2,3,4\) encoded by \(L\). Once the target values \(0,1,\infty\) are
   fixed, arbitrary triples cannot be moved to these values by a free
   projective-coordinate change.
2. **Normalization-aware elimination.** No \(A\) in that full family has an
   integral image whose normalization has genus \(11\), the prescribed
   boundary profiles, and no interior ramification for either projection.

An explicit \(A\) satisfying all those conditions would instead disprove the
proposed exclusion. A direct proof not using the residual family is equally
acceptable.

## Reading

Read [the route note](../routes/profile4/no_highpoint/170_NO_HIGHPOINT_RESIDUAL_GATE.md).
The missing notes `52`, `60`, and `62` and their reported sparse searches may
be used only after their calculations are independently reconstructed.
