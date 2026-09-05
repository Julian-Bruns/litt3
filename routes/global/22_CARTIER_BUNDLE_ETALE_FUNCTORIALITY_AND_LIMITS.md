# The Cartier bundle under finite etale covers

**Status:** proved-text for the base-change, numerical, Frobenius-filtration,
cyclic-cover, and explicit Cartier calculations below.  The final assessment is
a no-go result for the listed coarse invariants, not a theorem that the full
Cartier bundle or its theta divisor can never be useful.

## 1. Conventions and statement

Let `k` be a perfect field of characteristic `p>2`.  For a smooth projective
geometrically connected curve `C/k`, put

\[
 C^{(1)}=C\times_{\operatorname{Spec}k,F_k}\operatorname{Spec}k,
 \qquad F_C=F_{C/k}:C\longrightarrow C^{(1)},
\]

and define the bundle of locally exact differentials on `C^(1)` by

\[
 0\longrightarrow \mathcal O_{C^{(1)}}
 \longrightarrow F_{C,*}\mathcal O_C
 \longrightarrow B_C^1\longrightarrow 0.                 \tag{1}
\]

The Frobenius twist in this definition must not be suppressed.  Even over
`k=bar(F_5)`, there is no canonical `k`-isomorphism from an arbitrary curve to
its Frobenius twist.

### Theorem 1 (exact etale pullback)

Let `f:D -> C` be finite etale, and let
`f^(1):D^(1) -> C^(1)` be its Frobenius twist.  There is a canonical
isomorphism

\[
             B_D^1\ \simeq\ (f^{(1)})^*B_C^1.             \tag{2}
\]

It is compatible with composition of finite etale maps and with (1).

### Proof

The natural square

\[
\begin{CD}
D @>{F_D}>> D^{(1)}\\
@V f VV       @VV f^{(1)} V\\
C @>{F_C}>> C^{(1)}
\end{CD}                                                   \tag{3}
\]

is Cartesian.  Indeed, the natural map

\[
D\longrightarrow C\times_{C^{(1)}}D^{(1)}
\]

is the relative Frobenius of `D` over `C`, and relative Frobenius is an
isomorphism for an etale morphism.  Flat base change in (3) gives

\[
(f^{(1)})^*F_{C,*}\mathcal O_C
 \simeq F_{D,*}f^*\mathcal O_C
 \simeq F_{D,*}\mathcal O_D.                              \tag{4}
\]

Under (4), the pullback of the unit map in (1) is the unit map for `D`.
Since `f^(1)` is flat, pulling back (1) is exact.  Taking cokernels proves
(2).  All maps used are canonical, so the construction is compatible with
composition.  This proves the theorem. \(\square\)

Consequently, if `Z` is a common finite etale cover of `X` and `Y`, then

\[
(Z\to X)^{(1),*}B_X^1\simeq B_Z^1
 \simeq (Z\to Y)^{(1),*}B_Y^1.                            \tag{5}
\]

Thus the bundle passes the first functoriality test.  The rest of this note
explains why its most accessible invariants do not give an obstruction.

## 2. The standard bundle invariants are universal

Let `g=g(C)>=2`.

### Proposition 2 (rank, determinant, stability, and Frobenius HN polygon)

The following statements hold.

1. `B_C^1` has rank `p-1`, Euler characteristic zero, degree
   `(p-1)(g-1)`, and slope `g-1`.
2. There is a canonical perfect alternating pairing

   \[
   B_C^1\otimes B_C^1\longrightarrow \omega_{C^{(1)}}.
                                                               \tag{6}
   \]

   Hence, writing `r=(p-1)/2`,

   \[
                  \det B_C^1\simeq\omega_{C^{(1)}}^{\otimes r}.
                                                               \tag{7}
   \]
3. If `k` is algebraically closed, `B_C^1` is stable; over a general perfect
   field it is geometrically stable.  In particular, Theorem 1 implies the
   unusually strong fact that every finite etale pullback of `B_C^1` is
   stable: it is the Cartier bundle of the covering curve.
4. The Harder--Narasimhan filtration of `F_C^*B_C^1` has line-bundle
   quotients

   \[
            \omega_C,\ \omega_C^{\otimes2},\ldots,
            \omega_C^{\otimes(p-1)}.                         \tag{8}
   \]

   In particular its polygon, after division by `2g-2`, depends only on `p`.

### Proof

The rank follows from (1).  Since finite pushforward does not change
cohomology,

\[
 \chi(B_C^1)=\chi(\mathcal O_C)-\chi(\mathcal O_{C^{(1)}})=0.
\]

Riemann--Roch then gives the asserted degree and slope.

Identify `B_C^1` with the image of
`d:F_{C,*}O_C -> F_{C,*}Omega_C^1`.  If bars denote classes modulo
`O_{C^(1)}`, the rule

\[
            (\bar a,\bar b)\longmapsto \operatorname{Car}(a\,db)
                                                               \tag{9}
\]

is a well-defined alternating pairing with values in
`omega_{C^(1)}`.  Raynaud proves that (9) is perfect.  Taking the `r`-th
exterior power of its symplectic form gives a nowhere-vanishing section of

\[
(\det B_C^1)^{-1}\otimes\omega_{C^{(1)}}^{\otimes r}.
\]

Here `r!` is invertible because `r<p`, so this gives (7).  Stability over an
algebraic closure for `g>=2` is the theorem of Joshi; it also follows from
the direct argument in Tong cited below.  Formation of `B_C^1` commutes with
extension of perfect ground fields by the same flat-base-change argument as
in Theorem 1, so this gives geometric stability over a general perfect
field.  Applying the result to `D` and using (2) proves the assertion about
etale pullback.

It remains to prove (8).  Put

\[
 V=F_C^*F_{C,*}\mathcal O_C,
 \qquad I=\ker(V\longrightarrow\mathcal O_C),               \tag{10}
\]

where the second arrow is evaluation.  Pullback of (1) is exact because
`C` is smooth and hence Frobenius is flat.  The pulled-back unit
`O_C -> V` is split by evaluation, so its cokernel is canonically `I`.
Thus

\[
                       F_C^*B_C^1\simeq I.                   \tag{11}
\]

Locally at an etale parameter `t`, the algebra in (10) is

\[
       \mathcal O_C[\alpha]/(\alpha^p),
       \qquad \alpha=t\otimes1-1\otimes t,
\]

and `I=(alpha)`.  Powers of the diagonal ideal therefore give a canonical
filtration

\[
 0=I^p\subset I^{p-1}\subset\cdots\subset I^2\subset I,
 \qquad I^i/I^{i+1}\simeq\omega_C^{\otimes i}.              \tag{12}
\]

In the ascending order displayed in (12), the quotient degrees are strictly
decreasing.  The quotients are line bundles, hence semistable, so (12) is the
Harder--Narasimhan filtration.  This proves (8). \(\square\)

### Consequences in characteristic five

For `p=5`, the rank is four, the determinant is `omega^2`, and the four
Frobenius-HN slopes are

\[
           2(g-1),\ 4(g-1),\ 6(g-1),\ 8(g-1).               \tag{13}
\]

All of these identities commute with finite etale pullback.  For the
determinant one has

```
omega_(D^(1))=(f^(1))^*omega_(C^(1)),
```

whereas for the Frobenius-HN filtration one has

```
omega_D=f^*omega_C.
```

Also `g(D)-1=deg(f)(g(C)-1)`.

There is also no standard finite-monodromy bundle hidden here.  If `L` has
degree `g-1`, then `E=B_C^1 tensor L^{-1}` has degree zero, but the HN slopes
of `F_C^*E` are

\[
                       (2i-p)(g-1),\qquad 1\le i\le p-1.     \tag{14}
\]

They are not all equal.  Thus every degree-zero line-bundle normalization of
`B_C^1` is not strongly semistable and hence is not essentially finite, so
it does not define a finite etale monodromy representation.  There is a
related but distinct connection point.  The Cartier connection on `V` does
not preserve the evaluation ideal `I`: its first second-fundamental form
`I/I^2 -> omega_C` is the isomorphism in (12).  The quotient
`V/O_C=F_C^*B_C^1` nevertheless inherits a zero-`p`-curvature connection,
because the pulled-back unit subbundle `O_C` is horizontal.  Thus (11) does
not identify that quotient connection with the restriction of the
connection on `V` to `I`; and a zero-`p`-curvature connection should not be
conflated with finite etale monodromy.

## 3. Cohomology and the theta divisor change under covers

The long exact sequence of (1) identifies

\[
 h^0(C^{(1)},B_C^1)
 =\dim\ker\bigl(F:H^1(C^{(1)},\mathcal O)\to H^1(C,\mathcal O)\bigr).
                                                               \tag{15}
\]

This is the `a`-number of `C`; dually, it is the dimension of the kernel of
Cartier on `H^0(C,omega_C)`.

Raynaud proved that `B_C^1` has a theta divisor

\[
 \Theta_{B_C}\ =\ \{L\in\operatorname{Pic}^0(C^{(1)}):
                  h^0(B_C^1\otimes L)>0\}.                  \tag{16}
\]

The next exact formula shows why neither (15) nor (16) is itself a
commensurability invariant.

### Proposition 3 (prime-to-p cyclic-cover formula)

Let `f:D -> C` be a connected split cyclic etale cover of degree `n` prime
to `p` (the splitting is automatic over an algebraically closed field
containing `mu_n`).
Write `h=f^(1)`, and choose the order-`n` line bundle `eta` on `C^(1)` that
defines `h`, with the convention

\[
                  h_*\mathcal O_{D^{(1)}}
                  \simeq\bigoplus_{i=0}^{n-1}\eta^{-i}.      \tag{17}
\]

Then, for every `L in Pic^0(C^(1))` and every `q`,

\[
 H^q(D^{(1)},B_D^1\otimes h^*L)
 \simeq
 \bigoplus_{i=0}^{n-1}
 H^q(C^{(1)},B_C^1\otimes L\otimes\eta^{-i}).               \tag{18}
\]

In particular,

\[
 h^0(B_D^1)=\sum_{i=0}^{n-1}h^0(B_C^1\otimes\eta^{-i}).     \tag{19}
\]

Scheme-theoretically, pullback of the determinant-of-cohomology theta
divisor is the sum of torsion translates

\[
 (h^*)^*\Theta_{B_D}
 =\sum_{i=0}^{n-1}
   \{L:\ L\otimes\eta^{-i}\in\Theta_{B_C}\}.              \tag{20}
\]

### Proof

By Theorem 1, `B_D^1=h^*B_C^1`.  The projection formula and (17) give

\[
 Rh_*\bigl(B_D^1\otimes h^*L\bigr)
 \simeq
 \bigoplus_{i=0}^{n-1}B_C^1\otimes L\otimes\eta^{-i}.
\]

Taking cohomology proves (18) and (19).  In families over the Jacobian, the
determinant of cohomology of a direct sum is the tensor product of the
determinants, and its canonical theta section is the product of their theta
sections.  Its zero divisor is therefore the sum in (20), including
multiplicities. \(\square\)

Thus the theta divisor does not simply pull back from the base: on the
sub-Jacobian coming from a cyclic cover, it becomes a union of all the
relevant torsion translates.  Likewise, (19) has no cover-independent
normalization.  This failure occurs in actual covers, not just formally:
Raynaud's Theorem 2 gives every smooth proper curve of genus at least two a
finite etale Galois cover with solvable prime-to-`p` group that is not
ordinary.  In particular one may start with an ordinary curve.  Madore's
Theorem 4.1 presents the earlier generic-curve construction.

## 4. Explicit test against the cyclic genus-fifteen curve

Work now over `bar(F_5)` and take

\[
 X:\quad v^2=x^7-x+1,
 \qquad
 Y:\quad y^{31}=x(x-1).                                    \tag{21}
\]

The polynomial defining `X` is square-free: its derivative is `2x^6-1`,
and a hypothetical common root would first give `x=2` and then contradict
`2x^6=1`.  Thus `X` is a smooth genus-three curve.  If

\[
 (x^7-x+1)^2=\sum_m c_mx^m,
\]

its Cartier--Manin matrix on
`dx/v, x dx/v, x^2 dx/v` is, up to the harmless transpose convention,

\[
 (c_{5i-j})_{1\le i,j\le3}
 =\begin{pmatrix}
 0&0&1\\
 0&3&2\\
 1&0&0
 \end{pmatrix},
 \qquad \det=2\ne0.                                       \tag{22}
\]

Hence `X` is ordinary, `h^0(B_X^1)=0`, and its `p`-rank is three.

For `Y`, a basis of regular differentials is

\[
                       \omega_b=\frac{dx}{y^b},
                       \qquad 16\le b\le30.                 \tag{23}
\]

Indeed, the valuations at the points over `0,1,infinity` are respectively
`30-b,30-b,2b-32`.  Given `b`, let `b' in {1,...,30}` and `q in {0,...,4}`
satisfy

\[
                         5b'=b+31q.
\]

Since `y^31=x(x-1)`, the Cartier rule gives

\[
 \operatorname{Car}(\omega_b)
 =\frac1{y^{b'}}
   \operatorname{Car}\bigl((x(x-1))^qdx\bigr).             \tag{24}
\]

Only the coefficient of `x^4` can contribute.  It is nonzero exactly for
`q=2,3,4`, with values `1,3,1`.  Thus the nonzero arrows, labelled by their
nonzero scalar when it is `3`, are

\[
\begin{array}{lll}
16\to28,&17\xrightarrow{3}22,&18\to16,\\
21\to29,&22\xrightarrow{3}23,&23\to17,\\
26\to30,&27\xrightarrow{3}24,&28\to18.
\end{array}                                                  \tag{25}
\]

The other six basis vectors map to zero.  Therefore Cartier has rank nine,

\[
                   h^0(B_Y^1)=15-9=6.                       \tag{26}
\]

The two persistent three-cycles in (25),
`(16,28,18)` and `(17,22,23)`, also show that the stable Cartier rank, hence
the `p`-rank of `Y`, is six.

The base curves are therefore sharply separated by cohomology:

\[
\begin{array}{c|c|c|c|c}
 &g&h^0(B^1)&p\text{-rank}&\deg B^1\\ \hline
X&3&0&3&8\\
Y&15&6&6&56.
\end{array}                                                  \tag{27}
\]

But this does not obstruct a common cover.  If `Z -> X` and `Z -> Y` have
degrees `d_X,d_Y`, Riemann--Hurwitz gives

\[
                         d_X=7d_Y.                           \tag{28}
\]

The degrees of the pulled-back Cartier bundles then agree tautologically:
`8d_X=56d_Y`.  The four HN quotient degrees from (13) agree term by term:
`4i d_X=28i d_Y`.  The determinants both become `omega_(Z^(1))^2`.  Finally,
(19) and Raynaud's ordinary-to-nonordinary covers show that the discrepancy
in (27) is not preserved on passing to finite etale covers.

## 5. Route assessment

The construction gives the exact necessary identity (5), but the following
data cannot distinguish the curves in (21) up to finite-etale
commensurability:

* rank, degree, slope, determinant, stability, or the HN polygon of `B^1`;
* the HN polygon after Frobenius pullback;
* Nori/finite monodromy after a degree-zero twist;
* `h^0(B^1)`, the `a`-number, ordinarity, or `p`-rank by themselves;
* the divisor class of the Raynaud theta divisor, or naive pullback of that
  divisor along Jacobians.

The full theta divisor contains curve-specific information, and this note
does not rule out using all of it.  Formula (20), however, shows the missing
ingredient precisely: one would need a theorem extracting a quantity from a
theta divisor that is unchanged under sums of torsion translates for every
finite etale cover, including nonabelian covers.  No such quantity is supplied
by the standard numerical or cohomological data above.

## Primary references

* M. Raynaud, *Sections des fibres vectoriels sur une courbe*, Bull. Soc.
  Math. France **110** (1982), 103--125, especially section 4.1:
  <https://numdam.org/articles/10.24033/bsmf.1955/>.
* K. Joshi, *Stability and locally exact differentials on a curve*, C. R.
  Math. **338** (2004), 869--872:
  <https://www.numdam.org/articles/10.1016/j.crma.2004.02.019/>.
* X. Sun, *Stability of direct images under Frobenius morphism*, especially
  Lemma 2.1 on the canonical filtration: <https://arxiv.org/abs/math/0608043>.
* J. Tong, *Diviseur theta et formes differentielles*, Math. Z. **264**
  (2010), 521--569, sections 1.2 and 1.4:
  <https://arxiv.org/abs/0712.2046>.
* M. Raynaud, *Revetements des courbes en caracteristique p > 0 et
  ordinarite*, Compositio Math. **123** (2000), 73--88, Theorem 2:
  <https://www.cambridge.org/core/journals/compositio-mathematica/article/revetements-des-courbes-en-caracteristique-p0-et-ordinarite/16AB72912D3CE32BFC5D012B1025A8E4>.
* D. Madore, *Theta divisors and the Frobenius morphism*, in *Courbes
  semi-stables et groupe fondamental en geometrie algebrique*, Progress in
  Math. 187 (2000), 279--289, Theorem 4.1:
  <https://alexjbest.github.io/buntes/courbes-semi-stables.pdf#page=284>.
