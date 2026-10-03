# Proof: the ordinary genus-two character presentation

[Statement](../../Theorems/shared_tensors/finite_local_relation_kernel_counterexample.md).
2 October2026. No computation or classification of the chosen genus-two
family is needed.

## The local coefficient presentation is surjective and minimal

Ordinariness gives $\operatorname{Pic}(C)[5](k)\simeq\mathbf F_5^2$.
Each line A in that group has $F^*A\simeq O_Y$. Adjunction of a
chosen trivialization gives $A\to F_*O_Y$. Choose the trivializations
multiplicatively on two generators. The direct sum of all twenty-five
lines is then the algebra of their $\mu_5^2$ torsor, with an algebra
map to $F_*O_Y$ whose trivial-character map is the unit.

The two generator lines correspond to independent regular
Cartier-fixed logarithmic differentials $\beta_1,\beta_2$.
They span $H^0(Y,\omega_Y)$ over k, and therefore have no common
zero. One can see the correspondence explicitly: choose a rational
section of A, write its fifth-power trivialization as a rational
function with divisor divisible by five, and take its logarithmic
differential. This is regular and Cartier-fixed. If that differential
vanishes identically, the function is a fifth power and A is trivial;
the construction respects addition of character classes. These facts
identify the two independent character generators with an independent
Cartier-fixed basis on an ordinary genus-two curve. Here the
Frobenius-fixed basis of a bijective semilinear Frobenius space
exists over an algebraically closed field. The proof of
[Stacks, Lemma59.63.2](https://stacks.math.columbia.edu/tag/0A3L)
counts exactly $5^{\dim V}$ fixed vectors in the bijective case;
an $\mathbf F_5$-independent fixed basis is k-independent by applying
Frobenius to a minimal linear relation and subtracting it. The equivalent
Kummer and regular-logarithmic description above fixes its character
interpretation.

At any point, one $\beta_i$ is nonzero. In a local frame the associated
trivialization is a unit function u with nonzero derivative. Its
classes $1,u,u^2,u^3,u^4$ form a basis of the Frobenius local algebra:
modulo a Frobenius-base parameter, $u-u(P)$ is a uniformizer and its
first four powers together with one give the length-five basis.
Nakayama's lemma proves local surjectivity. Hence the twenty-five-line
algebra maps onto $F_*O_Y$. Quotienting its unit summand proves
$R=\bigoplus_{A\ne O_C}A\twoheadrightarrow B$.

Every one of these twenty-four character maps to B is nonzero. A
zero map would make its nonzero adjunction map to $F_*O_Y$ factor
through $O_C$, but $\operatorname{Hom}(A,O_C)=0$ for a nontrivial
degree-zero line. The representation of the diagonalizable group
$\mu_5^2$ is a direct sum of distinct characters; its coefficient
subobjects are sums of character subspaces. Since none is killed,
the presentation is quotient-minimal. This argument works despite
the group's being nonreduced; diagonalizable group representations
are graded by their character group in characteristic five as well.

## Seven constant relations after Frobenius

Let $\mathscr A=F^*F_*O_Y=O_Y\otimes_{O_C}O_Y$. Multiplication
$\mathscr A\to O_Y$ splits its unit inclusion. Put I equal to its
augmentation ideal. Then $F^*B\simeq I$.
The diagonal ideal has $I^5=0$ and its canonical line grades are
$I^j/I^{j+1}\simeq\omega_Y^j$ for $1\le j\le4$.
This follows in an etale local coordinate from the generator
$\delta=z\otimes1-1\otimes z$, with $\delta^5=0$; coordinate
changes give precisely the indicated cotangent powers.

The bundle $I^2$ has line grades $\omega_Y^2,\omega_Y^3,\omega_Y^4$.
Each has zero H1 on a genus-two curve. Thus $H^1(I^2)=0$, and
the sequence $0\to I^2\to I\to\omega_Y\to0$ gives $h^1(I)=1$.
Since $\deg I=\deg F^*B=20$ and $\operatorname{rk}I=4$,
Riemann--Roch yields $h^0(I)=20-4+1=17$ exactly.

Frobenius is flat on a smooth curve, so the kernel sequence pulls
back to $0\to F^*K\to O_Y^{24}\to I\to0$.
Its global sections give $h^0(F^*K)\ge24-17=7$.
All these sections are constant vectors in $O_Y^{24}$. Independent
ones form a trivial subbundle of $F^*K$, since constant independent
vectors remain independent at every point. Conversely $F^*K$ is a
subbundle of the semistable trivial bundle, so its maximum slope is
at most zero. It is therefore exactly zero.

The dual has a trivial line quotient after Frobenius. A finite
pullback of an ample bundle is ample, whereas a trivial quotient
line on a projective curve is not ample. Consequently $K^\vee$
cannot be ample.

## A nonzero etale-killable cohomology class

Choose any nonzero constant relation, giving an injection
$j:O_Y\to F^*K$. Its composite into $O_Y^{24}$ is a constant
split injection. Thus $H^1(j)$ is injective, because its composite
with $H^1(F^*K)\to H^1(O_Y^{24})$ is injective.

Ordinariness supplies a nonzero Frobenius-fixed class
$\xi\in H^1(Y,O_Y)$. The
[Artin--Schreier sequence](https://stacks.math.columbia.edu/tag/0A3J) realizes it
as the image of a nonzero $\mathbf F_5$ torsor class. The associated
connected degree-five etale cover kills that class after pullback.
Therefore $j_*(\xi)$ is a nonzero class in $H^1(F^*K)$ which the
same etale cover kills. This establishes the claimed failure of
all-height etale persistence, with no assertion about the untwisted
height-zero cohomology group.

The construction has one endpoint only. The compatible two-map
extraction problem is unchanged, but this exact example blocks the
suggested extension of
[the finite-etale kernel theorem](../../Theorems/shared_tensors/minimal_finite_coefficient_relation_kernel.md)
to local coefficients.
