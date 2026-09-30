# Proof: Frobenius in a pro-primary etale tower

The crucial point is arithmetic descent of the COVER, not a presumed
field of definition for its other endpoint map. All curves and
Jacobians in the final exclusion are the actual geometric ones.

## 1. The automorphisms invisible on the Frattini quotient

Let $P$ be a finitely generated pro-$\ell$ group. The kernel of
\[
\operatorname{Aut}(P)\longrightarrow
\operatorname{Aut}(P/\Phi(P))
\]
is pro-$\ell$, where $\Phi(P)=\overline{P^\ell[P,P]}$.
For completeness, in a finite $\ell$-group the kernel acts freely
on the set of lifts of a fixed basis of the Frattini quotient.
Every such tuple generates, by the Burnside basis theorem, so its
stabilizer is trivial. That set has $\ell$-power cardinality, and
the kernel therefore has $\ell$-power order. Apply this to a cofinal
system of characteristic finite quotients of $P$. The image of
$\Phi(P)$ is the Frattini subgroup of each quotient, so the inverse
limit proves the claim. This is also the standard pro-primary
automorphism theorem recorded in
[Reid, Theorem1.3.11(ii)](https://maths.qmul.ac.uk/~raw/cdr_thesis.pdf).

## 2. Models of covers and rational torsion

The prime-primary bound for the field of a COVER was already proved
by central embedding problems in
[solvable atlas Frobenius periods](solvable_atlas_frobenius_periods.md),
Section2. The pointed argument here also controls the full torsion
of the covering Jacobian, which is needed for the geometric-factor
test below; the cover-model bound alone is not claimed as new.

First suppose $C/\mathbf F_q$ has a rational point and $J(C)[\ell]$
is rational. The point splits the arithmetic fundamental-group
sequence. Let $P$ be the geometric maximal pro-$\ell$ fundamental
group, and let $\varphi$ be the automorphism supplied by Frobenius
and this splitting. The group $P$ is finitely generated. Its
Frattini quotient is dual to $H^1(C,\mathbf F_\ell)$, so $\varphi$
is the identity there. Section1 makes the closure of
$\langle\varphi\rangle$ a pro-$\ell$ group.

A chosen geometric point of a connected cover with $\ell$-group
Galois closure specifies an open subgroup $H\subset P$. Its orbit
under this compact pro-$\ell$ action has $\ell$-power length.
Thus $\varphi^{\ell^a}$ fixes $H$ for some $a$. The subgroup
$H\rtimes\operatorname{Gal}(\overline{\mathbf F}_q/
\mathbf F_{q^{\ell^a}})$ of the corresponding arithmetic group
constructs a model of $T\to C$ over that field, with the chosen
point above the base point rational. This uses the actual subgroup,
not just a Frobenius-invariant unpointed isomorphism class.

The geometric maximal pro-$\ell$ fundamental group of $T$ is $H$.
Indeed, any finite GALOIS $\ell$-group cover of $T$ has $\ell$-group Galois
closure over $C$: take conjugates over the finite $\ell$-group
closure of $T/C$ and then their compositum. The resulting group
is an extension of $\ell$-groups, equivalently a subgroup of an
iterated wreath product of $\ell$-groups. Thus no further pro-$\ell$
quotients of the geometric fundamental group of $T$ are missing.

The stabilizer of $H$ in $\overline{\langle\varphi\rangle}$ is
still pro-$\ell$. Its action on the finite group $H/\Phi(H)$ has
$\ell$-power image. A further $\ell$-power field extension kills
that action. Frobenius then acts trivially on $J(T)[\ell]$.

For general $C$, first make $J(C)[\ell]$ rational by an extension
of degree $m$, its Frobenius order. A rational point exists after
an additional $\ell$-power extension: the Weil bound is positive
over all sufficiently large fields. The preceding argument gives
the asserted field $\mathbf F_{q^{m\ell^a}}$. This establishes
the model and torsion claim without bounding $a$ or assuming any
original field of definition for $T$.

## 3. A geometric factor cannot conceal the residual eigenvalue

Let $B/\mathbf F_Q$ have rational full $\ell$-torsion, and suppose
$A_0/\mathbf F_Q$ is a geometric isogeny factor of $B$. Fix a
Frobenius eigenvalue $\pi$ of $A_0$. All required factor maps are
defined over a finite extension of degree $s$. The eigenvalues
over that extension are the $s$th powers of the original ones,
so some Frobenius eigenvalue $\alpha$ of $B$ satisfies
\[
\alpha^s=\pi^s,\qquad \alpha=\pi\zeta
\]
for a root of unity $\zeta$. This argument does not require the
factor itself to descend over $\mathbf F_Q$.

Fix an embedding into $\overline{\mathbf Q}_\ell$. Since
$B[\ell]$ is rational, the characteristic polynomial of its
Frobenius reduces to $(T-1)^{2\dim B}$. Therefore EVERY algebraic
conjugate of $\alpha$ reduces to one. For
$\sigma\in\operatorname{Gal}(\overline{\mathbf Q}/K)$, with
$\pi\in K$, it follows that
\[
\overline{\sigma\zeta/\zeta}
=\overline{\sigma\alpha/\alpha}=1.
\]
Reduction is injective on roots of unity of order prime to $\ell$.
Hence the prime-to-$\ell$ part $\zeta_{\ell'}$ is fixed by every
such $\sigma$, and belongs to $K$. The $\ell$-power part reduces
to one, giving
\[
\overline\pi=\overline{\zeta_{\ell'}^{-1}}
\in\overline{\mu(K)}.
\tag{4}
\]
This use of ALL conjugates is essential. The reduction of one
eigenvalue alone would allow an arbitrary cyclotomic twist and
would not prove the result.

Apply (4) over the field constructed in Section2, where the
eigenvalue of the original $A_0/\mathbf F_q$ is
$\pi^{m\ell^a}$. Raising to the $\ell^a$th power is an automorphism
of every finite subgroup of $\overline{\mathbf F}_\ell^\times$
and of $\overline{\mu(K)}$. Thus
$\overline\pi^{\,m}\in\overline{\mu(K)}$, proving the general test.

## 4. The fixed genus-nine eigenvalue

The established fixed-X arithmetic gives
$K=\mathbf Q(\pi_{25})$ and
$K\cap\mathbf Q^{\rm ab}=\mathbf Q(\zeta_3)$. Every root of unity
generates an abelian extension, so $\mu(K)=\mu_6$.
The already certified Frobenius polynomial reduces modulo two to
\[
T^{18}+T^{16}+T^{15}+T^{12}+T^{11}+T^9+T^7+T^6+T^3+T^2+1.
\tag{5}
\]
It is irreducible and its root has exact order $171=9\cdot19$.
These are the finite algebra checks in the existing
[exact orbit checker](../../../scripts/arithmetic/check_degree2_frobenius_orbits.py).
The order171 is on the TWO-TORSION VECTOR SPACE; the earlier
order57 is on the quotient set of $\mathbf F_4$-lines. They must
not be interchanged.

Over $\mathbf F_{25^b}$ the eigenvalue is $\pi_{25}^b$. Formula(2)
of the statement with $\ell=2$ forces
\[
171\mid3bm,\qquad\text{equivalently }57\mid bm.
\tag{6}
\]
If $g(Y)=h\le8$, its two-torsion has dimension $2h\le16$.
Since the order of two modulo nineteen is EIGHTEEN,
\[
19\nmid|\operatorname{GL}_{2h}(\mathbf F_2)|.
\]
Thus $19\nmid m$. If also $19\nmid b$, (6) is impossible.
The geometric simplicity of $A$ identifies a nonzero homomorphism
from $J(T)$ to $A$ with occurrence of $A$ as an isogeny factor,
proving(1). A nonconstant separable map $T\to X$ would supply
just such a homomorphism by pullback and norm.

Finally, in an original span $X\leftarrow Z\to Y$, take the
ACTUAL Galois closure of the $Y$-leg. If its group were a two-group,
the closure would still map to the original $X$ by the original
leg. Its Jacobian cannot contain $A$, a contradiction. No simultaneous
Galois closure of both legs is asserted. The backup is defined over
$\mathbf F_{125}\subset\mathbf F_{25^3}$; the main partner is
defined over $\mathbf F_{25^r}$ with its specified large prime
$r\ne19$. Both therefore satisfy the exclusion.

## 5. Reverse direction for the fixed backup

The [established backup arithmetic](../../curve_arithmetic/backup_curve_arithmetic.md)
gives Frobenius polynomial
\[
T^4-8T^3+182T^2-1000T+15625
\]
over F125. Its geometrically simple Jacobian has geometric
endomorphism field
\[
K_0=\mathbf Q(\sqrt{21},\sqrt{-25+\sqrt{21}}).
\]
Writing a=-25+sqrt21, its conjugate a' satisfies aa'=604,
which is not a square in Q(sqrt21). Thus the quartic is not Galois.
This quartic CM field has just one quadratic subfield,
the real field Q(sqrt21), and consequently has roots of unity
only plus or minus one. Indeed a root of unity of order greater
than two would either supply an imaginary quadratic subfield or
make K0 itself a quartic cyclotomic, hence Galois, field.

Use the common base F_(5^6). The relevant eigenvalues are the
cube of Frobenius25 on X and the square of Frobenius125 on Y0.
Let m0 be the SEMISIMPLE order on JX[ell]. The actual torsion
order is m0 times a power of ell. Since every nonzero residual
eigenvalue has order prime to ell, this extra power cannot affect
the divisibility test. Section3 would require every residual
target order o to divide 2m0.

Exact factorization of the two stated polynomials gives:

| ell | m0 on X over F_(5^6) | residual target orders | missing divisor of 2m0 |
|---|---:|---|---:|
| 7 | 274514 | 8 | 8 |
| 11 | 32478620 | 305 | 61 |
| 13 | 1608936 | 340 | 5 |
| 17 | 1094236464 | 16,144 | 9 |
| 19 | 5227320 | 543 | 181 |
| 23 | 12484359976 | 264 | 3 |
| 31 | 295834560 | 481 | 13 |

For example, at ell=7 the target order is8, whereas v2(2m0)=2.
All rows therefore contradict the necessary condition. Geometric
simplicity of JY0 proves(4) of the statement. Any actual second map
from T to Y0 would induce the forbidden geometric isogeny factor.
The field of that map is not assumed, and no model of both maps
over the torsion field is used.

The [bounded exact probe](../../../scripts/arithmetic/probe_pro_primary_residues.py)
computes irreducible factor degrees and multiplicative root orders
in their finite residue fields, retaining repeated factors for
the unipotent-order distinction. The
[executed data](../../../../litt3-computation-data/pro_primary_frobenius_20260921/residue_probe.json)
also contain the non-excluding reverse rows2,3,29. Only the displayed
seven positive rows are asserted as reverse exclusions here.
An [independent standard-library checker](../../../scripts/arithmetic/verify_reverse_pro_primary.py)
avoids factorization entirely: it verifies that the squarefree X
polynomial divides T^(3m0)-1, while the squarefree target polynomial
does NOT divide T^(4m0)-1. Its seven
[executed witnesses](../../../../litt3-computation-data/pro_primary_frobenius_20260921/reverse_independent_check.txt)
all pass. These divisibility tests alone suffice for the exclusion.

## Boundary of the argument

This is a restriction on PRIME-POWER MONODROMY, not prime-power
degree. A non-Galois cover of two-power degree may have a much
larger mixed-prime Galois closure. Nor is the kernel of an action
on an arbitrary finite group's abelianization necessarily a
two-group. Replacing the pro-two fundamental group by the whole
fundamental group would destroy Section1. The theorem gives no
unrestricted common-cover verdict.
