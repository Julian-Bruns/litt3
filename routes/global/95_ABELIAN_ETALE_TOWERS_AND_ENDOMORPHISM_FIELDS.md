# Abelian etale towers and endomorphism fields

**Status: proved; independently audited PASS, 2026-09-04. The target
arithmetic input has also been independently checked.**

[Combined audit, with auditor and nonbreaking suggestions](audits/95_96_98_ALL_DEGREE_PACKET_CHAIN_AUDIT.md).
[Target arithmetic audit](audits/76_GENUS25_Y_ARITHMETIC_AND_SIGNED_RATIO_AUDIT.md).

This argument needs no Galois assumption on the map to the second curve.
It excludes every abelian Galois covering degree at once, including degrees
divisible by the characteristic. It does not assert that arbitrary common
covers can be replaced by ones with abelian Galois monodromy.

All curves are smooth, projective, and geometrically connected over an
algebraically closed field. Endomorphisms and simplicity are geometric.
Write \(g_X=g(X)\), \(g_Y=g(Y)\), and \(s=g_X-1\).

## 1. The uniform obstruction

### Theorem 95.1

Suppose \(g_X\ge2\), \(J(Y)\) is simple, and

\[
                 K=\operatorname{End}^0_k J(Y)
\]

is a number field. Fix an embedding \(K\subset\overline{\mathbf Q}\),
and put

\[
        K_{\rm ab}=K\cap\mathbf Q^{\rm ab},\qquad
        a_0=[K_{\rm ab}:\mathbf Q].                         \tag{95.1}
\]

If there are a connected finite etale Galois cover \(D\to X\) with
finite abelian deck group and a nonconstant morphism \(D\to Y\), then

\[
                g_Y\le g_X\quad\hbox{or}\quad
                g_Y\le a_0(g_X-1).                        \tag{95.2}
\]

Consequently, if

\[
                 g_Y>\max\{g_X,a_0(g_X-1)\},              \tag{95.3}
\]

no curve in the abelian etale tower of \(X\) admits a nonconstant map
to \(Y\). Here this tower includes non-Galois intermediate covers of
finite abelian Galois covers; such intermediate covers are themselves
Galois because every subgroup of an abelian group is normal.

The map to \(Y\) need not be etale, Galois, or separable. There is no
assumption on the simplicity of \(J(X)\) or on \(\operatorname{Aut}(X)\).

### Lemma 95.2: the free-action character

For any finite group \(H\) acting freely on a curve \(D\), with
\(X=D/H\) of genus at least two, and any prime \(\ell\ne\operatorname{char}k\),

\[
 H^1_{\rm et}(D,\mathbf Q_\ell)
       \simeq \mathbf Q_\ell^{\oplus2}
           \oplus\mathbf Q_\ell[H]^{\oplus 2s}.          \tag{95.4}
\]

This includes the case \(\operatorname{char}k\mid |H|\).

#### Proof

For \(h\ne1\), the graph of \(h\) is disjoint from the diagonal in
\(D\times D\). The etale cohomological Lefschetz formula therefore gives

\[
       0=1-\operatorname{Tr}(h\mid H^1_{\rm et}(D,\mathbf Q_\ell))+1.
\]

The traces on \(H^0\) and \(H^2\) are both one. At the identity,
etale Riemann--Hurwitz gives
\(2g(D)=2+2|H|s\). These are precisely the character values on the
right of (95.4). Finite-group representations over \(\mathbf Q_\ell\)
are semisimple, and their characters determine them.

For the precise Lefschetz statement, see Milne,
[Lectures on Etale Cohomology, Theorem 25.1 and its proof](https://www.jmilne.org/math/CourseNotes/LEC.pdf),
pp. 147--148. Its cycle-class proof for a regular self-map of a smooth
proper variety does not impose a prime-to-characteristic order on the
self-map. In the present application the intersection is empty, so no
fixed-point multiplicity issue arises. \(\square\)

### Lemma 95.3: a cyclotomic module bound

Let \(F/\mathbf Q\) be a finite abelian extension, let \(K\) be a
number field, and set \(a=[F\cap K:\mathbf Q]\). A unital embedding

\[
                         F\hookrightarrow M_m(K)
\]

forces

\[
                         m\ge [F:\mathbf Q]/a.          \tag{95.5}
\]

#### Proof

The central action of \(K\) commutes with \(F\), so \(K^m\) is a
nonzero module over \(K\otimes_{\mathbf Q}F\). Because \(F/\mathbf Q\)
is abelian Galois, this algebra is a product of \(a\) fields, each of
degree \([F:\mathbf Q]/a\) over \(K\). Every nonzero module over this
product has dimension at least that degree over \(K\). The tensor
algebra need not act faithfully; the dimension conclusion does not
require faithfulness. \(\square\)

#### Proof of Theorem 95.1

Let \(H\) be the abelian deck group. For a primitive idempotent \(e\)
of the rational group algebra \(\mathbf Q[H]\), let \(A_e=eJ(D)\)
denote the corresponding abelian factor up to isogeny. One can define
this as the image of an integer multiple of \(e\); different choices
give isogenous abelian varieties.

The trivial-character factor is isogenous to \(J(X)\) and has
dimension \(g_X\). Each nontrivial primitive rational character orbit
has a character of some order \(n>1\), and

\[
          e\mathbf Q[H]\simeq F=\mathbf Q(\zeta_n),
          \qquad \dim A_e=s\varphi(n).                  \tag{95.6}
\]

Indeed, its summand in (95.4) has dimension \(2s\varphi(n)\).
There may be several distinct primitive idempotents of the same order
\(n\); (95.6) and the following argument apply to each separately.

Let \(f:D\to Y\) be nonconstant. The norm-pullback identity
\(f_*f^*=[\deg f]\) implies that \(f^*:J(Y)\to J(D)\) has finite
kernel. This remains true for an inseparable finite map. Since \(J(Y)\)
is simple, it occurs as an isogeny factor of at least one \(A_e\).
If it occurs in the trivial factor, then \(g_Y\le g_X\).

Otherwise choose a nontrivial such \(e\), and let the \(J(Y)\)-isotypic
part of \(A_e\) be isogenous to \(J(Y)^m\), with \(m\ge1\).
The isotypic part is preserved by every endomorphism of \(A_e\): there
are no nonzero homomorphisms between nonisogenous simple factors.
The field \(F=e\mathbf Q[H]\) therefore acts on it, giving a unital
embedding

\[
                        F\hookrightarrow M_m(K).
\]

Restriction is injective because it is a unital homomorphism from a
field to a nonzero algebra. Put \(a=[F\cap K:\mathbf Q]\). Lemma 95.3
and (95.6) give

\[
        \frac{\varphi(n)}a\,g_Y
                    \le m g_Y\le s\varphi(n),
\]

hence \(g_Y\le as\). Since \(F\cap K\subset K_{\rm ab}\),
we have \(a\le a_0\), proving (95.2). \(\square\)

## 2. A condition on the real endomorphism field

### Proposition 95.4

Suppose that \(K\) is a CM field whose maximal real subfield \(K^+\)
has degree greater than one, has no intermediate fields strictly
between \(\mathbf Q\) and \(K^+\), and is not Galois over
\(\mathbf Q\). Then

\[
                         [K_{\rm ab}:\mathbf Q]\le2.    \tag{95.7}
\]

#### Proof

Let \(E\subset K\) be an abelian extension of \(\mathbf Q\).
The intersection \(E\cap K^+\) is either \(\mathbf Q\) or \(K^+\).
The latter is impossible because every subfield of the abelian Galois
extension \(E/\mathbf Q\) is Galois, while \(K^+\) is not.
Since \(E/\mathbf Q\) is Galois,

\[
       [E:\mathbf Q]=[EK^+:K^+]\le[K:K^+]=2.
\]

Apply this to \(E=K_{\rm ab}\). \(\square\)

### Corollary 95.5: a parameterized genus range

Under the hypotheses on \(J(Y)\) in Theorem 95.1 and on its CM field
in Proposition 95.4, if

\[
                         g_Y>2(g_X-1),\qquad g_X\ge2,
\]

then no finite abelian etale Galois cover of \(X\) admits a nonconstant
map to \(Y\). The displayed inequality also implies \(g_Y>g_X\)
when \(g_X\ge2\). \(\square\)

## 3. Application to the current genus-25 curve

Let \(k=\overline{\mathbf F}_5\),

\[
       Y:\ z^2=L(t)(L(t)-1)(t-4),\qquad L(t)=t^{25}+t^5+t.
                                                               \tag{95.8}
\]

File [76](../../Theorems/Thm_fixed_pair_arithmetic.md), Proposition 76.3,
and its exact arithmetic certificate establish that \(J(Y)\) is
ordinary and absolutely simple. Its Frobenius field \(K\) has degree
50, and its real subfield \(K^+\) has degree 25 and normal-closure
Galois group \(S_{25}\) in the natural action.

For completeness, the recorded certificate proves this last assertion
using square-free factorization degrees \((25)\), \((24,1)\), and
\((23,2)\) at the primes 47, 173, and 467. They force transitivity,
primitivity, and a transposition, respectively. The maximal point
stabilizer \(S_{24}<S_{25}\) shows that \(K^+\) has no proper
nontrivial subfield; this stabilizer is not normal, so \(K^+\) is
not Galois.

Ordinarity and absolute simplicity give
\(\operatorname{End}_k^0J(Y)=K\): over every finite extension of the
field of definition the simple ordinary endomorphism algebra is a
field of degree 50, already containing this degree-50 Frobenius field.
Every geometric endomorphism is defined over some finite extension.
Thus Proposition 95.4 applies, giving \(a_0\le2\).

### Corollary 95.6

For **every** curve \(X/k\) with

\[
                            2\le g(X)\le13,
\]

no connected finite abelian etale Galois cover of \(X\) has a
nonconstant map to the fixed curve (95.8).

In particular, this applies to the genus-nine curve in file 76, with
\(25>2(9-1)=16\). Its automorphism group, trigonal equation, and
Jacobian simplicity play no role in this conclusion. \(\square\)

The arithmetic input remains dependent on file 76 and its certificate;
this note does not claim to add an independent audit of that input.

## 4. Exact scope and remaining problem

For the current pair this removes the Galois hypothesis on the second
leg and covers arbitrary mixed-prime abelian monodromy on the first.
The second map can even be ramified. It is therefore stronger in this
application than the common-cover corollaries of files 90--92, but not
a replacement for their general automorphism-group theorems.

For an arbitrary common etale cover \(Z\to X,Y\), its Galois closure
over \(X\) is still etale over \(X\) and maps to \(Y\). Its Galois
group need not be abelian. Theorem 95.1 consequently excludes all such
covers with abelian monodromy, but it does not exclude the general
case. Passing to a larger Galois cover cannot make a nonabelian
monodromy quotient abelian.

For nonabelian groups, rational character factors have larger matrix
algebras. The dimension cancellation above then leaves the degree of
an irreducible representation. Controlling that extra factor, or using
additional geometry of the map to \(Y\), is a separate task.
