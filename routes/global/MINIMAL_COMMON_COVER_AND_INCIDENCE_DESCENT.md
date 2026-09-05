# Minimal common covers and rational incidence descent

## Status and purpose

**Status: proved; independently audited (PASS).**

[Independent audit record](audits/MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT_AUDIT.md).

This note records exactly how far minimality reaches in the pushed-incidence
argument.  A minimal common cover is automatically birational to its image
in the product of the two fixed target curves.  By contrast, when its
exterior-product divisor family factors through a curve \(B\), the descended
normalization is naturally an etale cover of only one fixed target.  Its
other natural map is to \(B\), not to the second fixed target.  Thus this
factorization does not by itself contradict minimality.

The distinction matters even when the two target genera have an integral
ratio.  That ratio determines what the degree of a hypothetical map to the
second fixed curve would have to be; it does not construct such a map.

## 1. What minimality does imply

Let \(X,Y\) be smooth projective curves of genera at least two over an
algebraically closed field.  A *common etale cover* means a smooth connected
curve \(W\) equipped with finite etale maps

\[
                     u:W\longrightarrow X,\qquad
                     v:W\longrightarrow Y.             \tag{D.1}
\]

Choose \(W\) for which \(\deg v\) is minimal.  This is equivalent to
minimizing \(\deg u\), because etale Riemann--Hurwitz gives

\[
       \deg u\,\bigl(g(X)-1\bigr)
          =\deg v\,\bigl(g(Y)-1\bigr).                  \tag{D.2}
\]

### Proposition D.1 (a minimal common cover has no product-image quotient)

The map

\[
                       (u,v):W\longrightarrow X\times Y
\]

is birational onto its reduced image.

#### Proof

Let \(G\) be the normalization of the reduced image and let \(e\) be the
generic degree of \(W\to G\).  Both maps in (D.1) factor through \(G\).
In each of the function-field towers over \(X\) and \(Y\), ramification
indices multiply.  Since the composites are etale, the intermediate maps

\[
                         G\longrightarrow X,\qquad
                         G\longrightarrow Y
\]

and \(W\to G\) are finite etale.  If \(e>1\), then

\[
                         \deg(G/Y)=\deg(W/Y)/e,
\]

contrary to minimality.  Hence \(e=1\). \(\square\)

This proposition removes the generic image degree without any gonality or
Jacobian hypothesis.  Its force stops at quotients through which *both of
the given target maps descend*.

## 2. What a rational factor actually produces

Retain the minimal common cover (D.1), and assume that the product image
\(\Gamma\subset X\times Y\) has exterior-product class

\[
                      \mathcal O(\Gamma)\simeq N\boxtimes R. \tag{D.3}
\]

Write

\[
                         n=\deg(W/Y).
\]

The section cutting out \(\Gamma\) gives a divisor-family map

\[
                         \zeta:Y\longrightarrow\mathbf P H^0(X,N).
\]

Suppose that it factors through a finite map of degree \(d>1\), where
\(B\) is a smooth projective integral curve (in applications, the
normalization of the image),

\[
             Y\xrightarrow{\psi}B\xrightarrow{\iota}\mathbf P H^0(X,N),
             \qquad \deg\psi=d,                       \tag{D.4}
\]

and put \(S=\iota^*\mathcal O(1)\).  The tautological line on the
projective space gives an incidence section on \(X\times B\); denote its
zero divisor by

\[
                         \Gamma_0\subset X\times B.    \tag{D.5}
\]

### Proposition D.2 (the descended curve covers only the first fixed target)

One has

\[
                         R\simeq\psi^*S,
\]

the divisor \(\Gamma_0\) is integral, and

\[
                (1_X\times\psi)^*\Gamma_0=\Gamma
\]

scheme-theoretically.  Let \(Z_0\) be the normalization of
\(\Gamma_0\), with maps

\[
                   s:Z_0\longrightarrow X,\qquad
                   \varphi:Z_0\longrightarrow B.      \tag{D.6}
\]

The curve \(W\) is the normalization of \(Z_0\times_B Y\).  There is a
commutative square

\[
\begin{array}{ccc}
 W&\xrightarrow{v}&Y\\
 \big\downarrow q&&\big\downarrow\psi\\
 Z_0&\xrightarrow{\varphi}&B,
\end{array}                                             \tag{D.7}
\]

where

\[
                         \deg q=d.                     \tag{D.8}
\]

Both

\[
                         q:W\to Z_0,\qquad s:Z_0\to X  \tag{D.9}
\]

are finite etale.  In particular, the factor \(\psi\) in (D.4) is
generically separable.

However, the original map \(v:W\to Y\) cannot descend through \(q\).
More precisely, there is no morphism \(\lambda:Z_0\to Y\) satisfying

\[
                              v=\lambda q              \tag{D.10}
\]

unless \(d=1\).

#### Proof

Let \(V=H^0(X,N)\), and write the section cutting out \(\Gamma\) as a
map

\[
                         R^{-1}\longrightarrow V\otimes\mathcal O_Y.
\]

It is nonzero on every fiber: otherwise \(\Gamma\) would contain a
horizontal fiber, contrary to its finiteness over \(Y\).  Its image is
therefore a line subbundle, namely \(\zeta^*\mathcal O(-1)\).  The
factorization (D.4) identifies this with \(\psi^*S^{-1}\), proving
\(R\simeq\psi^*S\).  The tautological inclusion

\[
                         S^{-1}\longrightarrow V\otimes\mathcal O_B
\]

pulls back to the preceding map.  Evaluating these sections on \(X\)
proves the scheme-theoretic equality
\((1_X\times\psi)^*\Gamma_0=\Gamma\).

The map \(\psi\) is finite flat and surjective.  Integrality descends
under faithfully flat morphisms, so the integrality of \(\Gamma\) proves
that of \(\Gamma_0\).

The scheme-theoretic pullback assertion identifies \(\Gamma\) with the
integral fiber product \(\Gamma_0\times_B Y\).  Passing to normalizations
gives (D.7): equivalently, \(Z_0\times_B Y\) has the same field-valued
generic algebra as \(\Gamma_0\times_B Y=\Gamma\), and its normalization
is \(W\).  Since \(\psi\) is finite flat of degree \(d\), its base change
is finite flat of degree \(d\); in particular there are no vertical or
embedded extra components, and the generic degree of \(q\) is \(d\).
This proves (D.8).

The composite \(sq=u\) is etale.  The fields in

\[
                         k(X)\subset k(Z_0)\subset k(W)
\]

are therefore separable, and multiplicativity of ramification indices
shows that both maps in (D.9) are etale.

At the generic point, \(q\) is the degree-preserving base change of
\(\psi\), so

\[
 k(W)=k(Z_0)\otimes_{k(B)}k(Y)
\]

is a field of dimension \(d\) over \(k(Z_0)\).  Base change for Kahler
differentials gives

\[
 \Omega_{k(Y)/k(B)}\otimes_{k(Y)}k(W)
       \simeq\Omega_{k(W)/k(Z_0)}=0.
\]

Faithfulness of the field extension gives
\(\Omega_{k(Y)/k(B)}=0\), so \(k(Y)/k(B)\) is separable.

Finally, inside \(k(W)\) one has

\[
                         k(W)=k(Z_0)k(Y),               \tag{D.11}
\]

because \(W\) normalizes the integral fiber product.  If (D.10) held,
then \(v^*k(Y)\subseteq q^*k(Z_0)\).  Equation (D.11) would give
\(k(W)=k(Z_0)\), contradicting \([k(W):k(Z_0)]=d>1\). \(\square\)

Equivalently, the exact descent condition for the given \(Y\)-map is

\[
 v\operatorname{pr}_1=v\operatorname{pr}_2
       \quad\text{on }W\times_{Z_0}W.                 \tag{D.12}
\]

In a genuine factorization of degree \(d>1\), (D.12) necessarily fails:
the relation defining \(q\) identifies the \(d\) points of a generic
\(\psi\)-fiber, while \(v\) remembers which point of that fiber was chosen.

### Corollary D.2a (the Frobenius alternative cannot occur)

Every factor map \(\psi:Y\to B\) arising from the divisor family of a
bi-etale incidence curve as above is generically separable, even when the
characteristic divides \(d\).

If \(J(Y)\) is simple and \(B\) is the normalization of the image of
\(\zeta\), then exactly one of the following holds:

1. \(d=1\), so \(\zeta\) is birational onto its image;
2. \(B\simeq\mathbf P^1\).

Thus a positive-characteristic Frobenius factor is not a third possibility
in an actual bi-etale incidence setup.

#### Proof

Separability is Proposition D.2.  Suppose \(g(B)>0\).  Pullback along
\(\psi\) has finite kernel on Jacobians because
\(\psi_*\psi^*=[d]\), so its image is a positive-dimensional abelian
subvariety of \(J(Y)\).  Simplicity gives \(g(B)=g(Y)\).  Since
\(\psi\) is separable, Riemann--Hurwitz and effectiveness of the
different give

\[
 g(Y)-1\geq d\bigl(g(B)-1\bigr)=d\bigl(g(Y)-1\bigr).
\]

As \(g(Y)\geq2\), this forces \(d=1\).  If \(g(B)=0\), the smooth
projective curve \(B\) is \(\mathbf P^1\). \(\square\)

## 3. The exact missing hypothesis for a smaller common cover

Now suppose that the target genera satisfy

\[
                     g(Y)-1=r\bigl(g(X)-1\bigr)        \tag{D.13}
\]

for an integer \(r>1\).  Then

\[
                         \deg(W/X)=rn.                 \tag{D.14}
\]

Write

\[
                         \ell=\deg(Z_0/X).
\]

Equations (D.8)--(D.9) give

\[
                              d\ell=rn.                \tag{D.15}
\]

### Theorem D.3 (minimality criterion after incidence descent)

The rational factor (D.4) contradicts minimality of \(W\) if one can
additionally construct a finite etale map

\[
                         \lambda:Z_0\longrightarrow Y. \tag{D.16}
\]

Indeed, such a map necessarily has degree

\[
                  \deg\lambda={\ell\over r}={n\over d}<n.          \tag{D.17}
\]

The construction of \(\Gamma_0\), the etale map \(Z_0\to X\), and the
genus identity do not themselves furnish a map (D.16).  In particular,
the natural candidate obtained by descending \(v\) is ruled out by
Proposition D.2 when \(d>1\).

In particular:

1. A necessary numerical condition for (D.16) is

   \[
                              r\mid\ell,
   \]

   equivalently \(d\mid n\).
2. If \(r\nmid\ell\), genus already proves that \(Z_0\) cannot be an etale
   cover of \(Y\), so minimality cannot be applied to \(Z_0\).
3. Even when \(r\mid\ell\), equality of the required genera and degrees
   does not construct (D.16).  For example, in the endpoint
   \(\ell=r\), such a map would have degree one and would assert the
   additional geometric fact \(Z_0\simeq Y\).

#### Proof

If (D.16) exists, etale Riemann--Hurwitz applied to \(Z_0\to X\) and
\(Z_0\to Y\) gives

\[
 \ell\bigl(g(X)-1\bigr)
   =\deg\lambda\bigl(g(Y)-1\bigr)
   =r\deg\lambda\bigl(g(X)-1\bigr).
\]

Thus \(\deg\lambda=\ell/r\).  Substitution from (D.15) gives
\(\deg\lambda=n/d\), which is strictly smaller than \(n\).  Hence \(Z_0\)
would be a common etale cover of the two fixed curves with smaller degree
over \(Y\), contradicting minimality.

This also proves the divisibility assertions.  The incidence descent only
supplies the two arrows in (D.6); its second target is \(B\), not \(Y\).
Proposition D.2 proves that the given arrow \(W\to Y\) cannot supply the
missing map by descent.  Finally, Riemann--Hurwitz is only a necessary
degree-and-genus identity.  It contains no construction of a morphism to
the fixed curve \(Y\).  For instance, two nonisomorphic curves of the same
genus at least two satisfy the same genus identity but admit no etale
degree-one map between them. \(\square\)

## 4. Consequence for the degree-nine seven-diamond

For

\[
                       (r,n)=(7,9),
\]

the two residual rational factors from the pushed-incidence analysis are

\[
                       (d,\ell)=(21,3),\qquad(63,1).
\]

In both cases \(7\nmid\ell\).  Thus their descended normalizations have
genera \(7\) and \(3\), respectively, and cannot map etale to the fixed
genus-15 curve \(Y\).  They therefore do **not** produce smaller common
covers of \(X\) and \(Y\), even if the original degree-nine common cover
was chosen minimal.

The additional input needed to eliminate these factors must concern the
fixed curves themselves: for example, their torsion-divisor classes,
monodromy representations, or cyclic norm labels.  Minimality and the
genus ratio alone cannot do it.
