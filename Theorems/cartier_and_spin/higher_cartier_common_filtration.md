# Higher Cartier kernels on a clumpless correspondence

Version2,20 September2026. Let $k$ be algebraically closed of odd
characteristic $p$, and let $X\leftarrow Z\to Y$ be an actual finite
étale span of smooth projective connected hyperbolic curves, with
NO clump. Assume $p\nmid g(Y)-1$. Common bundles, morphisms and
subbundles retain their specified identifications on the same source.
Every Frobenius twist of this diagram is retained.

Put $B_C^{[r]}=F_{C*}^{[r]}\mathcal O_C/\mathcal O_{C^{(r)}}$ and
use the actual intermediate-algebra filtration
\[
0=P_0^{[r]}\subset P_1^{[r]}\subset\cdots\subset P_r^{[r]}=B^{[r]},
\qquad P_{j,C}^{[r]}=
(F_{C^{(r-j)}}^{[j]})_*\mathcal O_{C^{(r-j)}}/
\mathcal O_{C^{(r)}}.
\]
Its successive factors are the stable bundles
$E_{j,C}=(F_{C^{(r-j+1)}}^{[j-1]})_*B_{C^{(r-j)}}^{[1]}$,
of rank $(p-1)p^{j-1}$ and slope $g(C)-1$.

## Complete classification at every height

For EVERY $r\ge1$, the complete common saturated subbundle lattice is
\[
0=P_0^{[r]},\quad P_1^{[r]},\quad\ldots,\quad P_r^{[r]}=B^{[r]}.
\]
Every factor $E_j$, equivalently EVERY iterated direct image
$F_*^{[s]}B^{[1]}$, is common-simple. These are statements about
the actual common subbundles, not just possible ranks or a
semisimplification. Individual-endpoint stability is not a
substitute for common simplicity.

The common morphisms between all interval subquotients are determined
as well. At one fixed height, write $I_{a,b}=P_b/P_a$ for $0\le a<b\le r$.
Then
\[
\operatorname{Hom}_{\rm common}(I_{a,b},I_{c,d})=
\begin{cases}
k\cdot( I_{a,b}\twoheadrightarrow I_{c,b}\hookrightarrow I_{c,d}),
 &a\le c<b\le d,\\
0,&\text{otherwise}.
\end{cases}
\]
In particular every nonzero interval has only scalar common
endomorphisms. This describes the specified inclusions and quotients;
it does not identify unrelated source refinements.

On EVERY hyperbolic curve, independently of any span,
\[
\operatorname{Hom}(B_C^{[r]},P_{j,C}^{[r]})=0\quad(0<j<r),
\]
and every adjacent two-factor extension in the displayed filtration
is nonsplit. These nonsplit actual extensions, together with the
proved common simplicity, exclude every extra subobject.

## The connection obstruction that closes the induction

Put $H_s=F_*^{[s]}B^{[1]}$. A common subbundle $V\subset F_*H_s$
has a uniquely determined integer $1\le\ell\le p$ and an actual
common identification
\[
F^*V\simeq J^{\ell-1}H_s.
\]
The [scalar Atiyah obstruction](common_atiyah_jet_obstruction.md)
proves that such a jet bundle can have a common connection only
if $p\mid\ell$. Its proof traces on a rank-$p-1$ canonical grade,
never on the $p$-divisible total rank. Thus $\ell=p$ and $V=F_*H_s$.
Starting from common simplicity of $B^{[1]}$ completes the induction.

In particular, in characteristic5 the returned rank20 and rank40
connection exclusions settle height three. The general block-sum
identity extends them to EVERY height and every odd characteristic
under the stated degree hypothesis. Indeed, for all $s\ge0$ and
all $\ell\ge1$,
\[
J^{\ell-1}H_s\text{ admits a common algebraic connection}
\quad\Longleftrightarrow\quad p\mid\ell.
\]
The divisible lengths carry their canonical Cartier connection.

The height-two, adjacent nonsplitting and height-three obstruction
were returned by Pro. The all-height induction and exact jet-length
criterion are author extensions with focused proof checks. This
classifies these bundles CONDITIONAL on a clumpless span; it does
not exclude such a span or settle either common-cover candidate.
[Proof](../../Proofs/cartier_and_spin/higher_cartier_common_filtration.md).
