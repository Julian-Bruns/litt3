# Proof: degree-seven uniform pencils and actual norm exclusion

[Statement](../../Theorems/quotient_geometry/degree_seven_uniform_norm_exclusion.md).

## The ruled surface and the equality case

The actual cubic map has
\[
x_*\mathcal O_X=\mathcal O\oplus\mathcal O(-4)\oplus\mathcal O(-7).
\tag{1}
\]
Thus every function of degree at most six is in $k(x),$ by the
[pencil separation argument](../jacobians/torsion/reduced_divisor_rigidity.md).
Write $O$ for the point at infinity. The cubic curve has a smooth
embedding over $\mathbf P^1_x$ in the Hirzebruch surface $\mathbb F_3$.
On its finite chart the fiber coordinate is $y$; at infinity it is
$z=y/x^3$, with equation $s z^3=\widetilde P(s)$, $s=1/x$.
In the chart $v=1/z$, this is $s=\widetilde P(s)v^3$, so the curve
is smooth at $O$. The negative section $S_0$ meets it just at $O$,
with intersection multiplicity one. Its class is $3S_0+10F$.

We give the equality-case argument explicitly, rather than assuming
that an arbitrary degree-seven function is linear in $y$.
Let $u:X\to\mathbf P^1$ have degree seven. Since seven is not a
multiple of three, $(x,u)$ is birational onto its image
$\Gamma\subset\mathbb F_0=\mathbf P^1\times\mathbf P^1$.
Its bidegree is $(7,3)$, its arithmetic genus is twelve, and its
total normalization defect is three.

Resolve this trisection by elementary transformations at singular
points. Such a point has multiplicity two or three. Blowing it up
decreases the defect by one or three, respectively. The strict
vertical fiber has intersection one or zero with the strict
trisection; contracting it creates no new singularity on that
curve. Repeating therefore resolves $\Gamma$ in at most three
elementary transformations.

The resulting ruled surface containing the smooth triple cover is
$\mathbb F_3$. One way to identify it is relative duality: the
rank-two, trace-free part of $x_*\omega_{X/\mathbf P^1}$ recovers
the relative canonical embedding of any smooth trisection. Its
projective bundle is fixed by (1). Equivalently, a smooth
trisection of class $3S+bF$ on $\mathbb F_e$ has trace-free
pushforward $\mathcal O(e-b)\oplus\mathcal O(2e-b)$; (1) forces
$e=3$. The identification carries the actual embedded curve and
the given map $x$.

Each elementary transformation changes the Hirzebruch invariant
by one. Going from zero to three consequently requires exactly
three transformations, all at double points, and the invariants
are $0,1,2,3$. The first center lies on some horizontal section
$u=\infty$. Its strict transform is the negative section after
the first step. Both subsequent centers must lie on its strict
transform, since the invariant must increase each time.

Reverse these transformations. Their three centers are on $X$
and off $S_0$: each is the contracted vertical fiber's remaining
intersection with the trisection. They lie on a section disjoint
from $S_0$, the transform of any other horizontal section of
$\mathbb F_0$. Such a section in the displayed $\mathbb F_3$
coordinates is $y=A(x)$ with $\deg A\le3$. All centers lie over
finite $x$, since the only point of $X$ over infinity is on $S_0$.
If $B$ records their base points with multiplicity, $\deg B=3$.
The three elementary transformations divide $y-A$ by those base
parameters. After scaling the target coordinate, their composite is
\[
u=(y-A)/B.
\tag{2}
\]
This includes repeated or infinitely near centers. In particular,
it does not prematurely assume that $B$ is squarefree.

These elementary-transformation arguments are also the equality
argument of [Shin, Propositions2.10 and3.4](https://arxiv.org/pdf/0806.1849).
Here all necessary steps were given using the actual trisection;
they use surface intersection multiplicities and relative duality,
and remain valid in characteristic five.

## Uniformity controls the distinguished pole fiber

In (2), $u$ has a simple pole at $O$, since $y$ has pole order ten,
$B$ has pole order nine, and $A/B$ is regular at infinity.
Uniformity therefore makes this ENTIRE pole fiber unramified.

If a root of $B$ has multiplicity $m$ and $P$ is nonzero there,
at least two of the three branches have numerator a unit. They
give poles of order $m$, so $m=1$. A root shared with $P$ gives
a pole of order $3m$ if $A$ is a unit, or $3m-1$ if $A$ vanishes.
Neither can occur in the unramified pole fiber. Thus $B$ is
squarefree and coprime to $P$.

At each of its three roots there must be a branch with canceled
numerator. Otherwise the pole degree is at least eight: there
would be three poles over that root, at least two over the others,
and the pole at $O$. Since $\deg u=7$, cancellation occurs at
every root, proving $B\mid P-A^3$. The pole fiber consists of $O$
and two points over each root of $B$, all simple.

Every nontrivial ramification index of a uniform degree-seven map
is seven. The map is tame, and Riemann--Hurwitz gives exactly five
ramification points, each with differential zero of order six.

## A polynomial abc contradiction

Set
\[
D=BP'/3-B'P,\qquad E=BA'-AB'.
\]
Differentiation in the actual function field gives
\[
du=\frac{D-Ey^2}{B^2y^2}\,dx,
\qquad R:=\operatorname{Norm}_{k(X)/k(x)}(D-Ey^2)
          =D^3-E^3P^2.
\tag{3}
\]
Characteristic five and $\deg P=10$ imply
\[
\deg D=12,\qquad\deg E\le4,\qquad\deg R=36.
\tag{4}
\]
Indeed the leading term of $P'$ vanishes, whereas $-B'P$ has
nonzero leading coefficient. The degree-five terms in $BA'-AB'$
cancel. Also $E\ne0$: otherwise $A/B$ has zero derivative and
degree at most three, so is constant; this contradicts
$B\mid P-A^3$ and $\gcd(B,P)=1$.

The polynomials $D$ and $E$ are coprime. First, $D$ is nonzero at
every root of $B$ or $P$. At any other common root, let
$m=\min(\operatorname{ord}D,\operatorname{ord}E)$, so $1\le m\le4$.
Of the three distinct values of $y^2$ over this point, at most one
can cancel the leading term of $D-Ey^2$. Thus $du$ has zero of
order exactly $m$ on at least two branches. Uniformity requires
every such order to be six, a contradiction.

No ramification point of $u$ lies over a root of $P$: there
$dx/y^2$ is a unit differential and $D$ is a unit. Nor is $O$
ramified. At a root of $B$, the canceled branch in (2) contributes
order two to $D-Ey^2$, plus six if it is ramified; the other two
branches contribute zero. Away from these fibers, (3) counts
exactly the zeros of $du$. Consequently
\[
D^3-E^3P^2=cB^2H^6
\tag{5}
\]
for $c\in k^\times$ and a degree-five polynomial $H$. Repeated
$x$-coordinates among the five ramification points are retained
as multiplicities of $H$. A ramification point on a canceled
$B$-branch is allowed; the factor $B^2$ in (5) is essential.

The three terms in (5) are pairwise coprime, since
$\gcd(D,EP)=1$. Their total number of distinct polynomial roots
is at most
\[
12+4+10+3+5=34.
\tag{6}
\]
The polynomial $abc$ inequality now gives $36\le33$, impossible.
For completeness, its characteristic-five exception does not
apply. For coprime $a-b=c$, the Wronskian $a'b-ab'$ is divisible
by $abc/\operatorname{rad}(abc)$, hence its nonvanishing implies
$\deg c\le\deg\operatorname{rad}(abc)-1$. If that Wronskian
vanishes, $a/b$ is a fifth power. Here $a=D^3$ has degree36 and
is coprime to $b=E^3P^2$, so it cannot be a fifth power up to a
constant. This proves the uniform-pencil exclusion.

## The actual two-map norm

Suppose $\pi:T\to C$ and $h:T\to X$ are etale, $\deg\pi=7$,
and $h_*\pi^*=0$. The map $h$ cannot descend through $\pi$:
otherwise this homomorphism would be $[7](h_0)_*$, which is
nonzero. Prime degree therefore makes $(\pi,h)$ birational onto
its image. The generic incidence divisor on $X$ consists of seven
distinct, transitively permuted points. Its Abel class is constant
by the zero norm, while the divisor itself moves. Denote its fixed
degree-seven line bundle by $L$.

The complete system $|L|$ has no base points. A base divisor would
be a proper invariant subset of that transitive generic divisor;
the whole divisor cannot be fixed, since $h$ is nonconstant.
Furthermore $h^0(L)=2$. If $h^0(L)\ge3$, three general generating
sections give a morphism to a nondegenerate plane curve. Since
seven is prime, that morphism is birational and the plane image
has degree seven. Projection from a general smooth image point
has degree six, and hence factors through $x$ by (1).
Fix two distinct image points from a general cubic fiber of $x$.
Every such projection center would have to lie on their joining
line, which cannot contain the nondegenerate plane curve. This
contradiction proves the assertion.

Thus $|L|$ is a pencil, giving actual maps $u:X\to\mathbf P^1$
and $a:C\to\mathbf P^1$ with $uh=a\pi$. The source $T$ is the
normalization of the FULL fiber product: its generic degree over
$C$ is already the full degree seven. For any pair of points of
$X,C$ over the same target point, the normalization has a point
over that pair. At this point, etaleness of both legs gives
$e_u(x)=e_a(c)$. Fixing $c$ proves that each fiber of $u$ is
uniform. This contradicts the preceding exclusion.

Finally take the actual Galois closure $W\to Y$ of a genus-two
leg and a normal subgroup $N$ of order seven. The original other
map gives an actual etale map $W\to X$. If
$\operatorname{Hom}(J(W/N),J(X))=0$, apply the norm result to
$W\to W/N$. For $N=[G,G]$, the quotient is an abelian etale
cover of $Y$, and the established
[endomorphism-packet theorem](../jacobians/isogeny_sieves/etale_endomorphism_packets.md)
supplies that Hom vanishing for the fixed $X$. No simultaneous
Galois source or bound on $|G|$ is introduced.
