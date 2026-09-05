# The degree-45 families shadow is impossible

## Status and scope

**Status: proved, conditional only on the normalized mod-31 families
shadow; independent audit pending.**

This note closes the elliptic endpoint left open in file 50.  It does not
prove that an arbitrary algebraic correspondence is families preserving.
It proves the following precise finite statement: once normalized families
preservation supplies the two Kummer identities of Proposition 50.2, a
minimal non-visible generalized-profile pair of degree 45 cannot exist.

The proof uses the descent theorem in file 57 followed by an exhaustive
calculation over \(\mathbf F_{125}\).  The certificate is

`57_DEGREE45_F125_GRID_SEARCH.sage`.

## 1. The endpoint theorem

### Theorem 58.1

Let

\[
 u,v:\mathcal T\rightrightarrows
 S=\mathbf P^1_{\overline{\mathbf F}_5}(31,31,31)
\]

be a minimal-degree non-visible finite etale self-correspondence whose
coarse maps have the degree-45 generalized profile.  If, after one
\(S_3\)-normalization, its open-subgroup isomorphism has the mod-31 shadow
of families preservation from Lemma 50.1, then a contradiction results.

Consequently Theorem 50.3 remains true with its range enlarged from

\[
                         32\le d\le44
\]

to

\[
                         32\le d\le45.                 \tag{58.1}
\]

#### Proof

Suppose such a non-visible pair exists.  Proposition 50.2 and minimality
give precisely the hypotheses of Theorem 57.1.  That theorem supplies a
simultaneous model over

\[
                         K=\mathbf F_{125},
\]

an origin \(O=P_\infty\) on the elliptic source \(E\), and a nonzero point

\[
                         T\in E(K)[28]                  \tag{58.2}
\]

such that \(Q_i=P_i+T\).  It also supplies degree-two functions \(A,B\)
with

\[
\begin{aligned}
 \operatorname{div}(A)&=(P_0+T)+(O)-(P_0)-(T),\\
 \operatorname{div}(B)&=(P_1+T)+(O)-(P_1)-(T),           \tag{58.3}
\end{aligned}
\]

where \(P_0,P_1,O\) are distinct.  Finally, the common zero divisor

\[
 G=\gcd\bigl(\operatorname{div}_0(A^{31}-1),
              \operatorname{div}_0(B^{31}-1)\bigr)
\]

has degree 48 and at least 44 distinct points:

\[
                         |\operatorname{Supp}G|\ge44.    \tag{58.4}
\]

Lemma 58.2 below is an exhaustive finite calculation showing that the
left side of (58.4) is at most 32 for every datum allowed by
(58.2)--(58.3).
This contradiction proves the theorem. \(\square\)

## 2. Exact finite classification

### Lemma 58.2 (cyclotomic-grid bound)

Let \(K=\mathbf F_{125}\).  Let \(E/K\) be any elliptic curve, let
\(0\ne T\in E(K)[28]\), and let \(P_0,P_1\in E(K)\setminus\{O\}\) be
distinct.  For functions \(A,B\in K(E)^\times\) satisfying (58.3), put

\[
 \Sigma(A,B)=\{R\in E(\overline K):
                 A(R),B(R)\in\mu_{31}\}.
\]

Then

\[
                         |\Sigma(A,B)|\le32.             \tag{58.5}
\]

The upper bound includes every independent rescaling of \(A\) and \(B\).

#### Certificate and proof of exhaustiveness

The certificate represents the field as \(K=\mathbf F_5(z)\) of order
125 and performs only exact finite-field and elliptic-curve arithmetic.
Here is why its loops cover the entire statement.

First, every elliptic curve over a field of characteristic different from
2 and 3 has a short Weierstrass equation.  For each
\(j\ne0,1728\), the script uses

\[
 a=\frac{3j}{1728-j},\qquad b=\frac{2j}{1728-j}           \tag{58.6}
\]

in \(y^2=x^3+ax+b\), together with its quadratic twist by a generator of
\(K^\times\).  These are the two \(K\)-isomorphism classes with that
\(j\)-invariant.  At \(j=0\), the classes are indexed by
\(K^\times/(K^\times)^6\), which has order
\(\gcd(6,124)=2\).  At \(j=1728\), they are indexed by
\(K^\times/(K^\times)^4\), which has order four.  Thus the list contains

\[
                  2(125-2)+2+4=252                       \tag{58.7}
\]

representatives, exactly one from every \(K\)-isomorphism class.

For each representative, the script lists every rational point and keeps
every nonzero \(T\) killed by 28.  It then takes every unordered pair of
distinct nonzero points \(P_0,P_1\).  This loses nothing: after choosing
\(P_\infty\) as origin, these are exactly the possible marked high points.

For fixed \(E,P,T\), the divisor in (58.3) determines its function up to a
constant in \(K^\times\).  The script evaluates one such function using
the standard Miller line.  If \(S=P+T\), if \(\ell_{P,T}\) is the line
through \(P,T\) (the tangent when \(P=T\)), and if \(v_S\) is the vertical
line through \(S\), then

\[
                         A_{P,T}=\frac{v_S}{\ell_{P,T}}   \tag{58.8}
\]

has divisor

\[
                    (S)+(O)-(P)-(T).                     \tag{58.9}
\]

When \(S=O\), formula (58.8) is interpreted as the reciprocal vertical
line.  At the removable \(0/0\) occurring at \(-S\), the program uses the
equivalent regular expression obtained from

\[
 (y-L(x))(y+L(x))
    =(x-x(P))(x-x(T))(x-x(S)),                            \tag{58.10}
\]

where \(L(x)\) is the affine equation of the line.  The program also
checks for every function that its four level sets partition exactly all
rational points outside its zeros and poles.

It remains to account for the unknown multiplicative constant.  Since

\[
 |K^\times|=124=4\cdot31,
\]

one has

\[
 \mu_{31}=(K^\times)^4,
 \qquad a^{31}\in\mu_4\quad(a\in K^\times).              \tag{58.11}
\]

For a fixed base function \(A_{P,T}\), the condition

\[
                         (cA_{P,T})^{31}=1
\]

therefore selects one of exactly four level sets, indexed by the value of
\(A_{P,T}^{31}\in\mu_4\).  Conversely all four choices occur as \(c\)
varies.  The two constants for \(A\) and \(B\) are independent, so the
script tests all sixteen intersections of level sets for every pair
\(P_0,P_1\).

Finally, every geometric point counted by \(\Sigma(A,B)\) is rational over
\(K\).  Indeed, the two functions generate \(K(E)\): their deck
involutions are respectively

\[
 R\longmapsto P_0+T-R,qquad
 R\longmapsto P_1+T-R,
\]

which are distinct because \(P_0\ne P_1\).  Thus
\((A,B):E\to\mathbf P^1\times\mathbf P^1\) is a closed immersion onto a
smooth \((2,2)\) curve.  A point with both coordinates in
\(\mu_{31}\subset K\) is consequently fixed by Frobenius.  It is enough
to enumerate \(E(K)\), exactly as the certificate does.

The completed run reports

\[
\begin{array}{lr}
\text{elliptic isomorphism classes} &252,\\
\text{classes with nonzero rational 28-torsion}&186,\\
\text{nonzero rational 28-torsion points}&1256,\\
\text{unordered marked pairs tested}&9{,}580{,}970,\\
\text{largest intersection}&32,\\
\text{number of maximizers}&9.
\end{array}                                                \tag{58.12}
\]

The last five values are assertions inside the certificate, so an
incomplete or altered run fails rather than silently printing a partial
answer.  This proves (58.5). \(\square\)

## 3. Reproduction

From the repository root, run

```sh
sage routes/global/57_DEGREE45_F125_GRID_SEARCH.sage
```

On Sage 10.9 the calculation takes about three minutes on one CPU core.  The
SHA-256 hash of the certificate at the proving run is

```text
cffdd68caa4900adab4bc92662ff6cd9eebbd11e1a479c1138044e012e53152a
```

The certificate prints each successive record and then the summary
(58.12).  No random choices or numerical approximations are used.

## 4. Strategic meaning

Under normalized families preservation, all generalized profiles of
degrees 32 through 45 are now excluded.  Degree 31 remains separate for
the reason explained in file 50: there is no residual source inertia to
force the scalar in the first abelian quotient to be one.

This calculation does **not** supply the missing families-preserving
hypothesis for an arbitrary algebraic self-correspondence.  Its role is to
show that, if that hypothesis can be obtained by another argument, the
elliptic endpoint creates no further exception.
