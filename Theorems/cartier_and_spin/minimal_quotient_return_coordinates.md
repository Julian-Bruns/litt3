# Faithful minimal-quotient coordinates at every Frobenius height

Version1,26September2026. Let K be the fixed actual bundle on X, and let
q:K->O_X(5O) be the saturated quotient from the
[sharp line-degree theorem](small_shift_line_twist_vanishing.md), with
kernel O_X(-4O). Write F=F_abs.

For every geometric degree-zero line T and every n>=1,
\[
\operatorname{Hom}(F^{n*}K,O_X(5O)\otimes T)=0.
\]
Let 0->N->R->K->0 be any actual extension with deg N=-1. If
Hom(F^{n*}R,O_X(-4O))=0, then composition with q followed by restriction
to F^{n*}N is injective:
\[
\operatorname{Hom}(F^{n*}R,K)
\lhook\joinrel\longrightarrow
H^0\bigl(X,N^{-5^n}(5O)\bigr).
\]
The hypothesis holds whenever F^{n*}R is semistable, and also whenever
Hom(F^{n*}R,O_X(-O))=0. For n>=2 the target has dimension5^n-3.
This applies at every strict return of a semistable R, but does not
assert the existence of such a return.

For N=O_X(-O), n=2, and an actual matched middle-character map with
f=y*p(x), deg p<=7 and correction alpha=A(x), deg A<=6, its faithful
coordinate has the form
\[
y r(x),\qquad r=-\bigl((PE)_-p\bigr)_+-A,\qquad\deg r\le6.
\]
Here e=y^2 E(x) is the fixed Laurent extension class, and plus/minus
mean its nonnegative/negative x powers. On each fixed source satisfying
the Hom vanishing, this seven-dimensional coordinate space determines
the full map uniquely; every nonzero map has r!=0. A proposed r still
has to lift through the actual quotient q. This is not an assertion
that all r lift, or that a necessary incidence point is a return.

The current middle-character charts, the full second-return problem and
both original common-cover problems remain unresolved.

[Proof](../../Proofs/cartier_and_spin/minimal_quotient_return_coordinates.md).
