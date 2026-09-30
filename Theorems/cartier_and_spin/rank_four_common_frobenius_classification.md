# Rank-four Frobenius instability is exactly a Cartier twist

Version2,21September2026. Let $k=\overline{\mathbf F}_5$ and let
$X\xleftarrow fZ\xrightarrow gY$ be an ACTUAL finite etale span
of smooth proper hyperbolic curves, with $g(Y)=2$, no clump, and
no common regular projective connection. All identifications below
are on this original source or its indicated coefficient twist.

Write $F_C:C\to C^{(1)}$ for relative Frobenius and
$B_C=F_{C*}\mathcal O_C/\mathcal O_{C^{(1)}}$. Let $E$ be a
common rank-four bundle on the first twisted endpoints, semistable
on both of them. Then
\[
E\text{ is not strongly semistable}
\quad\Longleftrightarrow\quad F^*E\text{ is unstable}
\quad\Longleftrightarrow\quad
E\simeq B\otimes L
\text{ for an ACTUAL common line bundle }L.
\tag{1}
\]
In particular, every bundle in (1) is common-simple. The isomorphism
retains the specified comparison, and not just the two endpoint
isomorphism classes. Moreover, NO line twist of $B$ admits a common
connection in this no-oper branch, so it cannot have a common
Cartier antecedent. The same statement applies on every twist.

Consequently $4\mid\deg E_Y$ for any exceptional rank-four bundle.
Rank-four degree not divisible by four forces strong semistability.
More generally ONE Frobenius pullback decides strong semistability
for every common semistable bundle of rank at most four in the
no-oper branch; there is no delayed instability at those ranks.

There is a degree-zero existence criterion on the fixed span:
\[
\begin{split}
&\text{a common semistable rank-four degree-zero bundle fails
strong semistability}\\
&\qquad\Longleftrightarrow\qquad
\text{there is a common line bundle of degree one on }Y.
\end{split}
\tag{2}
\]
Here existence on a Frobenius twist transfers by the inverse
COEFFICIENT twist, not by identifying relative Frobenius pullbacks.
In the terminology of the
[common Picard group](../shared_tensors/saturated_divisor_relations.md),
(2) is equivalent to its degree generator being $e=1$, rather than
$e=2$. Together with the
[rank-two and rank-three theorem](low_rank_common_frobenius_instability.md),
this shows that when $e=2$ all common semistable degree-zero bundles
of ranks at most four are strongly semistable.

Dropping ONLY the no-common-oper assumption, let $m$ be the least
rank of a common semistable degree-zero bundle which is not strongly
semistable. This rank always exists, and its exact value is

| Common regular projective oper | $e=1$ | $e=2$ |
| --- | --- | --- |
| Exists | $m=2$ | $m=3$ |
| Does not exist | $m=4$ | $m=5$ |

The rank-five example in the last entry is the actual common bundle
$T=F_*\omega^{-2}$. It is common-simple of degree zero; the top
canonical line in $F^*T$ is $\omega^2$. The table measures objects
with the ORIGINAL source comparison, before choosing any cover to
make theta characteristics common. It does not assert which row
or column occurs for an unknown span of the fixed pairs.

The new case in the proof is a Harder--Narasimhan filtration with
two rank-two grades. A full-rank second fundamental form gives a
two-block oper and a scalar projective connection by taking the
trace of its normalized matrix differential operator. A rank-one
second fundamental form gives a dormant rank-two subquotient.
Both contradict the no-oper assumption. The remaining case is a
full dormant rank-four oper, whose complementary Frobenius quotient
is a line; finite Frobenius duality identifies its kernel as (1).

This is a direct author proof, not independently audited. It does
not construct an unstable common bundle or a common degree-one
line for either selected pair. It sharpens the rank-four boundary;
both original common-cover problems remain open.

[Proof](../../Proofs/cartier_and_spin/rank_four_common_frobenius_classification.md).
