# Rational-factor profiles are orbifold profiles, and the two residual profiles are sharp

## Status and purpose

**Status: proved; self-check complete.**

This note records the exact general content of the common-ramification
calculation for a rational factor of an incidence map. It also prevents a
misleading strategy: neither residual profile in Corollary 77.2b is
numerically impossible. Both occur in characteristic five, with connected
normalized fiber product and etale projections.

The realization proof uses only groups of order prime to five. Thus the
prime-to-characteristic tame fundamental-group theorem applies; no
realization is inferred merely from a branch-cycle tuple in a group whose
order is divisible by the characteristic.

## 1. The parameterized orbifold identity

### Proposition 1 (common uniform signature)

Let \(k\) be algebraically closed, and let

\[
             f_i:C_i\longrightarrow\mathbf P^1_k
             \qquad(i=1,2)
\]

be finite separable maps of degrees \(n_i\). Suppose the normalization
\(W\) of \(C_1\times_{\mathbf P^1}C_2\) is connected and both maps
\(W\to C_i\) are etale.

Then the branch supports of \(f_1,f_2\) coincide. At every common branch
value \(b\), there is an integer \(t_b\ge2\) such that every point in
either fiber \(f_i^{-1}(b)\) has ramification index \(t_b\). In particular,

\[
                         t_b\mid\gcd(n_1,n_2).          \tag{1.1}
\]

If the ramification is tame, then

\[
 {2g(C_1)-2\over n_1}
 =-2+\sum_b\left(1-{1\over t_b}\right)
 ={2g(C_2)-2\over n_2}.                               \tag{1.2}
\]

Conversely, for two tame covers having the same branch support and the
same uniform index \(t_b\) above every \(b\), every component of the
normalized fiber product has etale projections to both factors.

#### Proof

Fix points \(P_i\in C_i\) above the same \(b\), with ramification indices
\(e_i\). The normalization is surjective onto the fiber product, so there
is a point of \(W\) above \((P_1,P_2)\). Its ramification index over
\(\mathbf P^1\) is both \(e_1\) times its index over \(C_1\) and \(e_2\)
times its index over \(C_2\). Both latter indices are one, so \(e_1=e_2\).
As the pair was arbitrary, all indices in both fibers equal one common
\(t_b\). Taking one index equal to one also proves equality of the branch
supports. This proves (1.1).

For tame uniform ramification, the contribution over \(b\) to the
different of \(f_i\) is

\[
             {n_i\over t_b}(t_b-1)
             =n_i\left(1-{1\over t_b}\right).
\]

Riemann--Hurwitz gives (1.2).

For the converse, completed local extensions at points above \(b\) have,
after changing uniformizers, the form

\[
                         t=u^{t_b},\qquad t=v^{t_b},
\]

because \(t_b\) is prime to the characteristic. Every branch of the
normalized tensor product maps with ramification index one to both
factors. Away from the common branch support there is no ramification.
\(\square\)

### Corollary 2 (the prime-ratio incidence equation)

In the parameterized prime-ratio setting, write

\[
                  g(X)=s+1,\qquad g(Y)=rs+1.
\]

Suppose a rational factor produces tame maps

\[
 Z\longrightarrow\mathbf P^1\quad(\deg M),\qquad
 Y\longrightarrow\mathbf P^1\quad(\deg d),
\]

whose normalized fiber product has etale projections. If \(Z\to X\) is
etale of degree \(e\) and \(de=Mr\), then

\[
 \boxed{\quad
 \sum_b\left(1-{1\over t_b}\right)
       =2+{2rs\over d}=2+{2es\over M},
 \qquad t_b\mid\gcd(M,d).
 \quad}                                                  \tag{1.3}
\]

If \(\gcd(M,d)=\ell\) is prime, all \(t_b=\ell\), and

\[
                 \#B={2\ell\over\ell-1}
                       \left(1+{rs\over d}\right).      \tag{1.4}
\]

Thus (1.3) is an effective integrality/signature sieve, but the
constructions below show that it is not by itself an exclusion theorem.

## 2. The five-cubic profile is realized in characteristic five

### Proposition 3

Over \(k=\overline{\mathbf F}_5\), there are smooth curves \(Z_0,Y_0\)
of genera \(7,15\), maps

\[
 Z_0\longrightarrow\mathbf P^1\quad(\deg9),\qquad
 Y_0\longrightarrow\mathbf P^1\quad(\deg21),
\]

with five common branch values and respective fiber profiles
\(3^3,3^7\) above each one, such that their normalized fiber product is
connected and its projections to \(Z_0,Y_0\) are etale.

#### Proof

Let

\[
 A=(\mathbf Z/3)^2,\qquad
 B=(\mathbf Z/7)\rtimes(\mathbf Z/3),
\]

where \(1\in\mathbf Z/3\) acts on \(\mathbf Z/7\) by multiplication by
\(2\). Write

\[
             (a,i)(b,j)=(a+2^i b,i+j)
\]

in \(B\). For five standard puncture generators, use in \(A\)

\[
 e_1,e_1,e_2,e_2,e_1+e_2,                              \tag{2.1}
\]

and in \(B\)

\[
 (0,2),(0,1),(1,1),(0,1),(5,1).                        \tag{2.2}
\]

Every displayed element has order three, each list has product one, and
each list generates its group. The image in \(A\times B\) is the full
product. Indeed, Goursat's lemma reduces a proper subdirect product to a
common nontrivial quotient. The only possibility is \(C_3\). A character
of \(A\) has values on (2.1) of the form

\[
                         (a,a,b,b,a+b),
\]

whereas the quotient values of (2.2) are \((2,1,1,1,1)\), even up to a
nonzero scalar. These cannot agree.

The group \(A\times B\) has order \(189\), prime to five. The
prime-to-five tame fundamental group of a five-punctured projective line
therefore realizes this generating tuple as a connected tame Galois
cover. Quotient by \(B\), respectively by \(A\), gives the regular
degree-nine \(A\)-cover and regular degree-21 \(B\)-cover. Their profiles
are \(3^3\) and \(3^7\).

The normalized fiber product is connected because the combined monodromy
is \(A\times B\). Its projections are etale by Proposition 1 (equivalently,
the diagonal inertia meets either factor trivially). Tame
Riemann--Hurwitz gives genera \(7,15\). \(\square\)

## 3. The triangle profile is realized in characteristic five

### Proposition 4

Over \(k=\overline{\mathbf F}_5\), there are smooth curves \(X_0,Y_0\)
of genera \(3,15\), maps of degrees \(9,63\) to a common projective line,
and three common branch values with profiles

\[
\begin{array}{c|ccc}
       &b_0&b_1&b_2\\ \hline
 X_0&3^3&9&9\\
 Y_0&3^{21}&9^7&9^7,
\end{array}                                             \tag{3.1}
\]

such that the normalized fiber product is connected and both projections
are etale.

#### Proof

The degree-nine cover uses the regular action of \(C_9\), with branch
generators

\[
                              3,1,5\pmod9.              \tag{3.2}
\]

For the degree-63 cover, use the permutations

\[
\begin{aligned}
 \sigma_0&=(1\ 7\ 3)(2\ 8\ 6)(4\ 5\ 9),\\
 \sigma_1&=(1\ 2\ 3\ 4\ 5\ 6\ 7\ 8\ 9),\\
 \sigma_2&=(1\ 2\ 5\ 3\ 6\ 7\ 9\ 4\ 8).
\end{aligned}                                           \tag{3.3}
\]

With right-to-left composition,
\(\sigma_0\sigma_1\sigma_2=1\). They generate
\(\operatorname{PSL}_2(8)\) in its degree-nine action, and have cycle
types \(3^3,9,9\). Pair them with

\[
                         (0,1),(1,1),(3,1)             \tag{3.4}
\]

in the natural degree-seven affine action of
\(B=(\mathbf Z/7)\rtimes(\mathbf Z/3)\). The latter triple consists of
order-three elements, has product one, and generates \(B\).
The paired triples generate
\(\operatorname{PSL}_2(8)\times B\), since the two factors have no common
nontrivial quotient. In the product action on \(9\cdot7=63\) letters, the
cycle types are \(3^{21},9^7,9^7\).

Finally combine this representation with (3.2). The only possible common
nontrivial quotient of \(C_9\) and
\(\operatorname{PSL}_2(8)\times B\) is \(C_3\). The quotient values of
(3.2) are \((0,1,2)\), whereas those of (3.4) are \((1,1,1)\), even up
to automorphism. Goursat's lemma shows that the combined monodromy is the
full product.

Its order \(9\cdot504\cdot21\) is prime to five. The prime-to-five tame
fundamental-group theorem realizes the tuple over \(k\). Full combined
monodromy makes the normalized fiber product connected, Proposition 1
makes both projections etale, and Riemann--Hurwitz gives genera \(3,15\).
\(\square\)

## 4. Consequence for the fixed curves

Degrees, genera, common branch supports, and uniform tame ramification
cannot eliminate either residual alternative in
[the incidence theorem, Section 6](PARAMETERIZED_PUSHED_INCIDENCE_DICHOTOMY.md).
An exclusion
must use the fixed equations

\[
             X:v^2=x^7-x+1,\qquad Y:z^2=1-t^{31}.
\]

For the triangle alternative, normalize the two index-nine branch values
of \(X\to\mathbf P^1\) to zero and infinity. Their unique points \(P,Q\)
satisfy

\[
                              9(P-Q)=0\quad\text{in }J(X). \tag{4.1}
\]

The known Frobenius polynomial satisfies \(F^{72}-1\equiv0\pmod9\), so
all of \(J(X)[9]\) is rational over \(\mathbf F_{5^{72}}\). A decisive
finite algorithm is to enumerate the \(9^6\) torsion points, retain the
classes of reduced Mumford degree at most two (the possible point
differences over the algebraic closure), reconstruct the Riemann--Roch
spaces for \(9P-9Q\), and test whether the third fiber has type \(3^3\).

For the five-cubic alternative on \(Y\), write each branch fiber as
\(3D_b\), where \(\deg D_b=7\). Then

\[
                  [D_b-D_c]\in J(Y)[3].                \tag{4.2}
\]

The five classes (with one chosen as origin) are pairwise distinct:
equality would make \(D_b-D_c\) principal and produce a degree-seven
pencil on a genus-fifteen hyperelliptic curve. That is impossible because
a base-point-free pencil of degree at most the genus has even degree and
factors through the hyperelliptic pencil. This is necessary fixed-curve
information, but not yet an exclusion.
