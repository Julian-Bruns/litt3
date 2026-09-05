# Normalized norm connections: descent under equal p-rank, and the Tango defect

**Status: collaborative author proof, 2026-09-05; not independently audited.**

Authors: /root and /root/gluing_cohomology_rigidity. The explicit
characteristic-five rational-function identity below was also checked
exactly in Sage. No projective counterexample is asserted.

Normalized norm preserves regular connections with zero p-curvature.
It need not preserve Cartier-zero horizontal differentials: this already
fails for an actual connected affine etale double cover. For smooth
projective curves, equal p-rank eliminates the trace-zero difference
and makes the same norm construction a genuine descent mechanism.

For maximal Tango structures and their connection interpretation, see
[111](111_P_RANK_ONE_TANGO_DESCENT.md). The explicit characteristic-five
polynomial is from
[the local connection note](LOCAL_MAXIMAL_TANGO_CONNECTION_EQUATION_CHAR5.md).

## 1. The normalized norm connection

Let f:D -> E be finite etale of degree n prime to p, over an algebraically
closed field of characteristic p. Use the differential isomorphism
omega_D=f^*omega_E. Suppose nabla_D is a regular connection on omega_D.
In a local base frame dx write

\[
                       \nabla_D(dx)=a\,dx\otimes dx.
\]

Define the downstairs coefficient

\[
                         m=\frac{1}{n}\operatorname{Tr}_f(a).       \tag{N.1}
\]

This gives a regular connection nabla_N on omega_E. Indeed, under a
base coordinate change dt=q du, each etale conjugate obeys

\[
                       a_u=q a_t-\frac{q'}q.
\]

Taking the trace and dividing by n gives the identical transformation
law for m. Regularity follows since the trace maps regular functions
to regular functions. No splitting of f over E, and no prime-to-p
assumption on a Galois closure, is needed.

Equivalently, the norm connection is a connection on
Nm_f(omega_D)=omega_E^n; nabla_N is its unique normalized nth tensor
root as a connection. Here norm means
det(f_*omega_D) tensor det(f_*O_D)^(-1), with the corresponding
connection on the second factor subtracted. The etale-local split
calculation gives exactly (N.1).

If nabla_D has zero p-curvature, so does nabla_N. To check this at
the generic point, choose a separating coordinate x. Then partial=d/dx
satisfies partial^p=0. In a separable splitting field let a_i be the
n conjugate coefficients. The rank-one p-curvature formula gives

\[
                        a_i^p+\partial^{p-1}a_i=0.
\]

Because the image of n belongs to F_p^*,

\[
 m^p+\partial^{p-1}m
       =\frac1n\sum_i\bigl(a_i^p+\partial^{p-1}a_i\bigr)=0.         \tag{N.2}
\]

The p-curvature is a regular tensor, so generic vanishing suffices.

## 2. Equal p-rank makes norm actual descent

Assume now that D and E are smooth projective connected curves.
Let V_C be the F_p-vector space of regular Cartier-fixed differentials
on C. Its dimension is the geometric p-rank gamma(C).

For a zero-p-curvature connection nabla_D, set

\[
             \delta=\nabla_D-f^*\nabla_N\in H^0(D,\omega_D).
\]

The difference of two such connections is Cartier-fixed, and (N.1)
gives Tr_f(delta)=0. Cartier commutes with etale pullback and trace,
and Tr_f(f^*beta)=n beta. Hence

\[
                 V_D=f^*V_E\oplus\ker(\operatorname{Tr}_f:V_D\to V_E).
                                                                    \tag{N.3}
\]

If gamma(D)=gamma(E), the trace-zero summand is zero. Thus delta=0:
every zero-p-curvature connection on omega_D descends uniquely to
omega_E. Conversely every such downstairs connection pulls back.

This gives a bijection on maximal Tango structures as well. Once the
connection descends, its horizontal rational differential pulls back
to a Cartier-zero horizontal differential upstairs. Cartier commutes
with this pullback, and pullback on the target differentials on the
Frobenius twists is injective by faithful flatness. The downstairs
differential is therefore Cartier-zero. The corresponding adjoint
Frobenius map is an isomorphism because it becomes one after etale
pullback. This argument applies to non-Galois f without alteration.

The hypothesis gamma(E)=1 alone does not make (N.3) have zero kernel:
its dimension is gamma(D)-1. No conclusion that arbitrary covers
preserve p-rank is made here. Nor does the affine example below
decide global projective Tango descent when the p-rank increases.

## 3. The exact symmetric defect in characteristic five

Work in a common etale base coordinate x and put

\[
 P_4(a)=a^4-a^2a'+3(a')^2+4aa''-a'''.
\]

Use normalized trace brackets, and centered coefficients:

\[
 \langle h\rangle=\frac1n\sum_i h_i,\qquad
 m=\langle a\rangle,\quad b_i=a_i-m,\quad
 \mu_j=\langle b^j\rangle,\quad \sigma=\langle(b')^2\rangle.
\]

Thus <b>=0, and trace commutes with differentiation. If all
P_4(a_i)=0, direct expansion gives the exact identity

\[
 \boxed{
 P_4(m)=(m'-m^2)\mu_2+m\mu_2'+m\mu_3
                   +2\mu_3'+3\mu_2''+\sigma-\mu_4.
 }                                                                  \tag{N.4}
\]

For a check before eliminating mixed derivative moments, the expansion is

\[
\begin{aligned}
 \langle P_4(a)\rangle-P_4(m)
    ={}&(m^2-m')\mu_2+4m\mu_3+\mu_4
          -2m\langle bb'\rangle-\langle b^2b'\rangle\\
       &+3\langle(b')^2\rangle+4\langle bb''\rangle.
\end{aligned}
\]

Use mu_2'=2<bb'>, mu_3'=3<b^2b'> and
mu_2''=2<(b')^2>+2<bb''> to obtain (N.4). All coefficients are in
F_5. The combined expression multiplied by (dx)^4 is coordinate
invariant, even though its derivative moments are not individually
tensorial. Trace zero of b does not eliminate its quadratic and
quartic moments.

## 4. An actual connected affine etale counterexample

Let k have characteristic five, put N=x^2+x+1, and take

\[
 E=\operatorname{Spec} k[x,1/(xN)],\qquad
 D=E\mathbin{\times}_{\mathbf A^1_x}\mathbf A^1_z,
                       \qquad x=z^2.                                \tag{N.5}
\]

The map f:D -> E is finite etale of degree two: z is a unit, and
the derivative 2z is invertible. Its coordinate ring is a localization
of k[z], so D is connected. The deck involution is z -> -z.

Set u=1+z+z^2. Its norm is

\[
             (1+z+z^2)(1-z+z^2)=1+x+x^2=N,
\]

so u is a unit on D. The nowhere-zero differential

\[
 \xi=u\,dx=(2z+2z^2+2z^3)\,dz
                         =d(z^2+4z^3+3z^4)                          \tag{N.6}
\]

is exact. Declare it horizontal. This gives a regular zero-p-curvature
connection on omega_D, with Cartier-zero horizontal differentials.
Both conjugate coefficients satisfy P_4=0; they come from this single
connection, not independent choices on disconnected sheets.

Its normalized norm coefficient is

\[
                   m=-\frac12\frac{N'}N=2\frac{N'}N.
\]

Since 2^(-1)=3 in F_5, a horizontal differential for the normalized
connection is N^3 dx. But

\[
             N^3=x^6+3x^5+x^4+2x^3+x^2+3x+1,
\]

and hence

\[
                 \operatorname{Car}(N^3dx)=dx\ne0,
                  \qquad P_4(m)=\frac4{N^3}\ne0.                    \tag{N.7}
\]

The latter identity follows either by fourth differentiation of N^3
or direct substitution in P_4; it was checked exactly in the rational
function field over F_5 using Sage.

Thus normalized norm does not preserve the maximal Cartier-zero
condition even for a connected affine etale double cover with a
nowhere-zero exact horizontal differential. This is a local/affine
counterexample only. The smooth projective compactification of (N.5)
is ramified, and the displayed connections need not remain regular
at the omitted points. In particular this is not a counterexample
to the equal-p-rank projective descent statement in Section 2, or
to any claim requiring a projective etale map with p-rank-one base.
