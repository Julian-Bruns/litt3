# Proof: the norm component and its projective character spaces

[Statement](../../../Theorems/deformations/elementary_covers/elementary_weighted_carry.md).
The older rank-three calculation is a specialization of this one graded
argument. Keep the original rational generators and coefficient Frobenius;
neither a geometric coordinate change nor commuting higher operators is used.

## 1. The graded norm kernel

The original relation
\[
e_i^p=-p e_i-\sum_{j=2}^{p-1}\binom pj e_i^j
\]
never lowers weight. Its only weight-$p$ terms give
$E_i^p+\tau E_i$. The normal monomials are free over $W_m(k)$,
so there are no further graded relations.
Before truncating $\tau$, use
\[
A=k[\tau,E_1,\ldots,E_r]/(E_i^p+\tau E_i).
\]
An additive deck-equivariant map commutes with $e_i$ and multiplication
by $p$. Thus a correction divisible by $p$ raises weight at least
$p-1>a$, while the higher terms of $f$ raise it at least $a+1$.
The principal operator is exactly $q\Phi$ of weight $a$.

Invert $\tau$ and adjoin $c$ with $c^{p-1}=-\tau$. The algebra becomes
the function algebra on $E=cv$, $v\in\mathbf F_p^r$.
Homogeneity and the stated nonvanishing of $q$ make its multiplication
kernel exactly the origin component. Its integral generator is
\[
\nu=\prod_i(E_i^{p-1}+\tau),\qquad\deg\nu=D.
\]
The algebra is free over $k[\tau]$, and the coefficient of
$\prod_iE_i^{p-1}$ in $\nu$ is one. Hence an integral localized
multiple of $\nu$ cannot have a denominator in that coefficient.
Consequently $\ker(q:A\to A)=k[\tau]\nu$.

## 2. Homogeneous solutions and high-weight absorption

Let $d$ be the lowest weight of a nonzero $x$.
If $d+a<(p-1)m$, the equation $Lx=0$ places its principal term
in the untruncated norm kernel. The same is true if
$d+a=(p-1)m$: the only possible discarded term is a constant
multiple of $\tau^m$, but $q\Phi(x_d)$ is augmented and cannot
equal such a term, as evaluation at all $E_i=0$ shows.
For $m\le r$, every $d\le(p-1)m-a$ is below $D$, so is impossible.
For $m=r+1$, every $d<D$ has $d+a<(p-1)(r+1)$ and is likewise
impossible. These are the claimed kernel thresholds.

Let $T$ be the augmented part of $A/(q)$. The multiplication sequence
and norm kernel give its Hilbert series
\[
H_T(z)=
\frac{(1-z^a)(1+z+\cdots+z^{p-1})^r+z^{D+a}-1}
     {1-z^{p-1}}.
\]
It is a polynomial, since the augmented quotient vanishes after
inverting $\tau$ and is a finite $\tau$-torsion module.
The numerator has degree $D+a-1$ with leading coefficient $-r$;
thus $T$ vanishes in weights above $D+a-p$.
In particular $q$ surjects onto every augmented target of weight
at least $D+a-p+1$. Surjectivity passes to the $\tau^{r+1}$ quotient.

A coefficient-ring constant in $\Lambda_{r+1}$ has weight at most
$D$. Hence every target in $\mathcal W^{D+a}$ is augmented.
Cancel its lowest weight with $q\Phi$, using a source $a$ weights
lower, and apply the ACTUAL $L$. The residual has strictly greater
weight. Repetition terminates at the maximal normal weight $2D$,
and all sources stay in $\mathcal W^D$. This proves absorption.

## 3. Norm targets have a known first weight

The exact norm factor is
\[
N_G=\prod_i\bigl(e_i^{p-1}+p+\sum_{j=1}^{p-2}\binom p{j+1}e_i^j\bigr).
\]
Its first weight is $D$, with symbol $\nu$. At precision $p^r$
the constant term $\tau^r$ is discarded. If $Lx=N_G\eta$ and
the first source weight $d<D-a$, its image lies below $D$ and has
zero principal term. Section1's norm kernel, whose first degree is
$D$, excludes this. Hence $x\in\mathcal W^{D-a}$.
Since $a<p-1$, a constant normal monomial of this weight would be
divisible by $p^r$. All other normal monomials have zero augmentation,
so $\operatorname{aug}(x)=0$ in $W_r(k)$.

If $\eta$ is divisible by $p$, the target has weight at least $D+p-1$.
The same argument excludes $d\le D-a$. At the boundary $d+a=D$,
the only term discarded by $\tau^r=0$ is a constant multiple of
$\tau^r$. The augmented principal image $q\Phi(x_d)$ cannot equal
such a term, by evaluation at all $E_i=0$. Thus
$x\in\mathcal W^{D-a+1}$, including every degenerate quadratic symbol
permitted by the original-rational-direction hypothesis.

At precision $p^{r+1}$, $\tau^r$ survives. If $\eta\bmod p\ne0$,
the first target is $\nu\bar\eta$ of weight $D$, so the first source
would have weight $D-a$. Its principal equation
$q\Phi(x_{D-a})=\nu\bar\eta$ is impossible at $E_i=0$, where its two
sides are zero and $\tau^r\bar\eta$. Therefore $\eta\bmod p=0$.
The target now starts in weight $D+p-1$; for every $d<D$ one has
$d+a<D+p-1$, below the truncation weight. The norm kernel again
excludes such $d$. This gives $x\in\mathcal W^D$.

Conversely let $\eta$ be divisible by $p$, and prescribe any $c\in k$.
Take $x_0=N_G[c]$. Deck equivariance gives $Lx_0=N_G\beta$;
its reduction $f\Phi(\bar x_0)=0$ gives $\beta\bmod p=0$.
The residual $N_G(\eta-\beta)$ starts in weight $D+p-1$.
The constructive absorption in Section2 cancels it with a source
starting in weight $D+p-1-a>D$: each next cancellation has strictly
higher weight. Adding that correction to $x_0$ solves the equation
and preserves its leading coefficient $cN_G$. This proves sufficiency
and exhausts the reduction set without any coefficient commutation.

## 4. The critical projective coefficient extraction

Multiplication $q\Phi$ from weight $D-1$ to weight $D+a-1$ is
injective below the norm kernel and surjective above the augmented
cokernel. The target weight is $a-1$ modulo $p-1$, hence has no
constant term. Both critical weights are below the truncation weight
$(p-1)(r+1)$, so use their unique homogeneous lifts to $A$ before
setting $\tau=-1$. This identifies the two spaces with the
scaling-character $-1$ and $a-1$ functions on nonzero
$\mathbf F_p^r$ vectors; each has dimension $(p^r-1)/(p-1)$.

For the preimage $H$, specialization at $\tau=-1$ leaves normal
monomials of degrees $D-1,D-p,\ldots$, all congruent to $-1$.
In the sum over all $v\in\mathbf F_p^r$, multiplying by $v_i$
selects only $E_i^{p-2}\prod_{j\ne i}E_j^{p-1}$:
each exponent must be positive and divisible by $p-1$, and the
total degree is at most $D$. Its vector sum is $(-1)^r$.
Dividing into projective orbits divides by $p-1=-1$ in $k$,
so the factor $(-1)^{r+1}$ restores coefficient one.
For the graded preimage under $q\Phi$, substitute
$(\Phi H)(-1,v)=Z(-1,v)/q(v)$, then undo coefficient Frobenius.
This is precisely the stated detector, including its sign and order
of operations.

All detectors vanish exactly when the critical source has no
$\tau^0$ coefficient, hence is divisible by $p$.
Lift it, subtract its actual $L$-image and absorb the remaining
higher-weight tail by Section2. Conversely a source in
$p\Lambda+\mathcal W^D$ whose image has weight at least $D+a-1$
cannot start below $D-1$, because its principal image would be
nonzero there. Its critical preimage has no $\tau^0$ part, giving
the reverse implication. This proves the exact image criterion.

## 5. Scope and original evidence

At $p=5,a=2$ the formulas recover all old rank-three thresholds
and signed detectors, together with the entire arbitrary-rank extension.
The original returned93 checks,19 weighted degrees and636 rank-two/four
extractions remain in the
[original audit](../../../Research/audits/RANK125_WEIGHTED_REDUCTION_AUDIT_2026_09_13.md);
they are provenance, not the proof of the larger scope.
The [new focused review](../../../Research/audits/WEIGHTED_CARRY_GENERAL_PRINCIPAL_SYMBOL_AUDIT_2026_10_03.md)
checks the general grading and exact image statement without numerical replay.

For a geometric equation $Lx+R=0$, the theorem applies only after
bounding and testing the WHOLE nonlinear residual.
The [compatible quadratic channel](fourth_hodge_quadratic_channel.md)
does not by itself supply these inputs.
