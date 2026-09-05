# The full Sylow-seven norm: a prime-to-seven bound and its limit

## Status and purpose

**Status: proved.**  [Independent audit](audits/41_FULL_SYLOW_NORM_AUDIT.md).

This note returns to the full Sylow subgroup in file 29,
rather than passing immediately to one order-seven quotient.  Write

\[
             N=7^s m,\qquad 7\nmid m,
\]

for the degree of the cover of \(Y\).  The quotient by the full Sylow group
is an etale degree-\(m\) cover of \(X\).  If the full orbit norm of the map
to \(Y\) is nonzero, the absolute simplicity result of file 40 forces
\(m\geq9\).  If the stabilizer has cyclic quotient, a cyclotomic
representation bound still forces \(m\geq3\), even when the full norm
vanishes.  In particular, \(m\geq3\) whenever \(s\leq1\).

The last two sections explain exactly why this does not iterate for a
general Sylow group.  The stabilizer need not be normal, and after the first
degree-seven norm one has a correspondence rather than a map to \(Y\).
Moreover, already for \(P=(C_7)^3\), all the resulting rational
representation and dimension constraints are compatible with \(m=1\).

Throughout, \(J=\operatorname{Jac}(Y)\) and

\[
        \mathscr D=\operatorname{End}^0(J)
\]

is the degree-three division algebra over the degree-ten field \(E\) of
file 40.

## 1. The stabilizer and the normalizer step

Use Theorem 29.3.  Thus

\[
 a:W\longrightarrow Y,
 \qquad \deg(a)=N=7^s m,
\]

and a Sylow subgroup \(P\leq\operatorname{Deck}(W/X)\) acts freely, with

\[
                         |P|=7^{s+1}.
\]

Put \(q=\rho a:W\to S_0\), and define

\[
 Q=\{g\in P:a g=a\}.
                                                        \tag{41.1}
\]

By Corollary 38.2, this is also

\[
 Q=\{g\in P:qg\simeq q\}.
                                                        \tag{41.2}
\]

It is a proper subgroup of \(P\).  Since \(Q\) acts vertically and freely,
\(a\) descends to

\[
       a_Q:W/Q\longrightarrow Y,
       \qquad \deg(a_Q)=\frac{N}{|Q|}.
                                                        \tag{41.3}
\]

In particular, \(|Q|\mid N\).  There is no reason for \(Q\) to be normal
in \(P\), so in general the symbol \(P/Q\) does not denote a group.

The normalizer condition for finite \(p\)-groups nevertheless gives

\[
                         Q<N_P(Q).
\]

Choose \(R\leq N_P(Q)\) such that

\[
                   Q\triangleleft R,
                   \qquad R/Q\simeq C_7.               \tag{41.4}
\]

The action of \(R/Q\) on \(W/Q\) does not preserve \(a_Q\), by the exact
definition of \(Q\).  Lemma 40.2 applied to

\[
                 W/Q\longrightarrow W/R
\]

says that

\[
       (W/Q\to W/R)_*a_Q^*:J\longrightarrow J(W/R)
                                                        \tag{41.5}
\]

is nonzero.  This recovers, without choosing a subnormal series in advance,
the residual bound

\[
                         \frac{N}{|Q|}\geq9.             \tag{41.6}
\]

Indeed \(W/R\to X\) has degree \(N/|Q|\), and the image of (41.5) lies in
its Prym over \(X\), exactly as in Theorem 40.3.

The distinction between \(Q\triangleleft R\) and \(Q\triangleleft P\) is
essential in everything that follows.

## 2. The full norm dichotomy

Let

\[
                 C_0=W/P.
\]

Then \(C_0\to X\) is finite etale of degree \(m\), and

\[
                 g(C_0)=2m+1.                           \tag{41.7}
\]

Let \(p:W\to C_0\) be the quotient.  Consider the full norm

\[
                 \mathcal N_P=p_*a^*:J\longrightarrow J(C_0).
                                                        \tag{41.8}
\]

### Proposition 41.1 (survival of the full norm)

If \(\mathcal N_P\ne0\), then

\[
                              m\geq9.                    \tag{41.9}
\]

#### Proof

The variety \(J\) is absolutely simple of dimension fifteen by Proposition
40.1.  Hence the nonzero image of (41.8) is isogenous to \(J\).  There is no
nonzero homomorphism \(J\to J(X)\), since \(J(X)\) has dimension three.
Consequently this copy of \(J\) lies in

\[
 \ker\bigl(J(C_0)\longrightarrow J(X)\bigr)^0,
\]

whose dimension is

\[
                    g(C_0)-g(X)=2m-2.
\]

Thus \(15\leq2m-2\), which is equivalent to \(m\geq9\). \(\square\)

This proposition is stronger than the residual bound (41.6): it controls
the part of \(N\) prime to seven.  The difficulty is that Lemma 40.2 proves
nonvanishing only for a quotient of degree seven, not for the degree
\(7^{s+1}\) quotient \(p\).

## 3. A cyclotomic rank bound

We record the representation input used below.

### Lemma 41.2 (order versus \(\mathscr D\)-rank)

Let \(T\) be an element of exact order \(7^r\) in

\[
                    \operatorname{GL}_n(\mathscr D).
\]

Then

\[
                         n\geq2\cdot7^{r-1}.             \tag{41.10}
\]

#### Proof

The fields \(E\subset\mathbf Q(\zeta_{31})\) and
\(\mathbf Q(\zeta_{7^r})\) have trivial intersection.  Therefore

\[
 [E(\zeta_{7^r}):E]=\varphi(7^r)=6\cdot7^{r-1},
\]

and \(\Phi_{7^r}\) is irreducible over \(E\).  The minimal polynomial of
\(T\) contains this factor.  On the other hand, the reduced characteristic
polynomial of an element of \(M_n(\mathscr D)\) has degree \(3n\) over
\(E\), because \(\mathscr D\) has degree three.  Hence

\[
                 6\cdot7^{r-1}\leq3n,
\]

which proves (41.10). \(\square\)

For a \(P\)-orbit of a homomorphism \(J\to A\), a right
\(\mathscr D\)-subspace of rank \(n\) corresponds in the isogeny category
to a \(J\)-isotypic abelian subvariety of dimension \(15n\).

### Theorem 41.3 (cyclic effective orbit)

Suppose that \(Q\triangleleft P\) and

\[
                         P/Q\simeq C_{7^r}.
\]

Then

\[
                              m\geq3.                    \tag{41.11}
\]

More precisely, if the full norm is nonzero then \(m\geq9\).  If the full
norm is zero, then \(r\geq2\) and

\[
  15\bigl(2\cdot7^{r-1}+2\bigr)
       \leq 2m(7^r-1).                                  \tag{41.12}
\]

#### Proof

Put \(V=W/Q\) and \(\overline P=P/Q\).  The map

\[
       \bar a:V\longrightarrow Y
\]

has degree

\[
       d=\frac{N}{|Q|}=7^{r-1}m.                        \tag{41.13}
\]

By the definition of \(Q\), the stabilizer of \(\bar a\) in
\(\overline P\) is trivial.  Let

\[
 H_{\bar a}\subset\operatorname{Hom}^0(J,J(V))
\]

be the right \(\mathscr D\)-space generated by the
\(\overline P\)-orbit of \(\bar a^*\).  Equality of pullbacks of two maps
to \(Y\) implies equality of the maps, as proved in Theorem 40.3.  It
follows that the action of \(\overline P\) on \(H_{\bar a}\) is faithful.

If the full norm survives, Proposition 41.1 gives \(m\geq9\).  Suppose it
vanishes.  In characteristic zero, the full group sum is the projector
onto the invariant part.  Hence the cyclic module \(H_{\bar a}\) has no
invariant constituent, and its associated abelian subvariety lies in the
moving Prym of

\[
                         V\longrightarrow C_0.
\]

Here the norm formed on \(V\) differs from (41.8) only by the nonzero
scalar \(|Q|\), since \(W\to V\) is a \(Q\)-torsor.

The dimension of that Prym is

\[
 \begin{aligned}
  g(V)-g(C_0)
    &=14\cdot7^{r-1}m-2m\\
    &=2m(7^r-1).                                        \tag{41.14}
 \end{aligned}
\]

Faithfulness and Lemma 41.2 force a summand of
\(\mathscr D\)-rank at least \(2\cdot7^{r-1}\).

Let \(Z\leq\overline P\) be its unique subgroup of order seven.  Lemma
40.2 applied to \(V\to V/Z\) says

\[
              \sum_{z\in Z}z^*\bar a^*\ne0.            \tag{41.15}
\]

An exact-order-\(7^r\) constituent has no \(Z\)-fixed vector.  Because the
full invariant constituent is absent, (41.15) therefore requires a
separate nontrivial constituent factoring through \(\overline P/Z\).
Such a constituent has \(\mathscr D\)-rank at least two.  This also shows
that the zero-norm case is impossible when \(r=1\).  Comparing the resulting
isotypic dimension with (41.14) gives (41.12).

For \(r\geq2\), (41.12) implies

\[
 m\geq
 \left\lceil
  \frac{15(7^{r-1}+1)}{7^r-1}
 \right\rceil=3.
\]

Together with the nonzero-norm case, this proves (41.11). \(\square\)

## 4. The first two seven-adic levels

The preceding argument can be made unconditional when \(s\leq1\).

### Theorem 41.4 (small seven-adic valuation)

With \(N=7^s m\) as above:

1. if \(s=0\), then \(m\geq9\);
2. if \(s=1\), then \(m\geq3\);
3. in the second case, if \(Q\ne1\), then in fact \(m\geq9\).

#### Proof

If \(s=0\), then \(P\simeq C_7\) and \(Q=1\).  Lemma 40.2 says precisely
that the full norm is nonzero, so Proposition 41.1 applies.

Now let \(s=1\), so \(|P|=49\).  If \(Q\ne1\), then \(|Q|=7\).  Every
index-seven subgroup of a \(7\)-group is normal, and \(P/Q\simeq C_7\).
The order-seven norm is nonzero, so Proposition 41.1 again gives \(m\geq9\).

It remains to treat \(Q=1\) and a vanishing full norm.  There are two groups
of order \(49\).

If \(P\simeq C_{49}\), faithfulness and Lemma 41.2 require
\(\mathscr D\)-rank at least fourteen in the exact-order-\(49\) part.  The
norm for the unique order-seven subgroup is nonzero.  It vanishes on the
faithful part, while the full norm is zero, so a separate nontrivial
order-seven part of rank at least two is required.  The total rank is at
least sixteen.

Suppose instead that \(P\simeq C_7^2\).  Its eight nontrivial rational
character types are indexed by the eight order-seven subgroups: a type has
kernel \(R\) for exactly one such subgroup \(R\).  Since the full norm is
zero, there is no trivial type.  For every order-seven subgroup \(R\),
Lemma 40.2 gives

\[
                       \sum_{g\in R}g^*a^*\ne0.
\]

On nontrivial character types this sum is nonzero exactly on the type with
kernel \(R\).  Thus all eight types occur in the cyclic module generated by
\(a^*\).  Each has \(\mathscr D\)-rank at least two by Lemma 41.2, so the
total rank is again at least sixteen.

In either case the associated \(J\)-isotypic subvariety has dimension at
least

\[
                         15\cdot16=240.                  \tag{41.16}
\]

It lies in the moving Prym of \(W\to C_0\), whose dimension, for \(s=1\),
is

\[
          g(W)-g(C_0)=2m(7^2-1)=96m.                    \tag{41.17}
\]

Therefore \(240\leq96m\), and \(m\geq3\). \(\square\)

## 5. Why the normalizer argument cannot be iterated

The first step (41.5) is a nonzero homomorphism

\[
                         J\longrightarrow J(W/R).
\]

It is generally not the pullback induced by a map \(W/R\to Y\).  Indeed,
such a map would say that \(R\), rather than \(Q\), stabilizes \(a\), in
contradiction with (41.1).  Lemma 40.2 uses effective orbit divisors of an
actual map to \(Y\), so it cannot be applied again to (41.5) at the next
normalizer step.

Equivalently, averaging can lose information after one step.  Let
\(P=C_{49}=\langle\gamma\rangle\), let \(Z=\langle\gamma^7\rangle\), and
consider over \(E\) the representation

\[
 E(\zeta_{49})\oplus E(\zeta_7),
 \qquad
 \gamma(u,v)=(\zeta_{49}u,\zeta_7v).
                                                        \tag{41.18}
\]

For the vector \((1,1)\), the stabilizer is trivial and

\[
       \sum_{z\in Z}z(1,1)\ne0,
       \qquad
       \sum_{g\in P}g(1,1)=0.                           \tag{41.19}
\]

Tensoring with \(\mathscr D\) gives the same example in the category of
right \(\mathscr D\)-spaces.  Thus degree-seven norm nonvanishing does not
formally imply full-norm nonvanishing, even with trivial stabilizer.

There is also no extension of the effective-divisor proof at the next
stage.  Vanishing of a norm of degree \(n\) would put a moving family of
degree-\(n\) divisors on \(Y\) in one complete linear system.  The
hyperelliptic/Castelnuovo--Severi argument contradicts this for \(n=7\),
because \(g(Y)=15>6\).  At \(n=49\) it gives only \(g(Y)\leq48\), and
degree-\(49\) base-point-free linear systems on \(Y\) exist.

## 6. A sharp representation-theoretic barrier at \(s=2\)

The failure above is not merely a feature of a large regular
representation.  All the rational representation and dimension data used
in this note already permit \(m=1\) at the next seven-adic level.

### Proposition 41.5 (formal compatibility with \(m=1\))

Let

\[
                  P=C_7^3,\qquad Q=1,
                  \qquad s=2,\quad m=1.
\]

There is a right \(\mathscr D\)-space \(H\) of rank eighteen and a vector
\(v\in H\) such that

1. the stabilizer of \(v\) in \(P\) is trivial;
2. the full \(P\)-norm of \(v\) is zero; and
3. the norm of \(v\) under every order-seven subgroup of \(P\) is nonzero.

Moreover,

\[
        15\dim_{\mathscr D}H=270
        <2(7^3-1)=684,                                  \tag{41.20}
\]

so this module fits inside the dimension available in the moving Prym for
\(m=1,s=2\).

#### Proof

Regard \(P\) as a three-dimensional vector space over \(\mathbf F_7\), and
fix a line \(L_0\subset P\).  The eight planes containing \(L_0\) cover
all of \(P\), and their intersection is \(L_0\).  Add one plane not
containing \(L_0\).  The resulting nine planes \(H_1,\ldots,H_9\) still
cover every line of \(P\), while

\[
                         \bigcap_iH_i=0.                 \tag{41.21}
\]

For each \(H_i\), choose a nontrivial character of \(P/H_i\simeq C_7\).
This rational character type is realizable on a right
\(\mathscr D\)-space of rank two.  To see this directly, put

\[
                         L=E(\zeta_7).
\]

The extension \(L/E\) has degree six.  At every place above \(5\), it has
local degree six because \(5\) has order six modulo seven; this kills the
denominator-three local invariants of \(\mathscr D\).  The algebra
\(\mathscr D\) is unramified elsewhere.  Hence \(L\) splits
\(\mathscr D\), and \(L\) embeds as a maximal subfield of
\(M_2(\mathscr D)\).  Multiplication by \(\zeta_7\) supplies the required
rank-two representation.

Take the direct sum of these nine representations and choose \(v\) with a
nonzero component in every summand.  The stabilizer of the \(i\)-th
component is \(H_i\), so (41.21) gives trivial total stabilizer.  All nine
characters are nontrivial, hence the full norm is zero.  Every order-seven
subgroup is a line contained in at least one \(H_i\); on that summand its
norm is multiplication by seven, so its norm on \(v\) is nonzero.  Finally

\[
                         \dim_{\mathscr D}H=2\cdot9=18,
\]

and (41.20) follows. \(\square\)

Proposition 41.5 does not construct a curve or a common cover.  It proves a
precise limit: absolute simplicity of \(J\), the Honda algebra
\(\mathscr D\), all degree-seven norm nonvanishing statements, the exact
stabilizer, and the available Prym dimension cannot by themselves exclude
the case \(s=2,m=1\).  Further progress must use genuinely geometric
compatibility among the seven-power orbit maps, a polarization constraint
not visible in the rational module, or an independent invariant.
