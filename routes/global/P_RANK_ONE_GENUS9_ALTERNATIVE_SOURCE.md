# An optional genus-nine source with p-rank one

**Status: exact computation and author proof, 2026-09-05. Not independently
audited. This is an isolated alternative source, not a replacement for either
curve in file 76 and not a new common-cover exclusion for that pair.**

Over \(k=\overline{\mathbf F}_5\), let \(X_1\) be the smooth projective model
of

\[
                         y^2=x^{19}+x^{14}+1.
\]

Then \(g(X_1)=9\), its geometric p-rank is one, and its Jacobian is
geometrically absolutely simple. Its geometric endomorphism algebra is a
number field of degree 18, with no nontrivial abelian subfield.

The exact computations are reproduced by
[P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE_CERTIFICATE.sage](P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE_CERTIFICATE.sage).
Sage's local documentation identifies PARI `hyperellcharpoly` as the supported
small-characteristic algorithm. On the installed Sage 10.9, the first
Frobenius calculation took approximately 0.017 seconds, without exhaustive
point counting or a search beyond this first candidate.

## Geometry and p-rank

For \(f=x^{19}+x^{14}+1\),
\(f'=4x^{13}(x+1)^5\), whereas \(f(0)=f(-1)=1\). Thus \(f\) is
square-free. Its odd degree 19 gives genus nine.

Write \(c_j\) for the coefficient of \(x^j\) in \(f^2\). The Hasse--Witt
matrix is \(H=(c_{5i-j})_{1\le i,j\le9}\). Its entries lie in
\(\mathbf F_5\), so the ranks of its ordinary powers are the ranks of the
successive Frobenius iterates. Exact computation gives

\[
 \operatorname{rank}(H^j)=5,4,3,2,1,1,1,1,1\quad(1\le j\le9).
\]

The stable rank, hence the geometric p-rank, is one.

## Frobenius and the full signed group

The exact characteristic polynomial of 5-power Frobenius is

\[
\begin{aligned}
P(T)={}&T^{18}-T^{17}-10T^{15}+30T^{14}-50T^{13}+130T^{12}
 -435T^{11}+925T^{10}-700T^9\\
 &+4625T^8-10875T^7+16250T^6-31250T^5+93750T^4
 -156250T^3-390625T+1953125.
\end{aligned}
\]

Its reduction is \(T^{17}(T-1)\), independently agreeing with p-rank one.
It has the exact identity \(P(T)=T^9Q(T+5/T)\), where

\[
 Q(U)=U^9-U^8-45U^7+30U^6+705U^5-250U^4-4370U^3
             +315U^2+8350U+2400.
\]

All reductions used below are square-free:

| Prime | Factor degrees of Q | Factor degrees of P used |
| --- | --- | --- |
| 11 | 9 | 18 |
| 3 | 8, 1 | — |
| 229 | 7, 2 | 14, 4 |

The action on the nine reciprocal pairs is transitive by the first row.
The 8-cycle with a fixed point makes it primitive: a nontrivial block system
would consist of three blocks of size three, but the block containing the
fixed point cannot be invariant under that 8-cycle. The seventh power of
the permutation of type \((7)(2)\) is a transposition. A primitive group
containing a transposition is \(S_9\).

The full Galois group is a subgroup of \((C_2)^9\rtimes S_9\). The
18-cycle at 11 has ninth power switching all nine reciprocal pairs.
The signed cycle at 229 consists of a negative 7-cycle and a negative
2-cycle; its fourteenth power switches exactly the two pairs in the latter.
Conjugation by the surjective \(S_9\)-action supplies every weight-two
switch vector. These span the even-parity subspace of \(\mathbf F_2^9\).
The all-nine switch has odd parity, so the kernel contains all of
\((C_2)^9\). Therefore the full Galois group is

\[
                            W_9=(C_2)^9\rtimes S_9.
\]

Theorem 99.1 now applies: no ratio of distinct Frobenius roots is a root of
unity, and every positive Frobenius power has irreducible characteristic
polynomial of degree 18. The Jacobian is consequently absolutely simple
over every finite extension, and hence geometrically. The same theorem
gives

\[
 \operatorname{End}^0_k J(X_1)=\mathbf Q(\pi),\qquad
 [\mathbf Q(\pi):\mathbf Q]=18,\qquad
 \mathbf Q(\pi)\cap\mathbf Q^{\rm ab}=\mathbf Q.
\]

## Scope

This computation supplies an optional source parameter with p-rank one.
It does not change the genus-\((9,25)\) pair in file 76. For that pair,
the ratio three already prevents pure 5-group common-cover monodromy by
Riemann--Hurwitz; no new exclusion of such a current family is claimed.
No additional target curve or alternative pair has been constructed here.
