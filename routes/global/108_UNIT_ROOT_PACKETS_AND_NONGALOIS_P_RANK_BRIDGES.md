# Unit-root packets and non-Galois p-rank bridges

**Status: author proofs, 2026-09-05. Developed by the main agent with
`canonical_trace_algebra` and `x_elliptic_quotient_maps`; not independently
audited.** The representation-descent input is the audited Lemma 96.1.

These results refine the dimension method for an **ordinary** target.
They also isolate a genuine difference between Galois and non-Galois
etale covers. They do not solve the common-cover problem.

## 0. Relevance filter before applying a group exclusion

If a smooth connected projective curve (Z) has finite etale maps to
(X,Y), and (W/X) is the Galois closure of (Z/X), then (W/Y) is
still finite etale. Writing (G=\operatorname{Gal}(W/X)),

\[
 \frac{g(Y)-1}{\gcd(g(X)-1,g(Y)-1)}\ \mid\ |G|.                 \tag{108.0}
\]

This is immediate from

\[
 |G|(g(X)-1)=\deg(W/Y)(g(Y)-1).
\]

For the **unchanged** pair in file 76, the genera are (9,25), so
(3\mid |G|). Pure (5)-groups and groups
(C_{5^a}\rtimes C_h) with faithful action and (h\mid4) already fail
this test. Excluding them by the theorems below is **not a new exclusion
for that common-cover pair**. The theorems concern more general
parameters, and in fact prove stronger one-sided domination bounds.

Throughout, the ground field is algebraically closed of characteristic
(p>0); curves are smooth, projective, and connected. Write (f(C)) for
the (p)-rank, and

\[
 V_pJ(C)=T_p(J(C)[p^\infty]^{\rm et})\otimes_{\mathbf Z_p}\mathbf Q_p.
\]

It has dimension (f(C)), not (2g(C)). Rational norm and pullback give
(V_pJ(C)^H\simeq V_pJ(C/H)) for a finite group of automorphisms (H).
Indeed, the invariant projector is (|H|^{-1}\sum_{h\in H}h), including
when (p\mid |H|), since coefficients are in (\mathbf Q_p).

## 1. The exact p-group representation

### Proposition 108.1

For a connected finite etale Galois (P)-cover (D\to X), where (P)
is a nontrivial finite (p)-group,

\[
 V_pJ(D)\simeq \mathbf Q_p\oplus
                \mathbf Q_p[P]^{\oplus(f(X)-1)}.             \tag{108.1}
\]

In particular (f(X)\ge1).

### Proof

The Deuring--Shafarevich formula for any subgroup (H\le P) gives

\[
 f(D/H)=1+[P:H](f(X)-1).                                    \tag{108.2}
\]

For (H=1), nonnegativity shows (f(X)\ge1): if (f(X)=0), then
(f(D)=1-|P|<0).

Let (\theta) be the character of (V_pJ(D)). We prove that
(\theta(u)=1) for (u\ne1), by induction on the order (p^a) of (u).
The character values on all generators of (\langle u\rangle) agree:
the local cyclotomic Galois group
(\operatorname{Gal}(\mathbf Q_p(\zeta_{p^a})/\mathbf Q_p)) acts
transitively on primitive (p^a)-th roots, and the representation is
defined over (\mathbf Q_p).

The average of (\theta) on (\langle u\rangle) is, by (108.2),
(1+|P|p^{-a}(f(X)-1)). After multiplying by (p^a), subtract the
identity value (1+|P|(f(X)-1)), and subtract the known values (1)
at all nonidentity elements of smaller order. The remaining sum is
(\varphi(p^a)). Thus the common value at generators is (1).
This is exactly the character of the right side of (108.1).
Semisimplicity in characteristic zero proves the isomorphism. \(\square\)

The standard cohomological source is Crew, *Etale p-covers in
characteristic p*, Compositio Mathematica **52** (1984), Theorems 1.5
and 1.8 ([primary text](https://www.numdam.org/item/CM_1984__52_1_31_0.pdf)).
The argument above derives the representation directly from the
unramified Deuring--Shafarevich formula.

## 2. Ordinary target packet bound

### Theorem 108.2

Let (D\to X) be as in Proposition 108.1. Suppose (D) has a
nonconstant map to a curve (Y) whose Jacobian (A=J(Y)) is ordinary,
simple, and has geometric endomorphism algebra a number field (K).
Put (g=g(Y)). Then either

\[
                         g\le f(X),                          \tag{108.3}
\]

or a nontrivial complex irreducible character (\chi) of (P), with
(d=\chi(1)), (F=\mathbf Q(\chi)), and the Schur index
(e_K(\chi)) of file 96, satisfies

\[
 g\le (f(X)-1)[F\cap K:\mathbf Q]\frac{d}{e_K(\chi)}.         \tag{108.4}
\]

The map (D\to Y) need not be etale or separable. If it comes from a
common etale cover, both original maps remain part of the hypotheses
of that application; the stronger statement does not replace them.

### Proof

The nonconstant map makes (A) an isogeny factor of (J(D)), by
pullback and norm (also for a finite inseparable map, since their
composition is multiplication by its degree).

The trivial rational (P)-packet is isogenous to (J(X)). If it
contains (A), the additivity of (p)-rank under isogeny and
ordinariness of (A) give (g\le f(X)).

Otherwise choose a nontrivial rational packet containing (A),
represented by (\chi), and denote its abelian factor by (B_\chi).
Formula (108.1) gives its **exact** (p)-rank

\[
 f(B_\chi)=(f(X)-1)[F:\mathbf Q]d^2.                        \tag{108.5}
\]

Indeed, over an algebraic closure of (\mathbf Q_p), each character
in the rational orbit occurs in the regular representation with its
degree (d), and there are ([F:\mathbf Q]) such characters. This
calculation uses a rational central idempotent and is independent of
the splitting of (p) in (F).

Let (A^m) be the full (A)-isotypic factor of (B_\chi). It is
(P)-stable. The (K)-space (\operatorname{Hom}^0(A,A^m)), of
dimension (m), is a (K[P])-module in this rational packet.
Lemma 96.1 therefore gives, with a compatible character and embedding,

\[
 m\ge d\,e_K(\chi)[F:F\cap K].                             \tag{108.6}
\]

Since (A) is ordinary, (f(A^m)=mg). Combining (108.5)--(108.6)
with (mg\le f(B_\chi)) proves (108.4). Notice that the descent
argument occurs at the level of abelian varieties and (K[P])-modules;
it does not assume faithfulness of a particular (p)-adic component
of the action of (K). \(\square\)

### Corollary 108.3

If (f(X)=1), no connected finite etale (p)-group Galois cover of
(X) dominates an ordinary curve of genus at least two.

In fact all these covers have (p)-rank one by (108.2), so simplicity
or endomorphism hypotheses on the ordinary target are unnecessary
in this corollary.

## 3. An exact non-Galois bridge for Frobenius groups

### Proposition 108.4

Let (W\to X) be finite etale Galois with group (G=P\rtimes H),
where (P) is a finite (p)-group, (h=|H|), and (G) is a
Frobenius group in its action on (G/H): every nonidentity element
fixes at most one point. Equivalently in this situation, every
nonidentity element of (H) acts fixed-point freely on
(P\setminus\{1\}). Set (B=W/P) and (D=W/H). Then

\[
 f(D)=f(X)+\frac{|P|-1}{h}(f(B)-1).                         \tag{108.7}
\]

In particular this applies to a faithful action
(C_{p^a}\rtimes C_h) with (h>1) prime to (p). Such (h) divides
(p-1). Faithfulness of a complement acting on a *general* (p)-group
is not by itself the required fixed-point-free hypothesis.

### Proof

There is an equality of rational permutation characters

\[
 \mathbf Q[G]\oplus\mathbf Q^{\oplus h}
   \simeq \mathbf Q[G/P]\oplus\mathbf Q[G/H]^{\oplus h}.      \tag{108.8}
\]

At the identity both sides have dimension (|P|h+h). A nonidentity
element of (P) fixes all (h) points of (G/P), and no points of
(G/H). An element outside (P) fixes no points of (G/P), and
exactly one point of (G/H), by the Frobenius-group property. Thus
the characters agree at every element.

Pair (108.8), after extension to (\mathbf Q_p), with (V_pJ(W)).
Quotient invariants give

\[
                    f(W)+h f(X)=f(B)+h f(D).                \tag{108.9}
\]

On the other hand (W\to B) is an unramified (P)-cover, so
(f(W)-1=|P|(f(B)-1)). Substitution proves (108.7).

For cyclic (P=C_{p^a}), a prime-to-(p) subgroup of
(\operatorname{Aut}(P)) has order dividing (p-1) and injects
under reduction modulo (p). Thus every nonidentity automorphism
in that subgroup is multiplication by (u\not\equiv1\pmod p);
its only fixed element in (P) is zero. \(\square\)

## 4. An ordinary-target bound for a cyclic p-kernel

### Theorem 108.5

Under Proposition 108.4, suppose (P=C_{p^a}), and suppose (W)
dominates a curve (Y) with ordinary simple Jacobian (A) and
(\operatorname{End}^0(A)=K), where (K\cap\mathbf Q^{\rm ab}=\mathbf Q).
Assume (A) is not an isogeny factor of (J(B)). Then

\[
 g(Y)\le f(B)-1
       \le f(X)-1+(h-1)(g(X)-1).                            \tag{108.10}
\]

The assumption that (A) is not a factor of (J(B)) is automatic
when (g(Y)>g(X)): here (H\) is cyclic, and the abelian-cover
packet proof of file 95 bounds every such simple factor by (g(X)).

### Proof

Apply the rational (P)-packet decomposition to (J(W)). The
trivial packet is (J(B)), so (A) occurs in a nontrivial packet
indexed by a cyclotomic field (F_j=\mathbf Q(\zeta_{p^j})),
(1\le j\le a). Proposition 108.1 applied over (B) gives the
(p)-rank of this packet as

\[
                      \varphi(p^j)(f(B)-1).
\]

For the full (A^m)-isotypic factor there, the cyclic version of
Lemma 96.1 gives (m\ge\varphi(p^j)): character degree and Schur
index are one, and (F_j\cap K=\mathbf Q). Consequently
(m g(Y)\le\varphi(p^j)(f(B)-1)), proving the first inequality.

The cover (B\to X) is etale of degree (h). Its Jacobian is
isogenous to (J(X)) times a Prym of dimension
((h-1)(g(X)-1)). Its (p)-rank is therefore at most
(f(X)+(h-1)(g(X)-1)). This proves the second inequality.
\(\square\)

## 5. Limits and reusable tests

1. The representation (108.1) is a **p-group** result. An arbitrary
   finite deck group does not have its unit-root representation
   determined by (f(X)) in this fashion.
2. Ordinariness need not ascend along a non-Galois etale cover even
   of degree (p). An explicit degree-five example, with complete
   construction and exact Cartier matrices, is recorded in
   [the non-Galois counterexample note](NONGALOIS_ETALE_DEGREE5_CAN_DESTROY_ORDINARINESS.md).
3. The optional genus-nine source of (p)-rank one in
   [the source certificate](P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md)
   makes Corollary 108.3 available. It is not a replacement for file
   76, and by (108.0) it would not give a new pure-5-group exclusion
   against a genus-25 target.
4. None of these statements supplies a simultaneous Galois closure
   for the two legs. Only the closure over (X) is taken, and the
   map to (Y) is retained by composition throughout.
