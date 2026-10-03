# Proof: the projective coefficient isolates the Cartier exception

[Statement](../../Theorems/cartier_and_spin/low_rank_common_frobenius_instability.md).
Version3,3 October2026. All HN filtrations, image saturations
and connections are common for the two ACTUAL maps. Without a
clump, every common morphism has saturated image, so a nonzero
common map between lines is an isomorphism.

## 1. One projective coefficient for full and two-block opers

The standard oper/scalar dictionary is
[Ben-Zvi--Biswas, Proposition2.4.1 and Section2.5](https://arxiv.org/pdf/math/0204301#page=8).
Its leading-coefficient calculation is algebraic. A full
rank-$n$ oper with lowest quotient $N$ gives a regular operator
\[
D^n+a_1D^{n-1}+a_2D^{n-2}+\cdots:N\longrightarrow N\omega^n.
\]
When $n$ is invertible, put
\[
K=a_2-\frac{n-1}{2}a_1'-\frac{n-1}{2n}a_1^2.
\]
Changing the frame of $N$ leaves $K$ unchanged. The chain rule
under $t=h(s)$ gives
\[
K_s=(h')^2K_t+\frac{n(n^2-1)}{12}\{h,s\}.
\]
These identities use only denominators invertible for the
ranks and characteristics here; no characteristic-zero result
is imported without this check. Thus
$-6K/[n(n^2-1)]$ is an actual common projective potential
when that denominator is invertible. The coefficients are
$1/2,2,5$ for $n=2,3,4$: exactly rank four at $p=5$ is exceptional.

For a two-block oper of rank $2m$, eliminate the first block
to obtain the matrix operator $D^2+UD+V$. Its matrix
$K=V-U'/2-U^2/4$ conjugates under block-frame changes and
has coordinate shift $\{h,s\}I/2$. Hence $-\operatorname{tr}K/m$
is a common projective potential when $2m$ is invertible.
This is the same calculation with a matrix quotient, requiring
no common determinant or spin choice.

Every resulting regular common projective connection is dormant:
the [no-clump p-curvature argument](first_cartier_full_monodromy.md#3-frobenius-cannot-hide-a-common-affine-section)
contracts its trace-free p-curvature to a positive common
canonical tensor, which vanishes. Horizontality and the oper
second fundamental isomorphism then kill the remaining entries.
This part of that argument requires no endpoint degree condition.

## 2. Generate a smaller oper or the full flag

Take the FIRST unstable Frobenius pullback and rename its
semistable antecedent $E$; put $H=F^*E$. Except for rank four
with HN grades of ranks two and two, either $H$ or its dual
has a maximal HN piece of rank one. Call it $L$.
It is not horizontal, since Cartier descent would destabilize $E$.

Generate $V_1=L,V_2,\ldots$ successively under the connection.
The second fundamental map for $V_i$ factors through
$V_i/V_{i-1}$; a nonzero map has saturated line image and gives
\[
V_i/V_{i-1}\simeq(V_{i+1}/V_i)\omega.
\]
Thus ranks increase one at a time. If generation stops before
the whole bundle, its last $V_i$ is an ACTUAL horizontal
subbundle with a full dormant oper flag. Rank two or three
at a stop is detected by Section1; no semistability of its
Cartier antecedent is required. Otherwise the full oper has
rank $2,3$ or $4$, with the same detector except at $p=5,n=4$.
Inverse coefficient twisting transfers the connection to the
original span, keeping relative twists distinct.

In the remaining two-by-two HN case write
$0\to A\to H\to B'\to0$. Its nonzero second fundamental map
$A\to B'\omega$ has either full rank or rank one.
Full rank is an isomorphism and Section1's two-block detector applies.
At rank one put $K=\ker s$, $\operatorname{im}s=M\omega$.
The further map $K\to(A/K)\omega$ vanishes: semistability
of $A$ contradicts the degree equality a nonzero common
line map would impose. Thus $K$ is horizontal.
The dual argument makes $(B'/M)^*$ horizontal.
Its annihilator $V\subset H$ is horizontal, contains $A$,
and has $V/A=M$. The actual horizontal quotient $V/K$
is a rank-two oper with oper line $A/K\simeq M\omega$.
It too is detected by Section1. This handles partial rank,
rather than replacing the HN blocks by their semisimplifications.

At $p=5$, preserve also the concrete full-rank-three complement.
Adjunction of its lowest quotient gives $E\hookrightarrow F_*N$;
the same horizontal-kernel argument as Section5 makes this an
ACTUAL saturated injection. The first three cyclic jets, with
unit coefficients $1,2$, identify $F^*E$ with
$F^*F_*N/\mathcal H_3$. Its rank-two quotient $Q$ therefore
has $F^*Q\simeq\mathcal H_3$, with line grades
$N\omega^4,N\omega^3$. The canonical connection's index-four
map is an isomorphism, giving the complementary dormant
projective oper with its specified source comparison.

## 3. Keep the degree claims in their actual scope

On an endpoint put $s=g(C)-1$, $D=\deg E_C$ at the first
unstable step and $a=\deg L_C$.
A rank-two oper gives $2a=pD+2s$, hence $2\mid D$.
A full rank-three flag gives $3a=pD+6s$, hence $3\mid D$.

For a rank-three horizontal stop at $V_2$, its degree
$2a-2s$ is divisible by $p$, so $a=pm+s$.
Semistability of $E$ and destabilization by $L$ give precisely
\[
0\le D-3m<3s/p.
\]
Thus $3s\le p$ forces $D=3m$. The original degree differs
from $D$ by a sign and a power of $p$, preserving these
divisibilities. Without the small-genus hypothesis this
horizontal case supplies an oper, but not rank-three divisibility.
A rank-four two-block case supplies only parity; no general
rank-four degree assertion is used.

## 4. The actual theta refinement supplies the boundary example

Choose endpoint theta characteristics on the first twists.
Their pulled-back ratio on the source twist is two-torsion,
with square trivialization from the actual canonical comparison.
Its torsor, or a connected component when trivial, gives an
ACTUAL source refinement of degree at most two.
Inverse coefficient twisting realizes it on the original span.

A clump on this refinement maps to a clump below, by full-fiber
saturation. Equality of endpoint projective connections descends
through the faithfully flat source cover. Thus no clump and
no oper persist. The common $B\vartheta^{-1}$ is stable on
each endpoint, as is $B$ after every finite etale pullback.
This uses the [Joshi stability input](../jacobians/theta_divisors/etale_induction_stability.md),
since actual etale pullback identifies $B$ with the Cartier
bundle upstairs. It has rank $p-1$ and degree zero. The top
line of its first Frobenius pullback has degree
\[
\deg(\omega^{p-1}\otimes F^*\vartheta^{-1})
=(p-2)(g(C)-1)>0.
\]
This proves the stated conditional example.

## 5. Characteristic five: the complementary line fixes the comparison

For the rest retain $k=\overline{\mathbf F}_5$ and $g(Y)=2$.
In the no-oper branch Section2 leaves only the full four-step
dormant flag. Let $N$ be its lowest quotient.
Adjunction gives an actual common injection
\[
E\hookrightarrow F_*N.
\]
Its generic kernel would pull back to a horizontal subspace
inside the penultimate oper piece. Successive oper isomorphisms
force that subspace down the whole flag and hence to zero.
Common saturation gives a line quotient $Q$.

Write $\mathcal H_i$ for the canonical filtration of $F^*F_*N$,
with $\mathcal H_i/\mathcal H_{i+1}=N\omega^i$.
The cyclic-jet projection
$F^*E\to F^*F_*N/\mathcal H_4$ is an isomorphism:
its four grade maps have unit coefficients $1,2,3$.
Thus $\mathcal H_4\simeq F^*Q=N\omega^4$.
Finite Frobenius duality turns the quotient into a nonzero
common line map $N\to F^!Q=F^*Q\,\omega^{-4}$.
It is an isomorphism. Therefore the quotient is the
dualizing counit up to one common scalar, and its kernel is
\[
E=Q B^*=B\otimes Q\omega_{C^{(1)}}^{-1}.
\]
Dualizing $E$ if needed gives another actual line twist of $B$.
This is the common-map version of the
[published rank-$p-1$ uniqueness theorem](https://www.ms.u-tokyo.ac.jp/journal/jms240301.pdf#page=44);
endpoint uniqueness alone would not fix the source comparison.

Conversely $B\otimes L$ is stable and common-simple here.
For $\ell=\deg L_Y$, the top line of its Frobenius pullback
has degree $8+5\ell$, above its slope $5+5\ell$.
Hence it is unstable.

## 6. No delayed instability and the exact minimum rank

No line twist of $B$ has a common connection in this scope.
Indeed its Atiyah class is $a(B)+\operatorname{id}_B a(L)$,
while the actual Cartier pairing gives
$a(B)+a(B)^\dagger=\operatorname{id}_B a(\omega)$.
Vanishing of the former class would force
\[
\kappa_B=a(B)-\tfrac12\operatorname{id}_B a(\omega)=0.
\]
The [intrinsic skew-class detector](common_projective_atiyah_detection.md)
then gives a common dormant projective oper, a contradiction.

At the first instability, Section5 identifies the last
semistable antecedent as $B\otimes L$. A positive Frobenius
antecedent would have its canonical common connection.
Therefore the FIRST pullback was already unstable.
Also $\deg E_Y=4+4\deg L_Y$.
Degree zero occurs exactly when a common degree-minus-one
line exists. Coefficient twisting transfers that existence
to the original span, and duality gives the degree-one
criterion $e=1$.

If an oper exists, its actual common canonical-determinant
Bol bundle $Q$ gives the common-simple degree-zero adjoint
$K=\operatorname{End}^0(Q)$ by the
[proper-subbundle criterion](cartier_witt_oper_subbundle.md).
Common HN filtrations make $K$ endpoint semistable.
The oper line in $F^*Q$ gives a positive
$\operatorname{Hom}(F^*Q/L,L)=\omega$ inside $F^*K$,
so $K$ is not strongly semistable. Together with Section2,
this proves the exact rank-three converse.

A rank-two degree-zero unstable antecedent has oper line
of degree one on $Y$, so it requires both an oper and $e=1$.
Conversely those conditions give the degree-zero example
$Q\otimes L$ for a common degree-minus-one line $L$.
If an oper exists with $e=2$, the adjoint is the least-rank
example. With no oper, Section2 excludes ranks two and three;
the preceding degree-one criterion decides rank four.

Finally $T=F_*\omega^{-2}$ is the degree-zero rank-five
example, even when $e=2$. For a common saturated subbundle
$U$ of rank $s$, its canonical pullback grades are the first
$s$ grades $\omega^{i-2}$, $0\le i\le4$:
common saturation and the invertible Cartier indices force this.
Consequently
\[
5\deg U_Y=s(s-5).
\]
Integrality forces $s=5$, so $T$ is common-simple and
endpoint semistable. Its first pullback contains the
positive line $\omega^2$. This completes the table,
with the ORIGINAL source comparison before theta refinement.

The theorem detects an oper from supplied small coefficients.
It constructs no such coefficient from a bare common span
and resolves neither unmarked common-cover candidate.

The [independent bounded consolidation review](../../Research/audits/LOW_RANK_FROBENIUS_CONSOLIDATION_AUDIT_2026_10_03.md)
passed after restoring the concrete complementary quotient and
clarifying the theta coefficient twist. No numerical replay was needed.
