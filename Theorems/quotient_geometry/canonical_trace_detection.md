# Canonical multipliers detect every coefficient section of an actual span

Version2,3 October2026. The original odd-characteristic conclusions
retain their independent audit. Interpolation works in every
characteristic; very ample canonical powers supply primitive
multipliers even in characteristic two.

Let \(X\xleftarrow f Z\xrightarrow gY\) be an actual jointly minimal
finite bi-étale span of smooth projective connected curves of genus
at least two, over an algebraically closed field of arbitrary characteristic.
Write \(n=\deg f\), \(h=g(Y)\), and \(\mathcal A=f_*\mathcal O_Z\).
Neither Galoisness nor a restriction on the covering degrees is needed.

For any vector bundle \(V\) on \(X\) and \(r\ge2\), define the
weighted-trace map of sheaves using the actual differential identifications:
\[
\mathcal D_r:V\otimes\mathcal A\longrightarrow
V\otimes\omega_X^r\otimes H^0(Y,\omega_Y^r)^\vee,
\qquad \mathcal D_r(\xi)(q)=\operatorname{Tr}_f(\xi g^*q).
\]
Let \(D\) be the reduced degree-n divisor on \(Y_{\overline{k(X)}}\)
given by the geometric generic f-fiber. Put
\[
c_r=h^0(Y_{\overline{k(X)}},\omega_Y^{1-r}(D)).
\]
The generic kernel of \(\mathcal D_r\) has dimension
\(\operatorname{rk}(V)c_r\). More precisely it is
\(V_{k(X)}\) tensored with the trace-annihilator of the canonical
evaluation image, whose dimension is exactly \(c_r\).

Consequently \(\mathcal D_r\) is injective, both as a sheaf map
and on global sections, whenever \((r-1)(2h-2)>n\). In particular
one may take \(r=\lfloor n/(2h-2)\rfloor+2\).

There is a sharper test for a particular nonzero section \(\xi\).
Express its generic value in a basis of \(V_{k(X)}\), and let
\(\rho\) be the dimension of the span of its coefficients in
\(k(Z)\). This number is basis-independent. If
\(\mathcal D_r(\xi)=0\), then \(\rho\le c_r\).
Thus the full interpolation cutoff can be shortened whenever
the tensor rank \(\rho\) is larger than the remaining evaluation
defect.

If \(g_*f^*=0:J(X)\to J(Y)\), all the fiber divisors have a fixed
line-bundle class \(Q\in\operatorname{Pic}^n(Y)\), so
\(c_r=h^0(Y,\omega_Y^{1-r}Q)\). The bundle Q is globally generated.
If the span is also coreless, then \(h^0(Q)\ge3\). In genus two
this gives \(n\ge4\), without any Raynaud or small-a-number hypothesis.

Under this zero-cross-homomorphism hypothesis, for a genus-two
target put \(r_1=\lfloor n/2\rfloor+1\). Here \(n\ge2\).
At this degree, vanishing of \(\mathcal D_{r_1}(\xi)\) forces
\(\rho=1\) and
\[
Q\simeq
\begin{cases}
\omega_Y^{n/2},&n\text{ even},\\
\omega_Y^{(n-1)/2}(y),&n\text{ odd, for some }y\in Y.
\end{cases}
\]
The exact c_r test also gives lower detecting degrees for larger
\(\rho\); it is not restricted to this rank-one boundary.

In characteristic different from two, the weight-one primitive
multipliers have a sharper description. Choose a nonzero rational differential \(\theta\) on X. A general
\(\nu\in H^0(Y,\omega_Y)\) makes
\(\alpha=g^*\nu/f^*\theta\) a primitive element of
\(k(Z)/k(X)\). This assertion only needs both maps to be finite
separable and jointly minimal, not étale. If \(W\subset k(Z)\)
is the coefficient span of \(\xi\), of dimension \(\rho\), then:

- If \(W\subset U\subsetneq k(Z)\), \(\dim U=d\), some
  \(\alpha^j\xi\) leaves \(V_{k(X)}\otimes U\) with
  \(1\le j\le d-\rho+1\).
- If \(\operatorname{Tr}_f\xi=0\), some weighted trace
  \(\operatorname{Tr}_f(\xi(g^*\nu)^j)\) is nonzero with
  \(1\le j\le n-\rho\). This includes degrees divisible by p:
  separability, not \(\operatorname{Tr}(1)\ne0\), is the needed fact.

In EVERY characteristic, for any $c\ge3$, a general
$q\in H^0(Y,\omega_Y^c)$ makes
$\alpha_q=g^*q/(f^*\theta)^c$ primitive. The same coefficient-rank
escape bound holds with $\alpha_q$; if the initial trace vanishes,
some $\operatorname{Tr}_f(\xi(g^*q)^j)$ is nonzero for
$1\le j\le n-\rho$. This uses only finite separability and joint
minimality. Thus characteristic two requires no field-generation
assumption if canonical powers are used.

These statements apply on Frobenius twists with \(V=B_X\), so they
detect the particular exceptional section in the current excess-one
case. They do not imply that a mixed Frobenius cohomology obstruction
or Hasse coefficient is nonzero.

[Proof](../../Proofs/quotient_geometry/canonical_trace_detection.md).
