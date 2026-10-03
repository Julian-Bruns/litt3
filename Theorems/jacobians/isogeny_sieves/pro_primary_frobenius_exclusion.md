# Frobenius exclusions for prime-primary common-cover monodromy

Version3,3 October2026. Let $X/\mathbf F_{25}$ be the fixed
genus-nine curve, and put $A=J(X)$. Let $Y/\mathbf F_{25^b}$ be a
smooth proper geometrically connected curve with $1\le g(Y)\le8$.
If $19\nmid b$, then EVERY connected finite etale geometric cover
$T\to Y$ whose Galois closure has a TWO-GROUP as its group satisfies
\[
\boxed{\operatorname{Hom}_{\overline{\mathbf F}_5}(J(T),A)=0.}
\tag{1}
\]
In particular $T$ has no nonconstant separable map to $X$.
There is no bound on the covering degree, the exponent or the derived
length of its Galois group. The original cover need not be Galois.

Consequently neither selected genus-two partner has an actual common
finite etale span with the fixed $X$ whose genus-two leg has two-group
Galois closure. For the backup one uses $\mathbf F_{25^3}$; for the
main partner one uses $\mathbf F_{25^r}$, where the chosen prime
$r$ is larger than the recorded bound and is not nineteen.
Both original maps are retained in this consequence. It does not
exclude arbitrary mixed-prime Galois groups or solve either unrestricted
common-cover problem.

## A general pro-primary arithmetic test

Let $C/\mathbf F_q$ be a smooth proper geometrically connected curve,
let $\ell$ be ANY prime, and let
$m$ be the order of Frobenius on $J(C)[\ell](\overline{\mathbf F}_q)$
(the étale torsion, including when $\ell=\operatorname{char}(\mathbf F_q)$).
For a zero-dimensional torsion space take $m=1$. Every geometric
connected etale cover $T\to C$ with $\ell$-group Galois closure has
a model over $\mathbf F_{q^{m\ell^a}}$, for some $a\ge0$, whose
Jacobian has rational étale $\ell$-torsion over that SAME field.
For $\ell\ne\operatorname{char}(\mathbf F_q)$ this is the full torsion.
Neither the given cover nor any map out of it is assumed to descend
over the initial field.

Suppose an abelian variety $A_0/\mathbf F_q$ is a geometric isogeny
factor of $J(T)$, and let $\pi$ be any Frobenius eigenvalue of $A_0$.
Put $K=\mathbf Q(\pi)$, or any number field containing $\pi$.
At every reduction for which $\pi$ is an $\ell$-adic UNIT one has
\[
\boxed{\overline\pi^{\,m}\in\overline{\mu(K)}.}
\tag{2}
\]
Here $\mu(K)$ is the finite group of roots of unity in $K$ and the
bars mean reduction in $\overline{\mathbf F}_\ell$.
In particular, if $o$ is the order of $\overline\pi$ and $w$ is
the prime-to-$\ell$ part of $|\mu(K)|$, then $o\mid mw$.
The reduction of the prime-to-$\ell$ part of a root of unity is
injective; root-of-unity twists from outside $K$ cannot bypass (2).
For $\ell\ne\operatorname{char}(\mathbf F_q)$ every eigenvalue is a
unit. At the characteristic prime this assertion concerns only the
unit roots; positive-slope eigenvalues supply no such test.

For the fixed $X$, the existing exact Frobenius calculation gives
\[
[K:\mathbf Q]=18,\qquad \mu(K)=\mu_6,\qquad
\operatorname{ord}(\overline\pi_{25})=171=9\cdot19.
\tag{3}
\]
Thus a more precise necessary condition for a two-group cover over
$\mathbf F_{25^b}$ is $57\mid bm$. If all two-torsion of $J(Y)$
is rational over that field, this reads $57\mid b$. The selected
partners both have rational Weierstrass points over their chosen
fields, although the stronger low-genus exclusion (1) does not need
that additional fact.

## Reverse-direction exclusions for the backup

Let $Y_0/\mathbf F_{125}$ be the fixed genus-two backup. For every
prime
\[
\ell\in\{7,11,13,17,19,23,31\},
\]
EVERY connected finite etale geometric cover $T\to X$ with
$\ell$-group Galois closure satisfies
\[
\operatorname{Hom}_{k}(J(T),J(Y_0))=0.
\tag{4}
\]
In particular no such cover admits a nonconstant separable map to
$Y_0$. Hence these are also excluded Galois-closure groups for the
ORIGINAL X-leg of a backup span, with no degree bound and without
requiring that leg to be Galois. The condition is on monodromy, not
merely on the prime factors of its degree.

This uses the same test(2), now with the genus-nine curve as the
base, the geometric factor $J(Y_0)$ as target, and its roots of
unity $\mu_2$. The seven exclusions require only polynomial-power witnesses:
a valid exponent bound on the base's semisimple Frobenius order and
failure of the corresponding target annihilation. Exact root orders
and factorization are unnecessary. The historical tested primes2,3,29
do not give a reverse exclusion by this test; no assertion about
untested primes or the main partner is made in(4).

[Proof](../../../Proofs/jacobians/isogeny_sieves/pro_primary_frobenius_exclusion.md).
