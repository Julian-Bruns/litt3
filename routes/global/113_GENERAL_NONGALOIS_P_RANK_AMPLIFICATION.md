# General non-Galois p-rank amplification

**Status: collaborative author proof, 2026-09-05; not independently
audited.** Main proof: `/root`. Separate verification of the complete
group tower and inequalities: `/root/canonical_trace_algebra`.

This extends the mechanism of file 112 to arbitrary positive base
p-rank. It retains actual finite etale covers throughout. In particular,
the intermediate p-power-degree cover below is NOT assumed Galois.
No older result is removed before an independent audit.

Throughout, curves are smooth, projective and connected over an
algebraically closed field of characteristic p > 0. Write gamma(C) for
the p-rank of C.

## 1. Statements

### Theorem 113.1 (p-monodromy extraction with a quantitative remainder)

Let D -> X be finite etale, with gamma(X) >= 1. Choose a connected
finite etale Galois closure W -> X, and put

\[
 G=\operatorname{Aut}(W/X),\quad D=W/H,\quad
 N=O^p(G),\quad K=H\cap N,\quad E=W/HN.
\]

Here O^p(G) is the smallest normal subgroup with p-group quotient.
Set

\[
 d=[G:HN],\qquad h=[H:K],\qquad n=[N:K],\qquad
 c=[k[N/K]:k],                                            \tag{113.1}
\]

where the last brackets mean the composition multiplicity of the
trivial module in the permutation k[N]-module on N/K.

Then D -> E -> X is an actual finite etale factorization, with
degrees n and d, respectively. The monodromy of E/X is a p-group,
and

\[
 \gamma(E)=1+d(\gamma(X)-1).                              \tag{113.2}
\]

Moreover,

\[
 \boxed{\quad
 \gamma(D)\ge
 1+c(\gamma(E)-1)+\left\lceil\frac{c-1}{h}\right\rceil.
 \quad}                                                   \tag{113.3}
\]

In particular, gamma(D) >= gamma(E), and

\[
 p\mid n\quad\Longrightarrow\quad
                    \gamma(D)\ge2\gamma(E).              \tag{113.4}
\]

Thus if gamma(D) < 2 gamma(E), the residual degree n is prime to p:
the entire p-part of deg(D/X) lies in its p-group-monodromy factor.

### Corollary 113.2 (unconditional bound for p-divisible degree)

For any connected finite etale D -> X with gamma(X) >= 1 and
p dividing deg(D/X),

\[
 \boxed{\quad
 \gamma(D)\ge
 \min\{1+p(\gamma(X)-1),\;2\gamma(X)\}.
 \quad}                                                   \tag{113.5}
\]

Consequently, for odd p and gamma(X) >= 2,

\[
                \gamma(D)\ge2\gamma(X).                 \tag{113.6}
\]

For p = 2 and gamma(X) >= 2, the corresponding consequence is
gamma(D) >= 2 gamma(X) - 1.

### Corollary 113.3 (rank-preserving covers)

If gamma(D) = gamma(X) >= 2, then deg(D/X) is prime to p, for every
characteristic prime p, including p = 2.

If gamma(D) = gamma(X) = 1, then D/X factors through a cyclic
Galois cover E/X carrying exactly the p-part of its degree, with
D/E of degree prime to p. This recovers Theorem 112.3.

The rank-one conclusion does NOT assert that the Galois closure
W has rank one.

## 2. Modular input and its precise scope

Theorem 112.2 proves the following statement from the actual projective
summands in the Cartier-semisimple differential module. If W -> B is
finite etale Galois with group J, and L <= J is any subgroup, then

\[
 \gamma(W/L)\ge [k[J/L]:k]
 \bigl(\gamma(B)-\dim_{\mathbf F_p}\operatorname{Hom}(J,\mathbf F_p)\bigr).
                                                               \tag{113.7}
\]

The subgroup L need not be core-free. The reason is that the projective
cover P_J(k) of the trivial module occurs as an actual direct summand
with the displayed multiplicity, and

\[
 \dim P_J(k)^L=[k[J/L]:k].
\]

These statements concern invariant DIFFERENTIALS, which descend
through finite etale maps compatibly with Cartier. They do not use
the generally false equality between downstairs mod-p etale
cohomology and upstairs invariant mod-p etale cohomology.

The published decomposition and multiplicity input is
[Borne, *A relative Shafarevich theorem*, Lemma 2.1 and Proposition 2.4](https://arxiv.org/pdf/math/0204088),
or [Stalder, *On p-rank representations*, Remark 4.9 and Theorem 5.4](https://arxiv.org/pdf/math/0402340).
File 112 records the proof specialization and module argument.

Finally, c >= 1 always. If p divides [J:L], then c >= 2: the
constant submodule lies in the kernel of augmentation, and the
augmentation quotient supplies a second trivial composition factor.

## 3. Proof of Theorem 113.1

The subgroup N = O^p(G) is p-perfect. Indeed, O^p(N) is characteristic
in N, which is characteristic in G. Hence O^p(N) is normal in G;
both N/O^p(N) and G/N are p-groups, so G/O^p(N) is a p-group.
Minimality of O^p(G) implies O^p(N) = N. Equivalently,

\[
                  \operatorname{Hom}(N,\mathbf F_p)=0.   \tag{113.8}
\]

Define two additional actual intermediate curves

\[
                       B=W/N,\qquad D'=W/K.
\]

Since N is normal, HN is a subgroup and K is normal in H. The
resulting diagram is

\[
 \begin{array}{ccc}
 D'&\longrightarrow&B\\
 \downarrow&&\downarrow\\
 D&\longrightarrow&E\\
 &&\downarrow\\
 &&X.
 \end{array}
\]

All arrows are finite etale. Both D'/D and B/E are Galois with the
same p-group, canonically isomorphic to

\[
                H/K\simeq HN/N\le G/N,
\]

of order h. Also B/X is Galois with p-group G/N of order dh.
The degrees of D'/B and D/E are both n.

Apply Deuring--Shafarevich only to the three genuinely Galois
p-group covers just identified:

\[
 \begin{aligned}
 \gamma(B)-1&=dh(\gamma(X)-1),\\
 \gamma(B)-1&=h(\gamma(E)-1),\\
 \gamma(D')-1&=h(\gamma(D)-1).
 \end{aligned}                                           \tag{113.9}
\]

The first two equations give (113.2). Thus gamma(E) >= 1.

Now apply (113.7) to the etale Galois cover W/B, whose group is
N, and the subgroup K <= N. By (113.8),

\[
                          \gamma(D')\ge c\gamma(B).      \tag{113.10}
\]

Substitute the last two identities in (113.9):

\[
 1+h(\gamma(D)-1)\ge c\bigl(1+h(\gamma(E)-1)\bigr).
\]

Dividing by h and using integrality gives precisely (113.3).
For c >= 1 this implies gamma(D) >= gamma(E). If p divides n,
then c >= 2. Since gamma(E) - 1 >= 0 and
ceil((c - 1)/h) >= 1, the right side of (113.3) is at least

\[
                  1+2(\gamma(E)-1)+1=2\gamma(E).
\]

This proves (113.4) and the theorem. \(\square\)

## 4. Proof of the corollaries

The degree of D/X is dn, where d is a p-power. If p divides dn,
there are two cases.

If d > 1, then d >= p and (113.2)--(113.3) give

\[
                 \gamma(D)\ge1+p(\gamma(X)-1).
\]

If d = 1, then p divides n, E = X, and (113.4) gives
gamma(D) >= 2 gamma(X). This proves (113.5).

For an integer f >= 2 and p >= 3,

\[
             1+p(f-1)-2f=(p-2)f-p+1\ge p-3\ge0.
\]

Hence (113.6) follows. For p = 2 the minimum is 2f - 1.
Both bounds are strictly greater than f when f >= 2, proving
the first part of Corollary 113.3.

For gamma(X) = gamma(D) = 1, equation (113.2) gives gamma(E) = 1,
so (113.4) forces p not to divide n. Moreover the p-group G/N has
Frattini generator rank at most gamma(X) = 1, by inflation into
H^1_et(X,F_p). It is therefore cyclic. Every subgroup of G/N is
normal, so HN is normal in G and E/X is cyclic Galois. Its degree
d is exactly the p-part of dn. \(\square\)

## 5. Relevance filter for the fixed pair

For the pair in file 76, the genus-nine source has 5-rank 6 and
the genus-25 target is ordinary, hence has 5-rank 25. A common
etale cover Z has degrees

\[
             \deg(Z/X)=3M,\qquad \deg(Z/Y)=M,
             \qquad g(Z)=24M+1.
\]

If 5 divides M, Corollary 113.2 applied to the Y-leg gives

\[
                            \gamma(Z)\ge50.              \tag{113.11}
\]

This is a new necessary condition supplied by the general mechanism,
NOT a contradiction: 50 <= 24M + 1 for every positive multiple
M of 5. It gives no new excluded degree for that pair by itself.
The intermediate E constructed from one leg need not map to the
other original curve. No argument in this note assumes otherwise.

## 6. Boundaries and next use

- The exponent of p in deg(D/X) does not, by this proof alone,
  count a sequence of rank doublings. A single primitive residual
  cover may have degree divisible by a large power of p.
- A prime-to-p-degree cover can have a Galois closure with p in
  its group order and with larger p-rank. The theorem does not
  turn such covers into prime-to-p Galois covers.
- Rank preservation is an actual hypothesis, not a property of
  all covers of a rank-one curve.
- No simultaneous Galois closure of a common correspondence is
  constructed or assumed.

The robust output is the exact decomposition of p-rank growth
into a p-group-monodromy factor and a modularly constrained
remainder. A solution of the common-cover problem needs an
additional constraint using both actual etale maps from the
same curve.
