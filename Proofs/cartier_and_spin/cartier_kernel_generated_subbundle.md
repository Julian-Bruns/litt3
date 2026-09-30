# Proof: local Cartier jets and a degree obstruction to descent

[Statement](../../Theorems/cartier_and_spin/cartier_kernel_generated_subbundle.md).
We use the already certified basis and Wronskian from
[the kernel Wronskian proof](fixed_x_kernel_wronskian.md); no large
atlas calculation or new cover enumeration is required.

## Evaluation in the exact-differential bundle

For a uniformizer $z$ on $X$, the locally exact differentials have
basis
\[
dz,\quad z\,dz,\quad z^2\,dz,\quad z^3\,dz
\]
over $\mathcal O_{X^{(1)}}$, whose local uniformizer is $z^{(1)}$.
The coefficient of $z^{5a+j}dz$ contributes to row $j$ with
valuation $a$. For an exact form the row $j=4$ is absent.
Consequently, if three constant-linear combinations of the global
forms have orders $n_1,n_2,n_3$ with distinct residues modulo five,
their evaluation lattice has determinant valuation
$\sum_i\lfloor n_i/5\rfloor$: each column is divisible by the
indicated power, and its first nonzero row is different from the
other two. This also gives the individual elementary divisors in
the cases below, by factoring those column powers.

Write the three forms as $q_i(x)\theta$, where
$\theta=dx/y^2$ and the polynomial degrees are $2,3,5$.
The certified polynomial net has no finite base point, and its
Hasse--Wronskian $W$ is squarefree and disjoint from the cubic
branch polynomial. Its generic order sequence is $(0,1,2)$.

At a finite unramified point not over a root of $W$, the form
orders after a constant basis change are $(0,1,2)$. At a root of
$W$ they are $(0,1,3)$: a simple Wronskian zero has ramification
weight one, and the characteristic-five jet coefficients involved
through order three are invertible. In both cases the three
leading rows are distinct and have valuation zero. There is no
evaluation defect at these points.

At a cubic branch point, $x-a$ has order three in the uniformizer
$y$, while $\theta$ is a unit times $dy$. The polynomial net has
order sequence $(0,1,2)$ there because $W(a)\ne0$. Thus the form
orders are $(0,3,6)$. Their residues modulo five are $0,3,1$, so
the elementary-divisor valuations are $(0,0,1)$.

At infinity the three orders are $10,7,1$, since
$\operatorname{ord}_O\theta=16$ and $x$ has pole order three.
Their residues are $0,2,1$; the valuations are therefore $(0,1,2)$.
In particular the evaluation has generic rank three everywhere
on the curve. Its domain is $\mathcal O_C^3$ and it is injective.
The length of the saturation modulo the evaluation image is
\[
10\cdot1+(0+1+2)=13,
\]
with determinant divisor $R+3O$. On the Frobenius twist the function
$y^{(1)}$ has divisor $R-10O$, so this divisor is linearly equivalent
to $13O$.

## The annihilator and quotient line

The perfect alternating pairing identifies
$B_X\simeq B_X^\vee\otimes\omega_C$ and has
$\det B_X\simeq\omega_C^2$. Put $A=U^\perp$.
The quotient by $U$ is $A^\vee\otimes\omega_C$. Taking determinants
therefore gives
\[
\det U=\omega_C\otimes A.
\]
The fixed canonical divisor is $16O$. Hence $A=\mathcal O_C(-3O)$
and $B_X/U=\mathcal O_C(19O)$, as asserted.
After any finite étale pullback, $A$ still has strictly negative
degree and has no global section. This proves the last assertion
of the statement. It does not imply injectivity of a trace on
these pairings; sums over fibers may still cancel.

## One complete transport already fills rank four

Here is the relevant descent observation for any vector bundle
$E_Y$ on a curve and any finite étale map $g:Z\to Y$. For a
subbundle $A\subset g^*E_Y$, the trace-transport image at a
geometric generic point over $Y$ is the sum of the subspaces
$A_z\subset (E_Y)_y$ over ALL points in that fiber. This follows
after splitting the finite étale algebra; its trace is the sum
of the components, with no factor requiring inversion.

If that sum has the same dimension as $A_z$, all the subspaces
are equal. The generic subspace therefore descends to $k(Y)$.
Its unique saturated extension in $E_Y$ is a subbundle; its
pullback is the given $A$, because saturation is preserved by
étale pullback. Thus a transport image of unchanged generic rank
is exactly the condition for the subbundle to descend.

Apply this with $E_Y=B_Y$ and $A=f^{(1)*}U$, of rank three in a
rank-four bundle. Put $n=\deg f$. Riemann--Hurwitz gives
$\deg g=8n$. If the rank stayed three, the descended subbundle
$U_Y$ would have
\[
8n\deg U_Y=\deg(f^{(1)*}U)=13n,
\]
which is impossible. The generic trace-transport rank is therefore
four. This applies to either selected endpoint and requires
neither corelessness nor prime-to-five degrees.

The result so far concerns generic rank, not equality of the integral
subsheaves. We now retain the finite defect of the actual image.

## Complete transport of an integral image

For any common vector bundle $E_Z=f^*E_X=g^*E_Y$ and coherent
subsheaf $A\subset E_Z$, define $T_f,T_g$ by the displayed trace
images in the statement. Splitting the finite étale algebra shows
\[
A\subseteq T_f(A),\qquad A\subseteq T_g(A).
\]
This assertion uses the independent local idempotent components,
not multiplication by the covering degree.

Say that a sheaf is étale-generated if it is a quotient of a vector
bundle trivialized by a finite étale cover. Complete transport
preserves this property. Indeed finite étale pullback does, and
finite étale pushforward of an étale-trivial bundle is again
étale-trivial: a finite Galois closure of a composite trivializing
cover splits it into trivial summands. Taking the indicated image
is taking a quotient. These are separate one-leg constructions.

The initial evaluation image is generated by $\mathcal O_Z^3$.
Thus all $J_j$ are étale-generated. Their generic rank is four by
the first part of the proof. An étale-trivial bundle is semistable
of degree zero. Its locally free quotient $J_j$ has nonnegative
degree. Since $\deg B_Y=(5-1)(g(Y)-1)=4$, this proves
\[
\ell_j:=\operatorname{length}(B_Y/J_j)=4-\deg J_j\in\{0,1,2,3,4\}.
\]
The inclusions in one round give
\[
g^*J_j\subseteq T_f(g^*J_j)\subseteq g^*J_{j+1}.
\]
If $J_{j+1}=J_j$, both inclusions are equalities. Hence $g^*J_j$
descends integrally through both legs. This argument applies to
the actual lattices, without saturating them in $B_Z$.

## A surviving defect would have degree four

Suppose a round stabilizes at a proper subsheaf $J_Y\subset B_Y$,
with descended $J_X\subset B_X$. Their determinant defects are
effective divisors $D_X,D_Y$ satisfying
\[
f^*D_X=g^*D_Y\ne0,\qquad \deg D_Y\le4.
\]
Their common support is a clump. Corelessness gives at most one
finite component of the physical fiber graph, and a common divisor
has constant coefficient on it. The
[genus-two size restriction](../shared_tensors/genus_two_clump_connection_reduction.md)
and the assumed singleton exclusion therefore force
\[
D_Y=\sum_{y\in S_Y}y,\qquad |S_Y|=4,\qquad \deg J_Y=0.
\]
As a degree-zero quotient of an étale-trivial bundle, $J_Y$ is itself
étale-trivial. One can see this after a finite étale trivialization:
the resulting quotient of $\mathcal O^N$ has degree zero, so its
Grassmannian classifying map has degree zero against the Plücker
polarization and is constant. Its pullback to $Z$ is étale-trivial,
and consequently so is $J_X$, by composition of trivializing finite
étale covers. The compatible injections into $B$ retain the original
three global exact forms on their common pullback.

## Excluding the common finite coefficient

The general [finite-coefficient theorem](../shared_tensors/common_finite_coefficients.md)
now excludes any nonzero compatible map from finite-étale-trivial
coefficients to $B$ in a coreless genus-two span with no singleton
clump. Apply it to $J_X,J_Y$. No retained global section and no
fixed-curve spectral calculation are needed at this step.

Every positive $\ell_j$ consequently decreases strictly in the next
round. Since $\ell_0\le4$, we obtain $J_4=B_Y$. This supplies a
uniform bound for linear sheaf transport, while explaining its
limitation: the finite defect is exhausted, not converted into a
nonempty invariant boundary. It gives no finite spectral orbit and
does not settle either common-cover candidate.
