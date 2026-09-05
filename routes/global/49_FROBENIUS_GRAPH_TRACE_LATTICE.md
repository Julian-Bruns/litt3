# Frobenius-graph tests and the trace lattice at \(M=9\)

## Status, result, and exact gap

**Status: proved.**

**Audit: PASS** -- `/root/frobenius_trace_lattice_audit`, 2026-09-04.
The audit found no breaking objection.  It records two non-breaking
presentation points: the hyperelliptic companion graphs need the same
one-line no-common-component check as the direct graphs, and Corollary 49.4
contains a dangling “and.”
[Audit record](audits/49_FROBENIUS_TRACE_LATTICE_AUDIT.md).

This note turns intersections with graphs of Frobenius, rotations, and the
hyperelliptic involution into 93 exact integral trace tests on each cross
endomorphism

\[
                 u_j=a_*\beta^{j*}a^*\in\operatorname{End}(J(Y)),
                 \qquad 1\leq j\leq6,
\tag{49.1}
\]

in the \(M=9\) seven-diamond.  The tests span the full
ninety-dimensional rational endomorphism algebra and satisfy an exact
Parseval identity.  Consequently the remaining endomorphism problem is a
finite lattice enumeration, rather than an unbounded search.

There is a sharp conditional conclusion.  If the six \(u_j\) belong to
the coefficientwise crossed order

\[
 \mathcal R=\mathcal O_K\oplus\mathcal O_KF\oplus\mathcal O_KF^2,
\tag{49.2}
\]

then all their \(F\)- and \(F^2\)-components vanish, and their circulant
Gram matrix has rank seven.  We do **not** assert that
\(\mathcal R=\operatorname{End}(J(Y))\), or even that the particular
cross correspondences lie in \(\mathcal R\).  The missing input is an
integral comparison at the prime over \(31\): one must determine the
actual endomorphism lattice relative to the optimal embedding
\(\mathcal O_K\subset\operatorname{End}(J(Y))\), or prove directly that
these six geometrically produced elements satisfy the crossed-order
coefficient congruences.  The rational division algebra alone does not
supply this.

Throughout,

\[
 Y:z^2=1-t^{31},\qquad J=J(Y),\qquad K=\mathbf Q(\zeta_{31}),
\]

\[
 E=K^{\langle5\rangle},\qquad
 \mathscr D=\operatorname{End}^0(J).
\tag{49.3}
\]

File 40 proves that \(\mathscr D\) is a degree-three division algebra
over \(E\), containing \(K\) as a maximal subfield.  Let \(F\) denote the
endomorphism induced by the relative \(5\)-power Frobenius of the
\(\mathbf F_5\)-model of \(Y\), using the graph orientation for which it
acts covariantly on \(J\).  Then

\[
 FxF^{-1}=\sigma(x),\qquad \sigma(\zeta_{31})=\zeta_{31}^5,
 \qquad F^\dagger F=[5],
\tag{49.4}
\]

and dimension gives the cyclic-algebra decomposition

\[
                  \mathscr D=K\oplus KF\oplus KF^2.
\tag{49.5}
\]

Changing the graph orientation replaces \(F\) by its Rosati adjoint and
only permutes the three summands; none of the statements below changes.

## 1. The 93 graph-intersection bounds

Let \(\rho(t,z)=(\zeta_{31}t,z)\), and let \(\iota(t,z)=(t,-z)\).
For

\[
 0\leq s\leq2,\qquad b\in\mathbf Z/31,
\]

put

\[
                         q_{s,b}=F^s\rho^b\in\mathscr D,
\tag{49.6}
\]

where replacing \(b\) by a fixed nonzero multiple if necessary accounts
for pushforward versus pullback.  Thus \(q_{s,b}\) is induced by a graph
whose two projection degrees are \(5^s\) and \(1\).  Composing that graph
with \(\iota\) replaces \(q_{s,b}\) by \(-q_{s,b}\), without changing its
projection degrees.

### Proposition 49.1 (two-sided Frobenius-graph bounds)

For every \(j=1,\ldots,6\), \(s=0,1,2\), and
\(b\in\mathbf Z/31\),

\[
 \left|
  \operatorname{Tr}\bigl(u_j^\dagger q_{s,b}\mid
                 H^1_{\mathrm{et}}(Y,\mathbf Q_\ell)\bigr)
 \right|
       \leq 9(1+5^s).
\tag{49.7}
\]

The three bounds are respectively

\[
                              18,\qquad54,\qquad234.
\tag{49.8}
\]

The transpose graphs give, with the same right sides,

\[
 \left|\langle u_j,q_{s,b}^\dagger\rangle\right|
       \leq9(1+5^s).
\tag{49.9}
\]

#### Proof

Let \(\Gamma_j\) be the reduced image of

\[
          (a,a\beta^j):V\longrightarrow Y\times Y,
\]

and let \(e_j\) be the generic degree onto \(\Gamma_j\).  Work with the
effective pushforward cycle

\[
             Z_j=(a,a\beta^j)_*[V]=e_j\Gamma_j.
\]

This cycle has bidegree \((9,9)\), and its correspondence action is
exactly \(u_j\), regardless of whether the map to \(\Gamma_j\) is
birational.  The graph representing \(q_{s,b}\) has bidegree
\((5^s,1)\), up to interchanging the factors.  The fiber parts of the two
Neron--Severi cycle classes therefore intersect in

\[
                         9\cdot5^s+9\cdot1=9(1+5^s).
\]

The correspondence parts pair by minus the cohomological Rosati trace.
Hence

\[
 Z_j\cdot\operatorname{Graph}(q_{s,b})
 =9(1+5^s)-\operatorname{Tr}(u_j^\dagger q_{s,b}\mid H^1(Y)).
\tag{49.10}
\]

No component of \(Z_j\) is one of these graphs.  For \(s=1,2\), this
follows because the two normalized projection degrees of \(\Gamma_j\)
are equal, whereas those of the graph are \(5^s\) and \(1\).  For
\(s=0\), equality would give \(a\beta^j=\tau a\) for an automorphism
\(\tau\) of \(Y\).  Iteration would give \(\tau^7=1\), but
\(\operatorname{Aut}(Y)=C_{31}\times C_2\) has no nontrivial element of
order seven; the trivial case contradicts \(a\beta^j\ne a\).

Thus (49.10) is nonnegative.  Replacing the graph by its composition
with \(\iota\) changes the trace term's sign, and its intersection is
again nonnegative.  These two inequalities give (49.7).  Interchanging
the two factors gives the transpose graph and proves (49.9). \(\square\)

### Remark 49.2 (why transpose tests are globally redundant)

Put \(V_F=F^\dagger=5F^{-1}\) and \(\pi=F^3\in E\).  Up to rotation
indices, the transpose families are

\[
 q_{1,b}^\dagger\in (5/\pi)KF^2,\qquad
 q_{2,b}^\dagger\in (25/\pi)KF.
\tag{49.11}
\]

Thus they do give differently scaled tests on the two noncommutative
cyclic components if one studies one endomorphism in isolation.  For the
actual six-tuple, however, they add no independent inequality.  Indeed,
\(u_{7-j}=u_j^\dagger\), invariance of cohomological trace under
adjunction, and cyclicity of trace give

\[
 \langle u_j,q_{s,b}^\dagger\rangle
     =\langle u_{7-j},q_{s,b}\rangle.
\tag{49.12}
\]

Consequently all transpose bounds are already among the direct bounds
for the paired cross endomorphism.

## 2. Orthogonality and exact Parseval

Equip \(\mathscr D\) with its positive Rosati trace pairing

\[
 \langle x,y\rangle
   =\operatorname{Tr}(x^\dagger y\mid H^1_{\mathrm{et}}(Y,\mathbf Q_\ell)).
\tag{49.13}
\]

The value lies in \(\mathbf Q\) on \(\mathscr D\), and is an integer when
\(x,y\in\operatorname{End}(J)\).

### Proposition 49.3 (the three tight cyclotomic frames)

For \(0\leq s,r\leq2\) and \(b,c\in\mathbf Z/31\),

\[
 \langle q_{s,b},q_{r,c}\rangle=0\quad(s\ne r),
\tag{49.14}
\]

whereas

\[
 \langle q_{s,b},q_{s,c}\rangle
 =5^s
 \begin{cases}
 30,&b=c,\\
 -1,&b\ne c.
 \end{cases}
\tag{49.15}
\]

For each fixed \(s\), the 31 elements \(q_{s,b}\) have the unique
relation

\[
                         \sum_{b=0}^{30}q_{s,b}=0,
\tag{49.16}
\]

and span the thirty-dimensional space \(KF^s\).  The three families
together span the whole ninety-dimensional algebra \(\mathscr D\).

If \(x\in\mathscr D\) and

\[
 t_{s,b}(x)=\langle x,q_{s,b}\rangle,
\tag{49.17}
\]

then

\[
 \sum_{b=0}^{30}t_{s,b}(x)=0,
\tag{49.18}
\]

and one has the reconstruction and Parseval identities

\[
 x=\sum_{s=0}^2
       \frac1{31\cdot5^s}
       \sum_{b=0}^{30}t_{s,b}(x)q_{s,b},
\tag{49.19}
\]

\[
 \langle x,x\rangle
   =\sum_{s=0}^2
       \frac1{31\cdot5^s}
       \sum_{b=0}^{30}t_{s,b}(x)^2.
\tag{49.20}
\]

#### Proof

The reduced trace of either nontrivial cyclic-algebra summand
\(KF\) or \(KF^2\) is zero.  Thus distinct summands in (49.5) are
orthogonal.  Moreover,

\[
 (F^s\rho^b)^\dagger(F^s\rho^c)
       =5^s\rho^{\,c-b},
\]

up to a simultaneous permutation of \(b,c\) coming from \(\sigma\).
On the maximal subfield \(K\), the cohomological trace is the field trace
\(\operatorname{Tr}_{K/\mathbf Q}\).  Therefore

\[
 \operatorname{Tr}_{K/\mathbf Q}(\zeta_{31}^d)
  =
  \begin{cases}
  30,&d=0,\\
  -1,&d\ne0,
  \end{cases}
\]

which proves (49.14)--(49.15).

The relation (49.16) is the cyclotomic relation
\(\sum_b\zeta_{31}^b=0\).  The Gram matrix in (49.15) is

\[
                         5^s(31I_{31}-{\bf1}{\bf1}^{\,t}).
\]

It has rank thirty and acts by the scalar \(31\cdot5^s\) on the
sum-zero subspace.  This proves that each family is a tight frame for
\(KF^s\).  The orthogonal direct sum (49.5) now gives
(49.18)--(49.20). \(\square\)

### Corollary 49.4 (an exact finite lattice reduction)

For an actual cross endomorphism \(u_j\), all 93 numbers

\[
                         t_{s,b}=t_{s,b}(u_j)
\]

are integers satisfying

\[
 \sum_b t_{s,b}=0,\qquad
 |t_{s,b}|\leq9(1+5^s),
\tag{49.21}
\]

and

Conversely, (49.19) reconstructs at most one rational endomorphism from
such an array.  Hence the possible \(u_j\) form a finite, explicitly
enumerable set.  For the six-tuple one additionally imposes

\[
 u_{7-j}=u_j^\dagger,\qquad
 G=(u_{j-i})\geq0,
\tag{49.22}
\]

and any norm, rank, and frame constraints available from the diamond.

#### Proof

Integrality of (49.21) follows because both \(u_j\) and every graph
endomorphism \(q_{s,b}\) are integral.  Proposition 49.1 supplies the
box bounds.  There are only finitely many integer arrays in this box,
and Proposition 49.3 makes the trace map injective, proving the claim.
\(\square\)

This is an exact algorithmic reduction: enumerate the sum-zero integer
arrays satisfying (49.21), reconstruct by (49.19), and retain
only those elements lying in the actual lattice
\(\operatorname{End}(J)\) and satisfying (49.22).  The unresolved task is
not finiteness but an explicit description of that integral lattice.

## 3. What the coefficientwise crossed order would imply

We now record the conclusion available under the missing integral input.

### Lemma 49.5 (a cyclotomic coefficient gap)

Let

\[
 x=\sum_{i=0}^{30}c_i\zeta_{31}^i\in\mathcal O_K,
 \qquad c_i\in\mathbf Z,
\]

where the coefficient vector is unique up to adding one common integer
to all \(c_i\).  Put

\[
                         r_b=\operatorname{Tr}_{K/\mathbf Q}
                                  (\overline{x}\zeta_{31}^b).
\]

Then, after a permutation of the indices,

\[
                         r_b=31c_b-\sum_i c_i.
\tag{49.23}
\]

Consequently:

1. if \(|r_b|\leq10\) for every \(b\), then \(x=0\);
2. if \(|r_b|\leq9\) for every \(b\), then \(x=0\);
3. if \(|r_b|\leq18\) for every \(b\) and \(x\ne0\), then, after adding
   a common integer to the coefficients,
   \[
                    x=\sum_{i\in A}\zeta_{31}^i
                    \quad\text{with}\quad13\leq|A|\leq18.
   \tag{49.24}
   \]

#### Proof

The cyclotomic trace is \(30\) at exponent zero and \(-1\) at every
other exponent, giving (49.23).  Hence

\[
                         r_b-r_c=31(c_b-c_c).
\tag{49.25}
\]

Under either of the first two bounds, the left side has absolute value
strictly below \(31\), so all \(c_i\) are equal and the cyclotomic
relation gives \(x=0\).

Under the bound \(18\), (49.25) says that any two coefficients differ by
at most one.  Subtract their common minimum; then every coefficient is
zero or one.  If \(m\) of them are one, the trace values are
\(31-m\) on those \(m\) indices and \(-m\) on the other indices.
The bound \(18\) is therefore equivalent to
\(13\leq m\leq18\). \(\square\)

### Theorem 49.6 (conditional crossed-order conclusion)

Assume that every \(u_j\), \(1\leq j\leq6\), belongs to the
coefficientwise crossed order \(\mathcal R\) of (49.2).  Then

\[
                              u_j\in\mathcal O_K
                              \quad(1\leq j\leq6),
\tag{49.26}
\]

and each \(u_j\) has the form (49.24).  More precisely,

\[
 \operatorname{Tr}(u_j)\in
 \{-18,\ldots,-13\}\cup\{13,\ldots,18\},
\]

\[
 I_j=18-\operatorname{Tr}(u_j)
       \in\{0,\ldots,5\}\cup\{31,\ldots,36\}.
\tag{49.27}
\]

The circulant Gram matrix \(G=(u_{j-i})\) then has
\(\mathscr D\)-rank seven.  Equivalently, the primitive
\(J\)-isotypic orbit generated by \(a^*J\) consists of six copies of
\(J\).

#### Proof

Write

\[
                         u_j=x_0+x_1F+x_2F^2,
                         \qquad x_s\in\mathcal O_K.
\]

Orthogonality of the three cyclic-algebra summands and (49.4) give,
after harmless permutations of \(b\),

\[
 t_{s,b}(u_j)
   =5^s\operatorname{Tr}_{K/\mathbf Q}
       \bigl(\sigma^{-s}(\overline{x_s})\zeta_{31}^b\bigr).
\tag{49.28}
\]

For \(s=1\), Proposition 49.1 makes the integer cyclotomic trace on the
right at most \(\lfloor54/5\rfloor=10\) in absolute value.  For \(s=2\)
it is at most \(\lfloor234/25\rfloor=9\).  Lemma 49.5 gives
\(x_1=x_2=0\).  Thus \(u_j=x_0\in\mathcal O_K\).  File 45 shows that
\(u_j\ne0\), so the last part of Lemma 49.5 gives (49.24).
Formula (49.27) follows directly from (49.23), according as the
coefficient of \(\zeta_{31}^0\) is zero or one.

It remains to determine the Gram rank.  Put

\[
 L=E(\zeta_7).
\]

Then \(K\cap L=E\), and \(KL/L\) is a degree-three field.  Moreover,
file 40 gives

\[
                         \mathscr D\otimes_E L\simeq M_3(L),
\]

with \(KL\) a maximal subfield.  Fourier diagonalization of the
seven-by-seven circulant matrix \(G\) over \(L\) gives the seven blocks

\[
                         g_a=\sum_{j=0}^6u_j\zeta_7^{aj},
                         \qquad0\leq a\leq6.
\tag{49.29}
\]

Because every \(u_j\in K\), each \(g_a\) belongs to the field \(KL\).
It is therefore either zero or invertible in \(M_3(L)\).  The six
primitive blocks \(g_a\), \(a=1,\ldots,6\), are permuted transitively by
\(\operatorname{Gal}(L/E)\); hence they are either all zero or all
invertible.  They cannot all vanish, since the primitive orbit is
nonzero by Theorem 40.3.  Thus all six are invertible.  The invariant
block is also nonzero by Lemma 40.2, so \(G\) has full
\(\mathscr D\)-rank seven. \(\square\)

## 4. An unconditional maximal-order restriction in degree three

The same graph tests give one useful fact about the possible
bidegree-\((3,3)\) correspondence which arises if a cross map has generic
degree three.  This fact does not assume membership in \(\mathcal R\).

### Proposition 49.7 (the cyclotomic component vanishes in degree three)

Let \(\Gamma\subset Y\times Y\) be an irreducible effective
correspondence of bidegree \((3,3)\), whose normalization projections are
etale, and let

\[
                         v\in\operatorname{End}(J)
\]

be its correspondence endomorphism.  In the rational decomposition

\[
                         v=x_0+x_1F+x_2F^2,
                         \qquad x_s\in K,
\tag{49.30}
\]

one necessarily has

\[
                              x_0=0.                    \tag{49.31}
\]

Moreover,

\[
                    \langle v,v\rangle\leq102.          \tag{49.32}
\]

#### Proof

Intersection with the graphs of \(\rho^b\) and \(\iota\rho^b\) gives

\[
 \left|\operatorname{Tr}(v^\dagger\rho^b\mid H^1(Y))\right|
                              \leq 2\cdot3=6.            \tag{49.33}
\]

Write these 31 integral traces as \(t_b\).  Their sum is zero.

Let \(x\) be the \(K\)-component of \(v^\dagger\).  For every
\(y\in\mathcal O_K\),

\[
 \operatorname{Tr}_{K/E}(xy)
       =\operatorname{Trd}_{\mathscr D/E}(v^\dagger y)
       \in\mathcal O_E.
\]

Thus \(x\) lies in the inverse relative different
\(\mathfrak D_{K/E}^{-1}\).  The extension \(K/E\) is tamely and totally
ramified of degree three at the unique prime over \(31\), and unramified
elsewhere, so, with \(\lambda=1-\zeta_{31}\),

\[
                         \mathfrak D_{K/E}=(\lambda^2).
\tag{49.34}
\]

Take third finite differences in the cyclic index \(b\).  Since
\(x\lambda^3\in\lambda\mathcal O_K\),

\[
 \Delta^3t_b
   =\operatorname{Tr}_{K/\mathbf Q}
          (x\zeta_{31}^b(\zeta_{31}-1)^3)
   \equiv0\pmod {31}.                                  \tag{49.35}
\]

Here
\(\operatorname{Tr}_{K/\mathbf Q}(\lambda\mathcal O_K)
\subset31\mathbf Z\), as is seen directly on the basis
\(\lambda,\lambda\zeta_{31},\ldots,\lambda\zeta_{31}^{29}\).
Consequently \(b\mapsto t_b\bmod31\) is a polynomial function of degree
at most two on \(\mathbf F_{31}\).

All its values lie in

\[
 S=\{0,\pm1,\ldots,\pm6\}\subset\mathbf F_{31},
 \qquad |S|=13.
\]

A nonconstant linear polynomial has 31 values, while a genuine
quadratic polynomial over \(\mathbf F_{31}\) has
\((31+1)/2=16\) values.  Hence this polynomial is constant.  Reduction
modulo \(31\) is injective on the integer interval \([-6,6]\), so all
\(t_b\) are the same integer.  Their sum is zero, and therefore every
\(t_b=0\).  The \(s=0\) tight-frame identity in Proposition 49.3 now
gives \(x=0\), which is equivalent to (49.31).

Finally, formula (45.17), with \(n=3\), says

\[
 0\leq\delta(\Gamma)
       =3^2+14\cdot3-\frac12\langle v,v\rangle.
\]

This is (49.32). \(\square\)

The direct \(F\)-graph tests and the transposed \(F\)-graph tests bound
tight trace frames for the two remaining summands by \(18\), rather than
\(6\).  The interval \([-18,18]\) represents every residue modulo \(31\),
so the value-set argument in Proposition 49.7 does not eliminate those
summands.  Resolving them requires the full integral lattice and the
central action of \(F^3\), not only the relative codifferent.

## 5. The unresolved integral step

The conclusion of Theorem 49.6 uses exactly one fact not presently
proved for the geometric cross correspondences: coefficientwise
integrality in (49.2).  At the rational level (49.5) is exact, but an
element of a larger order in \(\mathscr D\) can have \(K\)-coefficients
in fractional ideals.  At the prime over \(31\), where the cyclotomic
extension \(K/E\) is ramified, such coefficients need not satisfy the
modulo-\(31\) difference relation used in (49.25), even though all 93
trace values remain integral.

Thus the next arithmetic problem is precise:

> Determine the completion of
> \(\operatorname{End}(J)\) at \(31\), relative to the embedded
> \(\mathcal O_K\), and enumerate its elements satisfying
> (49.21); or prove that the six elements arising from the
> etale cross correspondences lie in \(\mathcal R\).

Until that optimal-embedding/lattice problem is resolved, the
Frobenius-graph tests do not exclude the smaller cyclic-orbit ranks
allowed by the rational calculation in file 40.  The tests nevertheless
detect every rational component and reduce the remaining question to a
finite, explicit integral calculation.
