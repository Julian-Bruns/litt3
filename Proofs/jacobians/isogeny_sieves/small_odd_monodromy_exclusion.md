# Proof: low-index Sylow quotients retain a Frobenius obstruction

We use the established
[pro-primary Frobenius test](pro_primary_frobenius_exclusion.md).
The fixed eigenvalue $\pi_{25}$ has residual order171 at two,
and its number field has only sixth roots of unity. Thus, over a
field $\mathbf F_{25^c}$ with $19\nmid c$, a base curve whose
two-torsion Frobenius has order prime to nineteen cannot have
a pro-two cover with the fixed $J(X)$ factor.

## 1. Odd degree at most nine

Suppose $C\to Y$ is defined over that field and has odd degree
$d\le9$. The pullback and norm on two-adic Tate modules compose
to multiplication by $d$. Since $d$ is odd, the projector
$d^{-1}q^*q_*$ is integral at two and commutes with Frobenius.
It splits $J(C)[2]$ into the pulled-back four-dimensional
$J(Y)[2]$ and a complement of dimension
\[
2g(C)-4=2d-2\le16.
\]
The order of two modulo nineteen is eighteen. Neither general
linear group of these two dimensions has order divisible by
nineteen. Frobenius on $J(C)[2]$ therefore has order prime to
nineteen, proving the intermediate assertion. For $d=9$ it is
essential to retain this splitting: the whole Jacobian has
dimension ten, so the earlier genus-at-most-eight shortcut alone
would not apply.

## 2. The actual Sylow quotient

Let $W\to Y$ be the actual Galois closure of the original leg and
let $P$ be a Sylow-two subgroup of $G$. Set
\[
d=[G:P]=|G|_{\rm odd},\qquad C=W/P.
\]
The map $W\to C$ is two-group Galois and $C\to Y$ has odd degree
$d$. We need a model of this specific $C/Y$ over a field with
exponent prime to nineteen; a model of the entire original span
is not needed or presumed.

Put $N=\bigcap_{g\in G}gPg^{-1}$ and $Q=G/N$. The curve
$D=W/N$ is the Galois closure of $C/Y$, with faithful transitive
degree-$d$ action by $Q$ and two-group point stabilizers. In
particular $O_2(Q)=1$: every normal two-subgroup has orbits of
two-power size, and transitivity makes that size divide the odd
integer $d$, so it fixes every point.

For $d=\ell\in\{3,5,7\}$, Burnside's two-prime theorem makes $Q$
solvable. A solvable primitive group of prime degree has a regular
normal $C_\ell$ and embeds in its affine group. Consequently
\[
Q=C_\ell\rtimes H,\qquad H=C_{2^e},\quad 2^e\mid\ell-1.
\tag{2}
\]
One can see the affine assertion directly: a minimal normal subgroup
of a solvable primitive group is elementary abelian and transitive;
being abelian and transitive it is regular, hence here has order
$\ell$. A point stabilizer acts faithfully by its automorphisms.
This is the standard affine case of the primitive-group theorem;
see [Hulpke, ChapterII](https://www.math.colostate.edu/~hulpke/lectures/m676cgt/hulpkenotes.pdf).

For $d=9$, the group $Q$ is again solvable, and its Fitting subgroup
is a three-group because $O_2(Q)=1$. It is nontrivial. If it had
order three, the solvable Fitting centralizer theorem
$C_Q(F(Q))\subset F(Q)$ would embed $Q/F(Q)$ into
$\operatorname{Aut}(C_3)=C_2$, contradicting $9\mid|Q|$.
Therefore it has order nine. Any such group is abelian, so it
contains its own centralizer and the same theorem makes the
quotient act faithfully. Its normal orbits cannot have size three:
a point stabilizer is a two-group and has trivial intersection
with this order-nine subgroup. It is regular. Schur--Zassenhaus
now gives
\[
Q=A\rtimes H,\quad
A=C_9\text{ or }C_3^2,\quad
H\subset\operatorname{Aut}(A)\text{ a two-group}.
\tag{3}
\]
Here $|H|\le2$ for $A=C_9$, and $|H|\le16$ for $A=C_3^2$.

The Fitting centralizer theorem used here is the standard finite
SOLVABLE-group statement; see
[Boston's group-theory notes](https://people.math.wisc.edu/~nboston/notes3.pdf).
It is not being applied to an arbitrary nonsolvable group.

Thus in every case $B=D/A\to Y$ is two-group Galois. By the
pro-two model argument, after an extension whose degree is prime
to nineteen it has a model with all its deck transformations
defined. Indeed, first kill the two-torsion Frobenius of $Y$
(its order is prime to nineteen), then the pro-two Frattini
argument gives only additional powers of two, including for the
finite deck action.

It remains to descend the actual abelian odd-order cover $D/B$.

## 3. The cases three, five and seven

For $d=3$, equation(2) gives $g(B)\le3$. Frobenius on
$H^1_{\rm et}(B,\mathbf F_3)$ belongs to a general linear group
of dimension at most six. Since $\operatorname{ord}_{19}(3)=18$,
its order is prime to nineteen. After killing that action, the
given pointed $C_3$-cover descends. This follows directly by
stabilizing its defining character of the geometric fundamental
group.

For $d=5$, one has $g(B)\le5$. The defining etale characters lie
in $H^1_{\rm et}(B,\mathbf F_5)$, whose dimension is the p-rank,
at most five. Since $\operatorname{ord}_{19}(5)=9$, its Frobenius
order is again prime to nineteen. The same character descent
works in characteristic five; no prime-to-five specialization
and no rationality of the connected five-torsion are used.

For $d=7$, the intermediate cover $B/Y$ has degree one or two.
For a double cover, its deck involution splits $J(B)[7]$ over
the current field into $J(Y)[7]$ and the two-dimensional elliptic
Prym part. Frobenius on the first factor lies in
$\operatorname{GSp}_4(\mathbf F_7)$ and on the second in
$\operatorname{GL}_2(\mathbf F_7)$. Neither group order is
divisible by nineteen:
\[
|\operatorname{GSp}_4(\mathbf F_7)|
=7^4(7-1)(7^2-1)(7^4-1),\qquad
|\operatorname{GL}_2(\mathbf F_7)|=(7^2-1)(7^2-7).
\]
The degree-one case uses only the first group. This splitting is
necessary: $\operatorname{GL}_6(\mathbf F_7)$ itself DOES contain
elements of order nineteen. Killing the actual torsion action
again descends the specified $C_7$-cover over an extension of
degree prime to nineteen.

A rational point for the pointed constructions can always be
obtained over an additional power of the relevant prime, by the
Weil bound. All field extensions in this section remain prime
to nineteen.

## 4. The order-nine case

Now $B\to Y$ has two-group Galois group $H$ of order at most sixteen,
with all deck maps defined over the current field. The semisimple
$\mathbf F_3[H]$-module on its first cohomology has the free-cover
character
\[
H^1_{\rm et}(B,\mathbf F_3)
\simeq \mathbf F_3^{\,2}\oplus\mathbf F_3[H]^{\,2}.
\tag{4}
\]
This is the usual free-action Lefschetz character on three-adic
cohomology: a nonidentity deck element has trace two, while the
dimension is $2+2|H|$. Reduce its integral Tate-module lattice.
Since $3\nmid|H|$, the semisimple residue representation has the
same Brauer character and yields (4). Traces merely reduced modulo
three would not determine the multiplicities used here.

Every absolutely irreducible character of a group of order at
most sixteen has degree $c=1$ or $2$. Indeed its degree is a
power of two, and degree four would already use all sixteen
dimensions in the sum of squared degrees, leaving no trivial
character. Its character orbit over $\mathbf F_3$ has length
$f$ a power of two: the character values are in a field generated
by roots of unity of two-power order. Finite fields have no
Schur-index obstruction.

For a nontrivial simple factor $M_c(\mathbf F_{3^f})$ in the
group algebra, (4) consequently gives multiplicity $2c\le4$.
A Frobenius commuting with $H$ acts there through
$\operatorname{GL}_{2c}(\mathbf F_{3^f})$; on the trivial factor
it acts through $\operatorname{GL}_4(\mathbf F_3)$. Since
\[
\operatorname{ord}_{19}(3^f)=18/\gcd(18,f)\in\{9,18\},
\]
all these centralizer groups have order prime to nineteen.
Therefore Frobenius on $J(B)[3]$ has order prime to nineteen.

The pro-three model argument now descends the actual $A$-cover
$D/B$, where $|A|=9$, over an extension of degree prime to nineteen.
Equivalently, for $A=C_9$ one can kill Frobenius on nine-torsion:
the additional kernel from level three to level nine is a
three-group. The two descriptions retain the actual covering
subgroup.

## 5. Descending the quotient and finishing

We now have a model of $D\to B\to Y$ over a field of exponent
prime to nineteen. Its geometric $Q$-deck action can be made
rational over another such extension. To check this last point,
the abelian subgroup $A$ in (2) or (3) is the characteristic
Fitting subgroup. An automorphism of $Q$ restricts to an
automorphism of $A$ and induces one of $H=Q/A$. The kernel of
these two actions injects into the finite group of cocycles
$Z^1(H,A)$, whose order divides a power of $|A|$. None of
\[
|\operatorname{Aut}(A)|,\quad |\operatorname{Aut}(H)|,\quad |A|
\]
is divisible by nineteen. For $A$ of order nine, $H$ has order
at most sixteen and its Frattini automorphism test bounds the
odd part of $\operatorname{Aut}(H)$ by
$|\operatorname{GL}_4(\mathbf F_2)|$, also prime to nineteen.
The prime-order cases are smaller. Thus
$19\nmid|\operatorname{Aut}(Q)|$.

After killing this finite arithmetic deck action, quotienting
by the specified point stabilizer produces a model of the
ACTUAL $C=W/P\to Y$ over a field with exponent prime to nineteen.
Section1 and the pro-two test exclude $J(X)$ from the Jacobian
of $W$, since $W\to C$ is two-group Galois. But $W$ still has
the map to the original $X$. This is the contradiction.

The case $d=1$ is the previously proved pro-two theorem. No
classification of groups with larger odd part and no bound
on the original source degree is asserted.
