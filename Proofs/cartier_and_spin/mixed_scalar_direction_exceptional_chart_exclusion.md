# Excluding every source on the exceptional scalar-direction chart

Version2, 1 October2026.
[Statement](../../Theorems/cartier_and_spin/mixed_scalar_direction_exceptional_chart_exclusion.md).
All coordinates use the original basis $1,t,t^2,t^3$, with
$t^4=m=[21]$ nonsquare in $K=\mathbf F_{5^{14}}$.
Let $\rho(z)=z^{5^8}$, of order seven on $K$.

## Exact recovery and every coefficient boundary

The original third equation and the actual target coordinate $G_3=0$
give
$x=X^{5^4}=U_0+U_3r_0+U_2r_1+U_1r_2$ and
$Y=C_0+C_3r_0+C_2r_1+C_1r_2$.
Recover the ACTUAL first moment by $X=x^{5^{10}}$.
Source full support supplies $U_1,U_2,U_3,V_1,V_2,C_3\ne0$.
The first two nonconstant coordinates of the original third equation are
$hF_1+V_1=0$ and $hF_2+V_2=0$, where
$F_1=(U_1-U_3r_1)r_0+B_1$,
$F_2=(U_2-U_3r_2)r_0+B_2$,
$B_1=(mU_3-U_1r_1)r_2+U_2(m-r_1^2)$ and
$B_2=U_1r_1-U_2r_1r_2-U_1r_2^2+mU_3$.
In particular $F_1\ne0$ and $h=-V_1/F_1$.
Elimination gives $Ar_0=N$, $N=V_1B_2-V_2B_1$.

On $A=0$, put $k=V_2/V_1$, $b=(U_2-kU_1)/U_3$.
Then $r_2=kr_1+b$. Substituting in $N=0$ gives
$Lr_1+C^*=0$, with
$a_0=1-2kb$, $b_0=b^2+mk^2$,
$L=U_1a_0-U_3b_0$ and $C^*=mU_3a_0-U_1b_0$.
The determinant $mU_3^2-U_1^2$ is nonzero. If $L=C^*=0$,
then $a_0=b_0=0$. The first equation gives $kb=1/2\ne0$;
the second gives $m=-(b/k)^2$, contradicting nonsquareness since
$-1$ is a square. Thus $L=0$ makes this chart empty, while $L\ne0$
uniquely gives $r_1=-C^*/L$ and $r_2=kr_1+b$. No zero-coefficient
branch is discarded.

Fix this pair and let $q=r_0$. Set
$F_0(q)=-U_3q^2-(U_2r_1+U_1r_2)q
+m(U_3r_1+U_2r_2+U_1)$ and
$w=C_0+C_2r_1+C_1r_2$.
The constant original-third equation is exactly
$\rho(q)F_1(q)=P(q)$, with
$P(q)=[V_1F_0(q)-(V_0+\rho(w))F_1(q)]/\rho(C_3)$.
The numerator has degree two. The denominator $F_1$ is nonzero and
has degree at most one. If its linear coefficient is zero, then
$r_1=U_1/U_3$, $r_2=U_2/U_3$ and
$B_1=2U_2[m-(U_1/U_3)^2]\ne0$.

The two polynomials are coprime. At a root of $F_1$, also $F_2=0$.
The third Kummer coordinate of
$(q+r_1t+r_2t^2+t^3)(U-x)$ vanishes by the definition of $x$.
If $F_0$ were zero there, this full product would vanish in the FIELD
$F$. Both factors are nonzero: the first has third coefficient one
and the second has nonzero third coefficient $U_3$. This is impossible.
Hence $P$ is nonzero at every pole of $P/F_1$.

The degree-two rational map $R=P/F_1$ fixes infinity. Every candidate
satisfies the sevenfold return
$q=M(q)$, $M=R^{\rho^6}\circ\cdots\circ R^\rho\circ R$.
This map has degree128 and fixes infinity. Its finite fixed-point
polynomial $f$ is nonzero and has degree at most128. Therefore all
original-third candidates are obtained by the exact squarefree polynomial
$g=\gcd(f,q^{5^{14}}-q,\rho(q)F_1(q)-P(q))$.
The last gcd is evaluated after reducing the Frobenius power modulo
the current polynomial. It retains all and only actual $K$ roots of
the original semilinear equation. The preceding pole argument ensures
that $F_1$ is a unit in $K[q]/(g)$.

## The actual rank lift, not presumed rank automatism

Define $D,G$ from the first two ORIGINAL equations using these recovered
$\epsilon,X,Y$. Actual target rows satisfy
$Z_l=VW_l\rho(D_l/CW_l)$ for $l=0,1,2$, $Z_3=0$, with the fixed
coefficient-model weights. Define $W$ from the original fourth equation.
Write
$s=(E_{1,0}-X^{5^7},C_0-Y,U_0-x)$ and $\ell=sT^{-1}$.
The first three shifted full TOP columns have independent projections.
Since $\epsilon_3\ne0$, the map
$a\mapsto(\pi a,\pi(\epsilon a))$ is injective on $F$.
Thus original stacked rank three necessarily forces the fourth full
top column into their span, giving the exact scalar rank-lift equation
$R_{\mathrm{lift}}=Z_0+Y^5-\ell\,\pi Z=0$.
This condition is explicitly evaluated in the finite algebra $K[q]/(g)$.
For every source the exact gcd of $g$ with its lifted residual is one.
Consequently no actual rank-three solution remains on $A=0$, before
target pair authentication or the other three row identities are needed.

## Exact original-parameter coverage

The received audited source classification is used as an established
input: a full phase-span-two endpoint of support four, five or six,
without a common phase, has three distinct pairs with one repeated,
except for the four-distinct support-four patterns. The latter are
$(aa,ab,bb,cd)$ or four-cycle pair sets. The original classification and
its proof are in sections7.2–7.3 of the
[received audited report](../../../litt3-computation-data/october01_audited_replies/mixed_span_incidence/REPORT.md).
Literal phase rank/full support is computed over $\mathbf F_5$;
the supplied small-power independence identifies it with the actual
root-character conditions. It is not a rank of field-valued rows.

Enumerate these pair patterns on labels $0,\ldots,n-1$, require their
union to contain every label and their intersection to be empty, and
take the minimum under cyclic root rotation. This gives426/405/135
templates for $n=4/5/6$. The nine unordered four-distinct sets have48
full cyclic orders; they are included in the426 support-four templates.

The ACTUAL symmetry group on phase sets is generated by translations
and $H=(1,7,16,20,23,24,25)$, the E-fixed Frobenius multipliers.
It has order203 and acts freely on subsets of sizes4/5/6. A nontrivial
translation has order29. A nontrivial multiplier, after conjugating a
translation, has one fixed phase and four orbits of size seven; it
cannot preserve such a subset. Hence the support-orbit counts are
$\binom{29}{4}/203=117$, $\binom{29}{5}/203=585$ and
$\binom{29}{6}/203=2340$. Combining them with the templates gives
49842/236925/315900 actual source representatives.

Every symmetry preserves the ORIGINAL equations on BOTH endpoints.
Opposite phase translation sends source phases to $j+s$, target phases
to $j-s$, and sends
$\epsilon\mapsto\xi^{-13s}\epsilon$,
$X\mapsto\xi^{-8s}X$, $Y\mapsto\xi^{5s}Y$.
It leaves the normalized scalar ratios unchanged and sends
$A\mapsto\xi^{21s}A$. Simultaneous root rotation by $j$ is the
quartic automorphism $t\mapsto2^jt$; it sends
$r_l\mapsto2^{(l-3)j}r_l$ and $A\mapsto2^{3j}A$.
The allowed Frobenius acts coefficientwise and fixes $t$ and every
marked row weight. These transformations preserve $A=0$ and the actual
full rank condition. Arbitrary phase relabeling or arbitrary dilation
is not used as an equation symmetry. Thus the traversal excludes this
chart on all original parameter choices in the stated scope.

## Executed finite decision and focused verification

| Support | Sources | Finite return roots | Original-third candidates | Rank survivors |
| --- | ---: | ---: | ---: | ---: |
| 4 | 49842 | 98110 | 49775 | 0 |
| 5 | 236925 | 473693 | 236274 | 0 |
| 6 | 315900 | 633341 | 315100 | 0 |
| Total | 602667 | 1205144 | 601149 | 0 |

The one-core traversal completed17:57 UTC with exit zero. Every source
uses exact PARI finite-field modular powers/gcds and evaluates the
ORIGINAL rank lift in the finite quotient. Independent Sage/NTL versus
PARI coefficient comparisons passed on ten marked sources; direct
original-circuit comparisons passed on fifteen exact field points across
supports four, five and six. The full traversal's focused record check
passed603 contiguous chunks, every support/total count sum, unchanged
scanner source hashes and absence of survivor files. This verification
does not repeat the already completed finite-field computations.

Frozen source SHA256 values:

- `scan_direction_boundary.py`: `0a3932316551d52f7aabbbf44ccb0aea719be809d49713d73e873b05cca32d00`.
- `direction_boundary.py`: `6dbedb6a8891aba811c68ccb02df7b01dfb97d71aff2bd77df1eb555bbd87a1b`.
- `direction_system.py`: `e044372ffff47fd135cbd72095c18e51c1d6c970f68bc533a0e69b8e524fb517`.

The final deterministic execution fingerprint is
`891d4f573d0ef585e4ad208a0dc49a19d335cf23e81c9e67aaf36dfeaabb63ac`.
Per-source fingerprint payloads are reproducible from the source, not
retained as expanded certificates. Compact chunks, their complete hash
manifest and aggregate metadata are retained in the sibling raw
[record directory](../../../litt3-computation-data/oct01_local_continuation/mixed/direction_boundary_all/),
especially `checkpoint.json` and `integrity.json`. Reproduce with
[the scanner](../../scripts/oct01_mixed_incidence/scan_direction_boundary.py)
and check final coverage/provenance with
[the record verifier](../../scripts/oct01_mixed_incidence/check_direction_scan_records.py).
Recorded CPU18494.814275 seconds and wall21256.692243 seconds use one
core and OMP/BLAS thread counts one; wall time includes deliberate pauses.

## Source-only corollary: every remaining source has a polynomial chart

The existing traversal gives more than emptiness on $A=0$. Its frozen
`direction_boundary.py` computes exactly the source constant $L$ above
as `linear`, and returns `empty_stage` if and only if `linear` is zero.
The frozen scanner increments `linear_boundary_empty` on exactly that
return. All603 completed chunk counters and the final checkpoint have
zero such events (an absent Counter key has value zero). Therefore $L$
is nonzero on every one of the602667 canonical source inputs. This is
a consequence of the recorded execution and its frozen-source/count
provenance, not a new numerical traversal.
The focused
[source-boundary record check](../../scripts/oct01_mixed_incidence/check_source_linear_boundary_records.py)
passed603 manifest hashes, frozen scanner hashes, complete source counts
and zero boundary events. Its small
[exact record](../../../litt3-computation-data/oct01_local_continuation/mixed/source_linear_boundary_records.json)
does not modify the original checkpoint, integrity manifest or chunks.

This source nonvanishing extends to all original source markings. Phase
translation multiplies $L$ by $\xi^{17s}$: the ratios $k,d$ stay fixed,
and all $U_l$ receive the same factor. Root rotation by $j$ multiplies
$k$ by $2^j$, $d$ by $2^{-j}$ and $L$ by $2^j$; the factors of four
in the squared terms agree since $2^{4j}=1$. The E-fixed Frobenius
conjugates $L$. These are the same exhaustive genuine symmetries used
in the coverage proof. Hence no source on the original list has $L=0$.

For completeness the resulting polynomial chart is explicit. Set
$C^*=mU_3(1-2kd)-U_1(d^2+mk^2)$, $b^*=-C^*/L$,
$\ell=V_1L$, $\alpha=-U_1/(U_3^2V_1)$,
$\delta=-(kU_1+U_2)/U_3$ and $\eta=-2U_1d/U_3-km$.
For two free parameters $(a,c)\in K^2$ put
\[
r_1=b^*+ac,\qquad r_2=kr_1+d+a/(U_3V_1),
\]
\[
r_0=\alpha a+\delta b^*+\eta+(\delta a+\ell)c.
\]
Then $A=a$ and $Ar_0=N$ identically. Conversely every solution of
that quadric has these coordinates, with
$a=A$ and $c=(r_0-\alpha a-\delta r_1-\eta)/\ell$.
To see this even when $a=0$, rewrite its equation as
$a(r_0-\alpha a-\delta r_1-\eta)=\ell(r_1-b^*)$.
All denominators are fixed nonzero source constants, including $\ell$.
The first original moment becomes
\[
x=U_0-U_1d-kmU_3+U_3\ell c.
\]
Its coefficient is nonzero, and it is independent of $a$. The full
remaining incidence therefore lies on $a\ne0$ in this polynomial chart;
no additional $L=0$ torus branch is needed. The exact original-third,
rank-lift, companion and genuine-target conditions still have to be
imposed there.

The full $A\ne0$ mixed incidence remains open. No coefficient solution,
arbitrary scalar graph or necessary trace point is identified with an
actual smooth source carrying both finite etale maps.
