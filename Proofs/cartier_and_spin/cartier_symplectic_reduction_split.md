# Proof: the syzygies and the one-point modification

[Statement](../../Theorems/cartier_and_spin/cartier_symplectic_reduction_split.md).
Use the actual evaluation lattice from
[cartier_kernel_generated_subbundle](cartier_kernel_generated_subbundle.md)
and the absolute-Cartier coefficient convention from
[two_form_map_descent](two_form_map_descent.md). Relative twists are
retained; a coefficient twist changes the displayed polynomial
coefficients semilinearly, not the resulting line-bundle degrees.

## The image of the three sections

Write $s_0,s_1,s_2$ for the sections induced in $N$. Their alternating
minors are $b_{01}\theta,b_{02}\theta,b_{12}\theta$, with
$\theta=dx/y^2$ and ascending coefficient-code rows
\[
b_{01}=(4,16,3,18,21),\quad
b_{02}=(10,13,0,10,6),\quad
b_{12}=(15,3,3,18,18,4).
\]
Here $[n_0+5n_1]=n_0+n_1a$, where $a^2=a+3$.
The exact Sylvester determinant of the first two rows is $[12]\ne0$.
At infinity their form orders are $4,4,1$, since
$\operatorname{ord}_O\theta=16$ and $\operatorname{ord}_Ox=-3$.
Thus the common divisor of the minors is exactly $O$.

The image $I\subset N$ is torsion-free of rank two. Its determinant
is the minor image, so $N/I$ has length one at $O$ and no other support.
The kernel of $\mathcal O_C^3\twoheadrightarrow I$ is generated
rationally by $(b_{12},-b_{02},b_{01})$.

Homogenize the three polynomials to degree five on $\mathbf P^1$.
They have no common zero, including infinity because the leading
coefficient of $b_{12}$ is nonzero. If $\xi:C\to\mathbf P^1$ is the
degree-three map, this identifies
\[
I=\xi^*Q,\qquad
0\longrightarrow\mathcal O_{\mathbf P^1}(-5)
\longrightarrow\mathcal O_{\mathbf P^1}^3
\longrightarrow Q\longrightarrow0.
\tag{1}
\]
The equality follows from the actual saturated kernel line, not merely
from the degree of $I$.

## Two explicit syzygies

For the ordered row $(b_{01},b_{02},b_{12})$, the following rows are
syzygies, written as lists of ascending coefficients:
\[
q_2=((20,14,15),(16,1),(19,1)),
\]
\[
q_3=((3,7,23,14),(18,24,24,18),(1)).
\]
Their homogeneous cross product is exactly $[13]$ times the degree-five
row of minors. Thus they give a pointwise rank-two basis of the kernel
of $\mathcal O^3\to\mathcal O(5)$ and
\[
Q^*\simeq\mathcal O(-2)\oplus\mathcal O(-3),\qquad
I\simeq\mathcal O_C(6O)\oplus\mathcal O_C(9O).
\tag{2}
\]
This is also independently checked by syzygy dimensions $0,0,1,3$ in
degrees zero through three. Denote the intrinsic degree-nine summand
by $L$; uniqueness follows from $H^0(C,\mathcal O(-3O))=0$.

The quotient $I\to\mathcal O_C(6O)$ is given on the three generating
sections by the covector $(q_{2,2},-q_{2,1},q_{2,0})$. In the fiber at
infinity its values are $(0,0,[15])$. Meanwhile the relation from (1)
has values $([4],0,0)$. Hence $s_1,s_2$ give a basis of $I|_O$, and
$L|_O$ is exactly the line spanned by $s_1$.

## Which line is modified at infinity?

The original differential representing $s_1$ has order seven at the
source infinity. In the Cartier bundle over the first twist it is
therefore divisible by its base uniformizer: the locally exact basis
has exponents zero through three over fifth-power functions. Since
$U$ is saturated in $B_X$, the section belongs to the uniformizer
times $U$, and its image belongs to the uniformizer times $N$.

Consequently $s_1$ lies in the kernel of $I|_O\to N|_O$. That kernel
has dimension one, because $N/I$ has length one. It is therefore
precisely $L|_O$. A positive elementary modification of $I$ at this
fiber line enlarges $L$ to $L(O)$ and leaves the other direct summand
unchanged. This proves
\[
N=\mathcal O_C(6O)\oplus L(O)
=\mathcal O_C(6O)\oplus\mathcal O_C(10O).
\]
Taking trace-zero endomorphisms gives the asserted three line summands.

## The actual descent obstruction

Semistability and Harder--Narasimhan filtrations are preserved under
finite etale pullback. For rank two, the positive HN section of the
projective bundle has its intrinsic line
$L_{\max}^2(\det N)^{-1}$, of degree $20-16=4$ here. This degree
does not change under a line twist. On an algebraically closed curve
every projective rank-two bundle has a vector-bundle lift, so its HN
gap is an integer, independent of that lift.

If its pullback descended to Y, degree comparison with
$\deg g=8\deg f$ would give $4\deg f=(\deg g)d_Y$, and hence
$d_Y=1/2$. This is impossible. The degree-four top HN line of
$\operatorname{End}^0(N)$ gives the identical contradiction. Source
refinement multiplies both degrees equally and cannot remove it.

## Verification

The source script is
[cartier_symplectic_reduction.py](../../scripts/arithmetic/cartier_symplectic_reduction.py).
It checks the resultant, both polynomial syzygies, their homogeneous
cross product, the small syzygy dimensions and the nonzero leading
coefficients used at infinity. The executed output is stored outside
the repository in
[the computation directory](../../../litt3-computation-data/cartier_symplectic_reduction_20260921/output.txt).
The geometric lattice argument above is separate from that certificate.
