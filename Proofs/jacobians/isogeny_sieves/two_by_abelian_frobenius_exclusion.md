# Proof: the multiplicity-two centralizer on an odd cover

Use the [pro-primary Frobenius test](pro_primary_frobenius_exclusion.md).
For the fixed $J(X)$, residual two-adic Frobenius has order171,
while the residual roots of unity in its field have order three.
Hence a curve over $\mathbf F_{25^c}$ with $19\nmid c$ and
two-torsion Frobenius order prime to nineteen cannot have a
two-group-monodromy cover whose Jacobian contains $J(X)$.

## 1. Descending the actual odd abelian cover

In (2) let $W$ be the actual Galois closure of the $Y$-leg, and
put $C=W/P$. The map $C\to Y$ is the actual abelian $A$-cover.
A rational point of $Y$ exists over the current field: for
$q=25^b$, the genus-two Weil lower bound $q+1-4\sqrt q$ is
positive. It splits the arithmetic fundamental-group sequence.

A geometric abelian quotient of exponent dividing $n$ factors
through the dual of $H^1_{\rm et}(Y,\mathbf Z/n)$. Killing the
Frobenius action on this finite module therefore descends its
actual defining subgroup and its entire quotient action. We
obtain a model of $C\to Y$ with all $A$-deck transformations
defined. In particular this is not just a field-of-moduli claim.

We check that the necessary field degree is prime to nineteen.
For a prime power $\lambda^a\mid n$ with $\lambda\ne5$, the
torsion action is the dual of the four-dimensional Tate-module
action of the principally polarized Jacobian. It lies in a
symplectic similitude group over $\mathbf Z/\lambda^a$.
The reduction kernel is a $\lambda$-group, and
\[
|\operatorname{GSp}_4(\mathbf F_\lambda)|
=\lambda^4(\lambda-1)(\lambda^2-1)(\lambda^4-1).
\tag{5}
\]
Since the multiplicative group modulo nineteen has order eighteen,
a prime $\lambda\not\equiv0,\pm1\pmod {19}$ makes (5), and
the reduction kernel, prime to nineteen.

For $\lambda=5$, use the ETale Tate module instead. It is free
of rank equal to the p-rank, at most two. Its action modulo
$5^a$ lies in $\operatorname{GL}_f(\mathbf Z/5^a)$, $f\le2$.
These group orders are prime to nineteen since
$\operatorname{ord}_{19}(5)=9$. No assertion about rationality
of the connected five-torsion is needed. The same reasoning
also works if the p-rank is zero, when that character factor
is absent.

Chinese remaindering now proves that the full character action
has order prime to nineteen. Thus $C/Y$ with its specified deck
group descends over $\mathbf F_{25^c}$ with $19\nmid c$.

## 2. One centralizer test, also for even normal closures

Let D->Y be an actual finite etale Galois cover with group Q,
all deck transformations defined over the current field. For any
ell!=5 the [free-action character](etale_endomorphism_packets.md#1-free-action-and-one-rational-packet)
gives
\[
H^1_{\rm et}(D,\mathbf Q_\ell)
\simeq\mathbf Q_\ell^{\,2}\oplus\mathbf Q_\ell[Q]^{\,2}.
\tag{6}
\]
This uses characteristic-zero cohomology, even when ell or five
divides |Q|. It depends on the genus-two BASE, not on g(D).

Suppose the nontrivial simple factors of Q_ell[Q] are split matrix
algebras M_e(E), with E a finite extension of Q_ell of residue
degree f. A simple module has E-dimension e and occurs e times in
the regular module. Thus its isotypic cohomology is V tensor_E E^(2e).
Frobenius commutes with Q and acts on the multiplicity space through
GL_(2e)(E); on the trivial part it acts through GL4(Q_ell).
For ell!=19, the sufficient tests
\[
\operatorname{ord}_{19}(\ell)>4,\qquad
\operatorname{ord}_{19}(\ell^f)>2e
\tag{7}
\]
make the corresponding residue groups prime to nineteen.

The integral passage is essential when ell divides |Q|. Every
eigenvalue of these Frobenius blocks is an ell-adic unit, because
D is a curve over a field of characteristic five. Each block's
characteristic polynomial is consequently in O_E[T], with unit
constant term. Cayley--Hamilton constructs a Frobenius-stable
O_E-lattice: from a basis take the span of its first 2e iterates.
The unit constant term also makes that lattice invariant under
inverse Frobenius. Its reduction lies in GL_(2e)(F_(ell^f)).
Thus (7) excludes nineteen from every residual eigenvalue order.
This conclusion is independent of the chosen lattice. The
unipotent part of the actual Frobenius on J(D)[ell] adds only
ell-power order.

For any H<=Q, rational pullback identifies H1(D/H,Q_ell) with the
H-invariants. Its Frobenius eigenvalues are therefore among those
just controlled. Their residual orders, and hence Frobenius on
J(D/H)[ell], remain prime to nineteen. We do not reduce an
H-projector modulo ell or assume integral semisimplicity when
ell divides |H|. At ell=2, (7) proves the even-normal-closure
criterion in the statement, followed by the pro-two test.

When ell does not divide |Q|, Maschke also permits integral
reduction of (6). Its Brauer character gives
H1(D,F_ell)=F_ell^2 plus two regular modules. A nontrivial residue
block M_e(F_(ell^f)) therefore has multiplicity 2e and centralizer
GL_(2e)(F_(ell^f)). Test (7) applies directly. At ell=2 and Q odd
this proves the original nonabelian criterion (4), without a
Schur-index assumption in characteristic zero.

Apply this first to the actual abelian A-cover C/Y from Section1.
Its nontrivial character of order d has e=1 and
f=ord_d(2), so the centralizer is GL2(F_(2^f)). For d|n,
f divides ord_n(2). The condition 9 not dividing ord_n(2) gives
ord_19(2^f)=18/gcd(18,f)>2. The trivial GL4(F2) part is also
prime to nineteen. Hence Frobenius on J(C)[2] has order prime
to nineteen.

The pro-two test for W->C excludes the fixed J(X) factor in J(W),
whereas W still has the ACTUAL original map to X. This proves
the contradiction with both covering degrees unrestricted.

For the exponents in (3), use
\[
\operatorname{ord}_3(2)=2,\quad
\operatorname{ord}_5(2)=4,\quad
\operatorname{ord}_7(2)=3,\quad
\operatorname{ord}_{11}(2)=10,\quad
\operatorname{ord}_{13}(2)=12,\quad
\operatorname{ord}_{17}(2)=8.
\]
Increasing a prime-power exponent only multiplies these orders
by powers of that prime. The three-primary exponent is at most
two, so its order divides six. Their lcm is not divisible by nine,
and all six primes avoid 0,+1,-1 modulo nineteen.

## 3. Obtaining the constant-deck model

For a $\lambda$-group, $\lambda\ne2,5$, with
$\lambda\not\equiv0,\pm1\pmod {19}$, the base torsion argument
from Section1 makes $J(Y)[\lambda]$ rational over an extension
of degree prime to nineteen. The pro-$\lambda$ Frattini model
argument then adds only $\lambda$-power degrees. When the
cover is Galois, the same pro-$\lambda$ action on its finite
deck quotient can also be killed by a $\lambda$-power extension.
For $\lambda=5$, the identical argument uses the geometric
maximal pro-five fundamental group and its Frattini quotient
dual to the etale five-characters, of rank at most two. This
last paragraph concerns cover descent; it does not use a
rational-full-five-torsion eigenvalue test.

For the exponent-three Heisenberg group of order27, the ordinary
complex characters have degrees one and three, and all values
are in $\mathbf Q(\zeta_3)$. Over $\mathbf F_2$ the nontrivial
character orbit degree is two. The same remains true after
taking products with elementary abelian three-groups. Thus
(4) reads $9>2$ or $9>6$, and holds.

## 4. A genuine family beyond the earlier exclusions

Let
\[
\mathsf H_8=(\mathbf Z/8)^2\times(\mathbf Z/8)^2\times\mathbf Z/8,
\quad(a,b,c)(a',b',c')=(a+a',b+b',c+c'+a\cdot b').
\]
It has order $8^5$, derived subgroup $C_8$, and a faithful
irreducible character of degree64. Four standard generators
$x_1,y_1,x_2,y_2^{-1}$ satisfy the genus-two surface relation
and generate the group. Consequently it occurs as a
prime-to-five etale Galois-cover group of every genus-two
curve in characteristic five.

Both selected partners are ordinary, by the established
[family two-cover calculation](../../../Theorems/jacobians/ordinary_covers/genus_two_maximal_two_cover.md)
and [backup arithmetic](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md),
so each also has a
connected cyclic etale cover of degree $5^a$ for every $a$.
The two covers have coprime degrees; their fiber product is
connected and has group $\mathsf H_8\times C_{5^a}$.
For $a\ge2$ its odd part is larger than nine and its derived
subgroup has order eight, so neither of the preceding new
group theorems excludes it. The older character-size criterion
also permits its faithful degree64 packet.
The present theorem excludes an actual map to $X$ from EVERY
such cover. This example verifies genuinely new unbounded odd
degree coverage, rather than only producing abstract groups.

## Boundary

General mixed-prime groups need not admit these two stages.
Even for abelian odd quotients, if a character degree $f$ is
divisible by nine, its multiplicity-two centralizer CAN have
an element of order nineteen. An arbitrary later odd-primary
stage can also introduce that arithmetic factor. Neither step
can be discarded or iterated without a new argument.
