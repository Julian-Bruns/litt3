# Tame common orbifolds for the fixed genus-nine/genus-twenty-five pair

**Status: author proof, self-checked 2026-09-05; not independently audited.**

This note specializes the uniform-signature lemma in
RATIONAL_FACTOR_PROFILE_SHARPNESS.md to the fixed curves of files 76 and
98. It is only a conditional reduction: it assumes that the two curves
already map representably and etale to one finite **effective tame**
orbifold. It neither constructs that common orbifold nor treats wild
inertia.

Let \(k=\overline{\mathbf F}_5\), and let \(X,Y\) be the fixed curves with

\[
 g(X)=9,\qquad g(Y)=25,\qquad
 \operatorname{Hom}(JX,JY)=0,
\]

where \(Y\) is hyperelliptic and both Jacobians are absolutely simple.
Suppose there are representable finite etale maps

\[
                         X\longrightarrow \mathcal S,\qquad
                         Y\longrightarrow \mathcal S.                \tag{1}
\]

Here \(\mathcal S\) is a smooth proper effective tame orbifold curve.

## 1. The exact finite signature sieve

### Proposition 1

The coarse curve of \(\mathcal S\) is \(\mathbf P^1\). Write its stacky
orders as

\[
                    2\le m_1\le\cdots\le m_b,\qquad 5\nmid m_i,
\]

and put

\[
       \delta=\deg K_{\mathcal S}
              =-2+\sum_{i=1}^b\left(1-\frac1{m_i}\right)>0.          \tag{2}
\]

If \(n\) is the degree of the coarse map \(X\to\mathbf P^1\), then

\[
 \boxed{\quad
 \deg(Y\to\mathbf P^1)=3n,\qquad
 \delta=\frac{16}{n},\qquad
 m_i\mid n,\qquad
 n(b-2)-\sum_i\frac{n}{m_i}=16.
 \quad}                                                              \tag{3}
\]

Moreover

\[
                        n\le672,\qquad 3n\le2016.                    \tag{4}
\]

More sharply:

- if \(b\ge5\), then \(n\le32\);
- if \(b=4\), then \(n\le96\);
- if \(n>96\), the signature is triangular and the complete list allowed
  by (3) and tameness is

\[
\begin{array}{c|c|c}
n&3n&(m_1,m_2,m_3)\\ \hline
102&306 &(2,3,102)\\
108&324 &(2,3,54)\\
114&342 &(2,3,38)\\
128&384 &(2,4,8)\\
132&396 &(2,3,22)\\
144&432 &(2,3,18)\\
168&504 &(2,3,14)\\
192&576 &(2,3,12),(2,4,6),(3,3,4)\\
288&864 &(2,3,9)\\
384&1152&(2,3,8)\\
672&2016&(2,3,7).
\end{array}                                                          \tag{5}
\]

These are necessary numerical possibilities, not existence claims for the
fixed curves.

#### Proof

If the coarse curve \(S\) had positive genus, the two coarse maps would
give a nonzero homomorphism

\[
              JX\xrightarrow{\operatorname{Nm}}JS\longrightarrow JY,
\]

as in Proposition 118.3. Hence \(S\simeq\mathbf P^1\).

Representable etaleness says that over the \(i\)-th stacky point every
point of either coarse cover has ramification index exactly \(m_i\), and
there is no other ramification. Thus \(m_i\) divides both coarse degrees.
Orbifold Riemann--Hurwitz gives

\[
                 16=n\delta,\qquad48=(\deg Y/S)\delta,
\]

which proves (3).

For every hyperbolic effective orbifold with coarse curve \(\mathbf P^1\),

\[
                              \delta\ge\frac1{42}.                   \tag{6}
\]

Indeed, if \(b\ge5\), then \(\delta\ge b/2-2\ge1/2\). For \(b=4\), the
largest reciprocal sum strictly below two is
\(1/2+1/2+1/2+1/3\), so \(\delta\ge1/6\). For \(b=3\), ordering the
orders reduces the smallest case to the hyperbolic triangle
\((2,3,7)\), whose canonical degree is \(1/42\). This proves (4) and the
two branch-count refinements.

It remains to justify the short high-degree table rather than hide an
enumeration. If \(n>96\), then \(\delta<1/6\), so \(b=3\). For an ordered
hyperbolic triangle \((a,b,c)\), this inequality leaves only

\[
 (2,3,c),\qquad(2,4,c),\qquad(3,3,c).
\]

In the first family,

\[
        n=\frac{96c}{c-6},\qquad c\mid n
        \quad\Longleftrightarrow\quad c=6+d,\ d\mid96.
\]

Discarding \(5\mid c\) gives precisely the ten displayed
\((2,3,c)\)-rows. In the second family

\[
        n=\frac{64c}{c-4},\qquad c\mid n
        \quad\Longleftrightarrow\quad c=4+d,\ d\mid64;
\]

the conditions \(n>96\), \(c\ge5\), and \(5\nmid c\) leave \(c=6,8\).
In the last family, \(n>96\) and tameness leave only \(c=4\), giving
\((3,3,4)\) and \(n=192\). This proves (5). \(\square\)

Equation (3), together with the finite divisor set of each
\(1\le n\le672\), is the promised finite reduction in the remaining
degrees. It is much smaller than an enumeration of arbitrary maps, but a
signature satisfying (3) need not have a transitive monodromy tuple and
need not occur on either fixed curve.

## 2. The exact hyperelliptic dichotomy

Let

\[
                         h:Y\longrightarrow\mathbf P^1_t
\]

be the hyperelliptic map, with branch set \(\mathcal B\) of cardinality
52, and let \(q:Y\to\mathbf P^1_s\) be the coarse map in (1), of degree
\(3n\).

### Proposition 2

Exactly one of the following holds.

1. **Non-composed case.** The function \(q\) is not in \(k(t)\). Then

\[
                              3n\ge26,\qquad n\ge9.                  \tag{7}
\]

For the fixed \(Y\), the deck group of \(q\) is trivial.

2. **Hyperelliptically composed case.** There is a rational map

\[
             \phi:\mathbf P^1_t\longrightarrow\mathbf P^1_s,\qquad
             q=\phi\circ h,\qquad \deg\phi=N=\frac{3n}{2}.           \tag{8}
\]

In particular \(n\) is even. The map factors at the orbifold level as

\[
 Y\longrightarrow
 \mathcal H=[Y/\langle\iota_Y\rangle]
 \xrightarrow{\ \bar\phi\ }\mathcal S,                              \tag{9}
\]

where \(\mathcal H\) has coarse curve \(\mathbf P^1_t\), has 52 points
of order two, and \(\bar\phi\) is representable finite etale of degree
\(N\). For each target stacky point of order \(m_i\), let

- \(r_i\) be the number of points of \(\mathcal B\) over it;
- \(s_i\) be the number of other points in its \(\phi\)-fiber.

Then

\[
 \boxed{\quad
  \sum_i r_i=52,\qquad
  r_i+2s_i=\frac{3n}{m_i},\qquad
  r_i>0\Longrightarrow 2\mid m_i.
 \quad}                                                             \tag{10}
\]

Equivalently, at a Weierstrass point over the \(i\)-th branch value,

\[
                      e_\phi=\frac{m_i}{2},                         \tag{11}
\]

while at every other point of that fiber, \(e_\phi=m_i\). Consequently

\[
       52\le\sum_{2\mid m_i}\frac{3n}{m_i},\qquad
       r_i\equiv\frac{3n}{m_i}\pmod2.                               \tag{12}
\]

For the fixed \(Y\), the deck group of \(q\) is exactly
\(\langle\iota_Y\rangle\simeq C_2\).

#### Proof

If \(q\notin k(t)\), the index-two field \(k(t)\subset k(Y)\) and \(k(q)\)
generate \(k(Y)\). Castelnuovo--Severi applied to the degree-two and
degree-\(3n\) maps gives

\[
                         g(Y)\le(2-1)(3n-1)=3n-1,
\]

which is (7).

If \(q\in k(t)\), it has the form (8), so \(n\) is even. Uniform
ramification of \(q\) implies that every Weierstrass point maps to a
stacky point of \(\mathcal S\). If \(P\in Y\) lies over \(t_0\), then

\[
                         e_q(P)=e_h(P)e_\phi(t_0)=m_i.
\]

Thus (11) holds at the 52 branch points of \(h\), and \(e_\phi=m_i\) at
ordinary points. Summing local degrees in one \(\phi\)-fiber gives

\[
       N=r_i\frac{m_i}{2}+s_i m_i,
\]

which is (10); (12) follows immediately.

The involution \(\iota_Y\) preserves the reduced divisors over every
stacky point. Locally, if \(u\mapsto-u\) is the hyperelliptic action and
the coarse target parameter is \(u^{m_i}\), its image in target inertia is
the unique element of order two. Hence quotienting gives the
representable etale map (9). Equivalently, this follows by etale descent
along the stack torsor \(Y\to[Y/\langle\iota_Y\rangle]\).

Finally, file 98 proves

\[
       \operatorname{End}^0_kJ(Y)=K,\qquad K\cap\mathbf Q^{\rm ab}=\mathbf Q.
\]

Thus the only roots of unity in \(K\) are \(\pm1\). Faithfulness of the
action of \(\operatorname{Aut}(Y)\) on \(J(Y)\), together with the
hyperelliptic involution inducing \(-1\), gives
\(\operatorname{Aut}(Y)=\{1,\iota_Y\}\). The deck-group assertions now
follow from whether or not \(q\circ\iota_Y=q\). \(\square\)

Absolute simplicity also shows that neither coarse map can factor through
a proper positive-genus intermediate curve: pullback of the intermediate
Jacobian would give a nonzero proper abelian subvariety. It does not rule
out rational functional decompositions such as (8).

## 3. What minimality does not yet give

In the composed case, (9) is a genuine finite etale factorization through
the hyperelliptic quotient **orbifold**. It does not by itself give a map
\(X\to\mathcal H\). Taking a fiber product produces a further etale cover
of \(X\), not a smaller common cover of the two fixed curves. Therefore
minimality of a common curve cannot be invoked to discard (8) without an
additional simultaneous-descent statement. This is the same
Galois-to-non-Galois/core-alignment obstruction encountered elsewhere in
the route.

The non-composed case is even more clearly residual: it is a necessarily
non-Galois uniform cover of degree at least 27. Uniformity and the finite
signature equation do not classify its position in the fixed function
field \(k(Y)\).

## 4. Closest classification theorem and its boundary

The closest exact classical result located is D. Singerman,
[*Subgroups of Fuchsian Groups and Finite Permutation Groups*](https://doi.org/10.1112/blms/2.3.319),
Bull. London Math. Soc. **2** (1970), 319--323. Its subgroup-signature
criterion says that a finite-index subgroup of a Fuchsian group has a
prescribed signature exactly when the elliptic generators have the
required cycle lengths in a transitive coset permutation representation
and the hyperbolic-area/Riemann--Hurwitz identity holds. The proof reads
the subgroup periods from powers of conjugates of the elliptic generators
and uses the coset cycles plus the area formula.

For a torsion-free source, the criterion requires every elliptic generator
of order \(m_i\) to act as a product of \(m_i\)-cycles. This is precisely
the uniform-fiber condition used in (3). Thus Singerman confirms that the
next datum after the numerical signature is a transitive permutation
tuple. It does **not** classify maps from a fixed hyperelliptic curve,
preserve its prescribed 52-point branch set, or supply a characteristic-
five algebraic realization. In the tame setting the analogous monodromy
description comes from the prime-to-five tame fundamental group, but it
still does not solve these fixed-curve conditions.

The remaining assumptions that cannot be dropped are therefore explicit:

1. a finite effective common orbifold must first exist;
2. its inertia must be tame--wild different terms invalidate (2), (6), and
   the uniform Kummer local model;
3. a surviving signature and permutation tuple must still be realized by
   both fixed curves with the same branch support;
4. in the hyperelliptically composed case, one still needs simultaneous
   descent of the \(X\)-leg to the intermediate orbifold before minimality
   can be used.

No claim about the unrestricted common-cover problem follows from this
finite tame reduction alone.
