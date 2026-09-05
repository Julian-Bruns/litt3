# Two-point nonweak orbifolds: a finite branch and one residual family

**Status:** collaborative author proof, independently audited **PASS**,
2026-09-05. Authors: root and gluing_cohomology_rigidity.
Auditor: `/root/canonical_trace_algebra`. The all-degree arithmetic,
finite tables, and residual-family boundary were checked; numerical
survivors remain necessary conditions only.
[Audit record](audits/ALL_DEGREE_COMMON_ORBIFOLD_BOUND_AND_LOGARITHMIC_TORSION_AUDIT.md).

**Earlier limited independent audit:** Lemma 1 and its \(Q\le125\) consequence
have [PASS, 2026-09-05](audits/MAXIMAL_LOWER_BREAK_COMMON_RESIDUE_AUDIT.md).
That audit does not cover the rest of this note.

All assertions below are necessary conditions on a genuine representable
finite etale orbifold cover. Numerical survivors are not asserted to be
local actions or global covers. In particular, the unbounded family in
section 5 is a remaining boundary, not an existence result.

## 1. Two local lemmas, with the maximal-break argument included

Let a finite nontrivial \(p\)-group \(P\) act faithfully on \(k[[z]]\),
where \(k\) is algebraically closed of characteristic \(p\). Write \(G_i\)
for its lower filtration and \(B\) for its largest break.

### Lemma 1: common residues for the finite wild group

Every lower break of \(P\) is congruent to \(B\) modulo \(p\).
This is also Serre, *Local Fields*, Chapter IV, section 2, Proposition 11;
the preceding Proposition 10 gives the commutator facts used below.

#### Proof

The standard commutator inclusion
\([G_i,G_j]\subseteq G_{i+j}\), for \(i,j\ge1\), gives
\([P,G_B]\subseteq G_{B+1}=1\). Thus \(G_B\) is central.
Choose \(\tau\in G_B\setminus\{1\}\), of exact break \(B\), and any
\(\sigma\) of exact break \(b\). If \(b\not\equiv B\pmod p\), the
leading-commutator calculation in
[file 13](13_PROOF_LOCAL_RAMIFICATION.md) gives a nonzero term of degree
\(b+B+1\), with coefficient, up to sign,
\((B-b)ac\), where \(a,c\ne0\) are the respective leading coefficients.
This contradicts centrality of \(\tau\).
\(\square\)

This proof supplies the additional maximal-break step explicitly warned
about in file 13. It does not infer the result from the leading-term
calculation alone, and it concerns the finite wild group, not a
filtration including a nontrivial tame group at index zero.
In particular, in characteristic five, first break \(1\) and \(G_2\ne1\)
give

\[
                  G_2=G_3=\cdots=G_6,\qquad
 T:=\sum_{i\ge2}(|G_i|-1)\ge5(|G_2|-1).                         \tag{1}
\]

### Lemma 2: a maximal-break conductor bound

Put \(|P|=p^q\), \(|G_B|=p^j\), and
\(\epsilon=\sum_{i\ge1}(|G_i|-1)\). Then

\[
              p^{\,\lceil(q+j)/2\rceil}\mid \epsilon+B.          \tag{2}
\]

Indeed, \(N=G_B\) is central and elementary abelian. Choose a nontrivial
central character of \(N\) and an irreducible representation \(V\) of
\(P\) with that character, of dimension \(u\). Its central-character
packet in the regular representation gives \(u^2\le p^{q-j}\).
Every nontrivial ramification group contains \(N\), so \(V^{G_i}=0\)
for \(0\le i\le B\). Artin-conductor integrality gives

\[
                 a(V)=u\left(1+\frac{\epsilon+B}{p^q}\right)
                         \in\mathbf Z.
\]

If \(v=v_p(\epsilon+B)<q\), then \(p^{q-v}\mid u\); comparison with the
dimension bound gives \(2(q-v)\le q-j\), proving (2). If \(v\ge q\),
(2) is immediate. These are the same standard conductor inputs as in
[the small-tail lemma](SMALL_POSITIVE_RAMIFICATION_TAIL_AND_ONE_POINT_ORBIFOLDS.md).

## 2. Exact normalization for a genus-nine atlas

Work over \(\overline{\mathbf F}_5\). Suppose a genus-nine curve maps
representably finite etale to an effective orbifold with coarse curve
\(\mathbf P^1\), exactly two stacky points, one with nonweak wild
inertia \(P\rtimes C_m\), and the other with tame inertia \(C_N\).
Put \(Q=|P|=5^q\); both \(m\) and \(N>1\) are prime to five.
Let \(r_w,r_t\) be the respective numbers of points of the atlas over
the two branch points. Uniformity follows from representable etaleness,
as in the small-tail lemma.

The different exponents are \(Qm-1+\epsilon\) and \(N-1\).
If \(n\) is the coarse degree, then

\[
 n=r_wQm=r_tN,\qquad 16=r_w(\epsilon-1)-r_t.                     \tag{3}
\]

Set \(d=\gcd(r_w,r_t)=\gcd(r_w,16)\), \(D=16/d\), and normalize as in
[file 18](18_PROOF_NONWEAK_WILD_EXCLUSION.md). One obtains

\[
 \begin{gathered}
 r_w=da,\quad r_t=dQc,\quad
 m=ct,\quad N=at,\quad \epsilon=cL,\quad t\mid L,\\
 ch=a+D,\qquad Q+h=aL,\qquad
 \gcd(a,D)=\gcd(a,c)=1,\qquad 5\nmid act,\qquad D\mid16.          \tag{4}
 \end{gathered}
\]

\[
                         Q(c-a)\ge2a-D.                         \tag{5}
\]

For clarity, write \(r_t=db\). Equation (3) gives
\(b=a(\epsilon-1)-D\), with \(\gcd(a,b)=1\).
The identity \(Nb=Qma\) forces \(5\nmid a\) and \(b=Qc\) with
\(5\nmid c\). Coprimality then gives \(m=ct,N=at\).
The tame summation lemma of file 13 says \(m\mid\epsilon\), yielding
\(\epsilon=cL\), \(t\mid L\), and the two equations involving \(h\).
Finally nonweakness gives \(\epsilon\ge Q+3\), which implies (5).
Also \(4\mid\epsilon\).

If \(a\ge D\), (5) gives \(c>a\); the equation \(ch=a+D\) therefore
forces \(h=1\). No global Galois-group hypothesis has been introduced.

## 3. Complete reduction of the \(h=1\) branch

### Theorem 3

In the branch \(h=1\), the complete necessary list is

\[
\begin{array}{c|c|c|c|c|c}
a&Q&\text{wild breaks and group sizes}&t&m&N\\ \hline
1&5&G_1=G_2=G_3=C_5&2,3,6&2t&t\\
3&5&G_1=G_2=C_5&1,2&4t&3t\\
7&125&G_1=P,\ G_2=\cdots=G_6=C_5&1,3&8t&7t .
\end{array}                                                     \tag{6}
\]

In each row all groups after the last displayed one are trivial.
In every row \(D=1,d=16\). The coarse degrees are respectively
\(160t,960t,112000t\).

#### Parity and the first-break exceptions

Here \(c=a+D\) and \(aL=Q+1\). If \(D\) is even, then \(a,c\) are odd
and \(v_2(L)=1\), contradicting \(4\mid cL\). Hence \(D=1\).
Since \(v_2(Q+1)=1\), even \(a\) would make \(cL\) odd, again impossible.
Thus \(a\) is odd, \(c=a+1\) is even, and

\[
             \epsilon=\frac{(a+1)(Q+1)}a.                        \tag{7}
\]

If \(a=1\), the first break is at most three, since
\(\epsilon=2(Q+1)<4(Q-1)\).
At a first break \(b\), put \(s=\dim_{\mathbf F_5}P/G_{b+1}\).
The first-break Swan divisibility of file 13 says

\[
           5^{\lceil s/2\rceil}\mid\epsilon-b(Q-1).               \tag{8}
\]

For \(b=1,2\), the right side is respectively \(Q+3,4\), impossible.
For \(b=3\), the inequality \(3(Q-1)\le2(Q+1)\) forces \(Q=5\).
Thus \(P=C_5\), break three, \(L=6\), and the tame graded condition
allows \(t\mid6\); \(N=t>1\) leaves \(t=2,3,6\).

If \(a\ge3\) and the first break is at least two, (7) implies
\[
                           Q\le3+\frac4{a-1}.
\]
Only \(a=3,Q=5\) survives; its break is two and \(L=2\).
The tame graded condition gives \(t=1,2\). These are the first two
rows of (6). All other cases have first break one.

#### The first-break-one arithmetic

Put \(s=\dim_{\mathbf F_5}P/G_2\), \(H=5^{\lceil s/2\rceil}\), and
\[
                 E=\epsilon-(Q-1)=L+2.
\]
Tame gradedness and (8) give

\[
                      c\mid5^s-1,\qquad H\mid2c-1,              \tag{9}
\]

where the second statement follows from
\(aE=Q+2c-1\) and \(H\mid Q\).

The only solution of (9) with even \(c\) is \(s=2,c=8\).
Here is a short all-degree proof. Write \(2c=Hu+1\).
Since \(H\equiv1\pmod4\), even \(c\) forces \(u\equiv3\pmod4\),
so \(u\ge3\). Put \(\kappa=1\) for even \(s\), and \(\kappa=5\) for
odd \(s\), so \(5^s=H^2/\kappa\). Reducing the divisibility
\(c\mid H^2/\kappa-1\) gives

\[
                  v=\frac{2(\kappa u^2-1)}{Hu+1}
                         \in\{1,2,3\}.
\]

Indeed it is a positive integer, and \(c<H^2/\kappa\) gives
\(u<2H/\kappa\), whence \(v<4\).
The quadratic equation for \(u\) has square discriminant \(W^2\), with

\[
                     (W-vH)(W+vH)=8\kappa(v+2).
\]

Both factors are positive; therefore
\(H<4\kappa(v+2)/v\le12\kappa\).
For even \(s\), this leaves \(s=2\); for odd \(s\), only \(s=1,3\).
Checking even divisors of \(4,24,124\) respectively in (9) leaves
exactly \(s=2,c=8\).

Thus \(a=7\), \(7\mid5^q+1\), and \(q\equiv3\pmod6\).
Moreover \(|G_2|=Q/25\) and \(E=(Q+15)/7\).
Lemma 1 now supplies the decisive inequality

\[
       \frac{Q+15}{7}\ge5\left(\frac Q{25}-1\right),
                    \qquad\text{hence }Q\le125.
\]

Consequently \(Q=125\), \(E=20\), and
\(G_2=\cdots=G_6=C_5\). Since \(8t\mid24\) and \(t\mid18\),
one has \(t=1,3\). This proves (6).
\(\square\)

The last row's local wild filtration is realized by the Hermitian
125-group in the small-tail lemma; its usual tame group of order
24 contains complements of order 8 and 24. This local observation
does not realize a genus-nine orbifold atlas.

## 4. The finite part of \(h\ge2\)

Here \(a<D\), so the normalization variables \(D,a,h,c\) form a finite
list even though \(Q\) is not yet bounded.
Since \(D\) is even, \(a\) is odd. The condition \(4\mid\epsilon\)
becomes
\[
                            c(1+h)\equiv0\pmod4.
\]
Listing \(D\mid16\), odd \(1\le a<D\) prime to five,
\(h\mid a+D\), \(h\ge2\), and \(c=(a+D)/h\) prime to five with
\(\gcd(a,c)=1\), gives precisely

\[
\begin{array}{c|r|r|r|l}
D&a&h&c&\text{consequence of (5)}\\ \hline
2&1&3&1&\text{retained}\\
4&3&7&1&Q\le-1\\
8&1&3&3&\text{retained}\\
8&3&11&1&Q\le1\\
8&7&15&1&Q\le-1\\
16&3&19&1&Q\le5\\
16&7&23&1&Q\le0\\
16&11&3&9&Q\le-3\\
16&11&27&1&Q\le-1 .
\end{array}                                                     \tag{10}
\]

This is a small divisor calculation, not a search over covers.
For \((D,a,h,c)=(2,1,3,1)\), one has \(\epsilon=Q+3\).
If \(Q>5\), the first break is one and (8) would divide the tail four,
which is impossible. Thus \(Q=5\), with cyclic break two.
For \((16,3,19,1)\), (5) already gives \(Q=5\), again with break two.
The complete resulting necessary rows are

\[
\begin{array}{c|c|c|c|c|c}
(D,a,h,c)&Q&\text{break}&t&m&N\\ \hline
(2,1,3,1)&5&2&2,4,8&t&t\\
(16,3,19,1)&5&2&1,2,4,8&t&3t .
\end{array}                                                     \tag{11}
\]

The coarse degrees are respectively \(40t\) and \(15t\).

## 5. The exact remaining unbounded row

The only row not disposed of above is

\[
 D=8,\ d=2,\ a=1,\ h=3,\ c=3,\qquad
 L=Q+3,\quad \epsilon=3(Q+3),\quad m=3t,\quad N=t>1.              \tag{12}
\]

If \(q=1\), the wild group is \(C_5\) with break six, and
\(t=2,4,8\). The coarse degree is \(30t\).

If \(q\ge2\), the first break is at most three, because
\(\epsilon/(Q-1)=3+12/(Q-1)<4\).
Applying (8), its first quotient dimension \(s\) must satisfy
\[
       5^{\lceil s/2\rceil}\mid9+b.
\]
Only \(b=1\) is possible; it forces \(s\le2\).
Since \(3\mid m\) and \(m\mid5^s-1\), \(s\) is even. Thus \(s=2\).
Nonweakness rules out \(q=2\). Consequently every remaining profile has

\[
 \begin{gathered}
 q\ge3,\qquad |G_2|=5^{q-2},\qquad
 T=2Q+10,\qquad t\mid\gcd(8,Q+3),\quad t>1,\\
 t\in\{2,4,8\}\text{ for odd }q,\qquad
 t\in\{2,4\}\text{ for even }q,\\
 \text{every wild break is }1\pmod5,\qquad n=6Qt.                 \tag{13}
 \end{gathered}
\]

Unlike the \(h=1\) case, (1) does not bound \(Q\) here.
Lemma 2 gives a further genuine restriction: if \(B\) is the largest
break and \(|G_B|=5^j\), then

\[
                         5^{\lceil(q+j)/2\rceil}\mid B+9.        \tag{14}
\]

Equations (12)--(14) are the precise remaining boundary of this
reduction. No assertion is made that their solutions are realizable.
Successive ramification subgroups must themselves satisfy the
conductor restrictions; checking only the first quotient of \(P\)
does not certify a local action. Nor would a realized local action
alone supply either prescribed curve as an atlas of the same orbifold.
