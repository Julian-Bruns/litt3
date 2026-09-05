# Quadratic differential trace detects local ramification

**Status: standard consequence of the codifferent; proof recorded
2026-09-05. No new degree exclusion. This route is paused.**

## Exact local image

Let \(k\) be algebraically closed and let
\(A=k[[x]]\subset B=k[[u]]\) be a finite separable extension of
complete discrete valuation rings. Write \(K\subset L\) for their
fraction fields and put

\[
 e=v_u(x),\qquad \delta=v_u(dx/du).
\]

Thus \(\delta\) is the different exponent, including in wild
characteristic. For \(n\ge1\), define rational differential trace by

\[
 \operatorname{Tr}^{(n)}(a(du)^n)
 =\operatorname{Tr}_{L/K}\!\left(a(du/dx)^n\right)(dx)^n.
\]

Its exact image on all regular local differentials is

\[
 \boxed{\operatorname{Tr}^{(n)}(B(du)^n)
 =x^{-\lceil(n-1)\delta/e\rceil}A(dx)^n.}
\]

Indeed, the codifferent is \(\mathfrak m_B^{-\delta}\). For integers
\(r,s\), the fact that \(\mathfrak m_B^r\) is a \(B\)-ideal gives

\[
 \operatorname{Tr}_{L/K}(\mathfrak m_B^r)\subset x^sA
 \iff x^{-s}\mathfrak m_B^r\subset\mathfrak m_B^{-\delta}
 \iff es\le r+\delta.
\]

Consequently
\(\operatorname{Tr}_{L/K}(\mathfrak m_B^r)
=x^{\lfloor(r+\delta)/e\rfloor}A\).
Since \(B(du)^n=\mathfrak m_B^{-n\delta}(dx)^n\), the formula follows.

Linear differential trace is always regular. In contrast, **all regular
local quadratic differentials have regular trace if and only if the
extension is unramified**. The largest attainable quadratic pole order
is \(\lceil\delta/e\rceil\).

For tame ramification, \(\delta=e-1\), so the pole is simple. In the
model \(x=u^e\), with \(e>1\) prime to the characteristic,

\[
 \operatorname{Tr}^{(2)}(u^{e-2}(du)^2)
 =e^{-1}x^{-1}(dx)^2.
\]

The formula also applies to wild ramification without replacing the
different by \(e-1\). For example, in characteristic five,
\(x=u^5+u^6\) has \(e=\delta=5\), hence maximal quadratic pole order
one. With several completed branches above a point, the pole order for
the full source module is the maximum of the branchwise orders: one
may choose a differential supported on a single branch.

## Global sections are a smaller test

For a finite separable map \(h:S\to C\) of smooth projective curves,
the local formula computes the image of the full sheaf
\(h_*\omega_S^n\) under rational differential trace. It does not by
itself show that a section of \(H^0(S,\omega_S^n)\) attains a local
polar coefficient.

A sufficient condition, for \(g(S)>1\) and \(n\ge2\), is

\[
 \deg h<(n-1)(2g(S)-2).
\]

For any point \(c\in C\), Serre duality then gives
\(H^1(S,\omega_S^n(-h^*c))=0\). Hence global sections realize every
restriction modulo \(h^*c\), including a chosen branchwise leading
polar coefficient. Changing a local differential by a multiple of the
base parameter lowers its traced pole order by at least one. Thus,
under this sufficient inequality, every ramified fiber is detected by
some global \(n\)-differential. In degree two, with \(S=Y\) of genus
25, the sufficient inequality is \(\deg h<48\). Failure of this
inequality does not assert that global detection fails; this argument
simply does not guarantee it.

Three spaces must remain distinct in the common-cover problem:

- All regular local quadratic differentials permit arbitrary local
  coefficients and independent choices on the completed branches.
- \(H^0(Z,\omega_Z^2)\) imposes global regularity; the preceding
  cohomology argument is one way to realize the needed local data.
- \(g^*H^0(Y,\omega_Y^2)\) is only the prescribed pullback subspace.
  Surjectivity for the full space \(H^0(Z,\omega_Z^2)\) does not imply
  surjectivity for this subspace.

For the proposed common etale cover with \(g(Y)=25\),
\(\deg g=N\), and \(g(Z)=24N+1\), the full global space has dimension
\(72N\), whereas the target pullback subspace has dimension \(72\).
The local detector
therefore cannot automatically be applied to the transported target
forms. No obstruction to common covers in unbounded degree is claimed.
