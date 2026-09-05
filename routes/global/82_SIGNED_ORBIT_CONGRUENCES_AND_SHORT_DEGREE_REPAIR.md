# Signed-orbit congruences and the repaired short-degree sieve

**Status: proved; independently audited (PASS, 2026-09-04).**

Auditor: `x_elliptic_quotient_maps`.
[Verdict and non-breaking observations](audits/82_SIGNED_ORBIT_CONGRUENCES_AND_SHORT_DEGREE_REPAIR_AUDIT.md).
No breaking objections were found.

This note continues the corrected full-orbit construction of file 81.  Its
purpose is twofold.  First, it records the restriction imposed by the
order-\(r\) deck transformation on the finite orbit of square-root choices.
Second, it uses the exceptional equality case to restore the short-degree
conclusion of Corollary 68.6 without the false field-intersection argument
identified in the audit of files 66 and 68.

The finite group statement is particularly rigid.  If \(j\) is the number
of square-root choices in the relevant orbit, then

\[
             j\equiv 1\ \text{or}\ 2\pmod r.
\]

In the geometric application every nontrivial \(j\) is even.  Consequently

\[
          j\in\{1,2,r+1\}\quad\text{or}\quad j\geq 2r+2.
\]

The exceptional value \(j=r+1\) forces a cyclic Hadamard simplex.  Its
involutions are incompatible with the etale signed-root cover, giving
uniform genus bounds.  These bounds eliminate the exceptional value in the
short range.

## 1. The orbit of a sign selection

Let \(r\) be an odd prime and write

\[
 \Omega=\mathbf F_2^r,\qquad
 \Lambda=\{(i,\epsilon):i\in\mathbf Z/r\mathbf Z,
                         \ \epsilon\in\mathbf F_2\}.
\]

The signed permutation group

\[
                    W_r=(\mathbf F_2)^r\rtimes S_r
\]

acts on the cube \(\Omega\) by affine coordinate permutations and on the
\(2r\) signed letters \(\Lambda\).  Let \(H\leq W_r\), assume that

\[
              \beta=(0,(0\ 1\ \cdots\ r-1))\in H,
\]

and put

\[
              \mathcal O=H\cdot0,\qquad
              H_0=\operatorname{Stab}_H(0),\qquad
              j=|\mathcal O|=[H:H_0].
\]

### Theorem 82.1 (orbit congruence and equality geometry)

One has

\[
 j\equiv
 \begin{cases}
 1\pmod r,&\mathbf 1\notin\mathcal O,\\
 2\pmod r,&\mathbf 1\in\mathcal O,
 \end{cases}                                           \tag{82.1}
\]

where \(\mathbf1=(1,\ldots,1)\).  In particular, if \(j\) is even whenever
\(j>1\), then

\[
 \begin{split}
  \mathbf1\notin\mathcal O, j>1&\Longrightarrow
       j=1+(2a+1)r\quad(a\geq0),\\
  \mathbf1\in\mathcal O&\Longrightarrow
       j=2+2ar\quad(a\geq0).
 \end{split}                                           \tag{82.2}
\]

Thus

\[
                 j\in\{1,2,r+1\}
                 \quad\text{or}\quad j\geq2r+2.       \tag{82.3}
\]

If \(j=r+1\), then \(r\equiv3\pmod4\).  More precisely, after identifying
the coordinates with \(\mathbf Z/r\mathbf Z\), there is a subset
\(A\subset\mathbf Z/r\mathbf Z\) such that

\[
 \mathcal O=\{0\}\cup\{\mathbf1_{A+i}:i\in\mathbf Z/r\mathbf Z\},
                                                               \tag{82.4}
\]

and

\[
 |A|={r+1\over2},\qquad
 |A\cap(A+i)|={r+1\over4}\quad(i\ne0).                \tag{82.5}
\]

All distinct vertices of \(\mathcal O\) therefore have Hamming distance
\((r+1)/2\).  Equivalently, after adjoining an initial \(+1\) coordinate,
the sign vectors of \(\mathcal O\) are the rows of a normalized Hadamard
matrix of order \(r+1\), with \(\beta\) cyclic on the other \(r\) rows and
columns.

#### Proof

The permutation \(\beta\) has exactly two fixed vertices on \(\Omega\),
namely \(0\) and \(\mathbf1\); all its other orbits have length \(r\).
The \(H\)-orbit \(\mathcal O\) is \(\beta\)-stable and contains \(0\), so
counting its fixed vertices modulo \(r\) proves (82.1).

Suppose now that every \(j>1\) under consideration is even.  In the first
line of (82.1), write \(j=1+ar\).  Since \(r\) is odd, evenness of \(j\)
forces \(a\) to be odd.  In the second line write \(j=2+ar\); here
evenness forces \(a\) to be even.  This is (82.2), and (82.3) follows.

There is also a purely group-theoretic source of the required evenness.
If \(H\) is transitive on the signed letters \(\Lambda\), then every
\(H\)-orbit on \(\Omega\), including \(\mathcal O\), has even size.  Indeed,
write the cube coordinates as signs and, for a signed coordinate functional
\(\ell\), put

\[
                         S_\ell=\sum_{x\in\mathcal O}\ell(x).
\]

Equivariance and transitivity on signed coordinates make \(S_\ell\)
independent of \(\ell\).  The opposite signed functional \(-\ell\) belongs
to the same orbit, while \(S_{-\ell}=-S_\ell\).  Hence every \(S_\ell=0\),
which is possible for a sum of \(|\mathcal O|\) signs only when
\(|\mathcal O|\) is even.  In this situation (82.2) may equivalently be
read as

\[
 j\equiv r+1\pmod{2r}\quad(\mathbf1\notin\mathcal O),
 \qquad
 j\equiv2\pmod{2r}\quad(\mathbf1\in\mathcal O).        \tag{82.2a}
\]

Assume \(j=r+1\).  Equation (82.1) shows that \(\mathbf1\notin\mathcal O\),
so \(\mathcal O\setminus\{0\}\) is one \(\beta\)-orbit.  This gives
(82.4) for a nonempty proper subset \(A\), all of whose translates have
one common weight \(w=|A|\).

Every element of \(H\) is a cube isometry, and \(H\) is transitive on
\(\mathcal O\).  The distance multiset from \(0\) to the other vertices is
therefore the distance multiset from any vertex to the other vertices.
The first multiset consists of \(r\) copies of \(w\), so

\[
       |A\mathbin\triangle(A+i)|=w\qquad(i\ne0).
\]

It follows that

\[
                 |A\cap(A+i)|={w\over2}\qquad(i\ne0). \tag{82.6}
\]

Summing (82.6) over nonzero \(i\), and counting ordered pairs of distinct
elements of \(A\), gives

\[
              {r-1\over2}w=w(w-1).
\]

Since \(w>0\), this yields \(w=(r+1)/2\), and (82.6) becomes (82.5).
In particular \(w\) is even and \(r\equiv3\pmod4\).

For the last assertion, attach to each \(x\in\mathcal O\) the row

\[
                    (1,(-1)^{x_0},\ldots,(-1)^{x_{r-1}}).
\]

The inner product of two distinct rows is

\[
                  1+r-2d_H(x,y)=0.
\]

There are \(r+1\) such rows of length \(r+1\), so they form a Hadamard
matrix.  The asserted cyclic symmetry is inherited from \(\beta\).
\(\square\)

The following parity observation will control ramification in the equality
case.

### Lemma 82.2 (Hadamard-orbit involutions fix a signed letter)

Under the hypotheses of Theorem 82.1, suppose \(j=r+1\).  Every involution
of \(H\) fixes a point of \(\Lambda\).

#### Proof

Write an involution as \(h=(a,\pi)\), acting on \(\Omega\) by

\[
                            x\longmapsto a+\pi x.
\]

Then

\[
                         \pi^2=1,\qquad \pi(a)=a.       \tag{82.7}
\]

If \(a=0\), the involution \(\pi\) of the odd set of \(r\) coordinates
has a fixed coordinate, and the corresponding two signed letters are
fixed by \(h\).

Suppose \(a\ne0\).  Since \(a=h(0)\in\mathcal O\), Theorem 82.1 gives

\[
                              |a|={r+1\over2},          \tag{82.8}
\]

which is even.  If \(h\) fixed no signed letter, then every coordinate
fixed by \(\pi\) would have to be sign-flipped, hence would belong to the
support of \(a\).  The number of fixed coordinates of an involution on an
odd set is odd.  Because \(a\) is \(\pi\)-invariant, its support away from
those fixed coordinates is a union of two-cycles.  Consequently \(|a|\)
would be odd, contradicting (82.8).  Thus \(h\) fixes a signed letter.
\(\square\)

## 2. Ramification and genus in the exceptional orbit

Return to the notation and hypotheses of file 81.  Thus

\[
 g(X)=s+1,\qquad g(Y)=rs+1,\qquad k(Y)=k(t,z),\quad z^2=f(t),
\]

and there is an etale diamond

\[
 V\xrightarrow{a}Y,\qquad
 V\xrightarrow{p}C\xrightarrow{c}X,\qquad
 \deg p=r,\quad\deg a=\deg c=M,
\]

where \(p\) is generated by \(\beta\) and \(a\beta\ne a\).  Use the full
orbit fields

\[
 B\subset D\subset F=k(C),\qquad E_*=D(t,z)\subset L\subset K=k(V)
\]

from Theorem 81.1 and put

\[
 e=[F:B]=mj,qquad m=[F:D],qquad j=[D:B],qquad
 N={M\over m}={jd\over2}.                              \tag{82.9}
\]

Let

\[
                         E=B(t),\qquad E'=B(t,z).
\]

Assume that the coefficient system has dimension at least three.  This is
automatic in the common-cover application when \(J(Y)\) is absolutely
simple, by Proposition 68.4a.

### Theorem 82.3 (the all-degree Hadamard alternative)

Suppose \(j=r+1\).  Then the sign-selection orbit has the Hadamard geometry
of Theorem 82.1, in particular \(r\equiv3\pmod4\).  Every nontrivial
inertia group of \(L/B\) has order \(r\), the quadratic map

\[
                              E'\longrightarrow E
\]

is etale, and

\[
                       g(E)={drs\over2}+1.              \tag{82.10}
\]

Writing \(b=g(B)\), one has

\[
        b\geq {ds\over2}-{(r-1)d\over r}+1,             \tag{82.11}
\]

and therefore

\[
                              d\geq s+2.                \tag{82.12}
\]

If additionally \(r\nmid m\), then \(L/B\) is etale and

\[
                         b={ds\over2}+1,
                         \qquad d\geq s+3.              \tag{82.13}
\]

#### Proof

The group \(H=\operatorname{Gal}(L/B)\) acts transitively on the signed
letters: these are the conjugates of the primitive element \((t,z)\) of
the field \(E'/B\).  The stabilizer of one signed letter fixes \(E'\).
Since \(L/E'\) is an intermediate map of the etale cover \(V/Y\), it is
etale.  Therefore every inertia group \(I\) of \(L/B\) acts freely on the
set \(\Lambda\) of \(2r\) signed letters.  In particular

\[
                              |I|\mid2r.                \tag{82.14}
\]

This conclusion is valid before any tameness assumption: it is just the
orbit-stabilizer theorem applied to a free action.  Since
\(\operatorname{char}k\ne2,r\), (82.14) then shows that inertia is tame,
hence cyclic.  An even-order inertia group would contain an involution,
contradicting Lemma 82.2 and the free action on \(\Lambda\).  Thus inertia
has order one or \(r\).

It follows in particular that the quadratic extension \(E'/E\) is
unramified.  The map \(E'\to Y\) is etale of degree \(d\), so

\[
                         g(E')-1=drs.
\]

Etale Riemann--Hurwitz for \(E'/E\) proves (82.10).

The spectral equation cuts out an integral curve in
\(B\times\mathbf P^1\) whose normalization is \(E\).  Its arithmetic genus
is

\[
                         rb+(r-1)(d-1).
\]

Comparison with (82.10) gives (82.11).  The coefficient model of \(B\) is
birational, nondegenerate, and has degree \(d\); hence

\[
                         b\leq{(d-1)(d-2)\over2}.       \tag{82.15}
\]

Combining (82.11) and (82.15) yields

\[
                         d\geq s+1+{2\over r}.
\]

Since \(d\) is integral and \(r\geq3\), this is (82.12).

It remains to prove the stronger assertion when \(r\nmid m\).  The group
\(H_0=\operatorname{Gal}(L/D)\) acts faithfully on the selected \(r\)
signed roots, so \(H_0\leq S_r\).  It contains \(\langle\beta\rangle\),
and therefore

\[
 v_r(|H|)=v_r(|H_0|(r+1))=1.                           \tag{82.16}
\]

Thus all subgroups of order \(r\) in \(H\) are conjugate to
\(\langle\beta\rangle\).

Moreover \(E_*\subset L\subset K\) and \([K:E_*]=m\), so
\([K:L]\mid m\).  If \(\beta\) fixed a point of \(L\), it would act on
the fiber of the etale map \(V\to L\).  It has no fixed point upstairs,
because \(V\to C\) is a \(C_r\)-torsor, so that fiber would be a union of
orbits of length \(r\).  This would force

\[
                              r\mid[K:L]\mid m,
\]

contrary to the hypothesis.  Hence \(\beta\), and by conjugacy every
order-\(r\) subgroup of \(H\), acts freely on \(L\).  The order-\(r\)
inertia alternative is impossible, and \(L/B\) is etale.

Put \(q=[K:L]\).  From \(E_*\subset L\subset K\) and (82.9),

\[
 [L:B]={m\over q}r(r+1),\qquad
 g(L)-1={M\over q}rs,qquad
 M={m(r+1)d\over2}.
\]

Etale Riemann--Hurwitz for \(L/B\) now gives

\[
             b-1={g(L)-1\over[L:B]}={ds\over2}.
\]

Combining this equality with (82.15) gives \(d\geq s+3\), proving
(82.13). \(\square\)

## 3. The repaired short-degree conclusion

### Corollary 82.4 (short sign-choice and coefficient degrees)

Assume the hypotheses of Theorems 81.1 and 81.2, with \(J(Y)\) absolutely
simple.  Then

\[
                 M<2r+2\quad\Longrightarrow\quad
                 j\in\{1,2\}.                          \tag{82.17}
\]

In particular, in the original initial interval

\[
                         r+2\leq M<2r,
\]

one has

\[
                         m=1,qquad e=j\in\{1,2\}.      \tag{82.18}
\]

Thus the initial-interval assertion of Corollary 68.6 is restored by the
full-orbit construction, independently of the invalid quadratic-core
intersection formula.

#### Proof

Theorem 81.2 gives

\[
                         m\mid M,qquad N={M\over m}\geq r.
\]

Proposition 68.4a gives a coefficient system of dimension at least three,
so its nondegenerate projective model has \(d\geq2\).  Since
\(jd=2N\), this implies

\[
                              j\leq N\leq M.            \tag{82.19}
\]

Theorem 81.1 says that \(j=1\) or \(j\) is even.  Apply Theorem 82.1.
If \(M<2r+2\), then (82.19) and (82.3) leave only

\[
                              j=1,\quad2,\quad r+1.
\]

Suppose for contradiction that \(j=r+1\).  Theorem 82.3 gives
\(d\geq s+2\), and hence

\[
                         N={jd\over2}
                           \geq{(r+1)(s+2)\over2}.      \tag{82.20}
\]

If \(s\geq2\), the right side is at least \(2r+2\), contradicting
\(N\leq M<2r+2\).  If \(s=1\), (82.20) gives
\(N\geq3(r+1)/2\).  The inequality \(M=mN<2(r+1)\) then forces \(m=1\).
In particular \(r\nmid m\), so the stronger part of Theorem 82.3 gives
\(d\geq s+3=4\), again forcing \(N\geq2r+2\).  This contradiction proves
(82.17).

Finally suppose \(M<2r\).  If \(m\geq2\), then

\[
                              M=mN\geq2r,
\]

which is impossible.  Hence \(m=1\), and (82.9) gives \(e=j\).
Equation (82.17) now proves (82.18). \(\square\)

## 4. Scope

The congruence (82.1) and the Hadamard geometry are pure finite group
facts.  The parity of nontrivial \(j\), the relation \(jd=2N\), and the
genus bounds use the hyperelliptic full-orbit square of file 81.  No claim
is made that the Hadamard alternative is group-theoretically empty: for
many primes \(r\equiv3\pmod4\), cyclic difference sets of the displayed
parameters exist.  What excludes it in the short geometric range is the
combination of signed-root etaleness and the coefficient-curve genus.
