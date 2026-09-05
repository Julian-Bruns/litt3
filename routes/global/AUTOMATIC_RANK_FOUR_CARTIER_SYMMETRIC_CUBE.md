# The rank-four Cartier symmetric-cube condition is automatic

**Status: literature consequence with explicit removal of the line twist,
2026-09-05. No novelty or common-cover exclusion claimed.**

Let \(C\) be any smooth projective curve of genus at least two over
\(\overline{\mathbf F}_5\), let \(F:C\to C^{(1)}\) be relative Frobenius,
and let \(L^2\simeq\omega_{C^{(1)}}\). Put
\(E=B_C^1\otimes L^{-1}\). There exists a rank-two bundle \(Q\) on
\(C^{(1)}\), with trivial determinant, such that

\[
                         E\simeq\operatorname{Sym}^3Q.
\]

The isomorphism can be chosen symplectic. After Frobenius pullback it
respects the canonical zero-p-curvature connection and the oper filtration.

Hoshi's Proposition 1.4 constructs the normalized Cartier oper;
Theorem 2.1 proves uniqueness of the rank-\((p-1)\) dormant oper up to a
dormant line twist. Remark 1.4.2 states existence of rank-two dormant opers
on every such curve and obtains rank \(p-1\) by symmetric powers. No
ordinarity or large-characteristic assumption is imposed.
[Hoshi, §§1–2](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1822revised.pdf).

To remove the twist for the specified \(L\), set
\(\theta=F^*L\otimes\omega_C^{-2}\). Then \(\theta^2\simeq\omega_C\),
and the lowest quotient of \(F^*E\) is \(\theta^{-3}\). Choose a dormant
\(SL_2\)-oper \(U\) with oper subline \(\theta\): any initial choice can
be adjusted by a two-torsion line with its canonical dormant connection.
The induced symmetric-cube filtration makes \(\operatorname{Sym}^3U\)
a dormant rank-four oper with the same lowest quotient; its successive
Kodaira–Spencer multipliers \(1,2,3\) are invertible in characteristic five.

Uniqueness gives an isomorphism of filtered flat bundles
\(F^*E\simeq\operatorname{Sym}^3U\otimes(N,\nabla_N)\).
The lowest quotient forces the underlying \(N\) to be trivial. Trivial
determinant connections force \((N,\nabla_N)^4\) to be trivial, so
\(\nabla_N=d\), since four is invertible. Cartier descent gives the
asserted isomorphism with \(Q=U^{\nabla_U}\). Stability of \(E\) makes
its two symplectic forms differ by a scalar; rescaling the isomorphism
removes this scalar over the algebraically closed field.

Wakabayashi's rank-\(n\)/rank-\((p-n)\) duality gives the same endpoint
from rank one: see Corollary 4.3.3 and Theorem 6.2.2. The separate bound in
his counting formula is not a hypothesis of this uniqueness theorem.
[Wakabayashi, §§4.3 and 6.2](https://www.ms.u-tokyo.ac.jp/journal/jms240301.pdf).

Several rank-two opers can therefore give different reductions of the
same rank-four oper. For example, the generic genus-two count in
characteristic five is \((5^3-5)/24=5\), whereas the rank-four projective
oper is unique.
[Wakabayashi, introduction and Theorem 3.3](https://ems.press/content/serial-article-files/41233).

The existence condition is compatible with finite etale pullback but is
automatic on both current curves in file 76. It does not identify chosen
rank-two reductions after common pullback and supplies none of the extra
matching data required in file 33. No current-curve test or retargeting
follows from this observation.
