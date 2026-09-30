# Proof: use the Frobenius recurrence before dividing Taylor terms

[Statement](../../Theorems/deformations/frobenius_taylor_thickness.md).
Valuations are normalized by $v_\pi(\pi)=1$. All matrix estimates
mean the minimum valuation of their entries.

## The logarithmic denominator bound

Work locally in an integral frame and an étale coordinate $z$.
Choose the Frobenius lift $\varphi(z)=z^p$. Its matrix $\Phi$ satisfies
\[
v_\pi(\Phi)\ge0,\qquad v_\pi(\Phi^{-1})\ge-a.
\tag{2}
\]
The connection is integral. Thus its rational Taylor coefficients
$T_j$, obtained by dividing the $j$th iterated covariant derivative
by $j!$, are integral for $j<p$. They exist over $A[1/p]$ in every
degree; convergence will follow from the bound, not be assumed.

Choose the orientation of transport from $z$ to $z+t$ and use the
same orientation throughout. Horizontality of Frobenius gives the
formal identity
\[
T(z,t)=\Phi(z+t)\,T^{\sigma}(z^p,\Delta)\,\Phi(z)^{-1},
\qquad \Delta=(z+t)^p-z^p.
\tag{3}
\]
The superscript denotes coefficient Frobenius. Reversing transport
gives the equivalent identity with the two endpoint factors reversed;
the following bounds are identical. Integral functions have integral
Hasse expansions in an étale coordinate, so all coefficients of
$\Phi(z+t)$ are integral. Also
\[
\Delta\equiv t^p\pmod p,
\qquad [t]\Delta=pz^{p-1}.
\tag{4}
\]
Assume the required bound is known in degrees below $j\ge p$ and put
$r=\lfloor\log_pj\rfloor$. In the coefficient of $t^j$ on the
right of (3), consider a term involving $T_k$ with $k<j$.

If $k<p^r$, its valuation, including the final inverse in (2), is
at least $-a(r-1)-a=-ar$; for $k=0$ use $T_0=1$ directly.
If $p^r\le k<j$, every coefficient of $\Delta^k$ of degree at most
$j$ is divisible by $p$: its reduction is $t^{pk}$ and
$pk\ge p^{r+1}>j$. The term consequently has valuation at least
\[
-ar+e-a\ge-ar.
\tag{5}
\]
Only the coefficient with $k=j$ involves the unknown $T_j$. In
that term the degree-$j$ coefficient of $\Delta^j$ is
$(pz^{p-1})^j$, and the degree of $\Phi(z+t)$ must be zero.
Its valuation is at least $v_\pi(T_j)+ej-a$.
Since $ej-a>0$, this term is strictly more integral than $T_j$.
Equation(3) therefore implies $v_\pi(T_j)\ge-ar$: otherwise its
left side has smaller valuation than every term on its right side.
This completes the induction.

For a finite Frobenius cycle apply the induction simultaneously to
all component Taylor series. In degree $j$ the only not-yet-bounded
term comes from degree $j$ on the preceding component, multiplied by
a matrix operator that improves valuation by at least $ej-a>0$.
If any component violated the bound, choose the smallest valuation
among this finite cycle. Every term on the right side of its identity
has strictly greater valuation, a contradiction. This proves the
same estimate with the maximum of the component height bounds.

For the sharper bound, let $a_i$ be the height of the map entering
component $i$ and set $S_i(r)=a_i+S_{i-1}(r-1)$. The same induction
works with lower bound $-S_i(r)$. For $k<p^r$, the term coming from
the preceding component has valuation at least
$-S_{i-1}(r-1)-a_i=-S_i(r)$. For $p^r\le k<j$, it has valuation at
least $-S_{i-1}(r)+e-a_i\ge-S_i(r)$, since their difference is
$e-a_{i-r}\ge0$. To handle $k=j$, choose a component minimizing
$v_\pi(T_{i,j})+S_i(r)$. The unknown term improves this adjusted
valuation by at least $ej-a_{i-r}>0$. A negative minimum would again
contradict the recurrence. This proves the simultaneous componentwise
bound without a uniform-height replacement.

This is a direct local argument over the ramified coefficient DVR.
For comparison, the integral-connection specialization of
[Kedlaya--Tuitman, Lemma2.5](https://arxiv.org/pdf/1111.0136)
gives the same logarithmic bound from the valuations of a Frobenius
matrix and its inverse. No unramified coefficient assumption from
their presentation is being imported: (2)--(5) prove the estimate
used here.

## Integral transport on the needed neighborhood

Substitute a coordinate displacement of valuation at least $n$.
For $j\ge p$ and $r=\lfloor\log_pj\rfloor\ge1$, the $j$th term has
valuation at least $nj-ar$. Since
\[
j-1\ge p^r-1\ge(p-1)r,
\]
the strict inequality $(p-1)n>a$ makes $nj-ar>n$.
For $2\le j<p$, integrality of $T_j$ gives valuation at least
$2n>n$. These bounds tend to infinity with $j$.
The series therefore converges integrally; its constant term is the
identity and its only contribution modulo $\pi^{n+1}$ is the usual
linear connection term. The same estimates apply with any larger
displacement valuation.

For component $i$, the refined estimate instead requires exactly the
sufficient inequalities
\[
n(p^r-1)>S_i(r)\qquad(r\ge1).
\tag{6}
\]
It is enough to check $1\le r\le f$. Indeed periodicity gives
$S_i(r+f)=S_i(r)+S_i(f)$, whereas
$p^{r+f}-1\ge(p^r-1)+(p^f-1)$. Induction reduces every ratio to
the maximum of the first $f$ ratios. This gives the finite threshold
$n>\tau_i$ in the statement. The coefficient losses grow at most
linearly in $r$, so convergence follows as before.

If the last $s$ incoming heights vanish, then $S_i(r)=0$ for
$r\le s$ and $S_i(r)\le e(r-s)$ otherwise. For $r=s+t$,
\[
p^{s+t}-1\ge t(p^{s+1}-1)\qquad(t\ge1),
\]
as follows by adding the successive positive increments of $p^r$.
Thus $\tau_i\le e/(p^{s+1}-1)$, proving the stated oper criterion
after incoming Frobenius isomorphisms. An isomorphism here means an
actual integral one, including its connection, rather than a generic
isomorphism or the equality of Newton slopes.

The rational Taylor transport of an integrable connection satisfies
composition and inverse identities formally. Convergence on this
neighborhood allows substitution into those identities. They are
equalities of integral maps because the ambient modules are
$\pi$-torsion-free. This proves the cocycle, inverse and functoriality
assertions without choosing new transport maps or new Frobenius data.

## A composite Frobenius: the first denominator still occurs at p

Suppose only a horizontal $q=p^s$ Frobenius is given, with
$v_\pi(\Phi)\ge0$ and $v_\pi(\Phi^{-1})\ge-a$, $a\le e$.
Replace $z^p,\Delta$ in(3) by
$z^q,(z+t)^q-z^q$. Its nonleading coefficients are divisible
by $p$, and its linear coefficient is $qz^{q-1}$.
The integral connection supplies $T_j$ integral for $j<p$.
For $j\ge p$, put $r=1+\lfloor\log_q(j/p)\rfloor$.
In the coefficient recurrence the terms with
$k<pq^{r-1}$ have valuation at least $-a(r-1)-a=-ar$.
The term $k=0$ also has valuation at least $-a\ge-ar$.
For $pq^{r-1}\le k<j$, the reduction of $\Delta^k$ is
$t^{qk}$, of degree at least $pq^r>j$. These terms gain $e$
and satisfy the same bound because $e\ge a$. The unknown
degree-$j$ term improves valuation by $sej-a>0$.
This proves the bound $v_\pi(T_j)\ge-a b_s(j)$.

Since $j-1\ge pq^{r-1}-1\ge r(p-1)$, its transport
criterion is again $(p-1)n>a$. The gluing argument below
therefore applies to this weaker, composite-only hypothesis.
The initial oper line must still be supplied on the whole
specified thickening.

Here is a sharp local example for $s\ge2$. Let the coefficient
Frobenius fix $\pi$, put $q=p^s$, and work on the restricted
formal affine line over $A$. In a frame $(e_1,e_2)$ set
\[
\Phi(z)=\begin{pmatrix}1&z^p\\0&\pi^a\end{pmatrix},\qquad
\nabla=d+\begin{pmatrix}0&B(z)\\0&0\end{pmatrix}dz,
\quad
B(z)=-\sum_{n\ge0}\frac{p q^n}{\pi^{a(n+1)}}z^{p q^n-1}.
\tag{7}
\]
The coefficient valuations in $B$ are
$e-a+n(se-a)$. They are nonnegative and tend to infinity,
so this is an integral convergent connection. Directly shifting
the series gives
\[
pz^{p-1}+\pi^a B(z)=qz^{q-1}B(z^q).
\tag{8}
\]
Equation(8) is exactly the off-diagonal horizontality equation
$d\Phi+N\Phi=\Phi\,\varphi_q^*N$. The determinant of
$\Phi$ is $\pi^a$ and its inverse has height $a$.
Up to the common sign determined by transport orientation,
the off-diagonal Taylor coefficient is
\[
(T_j)_{12}=\sum_{n\ge0}
\pi^{-a(n+1)}\binom{p q^n}{j}z^{p q^n-j}.
\tag{9}
\]
Terms with $pq^n<j$ are zero. Each fixed coefficient converges
because its valuations tend to infinity with $n$.
At $j=p$ the $n=0$ term is $\pi^{-a}$, while for $n\ge1$
\[
v_p\binom{p q^n}{p}=sn,
\qquad
v_\pi\left(\pi^{-a(n+1)}\binom{p q^n}{p}\right)
=sen-a(n+1)\ge0.
\]
Thus $v_\pi(T_p)=-a$ exactly. The divided Taylor estimate also
shows topological quasi-nilpotence: the valuations of the
undivided iterated covariant derivatives are bounded below by
$e v_p(j!)-a b_s(j)$, which tends to infinity. The local
connection consequently defines an integral crystal with the
displayed horizontal $q$-Frobenius.

This example isolates the failed higher-descent inference. In(3),
the $k=0$ contribution is the Taylor expansion of $\Phi(z+t)$
times $\Phi(z)^{-1}$. At degree $p<q$ it can already have
valuation $-a$; no factor of $\Delta$ accompanies it. Ignoring
it would incorrectly replace $p$ by $q$ in the denominator
threshold. Even when $a<e$, so the ordinary reduced connection
in(7) is dormant, this does not supply an integral higher Taylor
stratification. The example has constant triangular Newton data;
it is a local obstruction to that inference, not a counterexample
to the common-cover problem or to a global nonconstant-polygon
statement.

## Evaluating the fixed lattice on curve deformations

Choose a smooth formal lift of $C/W(k)$, which exists for a smooth
proper curve, and tensor it with $A$. The original crystal evaluates
there. Its restriction modulo $\pi^n$ is the stated bundle on the
constant curve: $n\le e$ makes $A/\pi^n$ a $k$-algebra through
$W(k)\to k$.

Any deformation of this constant thickening is, on small affine
étale-coordinate opens, isomorphic to the corresponding reference
lift. Differences between these identifications are congruent to
the identity modulo $\pi^n$. The integral Taylor maps just proved
glue the local evaluations of the FIXED lattice. Their cocycle
shows that the result is independent of the identifications. This
constructs its evaluation functor on these deformations, even when
the ideal $(\pi^n)$ admits no integral divided powers. Equivalently,
it extends the rational convergent evaluation while retaining the
specified integral lattice on this neighborhood.

At the step $A/\pi^m\leftarrow A/\pi^{m+1}$, $m\ge n$, changing
curve gluing by $1+\pi^m\delta_{ij}$ changes the normal line-lifting
obstruction by the second fundamental form applied to $\delta_{ij}$.
All higher Taylor terms vanish at this precision by the preceding
bound. For an oper this is the isomorphism
\[
T_C\xrightarrow{\sim}\mathcal Hom(L,H/L).
\]
The curve and line obstruction torsors are consequently identified.
Exactly one curve-lift class kills the line obstruction; $H^0(T_C)=0$
makes the line lift and the marked identifications unique. Induction
and formal algebraization give the claimed proper lift.

This is the same obstruction argument as
[crystalline oper lifting](crystalline_oper_lifting.md); the new point
is the integral evaluation and linear comparison below the generic
divided-power threshold. Finite étale pullback preserves (2), the
Taylor identities and the oper. Hence uniqueness identifies the
lifts of the actual common source from the two endpoints.
The stable-lattice descent argument in that proof also preserves
$F$ and its height bound by faithful flatness. Its unique initial
line over $A/\pi^n$ descends, so one endpoint lattice and rational
compatibility suffice.

## Focused checks of the new implication

For a cycle, the bound is required at EVERY constituent $p$-Frobenius
step; a bound only on $F^f$ is not silently substituted. The terms
with large $k<j$ in (3) acquire a factor $p$, not just a factor
$\pi$; $e\ge a$ is essential in (5). The term $k=j$ is not silently
discarded: its strict contraction is the reason the induction works.
The initial line is given on the entire specified thickening. The
gluing uses the convergent Taylor cocycle and never postulates
divided powers on the uniformizer. These points are precisely what
prevents applying the conclusion to an arbitrary mod-$\pi$ oper
or an uncontrolled Frobenius cycle.
