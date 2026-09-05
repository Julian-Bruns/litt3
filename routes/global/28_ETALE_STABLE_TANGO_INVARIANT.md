# The finite-etale stable Tango invariant

## Status and purpose

**Status: proved.**  This note constructs an exact finite-etale
commensurability invariant in characteristic \(p\).  For the cyclic
genus-fifteen curve used in the proposed counterexample, it gives the explicit
lower bound \(5/14\).  It does not yet separate that curve from the chosen
genus-three curve: the remaining task is a uniform upper bound over the
entire finite-etale tower of the latter.

Throughout, \(k\) is an algebraically closed field of characteristic
\(p>0\), and all curves are smooth, projective, and connected.

## 1. The Tango invariant and pullback

For a curve \(C\) of genus at least two and
\(h\in k(C)\setminus k(C)^p\), put

\[
 n_C(h)=\deg\left\lfloor\frac{\operatorname{div}(dh)}p\right\rfloor,
 \qquad
 n(C)=\max_{h\notin k(C)^p} n_C(h).                       \tag{28.1}
\]

The floor is taken coefficient by coefficient.  Since \(dh\) is a nonzero
rational differential,

\[
                 n(C)\leq
                 \left\lfloor\frac{2g(C)-2}{p}\right\rfloor.       \tag{28.2}
\]

We also use Tango's lower bound \(n(C)\geq0\) for curves of genus at least
two.  (More generally, identifying \(n(C)\) with the maximal degree of a
line subbundle of \(B_C^1\), the Mukai--Sakai subbundle inequality gives
\(n(C)\geq g(C)/(p-1)-1\).)  Thus the maximum in (28.1) is a finite,
nonnegative integer.

### Lemma 28.3 (etale pullback is monotone)

If \(f:D\to C\) is finite etale of degree \(e\), then

\[
                              n(D)\geq e\,n(C).             \tag{28.3}
\]

#### Proof

Choose \(h\in k(C)\setminus k(C)^p\) attaining \(n(C)\).  The element
\(h\), viewed in \(k(D)\), is not a \(p\)-th power.  Indeed, a \(p\)-th
root of \(h\) would generate a nontrivial purely inseparable subextension of
the separable extension \(k(D)/k(C)\).

Because \(f\) is etale,

\[
       \operatorname{div}_D(dh)=f^*\operatorname{div}_C(dh).
\]

All ramification indices are one, so coefficientwise flooring commutes with
this pullback.  Consequently

\[
 \deg\left\lfloor\frac{\operatorname{div}_D(dh)}p\right\rfloor
 =e\deg\left\lfloor\frac{\operatorname{div}_C(dh)}p\right\rfloor
 =e\,n(C).
\]

Taking the maximum on \(D\) proves the claim. \(\square\)

## 2. Stabilization over the etale tower

Define

\[
 \tau_{\mathrm{et}}(C)=
 \sup_{f:D\to C\ \mathrm{finite\ etale\ connected}}
       \frac{n(D)}{g(D)-1}.                                \tag{28.4}
\]

The identity cover is included.  Bound (28.2) gives

\[
                         \tau_{\mathrm{et}}(C)\leq\frac2p. \tag{28.5}
\]

### Theorem 28.6 (commensurability invariance)

If \(Z\to C\) is a connected finite etale cover, then

\[
                       \tau_{\mathrm{et}}(Z)
                       =\tau_{\mathrm{et}}(C).             \tag{28.6}
\]

Consequently, two curves having a finite etale cover in common have the same
value of \(\tau_{\mathrm{et}}\).

#### Proof

Every connected finite etale cover of \(Z\) is also one of \(C\), so
\(\tau_{\mathrm{et}}(Z)\leq\tau_{\mathrm{et}}(C)\).

For the reverse inequality, let \(D\to C\) be any connected finite etale
cover and choose a connected component \(W\) of \(D\times_C Z\).  Both maps
\(W\to D\) and \(W\to Z\) are finite etale and surjective.  If
\(a=\deg(W/D)\), Lemma 28.3 and Riemann--Hurwitz give

\[
 \frac{n(W)}{g(W)-1}
 \geq
 \frac{a\,n(D)}{a(g(D)-1)}
 =\frac{n(D)}{g(D)-1}.                                    \tag{28.7}
\]

The left side is one of the terms defining
\(\tau_{\mathrm{et}}(Z)\).  Taking the supremum over \(D\) proves the
opposite inequality.  Applying (28.6) to both legs of a common cover gives
the final assertion. \(\square\)

## 3. Exact value on the first level of the cyclic tower

Now take \(p=5\) and

\[
                  Y:\quad y^{31}=x(x-1).                  \tag{28.8}
\]

The degree-\(31\) map \(x:Y\to\mathbf P^1\) is totally ramified at the
unique points \(P_0,P_1,P_\infty\) over \(0,1,\infty\), respectively, and
unramified elsewhere.  Riemann--Hurwitz gives \(g(Y)=15\).  Directly,

\[
            \operatorname{div}(dx)
            =30P_0+30P_1-32P_\infty.                     \tag{28.9}
\]

Therefore

\[
 \deg\left\lfloor\frac{\operatorname{div}(dx)}5\right\rfloor
 =\deg(6P_0+6P_1-7P_\infty)=5.                            \tag{28.10}
\]

The universal bound (28.2) is also \(\lfloor28/5\rfloor=5\), so

\[
                              n(Y)=5                      \tag{28.11}
\]

and hence

\[
                  \boxed{\tau_{\mathrm{et}}(Y)\geq\frac5{14}}.    \tag{28.12}
\]

More precisely, for every finite etale cover \(D\to Y\) of degree \(e\),
the pullback of \(dx\) witnesses \(n(D)\geq5e\), so every level of this
tower already has normalized Tango invariant at least \(5/14\).

## 4. The generalized-profile calculation

The same computation applies directly to the low-degree strata in file 16.
Suppose that \(p=5\) and that a separable function
\(x:C\to\mathbf P^1\) has degree \(31+m\), is unramified away from
\(0,1,\infty\), and has fiber divisors

\[
 x^{-1}(i)=31P_i+E_i,\qquad i=0,1,\infty,                 \tag{28.13}
\]

where each \(E_i\) is reduced of degree \(m\).  Then

\[
 \operatorname{div}(dx)
 =30P_0+30P_1-32P_\infty-2E_\infty.                       \tag{28.14}
\]

It follows that

\[
 \deg\left\lfloor\frac{\operatorname{div}(dx)}5\right\rfloor
 =\deg(6P_0+6P_1-7P_\infty-E_\infty)=5-m.                 \tag{28.15}
\]

In particular, every generalized-profile source with \(m\leq4\) carries a
positive-degree Tango line supplied by each leg.  For a self-correspondence,
the two functions \(x\) and \(r\) therefore supply two such exact
differentials on the same curve.  This observation does not by itself show
that their Tango lines coincide, but it makes that uniqueness question
precise.

## 5. The exact remaining separation problem

For any genus-three curve \(X\) in characteristic five, Tango's lower bound
together with (28.2) gives \(n(X)=0\).  This alone is not enough: a finite
etale cover of \(X\) can
acquire new exact differentials which do not descend to \(X\).

For the explicit ordinary genus-three curve

\[
                       X:\quad v^2=x^7-x+1                \tag{28.16}
\]

used in file `22`, Theorem 28.6 reduces the desired noncommensurability to
the concrete tower-wide inequality

\[
                     \tau_{\mathrm{et}}(X)<\frac5{14}.     \tag{28.17}
\]

The stronger uniform gap (28.17) implies, and for the desired
noncommensurability it is already enough to prove directly, that every
connected finite etale cover
\(D\to X\) satisfies

\[
                       14\,n(D)<5\bigl(g(D)-1\bigr).        \tag{28.18}
\]

If a common cover of \(X\) and \(Y\) existed, its degrees over them would
satisfy \(\deg(Z/X)=7\deg(Z/Y)\), and the pullback of (28.9) would violate
(28.18).  Thus (28.18), unlike ordinarity or the base-level Tango number, is
exactly strong enough to prove the proposed counterexample.

The present note does not prove (28.17).  Its value is to isolate a second
route whose missing statement concerns line subbundles of the Cartier bundle
over the entire etale tower, rather than the visibility of triangle-orbifold
correspondences.

## Primary references for the Tango bounds

* H. Tango, *On the behavior of extensions of vector bundles under the
  Frobenius map*, Nagoya Math. J. **48** (1972), 73--89, especially
  Lemma 10, Definition 11, and Proposition 14.
* S. Mukai and F. Sakai, *Maximal subbundles of vector bundles on a curve*,
  Manuscripta Math. **52** (1985), 251--256.
