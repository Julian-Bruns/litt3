# A scalar Atiyah obstruction at every Frobenius height

Version1,20 September2026. Let $k$ be algebraically closed of odd
characteristic $p$, and let $X\leftarrow Z\to Y$ be an actual finite
étale span of smooth projective connected hyperbolic curves with no
clump. Assume $p\nmid g(Y)-1$. Common objects retain the prescribed
identifications on the SAME source, on every relative Frobenius twist.

Set $B_C=F_{C*}\mathcal O_C/\mathcal O_{C^{(1)}}$, and, for $s\ge0$, put
\[
H_{s,C}=(F_{C^{(1)}}^{[s]})_*B_C
\quad\hbox{on }C^{(s+1)}.
\]
Write $\omega$ for the canonical common line on the twist in use.
Let $\varepsilon=a(\omega)$ be the COMMON normalized Atiyah extension
class, and let $\alpha_s=a(H_s)$. Then
\[
\beta_s=F^{[s]*}\varepsilon\ne0,\qquad
\gamma_s=\operatorname{id}_{H_s}\otimes\varepsilon\ne0.
\tag{1}
\]
These are extension classes in the actual common category. For $s>0$
the scalar extension representing $\beta_s$ splits on each endpoint
separately; its nonzero class records their incompatible gluings.

Finite Frobenius duality gives a canonical common perfect alternating
pairing $H_s\otimes H_s\to\omega$. Its adjoint involution satisfies
\[
\alpha_s+\alpha_s^\dagger=\gamma_s.
\tag{2}
\]
In particular NONE of the $H_s$ has a common algebraic connection,
even though at positive height its endpoint degree is divisible by $p$.

There is a general filtered version. Suppose $E$ is common-simple,
has a perfect common $\omega$-valued self-duality, and
$\gamma_E=\operatorname{id}_E\otimes a(\omega)\ne0$.
Let $V$ have a common filtration with successive graded objects
$E,E\omega,\ldots,E\omega^{\ell-1}$, in that order, with their
specified identifications. A common connection on $V$ forces
\[
\ell a(E)+\frac{\ell(\ell-1)}2\gamma_E=0,
\qquad \ell^2\gamma_E=0.
\tag{3}
\]
Consequently $p\mid\ell$. This uses the full extension and the
comparison on $Z$, not only its endpoint degrees or associated graded.

More generally, for a perfect common $\omega^w$-valued self-duality,
the same calculation gives
\[
\ell(w+\ell-1)\gamma_E=0.
\tag{3a}
\]
The scalar detector also applies to $F_*^{[s]}L$ for ANY common
line bundle $L$: its top grade has rank one. In particular its
scalar Atiyah class remains nonzero.

Conversely, for any common vector bundle $E$ and every $m\ge1$, the
actual jet identity
\[
J^{pm-1}E\simeq F^*J^{m-1}(F_*E)
\tag{4}
\]
gives a canonical common dormant connection. Therefore whenever
$E=H_s$ is common-simple, the exact criterion is
\[
J^{\ell-1}H_s\text{ has a common algebraic connection}
\quad\Longleftrightarrow\quad p\mid\ell.
\tag{5}
\]
The [all-height filtration theorem](higher_cartier_common_filtration.md)
proves that every $H_s$ is indeed common-simple, using (1)--(3)
inductively. The proof of (1)--(3) does not assume that conclusion.

The height-one/rank20 and two-block argument was returned by Pro.
The arbitrary-height scalar detection, filtered block calculation,
and exact jet-length criterion are author extensions. They do not
construct a clump or settle either common-cover candidate.
[Proof](../../Proofs/cartier_and_spin/common_atiyah_jet_obstruction.md).
