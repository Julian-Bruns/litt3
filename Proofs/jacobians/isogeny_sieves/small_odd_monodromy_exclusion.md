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

For $d=\ell\in\{3,5,7,11\}$, Burnside's two-prime theorem makes $Q$
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
with this order-nine subgroup. It is regular. Its point stabilizer is a complement, giving
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

## 3. Prime odd index

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

For d=7 or11, the intermediate cover B/Y has degree one or
two. At ell=d, the odd-coefficient pull-norm projector splits
J(B)[ell] into J(Y)[ell] and, for a double cover, a rank-two
elliptic Prym part. Frobenius acts respectively through
GSp4(F_ell) and GL2(F_ell). Since ord_19(ell)=3, neither group
order is divisible by nineteen: their cyclotomic factors use
only exponents1,2,4. The degree-one case uses only GSp4.
The splitting is essential, because GL6(F_ell) DOES have an
element of order nineteen. Killing this actual torsion action
descends the specified C_ell-cover over an extension of degree
prime to nineteen.

A rational point for the pointed constructions can always be
obtained over an additional power of the relevant prime, by the
Weil bound. All field extensions in this section remain prime
to nineteen.

## 4. The order-nine case

Now B->Y has two-group Galois group H of order at most sixteen,
with all deck maps defined over the current field. Every absolute
irreducible character of H has degree e=1 or2: its degree is a
power of two, and degree four would exhaust the sum of squared
degrees, leaving no trivial character. Its character orbit over
F3 has degree f a power of two, since the character values are
generated by roots of unity of two-power order.

Because 3 does not divide |H|, apply the semisimple residue
case of the [centralizer test](two_by_abelian_frobenius_exclusion.md#2-one-centralizer-test-also-for-even-normal-closures)
at ell=3 to this ACTUAL H-cover of the genus-two Y. Its
free-cover Brauer character gives multiplicity 2e<=4 on each
nontrivial block M_e(F_(3^f)), and dimension four on the trivial
block. Since
\[
\operatorname{ord}_{19}(3^f)=18/\gcd(18,f)\in\{9,18\},
\]
Frobenius on J(B)[3] has order prime to nineteen. This uses the
characteristic-zero free-cover character, rather than traces
merely reduced modulo three.

The pro-three model argument now descends the actual $A$-cover
$D/B$, where $|A|=9$, over an extension of degree prime to nineteen.
Equivalently, for $A=C_9$ one can kill Frobenius on nine-torsion:
the additional kernel from level three to level nine is a
three-group. The two descriptions retain the actual covering
subgroup.

## 5. Descending the actual quotient

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
For d<=9, Section1 already gives its required two-torsion order.

## 6. The degree-eleven quotient

At d=11 the faithful closure group is C11 or D22, now with all
deck maps defined over a field whose exponent is prime to nineteen.
The degree-four plus degree-twenty pull-norm splitting alone would
not suffice; its large block can have order nineteen.

Instead let L=Q2(zeta11). Because ord_11(2)=10, L/Q2 is unramified
of degree ten. Inversion is its order-two automorphism, namely
Frobenius^5, so its fixed field E is unramified of degree five.
The group algebras are
\[
\mathbf Q_2[C_{11}]=\mathbf Q_2\times L,\qquad
\mathbf Q_2[D_{22}]=\mathbf Q_2\times\mathbf Q_2\times M_2(E).
\]
The two scalar factors in the second formula are the trivial
and sign characters. The matrix factor is explicit: multiplication
by zeta11 and field inversion act on the two-dimensional E-space L.
Their algebra is M2(E), and dimensions2+4*5=22 account for the
whole group algebra.

The [rational centralizer criterion](two_by_abelian_frobenius_exclusion.md#2-one-centralizer-test-also-for-even-normal-closures)
therefore bounds Frobenius on the nontrivial multiplicity spaces by
GL2(F_(2^10)) in the cyclic case, and GL2(F2), GL4(F_(2^5)) in the
dihedral case. These orders are prime to nineteen because
ord_19(2^10)=9>2 and ord_19(2^5)=18>4. The trivial GL4(F2) block
is also prime to nineteen. Its stable-lattice argument applies
even though two divides |D22|; no characteristic-two
semisimplicity or integral involution projector is used.
Thus Frobenius on the ACTUAL C=D/H has order prime to nineteen.

## 7. Both original maps give the contradiction

The pro-two test excludes $J(X)$ from the Jacobian
of $W$, since $W\to C$ is two-group Galois. But $W$ still has
the map to the original $X$. This is the contradiction.

The case $d=1$ is the previously proved pro-two theorem. No
classification of groups with odd part at least thirteen and no bound
on the original source degree is asserted.
