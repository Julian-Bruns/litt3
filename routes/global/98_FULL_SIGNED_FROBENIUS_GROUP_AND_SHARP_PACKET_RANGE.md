# Full signed Frobenius group and the sharp packet range

**Status: proved; independently audited PASS, 2026-09-04. The target
arithmetic input from file 76 has also been checked. Exact modular
checks PASS.**

[Combined audit, with auditor and nonbreaking suggestions](audits/95_96_98_ALL_DEGREE_PACKET_CHAIN_AUDIT.md).
[Target arithmetic audit](audits/76_GENUS25_Y_ARITHMETIC_AND_SIGNED_RATIO_AUDIT.md).

This note sharpens the arithmetic input to files 95--96. The genus-25
Jacobian in file 76 has **no nontrivial abelian subfield** in its geometric
endomorphism field. Thus their constant \(a_0\) is one, not merely at
most two. No large number-field subfield computation is needed.

## 1. A parameterized signed-group certificate

Let \(n\ge3\) be odd, let \(q>0\), and suppose a separable polynomial

\[
                  P(T)=T^nQ(T+q/T)\in\mathbf Q[T]
\]

has \(2n\) distinct nonzero roots forming \(n\) distinct pairs
\(\{\alpha_i,q/\alpha_i\}\). Let \(G\) be its splitting-field
Galois group. The reciprocal pairing gives

\[
             G\le V\rtimes S_n,\qquad V=\mathbf F_2^n.
                                                               \tag{98.1}
\]

The projection to \(S_n\) is the Galois action on the roots of \(Q\).
A coordinate of \(V\) switches the two roots in one pair.

### Lemma 98.1

Suppose the projection of \(G\) to \(S_n\) is surjective and
\(G\cap V\) contains both a vector of weight two and a vector of odd
weight. Then

\[
                         G=\mathbf F_2^n\rtimes S_n.    \tag{98.2}
\]

#### Proof

The subgroup \(G\cap V\) is invariant under the projected \(S_n\).
The permutation orbit of a weight-two vector consists of all vectors
\(e_i+e_j\). These span the even-weight hyperplane \(V_0\).
An odd-weight vector together with \(V_0\) spans \(V\), so
\(V\subset G\). Surjectivity onto \(S_n\) now gives (98.2).
\(\square\)

### Lemma 98.2

Let \(N/\mathbf Q\) have Galois group
\(W=\mathbf F_2^n\rtimes S_n\), \(n\ge3\), acting on \(2n\)
signed letters. If \(K=N^H\), where \(H\) is the stabilizer of one
signed letter, then

\[
                         K\cap\mathbf Q^{\rm ab}=\mathbf Q.
                                                               \tag{98.3}
\]

#### Proof

The abelianization of \(W\) is \(C_2\times C_2\), given by total
sign-switch parity and permutation parity. Indeed,

\[
                       [W,W]=V_0\rtimes A_n:
\]

commutators of a permutation with a coordinate switch generate \(V_0\),
and commutators in \(S_n\) generate \(A_n\); the displayed quotient
is abelian.

The stabilizer \(H\) surjects onto this abelianization. It contains
a switch at a different coordinate, realizing the first parity, and
a transposition of two other coordinates, realizing the second.
Hence \(\langle H,[W,W]\rangle=W\).

For an abelian extension \(E/\mathbf Q\) contained in \(K\), the
subgroup \(\operatorname{Gal}(N/E)\) contains both \(H\) and
\([W,W]\). It must be \(W\), proving \(E=\mathbf Q\).
Apply this to \(E=K\cap\mathbf Q^{\rm ab}\). \(\square\)

## 2. Two small factorizations for the current target

Let \(Y\), \(P_Y\), and \(Q_Y\) be as in file
[76](../../Theorems/Thm_fixed_pair_arithmetic.md), so

\[
 Y:\ z^2=(t^{25}+t^5+t)(t^{25}+t^5+t-1)(t-4),\qquad
 P_Y(T)=T^{25}Q_Y(T+5/T).
\]

File 76 proves \(\operatorname{Gal}(Q_Y)=S_{25}\). Exact square-free
factorizations give the following degrees:

\[
\begin{array}{c|c|c}
 \text{prime}&Q_Y\bmod\ell&P_Y\bmod\ell\\ \hline
 47 &(25)&(50)\\
 467&(23,2)&(46,4).
\end{array}                                                   \tag{98.4}
\]

The short certificate below checks the two rows directly from the
polynomial already recorded in file 76.

### Proposition 98.3

The splitting-field Galois group of \(P_Y\) is

\[
                    \mathbf F_2^{25}\rtimes S_{25}.
                                                               \tag{98.5}
\]

Consequently, for the geometric endomorphism field
\(K=\operatorname{End}^0_kJ(Y)=\mathbf Q(\pi_Y)\),

\[
                         K\cap\mathbf Q^{\rm ab}=\mathbf Q.
                                                               \tag{98.6}
\]

#### Proof

A good-prime Frobenius element at 467 has cycles of lengths 23 and 2
on the reciprocal pairs. The factorization of \(P_Y\) shows that
both cycles are negative: a positive length-\(r\) pair-cycle lifts
to two length-\(r\) cycles, whereas a negative one lifts to one
length-\(2r\) cycle. Thus its 46th power fixes every pair, is the
identity on the 23-cycle, and switches both pairs in the 2-cycle.
This is a weight-two vector in \(G\cap V\).

At 47 the Frobenius element is a negative 25-cycle on pairs, since
it is a 50-cycle on roots. Its 25th power switches all 25 pairs.
This is an odd-weight vector. The projection of \(G\) to \(S_{25}\)
is already surjective by file 76. Lemma 98.1 proves (98.5).

The irreducibility of \(P_Y\) identifies \(K\) with the fixed field
of a signed-letter stabilizer. Lemma 98.2 proves (98.6).
The identification with the full geometric endomorphism field uses
ordinarity and absolute simplicity from file 76, as explained in
file 95. \(\square\)

## 3. Uniform geometric consequences

The following consequences use the proofs in files 95--96; they do not
add an independent audit of those proofs or the arithmetic input in 76.

### Corollary 98.4: all smaller genera, all abelian covering degrees

For every curve \(X/\overline{\mathbf F}_5\) with

\[
                          2\le g(X)<25,
\]

no connected finite abelian etale Galois cover of \(X\) admits a
nonconstant map to the fixed curve \(Y\) above.

#### Proof

Use Theorem 95.1 with \(a_0=1\). Its two necessary inequalities
would give \(25\le g(X)\) or \(25\le g(X)-1\), both false.
\(\square\)

### Corollary 98.5: a nonabelian monodromy threshold

Let \(2\le g(X)<25\), and suppose an etale Galois \(H\)-cover of
\(X\) admits a nonconstant map to \(Y\). Then some complex
irreducible character \(\chi\) of \(H\) satisfies

\[
        \frac{\chi(1)}{e_K(\chi)}\ge\frac{25}{g(X)-1}.
                                                               \tag{98.7}
\]

Here \(e_K(\chi)\) is the Schur index after extending the character
field to its compositum with \(K\), as in file 96.

In particular, a cover is impossible if every irreducible character
of \(H\) has degree at most \(b\), where

\[
                          b(g(X)-1)<25.                       \tag{98.8}
\]

It is enough that \(H\) has an abelian subgroup of index at most
\(b\). The order of \(H\) is unrestricted.

#### Proof

Every character field is cyclotomic-abelian, so (98.6) makes the
intersection degree in Theorem 96.2 equal to one. This gives (98.7).
The Schur index is at least one. Finally an irreducible character of
a finite group with an abelian subgroup of index \(b\) has degree
at most \(b\), by Frobenius reciprocity. \(\square\)

For the current genus-nine \(X\), (98.8) excludes every group with
all irreducible degrees at most three, including all groups with an
abelian subgroup of index two or three. This is a genuinely nonabelian,
unbounded-degree extension; it includes all finite dihedral groups.

For **any** genus-three \(X\), the same fixed \(Y\) excludes every
group having an abelian subgroup of index at most twelve. These are
tests of the genus-parameterized inequality, not separate degree
computations.

## 4. What this does not remove

An arbitrary common etale cover can be replaced by its Galois closure
over \(X\), without losing the etale map to \(Y\). Therefore these
results apply to the monodromy group of a possibly non-Galois first
leg. They do not require that the original first leg itself be Galois.

What remains is unrestricted nonabelian monodromy: its irreducible
character degrees are unbounded. One cannot remove this restriction
from the stronger no-domination statement in all cases. For
hyperelliptic \(X\), Bogomolov--Tschinkel prove that some finite etale
cover of \(X\) dominates every curve, when the map to the target may
ramify; see their
[Theorem 1.7](https://people.math.harvard.edu/~ctm/home/text/others/bogomolov/unramif/unramif.pdf).
Thus a proof for all monodromy groups must recover information from
the requirement that the second leg is etale, or impose further
substantive conditions on \(X\).
