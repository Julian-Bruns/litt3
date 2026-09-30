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

## 2. The centralizer, independent of the odd covering degree

Because $A$ has odd order, its action on two-adic cohomology has
the free-cover character
\[
H^1_{\rm et}(C,\mathbf F_2)
\simeq \mathbf F_2^{\,2}\oplus\mathbf F_2[A]^{\,2}.
\tag{6}
\]
As in the small-odd-part proof, obtain this first from the
two-adic free-action Lefschetz character and then reduce an
integral lattice. Maschke applies at two, even if $5\mid|A|$.
The original covering maps are etale, so every nonidentity deck
element has empty fixed locus.

For abelian $A$, its group algebra is a product of finite fields.
A character of order $d$ has residue orbit degree
$f=\operatorname{ord}_d(2)$. On a nontrivial field factor
$\mathbf F_{2^f}$, the module (6) has multiplicity TWO.
Since all deck transformations are defined over the current
field, Frobenius commutes with this action. It therefore acts
through $\operatorname{GL}_2(\mathbf F_{2^f})$ on that factor
and through $\operatorname{GL}_4(\mathbf F_2)$ on the trivial
factor.

If $d\mid n$, then $f\mid\operatorname{ord}_n(2)$.
The condition $9\nmid\operatorname{ord}_n(2)$ gives
\[
\operatorname{ord}_{19}(2^f)
=18/\gcd(18,f)>2.
\]
Thus neither $2^f-1$ nor $2^{2f}-1$ is divisible by nineteen.
Every indicated centralizer group has order prime to nineteen,
and so does the actual Frobenius on $J(C)[2]$.

The pro-two test applies to $W\to C$. It rules out the fixed
$J(X)$ factor in $J(W)$, whereas the original $X$-leg still
gives an actual map $W\to X$. This proves the contradiction.
Both covering degrees can grow arbitrarily; the multiplicity
two in (6) depends on the genus-two BASE, not on the genus of $C$.

For the exponents in (3), use
\[
\operatorname{ord}_3(2)=2,\ 
\operatorname{ord}_5(2)=4,\ 
\operatorname{ord}_7(2)=3,\ 
\operatorname{ord}_{11}(2)=10,\ 
\operatorname{ord}_{13}(2)=12,\ 
\operatorname{ord}_{17}(2)=8.
\]
Increasing a prime-power exponent only multiplies these orders
by powers of that prime. The three-primary exponent is at most
two, so the order at that factor divides six. The least common
multiple of all resulting orders is not divisible by nine.
All six primes avoid $0,\pm1$ modulo nineteen.

## 3. Nonabelian odd deck groups

Formula(6) holds for any finite odd group $A$. For a simple
factor $M_e(\mathbf F_{2^f})$ in its group algebra, the regular
module contains its simple module with multiplicity $e$.
Thus the nontrivial part in (6) has multiplicity $2e$ and its
centralizer is $\operatorname{GL}_{2e}(\mathbf F_{2^f})$.
The prime nineteen divides this order exactly when
$\operatorname{ord}_{19}(2^f)\le2e$. This proves criterion(4)
once the constant-deck model over a prime-to-nineteen field
has been obtained.

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
