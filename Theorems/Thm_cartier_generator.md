# Frobenius and Cartier constraints on a primitive invariant

Over \(k=\overline{\mathbf F}_5\), let
\(X\xleftarrow f Z\xrightarrow g Y\) be a finite étale span of smooth
projective connected curves of genus at least two, with
\(k(X)\cap k(Y)=k\) in \(k(Z)\). Suppose the canonical-ring
intersection using actual differential pullbacks is \(A=k[s]\),
with primitive homogeneous generator of degree \(d>0\).

Then \(5\nmid d\). Choose \(1\le r\le4\) with
\(rd\equiv1\pmod5\), and put \(n=(rd-1)/5\), \(w=(rd+4)/5\).
For every smooth curve \(C/k\) and \(n\ge0\), there is a canonical
additive inverse-Frobenius-semilinear operator
\[
C_{C,n}:H^0(C,\omega_C^{5n+1})\longrightarrow
H^0(C,\omega_C^{n+1}),
\]
compatible with étale pullback. In a separating parameter \(t\), its
rational-coordinate rule is
\[
C_{C,n}\bigl(a(dt)^{5n+1}\bigr)=a_4(dt)^{n+1},
\qquad a=\sum_{i=0}^4 a_i^5t^i.
\]
It obeys \(C_{C,n+a}(v^5u)=vC_{C,n}(u)\) for a section \(v\) of
weight \(a\) and a section \(u\) of weight \(5n+1\).

The invariant image lies in \(A_w\), and
\[
C_{Z,n}(s^r)=\begin{cases}0&d\nmid4,\\cs&d\mid4,\end{cases}
\qquad c\in k.
\]
In the second case \(r=5-4/d\), \(w=d\), and \(c\) may be zero.
Every eligible positive power has exponent \(r+5q\), \(q\ge0\), and
\[
C_{Z,n+qd}(s^{r+5q})=s^qC_{Z,n}(s^r).
\]
Each positive zero multiplicity \(e\) of \(s\) satisfies
\(e+d\not\equiv0\pmod5\).

For its uniform clump divisor \(eS\), an endpoint image of size \(t\)
and canonical degree \(h_C=2g(C)-2\) satisfies \(et=dh_C\). If
\(5\nmid h_C\), then \(5\nmid e,t\) and \(t\not\equiv-h_C\pmod5\).
In particular the image size is neither 0 nor 4 modulo 5 at a genus-9
endpoint, and neither 0 nor 2 modulo 5 at a genus-25 endpoint.

These are conditional constraints: they do not force \(d\mid4\),
produce a generator/clump, or exclude the span.

There is also a one-endpoint power test. If the primitive endpoint
tensor is \(s_X=t^m\), where \(t\) has weight \(b\) and \(d=bm\),
choose \(1\le a\le4\) with \(ab\equiv1\pmod5\), and put
\(n_b=(ab-1)/5\). For the above inverse \(r\) of \(d\), write
\(mr=a+5j\), \(j\ge0\). Then
\[
C_{X,n}(s_X^r)=t^j C_{X,n_b}(t^a).
\]
Thus if \(d\nmid4\), the SAME bounded root test
\(C_{X,n_b}(t^a)=0\) is necessary, independently of the exponent \(m\).
In particular, if \(s_X=\omega^d\) for a regular one-form \(\omega\), then
\(C(\omega)=0\) when \(d\nmid4\), and \(C(\omega)=c\omega\)
when \(d\mid4\). The same conclusion holds at either endpoint.
Consequently, if every regular Cartier eigenform on an endpoint
(including eigenvalue zero) with uniform positive zero multiplicity
has simple zeros, NO nonzero shared weight-\(m\) tensor can be an
\(m\)-th power of a regular one-form on that endpoint.
This conclusion concerns a coreless span and does not assume the
root descends through the other actual étale map.

Version2,2026-09-07: one-endpoint power test added; proof shortened
without changing the Frobenius conventions or preceding assertions.
Author prose; no independent whole-statement audit claimed.
[Proof](../Solutions/Sol_cartier_generator.md).
