# Finite tensor transport and affine spectral closure

Version3,2026-09-24.

Let $k$ be algebraically closed of characteristic $p>0$, and let
$X\xleftarrow f Z\xrightarrow g Y$ be an actual coreless finite
bi-étale span of smooth projective connected hyperbolic curves. Use
the canonical identifications on $Z$. A common finite multisection
of $\omega_Z^b$ means a finite generically reduced spectral
multisection descending to both endpoint line bundles, with monic
equation and regular coefficients; here $b>0$.

For a nonzero $\beta\in H^0(Z,\omega_Z^b)$, the following are
equivalent:

1. Some common finite multisection contains the graph of $\beta$.
2. A positive prime-to-$p$ power of $\beta$ is a shared tensor.

In this situation the common canonical ring is $k[s]$, with primitive
weight $d$ prime to $p$. If $h=\gcd(d,b)$, then
\[
\beta^{d/h}=c\,s^{b/h},\qquad c\in k^\times.
\]
Every nonzero branch of a common finite multisection containing
$\beta$ is a constant multiple of $\beta$. In particular, its
reduced generic branches are already rational over $k(Z)$.

If \(p\ge5\) and \(\operatorname{div}(\beta)=bD\) for a reduced
divisor \(D\), no such common multisection exists in a coreless span:
the shared power would give a reduced canonical marking on both
actual endpoints, so the
[marked-quotient theorem](../quotient_geometry/canonical_marked_quotient.md)
would force a core.

Let $\mathscr P$ be an actual common torsor under $\omega^b$.
If a common finite generically reduced multisection of $\mathscr P$
contains two distinct global sections $P,Q$ on $Z$, then their
difference satisfies the preceding conclusion. Every branch of that
multisection is of the form $P+c_j(Q-P)$, with $c_j\in k$.
Consequently three noncollinear global sections cannot have finite
common spectral closure in a coreless span.
For \(p\ge5\), the same impossibility holds for two distinct sections
if \(\operatorname{div}(Q-P)=bD\) with \(D\) reduced.

The criterion itself does not construct a common multisection or
exclude an arbitrary coreless span.

[Proof](../../Proofs/shared_tensors/finite_tensor_transport.md).
