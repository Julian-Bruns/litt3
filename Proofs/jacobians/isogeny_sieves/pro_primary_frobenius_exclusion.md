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
This is the standard Frattini automorphism theorem:
[Reid, Theorem1.3.11(ii)](https://maths.qmul.ac.uk/~raw/cdr_thesis.pdf#page=17).
It applies to the closed kernel in the natural profinite topology on
$\operatorname{Aut}(P)$. In particular any closed Frobenius subgroup
acting trivially on $P/\Phi(P)$ is pro-$\ell$.

## 2. Models of covers and rational torsion

The prime-primary bound for the field of a COVER was already proved
by central embedding problems in
[solvable atlas Frobenius periods](solvable_atlas_frobenius_periods.md),
Section2. The pointed argument here also controls the full torsion
of the covering Jacobian, which is needed for the geometric-factor
test below; the cover-model bound alone is not claimed as new.

First suppose $C/\mathbf F_q$ has a rational point and its geometric étale
$\ell$-torsion is rational. The point splits the arithmetic fundamental-group
sequence. Let $P$ be the geometric maximal pro-$\ell$ fundamental
group, and let $\varphi$ be the automorphism supplied by Frobenius
and this splitting. The group $P$ is finitely generated. Its
Frattini quotient is dual to $H^1(C,\mathbf F_\ell)$, so $\varphi$
is the identity there. When $\ell$ is the characteristic, use the
étale torsion: the [Artin–Schreier sequence](https://stacks.math.columbia.edu/tag/0A3J)
identifies $H^1(C,\mathbf F_\ell)$ with the Frobenius-fixed vectors
in $H^1(C,\mathcal O_C)$, so it is finite-dimensional and its dimension
is the $\ell$-rank. Thus the same finite-generation and Frattini argument
applies. Section1 makes the closure of
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
that action. Frobenius then acts trivially on $J(T)[\ell](\overline{\mathbf F}_q)$.
These are all the torsion points, without asserting rationality of a
connected torsion group scheme at the characteristic prime.

For general $C$, first make $J(C)[\ell]$ rational by an extension
of degree $m$, its Frobenius order. A rational point exists after
an additional $\ell$-power extension: the Weil bound is positive
over all sufficiently large fields. The preceding argument gives
the asserted field $\mathbf F_{q^{m\ell^a}}$. This establishes
the model and torsion claim without bounding $a$ or assuming any
original field of definition for $T$.

## 3. A geometric factor cannot conceal the residual eigenvalue

Let $B/\mathbf F_Q$ have rational étale $\ell$-torsion, and suppose
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

Fix an embedding into $\overline{\mathbf Q}_\ell$ at which $\pi$ is a
unit. Every unit eigenvalue of $B$ reduces to one: when $\ell$ is not
the characteristic this follows from the full Tate module; otherwise
these are exactly the eigenvalues on its étale $\ell$-adic Tate module.
For every $\sigma\in\operatorname{Gal}(\overline{\mathbf Q}/K)$, with
$\pi\in K$, the conjugate $\sigma\alpha=\pi\,\sigma\zeta$ is still a
UNIT eigenvalue of $B$, even if other conjugates have positive slope.
It follows that
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
The conjugates FIXING $K$ are the necessary ones. Their unit property
is automatic because they fix $\pi$. The reduction of one eigenvalue
alone would allow an arbitrary cyclotomic twist and would not prove
the result.

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

Use the common base $\mathbf F_{5^6}$, with Frobenius powers THREE
on $X$ and TWO on $Y_0$. Let $P_X,P_0$ be their original Weil
polynomials over $\mathbf F_{25},\mathbf F_{125}$, and let
$\overline P^{\rm red}$ denote the squarefree polynomial with the
same residual roots. For any integer $M$ prime to $\ell$, the two
checks
\[
\overline P_X^{\rm red}\mid T^{3M}-1,\qquad
\overline P_0^{\rm red}\nmid T^{4M}-1
\tag{7}
\]
already exclude the geometric factor. Indeed the semisimple order
$m_0$ of $X$ over the common base divides $M$. Its full torsion
order is $m_0$ times an $\ell$-power, which disappears from the
residual test. Formula(2) and $\mu(K_0)=\mu_2$ would force every
target root $\beta$ to satisfy $\beta^{4m_0}=1$, hence
$\beta^{4M}=1$, contradicting(7). No exact order is required.

The following SEVEN upper bounds satisfy(7):
\[
\begin{array}{c|rrrrrrr}
\ell&7&11&13&17&19&23&31\\\hline
M&274514&32478620&1608936&1094236464&
5227320&12484359976&295834560.
\end{array}
\]
They are the inputs of the
[polynomial-power checker](../../../scripts/arithmetic/verify_reverse_pro_primary.py);
its [executed witnesses](../../../../litt3-computation-data/pro_primary_frobenius_20260921/reverse_independent_check.txt)
prove base annihilation and target NONannihilation by modular
polynomial multiplication. The checker additionally verifies that the
base reductions are squarefree; the target has degree four less than
every tested prime, so dividing by its derivative gcd retains every
root. Thus this verification needs neither factorization nor a finite
extension-field or multiplicative-order algorithm.

Geometric simplicity of $J(Y_0)$ now proves(4). An actual map
$T\to Y_0$ would induce the forbidden geometric factor, even if that
map is defined over a later field. The original
[factorization receipt](../../../../litt3-computation-data/pro_primary_frobenius_20260921/residue_probe.json)
remains discovery evidence for these $M$ and for the nonexcluding
tested rows2,3,29; its now-unused source probe is deleted.

## Boundary of the argument

This is a restriction on PRIME-POWER MONODROMY, not prime-power
degree. A non-Galois cover of two-power degree may have a much
larger mixed-prime Galois closure. Nor is the kernel of an action
on an arbitrary finite group's abelianization necessarily a
two-group. Replacing the pro-two fundamental group by the whole
fundamental group would destroy Section1. The theorem gives no
unrestricted common-cover verdict.
