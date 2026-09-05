# Abelian étale towers acquire no sufficiently large simple factor

Date: 2026-09-05.
Authors: /root/gluing_cohomology_rigidity and /root.
Status: collaborative author proof; not independently audited as a whole.

This extracts the factor-theoretic content of the already audited proof
in [file 95](95_ABELIAN_ETALE_TOWERS_AND_ENDOMORPHISM_FIELDS.md).
That proof does not require the factor to arise from a map to a curve.
File 95 is retained unchanged as its previously stated special case.

## 1. Exact packet multiplicities

Let \(k\) be algebraically closed, let \(C/k\) be a smooth projective
connected curve of genus \(h\ge2\), and set \(s=h-1\).
Fix a geometrically simple abelian variety \(A/k\) of dimension \(d\)
such that
\[
                            \operatorname{End}^0_k(A)=K
\]
is a number field. A CM field is allowed; the argument only needs the
number-field condition. Fix \(K\subset\overline{\mathbf Q}\), and put
\[
                  a_0=[K\cap\mathbf Q^{\rm ab}:\mathbf Q].    \tag{1.1}
\]
For an abelian variety \(B\), write \(m_A(B)\) for the multiplicity
of \(A\) in its isogeny decomposition.

Let \(q:W\to C\) be any connected finite étale Galois cover with finite
abelian deck group \(H\). There is **no** restriction on the primes
dividing \(|H|\), including the characteristic of \(k\).

Decompose \(J(W)\) up to isogeny by the primitive idempotents
\(e\in\mathbf Q[H]\), and write \(P_e=eJ(W)\).
For a nontrivial packet \(e\), let \(n>1\) be the order of any of its
complex characters and set
\[
              F_n=\mathbf Q(\zeta_n),\quad
              a_n=[F_n\cap K:\mathbf Q],\quad
              b_n=\frac{\varphi(n)}{a_n}.                   \tag{1.2}
\]

**Theorem 1.** The trivial packet has multiplicity \(m_A(J(C))\).
Every nontrivial packet satisfies the exact divisibility and bounds
\[
 \boxed{\quad
 m_A(P_e)=b_n t_e,\qquad
 t_e\in\mathbf Z_{\ge0},\qquad
 t_e\le\left\lfloor\frac{s a_n}{d}\right\rfloor .
 \quad}                                                     \tag{1.3}
\]
In particular, occurrence in this packet requires \(d\le s a_n\).
The total multiplicity is
\[
             m_A(J(W))=m_A(J(C))+\sum_{e\ne e_{\rm triv}}b_n t_e.
                                                               \tag{1.4}
\]
Different packets can have the same character order \(n\); they are
counted separately in (1.4).

### Proof

For an auxiliary prime \(r\ne\operatorname{char}k\), the free-action
Lefschetz calculation in Lemma 95.2 gives
\[
 H^1_{\rm et}(W,\mathbf Q_r)
       \simeq \mathbf Q_r^{\,2}
                   \oplus\mathbf Q_r[H]^{\,2s}.             \tag{1.5}
\]
For every nonidentity deck transformation, its graph is disjoint from
the diagonal, so its trace on \(H^1\) is two. At the identity the
dimension is \(2+2|H|s\), by étale Riemann–Hurwitz. These are the
characters in (1.5). Representations over \(\mathbf Q_r\) are
semisimple even if \(r\) divides \(|H|\).

In particular, (1.5) does not require tame group order: the action is
free even when the characteristic divides \(|H|\). The relevant
Lefschetz formula is the cycle-class formula for a regular self-map of
a smooth proper variety; its precise source and scope are recorded
in file 95, Lemma 95.2.

The trivial packet is isogenous to \(J(C)\). For a nontrivial packet,
\[
                    e\mathbf Q[H]\simeq F_n,\qquad
                    \dim P_e=s\varphi(n).                  \tag{1.6}
\]
If its \(A\)-isotypic part has positive multiplicity \(m\), that part
is preserved by all endomorphisms of \(P_e\), since there are no
homomorphisms between nonisogenous simple factors. Restricting the
unital \(F_n\)-action therefore gives an embedding
\[
                               F_n\hookrightarrow M_m(K). \tag{1.7}
\]
It is injective because its source is a field and its unit acts
identically on a nonzero isotypic part.

The central \(K\)-action makes \(K^m\) a module over \(K\otimes_{\mathbf Q}F_n\).
As in Lemma 95.3, this algebra is a product of \(a_n\) fields, each
of degree \(b_n\) over \(K\). Decomposing the module by these field
factors shows that
\[
                                  b_n\mid m.                \tag{1.8}
\]
Some factors may act on the zero submodule; faithful action of the
whole tensor algebra is unnecessary. This is the divisibility
implicit in the proof of Lemma 95.3, not merely its lower bound.

Write \(m=b_n t_e\). The geometric dimension bound
\[
                    md\le\dim P_e=s\varphi(n)=s a_n b_n
\]
gives (1.3). The case \(m=0\) gives \(t_e=0\). Summing the isogeny
decomposition proves (1.4). No morphism from \(W\) to a target curve
has been used. \(\square\)

## 2. Uniform no-new-factor and Hom vanishing

**Corollary 2.** If
\[
                                  d>a_0(h-1),               \tag{2.1}
\]
then every cover above satisfies
\[
                              m_A(J(W))=m_A(J(C)).          \tag{2.2}
\]
Thus if \(\operatorname{Hom}(J(C),A)=0\), then
\[
       \operatorname{Hom}(J(W),A)=\operatorname{Hom}(A,J(W))=0
                                                               \tag{2.3}
\]
throughout the entire abelian étale tower of \(C\).
In particular, (2.3) holds automatically when
\[
                              d>\max\{h,a_0(h-1)\}.         \tag{2.4}
\]

Indeed \(a_n\le a_0\), so (1.3) forces every nontrivial packet
multiplicity to vanish. The equivalence of the two Hom-vanishing
directions follows from simplicity and isogeny decomposition.

Even when \(A\) already occurs in \(J(C)\), there is no multiplicity
growth under (2.1). More precisely, composition with norm and pullback
gives isomorphisms of rational Hom spaces
\[
\begin{aligned}
 q_*^*: \operatorname{Hom}^0(J(C),A)
           &\xrightarrow{\ \sim\ }\operatorname{Hom}^0(J(W),A),\\
 q^*_*: \operatorname{Hom}^0(A,J(C))
           &\xrightarrow{\ \sim\ }\operatorname{Hom}^0(A,J(W)).
\end{aligned}                                               \tag{2.5}
\]
These assertions concern rational Hom spaces and multiplicities;
equality of integral Hom lattices is not asserted.

For a specified cover of exponent \(N\), one can replace \(a_0\) in
(2.1) by \([K\cap\mathbf Q(\zeta_N):\mathbf Q]\). More generally, for
deck groups supported on a fixed finite set of primes \(S\), use
\[
 a_S=[K\cap\mathbf Q(\mu_{S^\infty}):\mathbf Q]\le a_0,       \tag{2.6}
\]
where the cyclotomic union allows all orders supported on \(S\).
This includes the characteristic among the allowed primes.

When (2.1) fails, the packet proof still gives (1.3)–(1.4), but does
not give a degree-independent bound on the sum: both the number of
packets and \(\varphi(n)\) can grow. This is a limitation of the
argument, not a claim that every numerically allowed packet occurs.

## 3. The exact abelian subfield of the fixed genus-nine endomorphism field

Let \(X\) be the fixed genus-nine curve in
[file 76](76_EXPLICIT_BRANCH_RATIONAL_R3_REDESIGN.md).
Proposition 76.2 and the argument in
[file 87, Proposition 87.10](87_TRIVIAL_AUTOMORPHISMS_AND_BRANCH_RIGIDITY_FORCE_DECK_NORMALITY.md)
give
\[
 \begin{gathered}
  J(X)\text{ geometrically simple},\qquad
  K=\operatorname{End}^0_kJ(X)=\mathbf Q(\pi_X),\\
  [K:\mathbf Q]=18,\qquad \mathbf Q(\zeta_3)\subset K,\\
  \operatorname{Disc}(K)
      =-3^{11}29^2\,10589^2\,16451926081^2\,24415659240899^2.
 \end{gathered}                                               \tag{3.1}
\]
The four displayed primes different from three are prime.
The equality with the geometric endomorphism algebra follows there
from \(\mathbf Q(\pi_X^n)=K\) for every \(n\), together with the
Honda–Tate dimension formula. It does not assume ordinarity of \(X\).

**Proposition 3.** For this field,
\[
                     K\cap\mathbf Q^{\rm ab}=\mathbf Q(\zeta_3),
                         \qquad a_0=2.                     \tag{3.2}
\]

### Proof

Put \(E=K\cap\mathbf Q^{\rm ab}\). It is an abelian Galois extension
of \(\mathbf Q\), contains \(\mathbf Q(\zeta_3)\), and has degree
dividing eighteen. Thus its degree is \(2,6\), or \(18\).

If it were greater than two, its finite abelian Galois group would
have a quotient of order three. There would be a cyclic cubic
subfield \(L\subset E\subset K\). Since \([K:L]=6\), the
discriminant tower formula gives divisibility of integer ideals
\[
                              \operatorname{Disc}(L)^6
                                      \mid\operatorname{Disc}(K).
                                                               \tag{3.3}
\]
Consequently the absolute discriminant of \(L\) can have no prime
factor other than three, and its three-adic valuation is at most one.
But a cyclic cubic field has positive square discriminant: its
permutation Galois group lies in \(A_3\), so the product of root
differences is rational. Thus (3.3) forces
\(\operatorname{Disc}(L)=1\), impossible for a nontrivial number field
by the Minkowski discriminant bound.

Therefore \([E:\mathbf Q]=2\), and the already contained quadratic
field identifies it as \(\mathbf Q(\zeta_3)\). \(\square\)

This short subfield deduction uses the previously certified arithmetic
in (3.1); it does not re-audit the point counts or field discriminant.

## 4. All genus-two bases, with no ordinarity assumption

**Corollary 4.** Let \(C/\overline{\mathbf F}_5\) be any smooth projective
connected genus-two curve. For every connected finite étale cover
\(W\to C\) with abelian Galois group,
\[
                \operatorname{Hom}(J(X),J(W))
                    =\operatorname{Hom}(J(W),J(X))=0.        \tag{4.1}
\]
This includes arbitrary mixed-prime abelian groups and groups of order
divisible by five. It requires neither ordinarity of \(C\) nor any
map from \(W\) to \(X\).

Indeed take \(A=J(X)\), \(d=9\), \(a_0=2\), and \(h=2\).
The inequality \(9>2(h-1)\) excludes all new packets, and the dimension
of \(J(C)\) excludes the trivial one.

The same proof works for every \(2\le h\le5\), since
\[
                              9>\max\{h,2(h-1)\}.
\]
In particular, any chosen abelian tower over a genus-two \(Y\)
retains \(\operatorname{Hom}(J(X),J(Y_n))=0\) at every level,
without a separate genericity or Newton-polygon computation.

This does **not** give that conclusion for the original genus-25
endpoint of file 76: there \(9>2(25-1)\) fails. Nor does it address
arbitrary nonabelian covers, or assert that an arbitrary common cover
can be replaced by one with abelian monodromy.
