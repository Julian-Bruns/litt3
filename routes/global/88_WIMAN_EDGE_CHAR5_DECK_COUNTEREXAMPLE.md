# A characteristic-five Wiman--Edge deck counterexample

**Status: proved below; exact Sage certificate PASS; independent audit pending.**

This is the characteristic-five companion to file 85. It shows that the
failure of odd-prime deck normality is not confined to characteristic
zero. There is a smooth genus-six curve over \(\mathbf F _5\) with
several distinct free \(C_5\)-actions whose isomorphic genus-two quotients
have absolutely simple Jacobian. Thus even in the characteristic of the
deck group, simplicity of the quotient Jacobian does not force a cyclic
prime deck group to be normal.

The calculation also explains why one specialization first looked
misleading: two of the four nonzero \(\mathbf F _5\)-members have quotient
Jacobian isogenous to the square of an elliptic curve, while the other two
have absolutely simple quotient Jacobian.

## 1. The curve and its free \(C_5\)-actions

Over \(\mathbf F _5\), put

\[
\begin{split}
 A_0={}&x^6+y^6+z^6+
 (x^2+y^2+z^2)(x^4+y^4+z^4)-12x^2y^2z^2,\\
 B_0={}&(x^2-y^2)(y^2-z^2)(x^2-z^2),\\
 F_t={}&A_0+tB_0 .
\end{split}                                             \tag{88.1}
\]

Let \(S\) be the degree-five del Pezzo surface obtained by blowing up

\[
 (-1:1:1),\quad(1:-1:1),\quad(1:1:-1),\quad(1:1:1)
                                                               \tag{88.2}
\]

in \(\mathbf P^2\), and let \(D_t\subset S\) be the strict transform of
\(F_t=0\).

These are the standard plane coordinates for the Wiman--Edge pencil; see
Dolgachev--Farb--Looijenga,
[Geometry of the Wiman--Edge pencil, I](https://doi.org/10.1007/s40879-018-0231-3),
Section 3.5. The assertions below are checked directly after reduction,
so no good-reduction assertion is being assumed.

### Theorem 88.1

For every \(t\in\mathbf F _5^\times\):

1. \(D_t\) is a smooth geometrically connected curve of genus six;
2. a faithful \(A_5\)-action on \(S\), defined over \(\mathbf F _5\),
   preserves \(D_t\);
3. every subgroup \(C_5\leq A_5\) acts freely on \(D_t\);
4. the quotient \(D_t/A_5\) has genus zero and tame signature
   \[
                              (0;2,2,2,3);              \tag{88.3}
   \]
5. for \(H=C_5\), the quotient \(X_t=D_t/H\) has genus two.

#### Proof

For each \(t=1,2,3,4\), saturating the Jacobian ideal of \(F_t\) by the
irrelevant ideal gives

\[
 \sqrt{(\partial_xF_t,\partial_yF_t,\partial_zF_t)^{\rm sat}}
                    =(x^2-z^2,\ y^2-z^2).              \tag{88.4}
\]

Thus the four points (88.2) are the only geometric singularities. In the
chart \(z=1\), the determinant of the two-variable Hessian is \(2\) at
each of them, so all four are ordinary nodes. The curve is geometrically
irreducible: if a degree-six curve with only these ordinary nodes were
reducible, Bezout would make intersections between distinct components
contribute at least \(1\cdot5=5\), whereas the four transverse nodes
provide total contribution at most four. Blowing up the nodes therefore
gives a smooth connected curve, and

\[
                         g(D_t)=10-4=6.                 \tag{88.5}
\]

For the group action, use the quadratic transformation

\[
\begin{split}
 T(x:y:z)=(&-x^2+y^2+z^2+xy+xz+yz:\\
           & x^2-y^2+z^2+xy+xz+yz:\\
           & x^2+y^2-z^2+xy+xz+yz)
\end{split}                                             \tag{88.6}
\]

and \(L(x:y:z)=(z:-y:-x)\). The map \(T\) is the standard Cremona
involution based at the first three points in (88.2), fixes the fourth,
and lifts to \(S\); \(L\) permutes all four points. Put
\(\phi=L\circ T\). Direct substitution gives

\[
\begin{split}
 A_0\circ\phi&=-(x+y)^2(x+z)^2(y+z)^2A_0,\\
 B_0\circ\phi&=-(x+y)^2(x+z)^2(y+z)^2B_0.              \tag{88.7}
\end{split}
\]

After cancellation, \(\phi^5\) is the identity. On the ten
\((-1)\)-curves of \(S\), the standard \(S_5\)-labeling identifies it
with a five-cycle. The linear map

\[
                         \rho(x:y:z)=(y:z:x)
\]

preserves both \(A_0\) and \(B_0\), and acts as a three-cycle. The two
boundary permutations generate \(A_5\), so \(\phi,\rho\) generate a
faithful \(A_5\)-action preserving every \(D_t\).

It remains to check freeness of \(\langle\phi\rangle\), where equal
characteristic makes a fixed-point argument essential. The radical of
the projective plane fixed ideal of \(\phi\) consists of

\[
 (-1:1:1),\quad(1:-1:1),\quad(1:1:-1),\quad
                         P=(0:2:1).                    \tag{88.8}
\]

The first three are base points of \(T\). No point of \(S\) lying on a
\((-1)\)-curve can be fixed: a five-cycle has two length-five orbits on
the ten boundary curves, so a fixed point on one would lie on all five
of its translates, while no three boundary curves meet. Hence \(P\) is
the unique fixed point of \(\phi\) on \(S\). But

\[
                       A_0(P)=0,\qquad B_0(P)=2,
\]

so \(F_t(P)=2t\ne0\). Every nonidentity power of \(\phi\) generates the
same \(C_5\), and the action on \(D_t\) is free. All Sylow-five subgroups
are conjugate in \(A_5\), proving assertion 3.

Point stabilizers for the \(A_5\)-action are now prime to five, and hence
cyclic tame inertia of order two or three. If \(q=g(D_t/A_5)\) and
\(n_2,n_3\) count the two inertia types, Riemann--Hurwitz gives

\[
 10=60(2q-2)+30n_2+40n_3.                              \tag{88.9}
\]

This forces \(q=0\) and \(3n_2+4n_3=13\), whose only nonnegative solution
is \((n_2,n_3)=(3,1)\). Finally, the free degree-five quotient gives

\[
                  g(X_t)-1=\frac{g(D_t)-1}{5}=1.
\]

This proves all assertions. \(\square\)

## 2. The \(A_5\)-packet and Frobenius

### Proposition 88.2

Let \(P_T(U)\) denote the Frobenius characteristic polynomial on
\(H^1(T_{\overline{\mathbf F}_5},\mathbf Q_\ell)\), for
\(\ell\ne2,3,5\). Then

\[
                              P_{D_t}(U)=P_{X_t}(U)^3.  \tag{88.10}
\]

Consequently \(J(D_t)\) is \(\mathbf F _5\)-isogenous to \(J(X_t)^3\).

#### Proof

The cover \(D_t\to D_t/A_5\) is tame with inertia
\((C_2,C_2,C_2,C_3)\). Equivariant Euler characteristic gives, for a
nontrivial irreducible \(A_5\)-representation \(W\),

\[
 [H^1(D_t):W]
   =2\dim W-3\dim W^{C_2}-\dim W^{C_3}.                \tag{88.11}
\]

The result is two for each of the two conjugate three-dimensional
icosahedral representations and zero for the representations of
dimensions four and five. A \(C_5\) fixes a one-dimensional line in
each three-dimensional representation.

Frobenius commutes with the \(\mathbf F _5\)-rational \(A_5\)-action.
Over a splitting \(\ell\)-adic field, write the two isotypic pieces as
\(W_3\otimes M_3\) and \(W'_3\otimes M'_3\), where both multiplicity
spaces have dimension two. The \(C_5\)-invariants are precisely
\(M_3\oplus M'_3=H^1(X_t)\), while \(H^1(D_t)\) contains three copies
of each multiplicity space. This proves (88.10). The isogeny statement
follows from Tate's theorem. \(\square\)

## 3. Exact point counts and absolute simplicity

The tangent cones at the four nodes are
\[
                 2(U^2+UV+V^2)\quad\hbox{or}\quad
                 2(U^2-UV+V^2).
\]
Their discriminant is \(3\), a nonsquare in \(\mathbf F _5\) which
becomes a square in \(\mathbf F _{25}\). Thus normalization replaces
each rational plane node by no \(\mathbf F _5\)-points and by two
\(\mathbf F _{25}\)-points. Exact enumeration gives

\[
\begin{array}{c|cc|cc|c}
t&\#(F_t=0)(\mathbf F _5)&\#D_t(\mathbf F _5)
 &\#(F_t=0)(\mathbf F _{25})&\#D_t(\mathbf F _{25})
 &L_{X_t}(T)\\ \hline
1,4&4&0&76&80&(1-T+5T^2)^2\\
2,3&4&0&46&50&1-2T+6T^2-10T^3+25T^4 .
\end{array}                                             \tag{88.12}
\]

Indeed, (88.10) divides each Frobenius trace by three. For \(t=2,3\),
for example,

\[
\begin{split}
 \operatorname{Tr}(F\mid H^1(X_t))&=(6-0)/3=2,\\
 \operatorname{Tr}(F^2\mid H^1(X_t))&=(26-50)/3=-8,
\end{split}
\]

which determines the displayed genus-two polynomial.

### Theorem 88.3 (the characteristic-five counterexample)

For \(t=2\) or \(3\), \(J(X_t)\) is absolutely simple. Consequently,
if \(H_1,H_2\) are distinct Sylow-five subgroups of \(A_5\), then

\[
 D_t/H_1\simeq D_t/H_2\simeq X_t
\]

are isomorphic genus-two curves with absolutely simple Jacobian, while
\(H_1,H_2\) are distinct free deck groups, neither is normal, and
\(\langle H_1,H_2\rangle=A_5\).

For \(t=1\) or \(4\), by contrast, \(J(X_t)\) is isogenous to the square
of an ordinary elliptic curve.

#### Proof

For \(t=2,3\), the Frobenius polynomial in reciprocal form is

\[
             R(U)=U^4-2U^3+6U^2-10U+25.               \tag{88.13}
\]

It is irreducible over \(\mathbf Q\), its discriminant is
\(2^8\,5^4\,11\), and its Galois group is \(D_4\) of order eight. If
\(\pi\) is one root and \(K=\mathbf Q(\pi)\), exact factorization over
\(K\) shows that \(K\) contains only two of the four roots of \(R\);
equivalently,
\[
             |\operatorname{Aut}_{\mathbf Q}(K)|=2.   \tag{88.14}
\]
In particular the quartic CM field \(K\) is not Galois. Its real
quadratic subfield is \(\mathbf Q(\pi+5/\pi)\).

The coefficient \(6\) is prime to five, so this is an ordinary abelian
surface. Suppose \(\mathbf Q(\pi^n)\) were a proper subfield of \(K\)
for some \(n>0\). If it were real, every real conjugate of the Weil
number \(\pi^n\) would be \(\pm5^{n/2}\), making
\(\pi^2/5\) a root of unity and forcing all Newton slopes to be
\(1/2\), contrary to ordinarity. It would therefore be an imaginary
quadratic field. Together with the real quadratic subfield it would make
\(K\) biquadratic and hence Galois, contradicting (88.14). Thus

\[
                       \mathbf Q(\pi^n)=K
                       \qquad\text{for every }n>0.     \tag{88.15}
\]

The Frobenius polynomial remains irreducible after every finite constant
extension, so \(J(X_t)\) remains simple after every such extension.
Every geometric abelian subvariety descends to a finite field extension;
hence \(J(X_t)\) is absolutely simple.

For \(t=1,4\), (88.12) is the square of the Frobenius polynomial of an
ordinary elliptic curve, proving the last assertion. Distinct Sylow-five
subgroups are conjugate, so their quotients are isomorphic; any two
distinct ones generate \(A_5\), as in Theorem 85.4. \(\square\)

## 4. Cartier and computational certificate

All four curves \(D_t\), \(t\ne0\), are ordinary. A basis of cubic
adjoints in the chart \(z=1\) is

\[
 1-x^2,\quad y-x^2y,\quad y^2-x^2,\quad
 y^3-x^2y,\quad x-x^3,\quad xy^2-x^3.                 \tag{88.16}
\]

For \(t=1,4\), coefficient extraction from \(F_t^4h\) makes Cartier the
identity on this basis; for \(t=2,3\), the exact matrices are different
but invertible. The retained certificate

88_WIMAN_EDGE_CHAR5_CERTIFICATE.sage

checks:

- the saturated singular ideals and all Hessians;
- the Cremona invariance, order-five relation, and fixed-point ideal;
- the \(A_5\) generation and Chevalley--Weil packet;
- all Cartier matrices and the four point-count rows;
- irreducibility, discriminant, Galois group, and automorphism count of
  (88.13).

It runs in approximately two seconds under Sage 10.9 and ends with
PASS.
