# The coefficient core and its shared ramification defect

## Status and purpose

**Status: mixed; quadratic-core assertion unproved as written.**

**Audit: FAIL on Theorem 66.4's field-intersection step** —
`/root/c14_elliptic_translation`, 2026-09-04.
[Audit record](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md).
The pushforward dichotomy and direct Prym bound remain valid. Theorem
66.4 and its consequences require the additional hypothesis
\([F\cap E':B]=2\). The full-orbit replacement is
[file 81](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md),
which retains all square-root choices. The original proof is preserved
below to make the failed inference and its scope traceable.

Continue with the order-seven diamond and norm polynomial

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a\ }&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{\ c\ }&X,
 \end{array}
 \qquad
 Y:z^2=1-t^{31},                                      \tag{66.1}
\]

where

\[
 \deg a=\deg c=M,\qquad \deg p=7,qquad
 g(V)=14M+1,\qquad g(C)=2M+1,                         \tag{66.2}
\]

and \(p\) is a cyclic etale cover.  Let

\[
 P(T)=\operatorname{Nm}_{V/C}(T-t),
\]

let \(B\) be the normalization of the coefficient image, and put

\[
 e=[k(C):k(B)],\qquad d=\frac{2M}{e}.
\tag{66.3}
\]

File 47 constructs the degree-seven spectral curve \(E/B\), with

\[
 k(E)=k(B)(t),\qquad [k(E):k(B)]=7,qquad
 [k(E):k(t)]=d.                                       \tag{66.4}
\]

This note proves a general dichotomy which is useful for every value of
\(M\) and every coefficient dimension.

* If the hyperelliptic square root \(z\) already belongs to \(k(E)\),
  then the fifteen-dimensional simple Jacobian \(J(Y)\) occurs in
  \(J(B)\).  In particular \(g(B)\geq15\) and \(M\geq7e\).
* If \(z\notin k(E)\), there is a canonical quadratic core \(D/B\).
  The curve \(E'=E(z)\) has degree seven over \(D\), maps etale to
  \(Y\) with degree \(d\), and its degree-seven norm embeds \(J(Y)\)
  into \(J(D)\).  Consequently
  \[
                         15\leq g(D)\leq2d+1,
  \]
  so \(d\geq7\).

The upper endpoint \(g(D)=2d+1\) is exactly the case in which both lower
maps in the normalized spectral square are etale.  In general they need
not be etale: they can have matching ramification which disappears after
normalizing the fiber product.  The theorem gives the exact common defect.
This caveat is essential; bare etale descent from the two upper maps would
be false.

## 1. A degree-seven norm lemma

We use the following form of the orbit-divisor argument from file 40.

### Lemma 66.1

Let \(r:R\to D\) be a finite separable map of degree seven between smooth
projective curves, and let \(b:R\to Y\) be any finite map.  Then

\[
                       r_*b^*:J(Y)\longrightarrow J(D) \tag{66.5}
\]

is nonzero.  Consequently \(g(D)\geq15\).

#### Proof

If (66.5) vanished, the degree-seven divisors

\[
                         b_*r^*(x),\qquad x\in D,
\]

would all lie in one complete linear system on \(Y\).  They vary and have
no common base point: for a fixed \(y\in Y\), the parameters whose divisor
contains \(y\) lie in the finite set \(r(b^{-1}(y))\).  This would give a
base-point-free degree-seven pencil on \(Y\).

Together with the hyperelliptic degree-two map, that pencil generates
\(k(Y)\), since the degrees are coprime.  Castelnuovo--Severi would give
\(g(Y)\leq(2-1)(7-1)=6\), contrary to \(g(Y)=15\).  Thus (66.5) is
nonzero.  File 40 proves that \(J(Y)\) is absolutely simple, so a nonzero
homomorphism from it has fifteen-dimensional image.  Hence \(g(D)\geq15\).
\(\square\)

## 2. The norm detects which side contains the square root

Write

\[
 F=k(C),\qquad K=k(V),\qquad h=p_*a^*:J(Y)\to J(C),
\]

and let \(q:C\to B\) be the coefficient map.

### Theorem 66.2 (pushforward dichotomy)

One has

\[
 q_*h\ne0\quad\Longleftrightarrow\quad z\in k(E).     \tag{66.6}
\]

More precisely:

1. If \(z\in k(E)\), there is an etale map
   \[
                      a_E:E\longrightarrow Y,
                      \qquad\deg a_E=M/e=d/2,          \tag{66.7}
   \]
   and
   \[
                    q_*h=[e]\,(E/B)_*a_E^*\ne0.       \tag{66.8}
   \]
2. If \(z\notin k(E)\), put \(E'=E(z)\).  Then
   \[
                        q_*h=0.                         \tag{66.9}
   \]

Consequently, in the first case

\[
                         g(B)\geq15,
 \qquad
                         M\geq7e.                      \tag{66.10}
\]

In the second case

\[
             \operatorname{im}(h)\subseteq
             \operatorname{Prym}(C/B),
 \qquad
                         g(B)\leq2M-14.                \tag{66.11}
\]

#### Proof

Suppose first that \(z\in k(E)\).  Then \(k(Y)\subset k(E)\), and file
47 gives the factorization

\[
                      V\longrightarrow E\xrightarrow{a_E}Y.
\]

Both maps are intermediate maps of the finite-etale cover \(V\to Y\),
so they are etale, with the degrees in (66.7).  Functoriality of pullback
and norm gives

\[
\begin{aligned}
 q_*h
   &=q_*p_*a^*\\
   &=(E/B)_*(V/E)_*(V/E)^*a_E^*\\
   &=[e]\,(E/B)_*a_E^*.
\end{aligned}
\]

Lemma 66.1 says that the last norm is nonzero, proving (66.8).

Now suppose \(z\notin k(E)\), and let

\[
                         s:E'=E(z)\longrightarrow E
\]

be the quadratic map.  The map \(a':E'\to Y\) given by \((t,z)\) is
finite etale, and its deck involution over \(E\) satisfies

\[
                         a'\gamma=\iota_Ya'.           \tag{66.12}
\]

The map \(V\to E'\) is etale of degree \(e/2\).  Thus

\[
 q_*h=[e/2]\,(E/B)_*s_*a'^*.                          \tag{66.13}
\]

But

\[
 s^*s_*a'^*=(1+\gamma^*)a'^*
             =a'^*(1+\iota_Y^*)=0.                    \tag{66.14}
\]

The map \(s^*:J(E)\to J(E')\) has finite kernel, so (66.14) forces
\(s_*a'^*=0\).  Equation (66.13) proves (66.9), and hence (66.6).

In the first case, (66.8) and the simplicity of \(J(Y)\) put a
fifteen-dimensional abelian subvariety in \(J(B)\), so \(g(B)\geq15\).
The map \(q:C\to B\) is separable here: the scalar extension of the
function-field extension \(F/k(B)\) to \(k(E)\) is \(K/k(E)\), which is
separable.  Riemann--Hurwitz therefore gives

\[
        2M=g(C)-1\geq e(g(B)-1)\geq14e,
\]

which is (66.10).

In the second case, \(K/k(E)\) is the separable tower
\(K/k(E')/k(E)\), so the same scalar-extension argument shows that
\(q\) is separable.  Equation (66.9) puts the fifteen-dimensional image
of \(h\) in the connected Prym of \(q\).  Its dimension is
\(g(C)-g(B)\), giving

\[
                      15\leq2M+1-g(B),
\]

which is (66.11). \(\square\)

### Corollary 66.3 (odd coarsenings are expensive)

Let \(w=\dim W_P\), so the coefficient image is a nondegenerate curve in
\(\mathbf P^{w-1}\) of degree \(d\).  If \(e\) is odd, then
\(z\in k(E)\).  Every nonbirational odd coefficient map therefore obeys

\[
 e\geq3,\qquad M\geq7e\geq21.                         \tag{66.15}
\]

Castelnuovo strengthens the first inequality in the two largest
coefficient dimensions.  The least even degree of a nondegenerate curve
of genus at least fifteen is

\[
\begin{array}{c|rrrrrr}
w&3&4&5&6&7&8\\ \hline
d_{\min}&8&10&12&14&16&18.
\end{array}                                            \tag{66.16}
\]

Thus a nonbirational odd coefficient degree can occur only if

\[
\begin{array}{c|rrrrrr}
w&3&4&5&6&7&8\\ \hline
M\text{ is at least}&21&21&21&21&24&27.
\end{array}                                            \tag{66.17}
\]

#### Proof

If \(e\) is odd, the quadratic polynomial defining \(E'/E\) cannot
define a subextension of the degree-\(e\) extension \(K/E\); hence
\(z\in k(E)\), as in Proposition 47.2.  Now apply (66.10).

For (66.16), apply Castelnuovo's genus bound in projective dimensions
two through seven, and remember from (66.7) that \(d\) is even.  The
successive first degrees for which the bound reaches fifteen are exactly
\(8,10,12,14,16,18\).  Since \(2M=ed\) and a nonbirational odd \(e\) is
at least three, combining this with \(M\geq7e\) gives (66.17). \(\square\)

## 3. The quadratic core in the non-descending case

Assume for the rest of the note that \(z\notin k(E)\).  Thus \(e\) is
even.  Put

\[
                         E'=E(z),
 \qquad
                         k(D)=F\cap k(E')              \tag{66.18}
\]

inside \(K\), and let \(D\) also denote the smooth projective curve with
this function field.

### Theorem 66.4 (the exact coefficient core)

With \(m=e/2\), the field degrees are

\[
 [k(D):k(B)]=2,qquad [F:k(D)]=m,qquad
 [k(E'):k(D)]=7,                                      \tag{66.19}
\]

and \(K=F\,k(E')\).  They give a normalized fiber square

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ s_V\ }&E'\\
 \big\downarrow p&&\big\downarrow r\\[-1mm]
 C&\xrightarrow{\ u\ }&D,
 \end{array}                                          \tag{66.20}
\]

where

\[
 \deg s_V=m,\qquad\deg p=\deg r=7,qquad\deg u=m.    \tag{66.21}
\]

The two upper maps \(p\) and \(s_V\) are finite etale.  The map

\[
                       a':E'\longrightarrow Y
\]

is finite etale of degree \(d\), and \(a=a's_V\).

Define

\[
                     h_D=r_*a'^*:J(Y)\longrightarrow J(D).
                                                               \tag{66.22}
\]

Then

\[
                    h_D\ne0,qquad h=u^*h_D,            \tag{66.23}
\]

and consequently

\[
                         15\leq g(D)\leq2d+1,
 \qquad
                         d\geq7.                        \tag{66.24}
\]

More exactly, if

\[
                         \eta=2d+1-g(D),                \tag{66.25}
\]

then

\[
 \deg\operatorname{Diff}(C/D)=e\eta,
 \qquad
 \deg\operatorname{Diff}(E'/D)=14\eta.               \tag{66.26}
\]

Thus the following are equivalent:

\[
 \eta=0
 \quad\Longleftrightarrow\quad C\to D\text{ is etale}
 \quad\Longleftrightarrow\quad E'\to D\text{ is etale}.       \tag{66.27}
\]

#### Proof

Since \(F E=K\), also \(F k(E')=K\).  The quadratic dichotomy gives

\[
                         [K:k(E')]=e/2=m.
\]

The compositum-intersection degree formula therefore gives

\[
 [F:F\cap k(E')]=m.
\]

Together with \([F:k(B)]=e=2m\), this proves
\([k(D):k(B)]=2\).  The equality \([K:F]=7\) similarly gives
\([k(E'):k(D)]=7\), proving (66.19)--(66.21).

The map \(p\) is etale by hypothesis.  The field \(k(E')\) is
intermediate in the finite-etale extension \(K/k(Y)\), so both
\(s_V:V\to E'\) and \(a':E'\to Y\) are etale; their degrees are
respectively \(m\) and

\[
             [k(E'):k(Y)]
               =\frac{[k(E'):k(t)]}{[k(Y):k(t)]}
               =\frac{2d}{2}=d.
\]

The two lower maps in (66.20) are separable because their base changes
to the common overfield \(K\) are separable.  Lemma 66.1 applied to
\(r:E'\to D\) and \(a':E'\to Y\) proves \(h_D\ne0\), and hence
\(g(D)\geq15\).

The equality \(h=u^*h_D\) is finite-flat base change for divisor
correspondences.  Concretely, the integral fiber product
\(C\times_D E'\) has function field \(K\), and pushing forward its
normalization does not change its generic cycle.  Therefore

\[
 u^*r_*a'^*=p_*s_V^*a'^*=p_*a^*=h,
\]

which proves (66.23).

Since \(E'\to Y\) is etale of degree \(d\),

\[
                         g(E')=14d+1.                  \tag{66.28}
\]

Riemann--Hurwitz for \(r:E'\to D\) gives

\[
 28d=7(2g(D)-2)+\deg\operatorname{Diff}(E'/D).
                                                               \tag{66.29}
\]

The different is effective, so \(g(D)\leq2d+1\).  Combined with the
already proved \(g(D)\geq15\), this gives (66.24).

Finally, Riemann--Hurwitz for \(u:C\to D\), using
\(g(C)-1=2M=ed=2md\), gives

\[
\begin{aligned}
 \deg\operatorname{Diff}(C/D)
   &=4M-m(2g(D)-2)\\
   &=e\bigl(2d+1-g(D)\bigr)=e\eta.
\end{aligned}
\]

Equation (66.29) similarly gives the second formula in (66.26).
For finite separable maps of smooth curves, vanishing of the different is
equivalent to etaleness.  This proves (66.27). \(\square\)

### Corollary 66.5 (the degree-seven endpoint has no defect)

If \(d=7\), then

\[
                         g(D)=15,\qquad\eta=0,
\]

and both lower maps in (66.20) are finite etale.

#### Proof

For \(d=7\), the two bounds in (66.24) both equal fifteen.  Now apply
(66.25)--(66.27). \(\square\)

## 4. What does not descend automatically

Even in the defect-free case, it does not follow formally that the
degree-seven map \(E'\to D\) is a \(C_7\)-torsor or that the deck
transformation of \(V\to C\) descends to \(E'\).  Galoisness and a chosen
group action do not descend from an arbitrary finite-etale base change
without compatible descent data.

When \(\eta>0\), there is an additional obstruction: the two bottom maps
in (66.20) are ramified in a matched way even though both maps out of
\(V\) are etale.  Such cancellation occurs in normalized fiber products
and cannot be discarded by fpqc descent.  Equations (66.26) isolate its
entire global size.  A genuine recursive reduction must therefore control
this shared ramification and the descent of the order-seven action; the
field intersection alone does not yet produce a smaller seven-diamond.
