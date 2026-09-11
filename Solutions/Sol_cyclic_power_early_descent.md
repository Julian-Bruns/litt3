# Uniform early cyclic descent: integral geometric comparison

Version1,2026-09-10. Pro return, with its precise input and chart
conventions retained. Fresh independent geometric audit PASS by
/root/audit_uniform_early_comparison; no coefficient correction.
[Statement](../Theorems/Thm_cyclic_power_early_descent.md).
The local script replays unchanged; it does not prove global descent.

## 1. Precision, actual objects and available inputs

Put p=5, m=n-1, J=n+a=m+a+1. A given compatible T_(J+1) has its
new flat/Hodge member through W_J. Normal differences begin at p^m,
so the normalized comparison has precision O=W_(a+1)(k).
Curve displacements begin at p^(m+1), with exactly the same normalized
coefficient precision. All deformations are marked.

Use [uniform nonlinear absorption](Sol_cyclic_power_nonlinear_absorption.md)
and the [late theorem](Sol_cyclic_power_late_descent.md) as established
inputs, not as claims about the early geometric equations. The actual
source and normal lattices are free rankr=3g(C)-3 over O[C_q]. Their
Fitting parts have ranks r-1 and1 and the nil reduction is e²Phi.
The pulled-back two-affine normal complex has an integral deck-linear
section and normal primitive. Negative tangent H0 gives uniqueness.
The scalar H0(omega²) is the regular dual by integral Serre duality.

For m=1 choose the supplied compatible reference through W_(a+3).
For m>=2 extend the ACTUAL given C_n to a smooth C_(J+1)^a and
extend its global filtered projective oper far enough. The scalar
gluing obstruction is H1(omega²)=0. This extends an oper, not its
next periodicity equation. Lift the original etale cover and its
deck action. The prescribed spin and flat square-trivial line are
retained; their infinitesimal lifts have no two-torsion ambiguity.

The input category of higher inverse Cartier contains the preceding
filtered flat object AND the new graded object with its identification.
It does not require the chosen auxiliary oper to solve its next
periodicity equation. We use that actual category and its corrected
filtered/graded gluing, as in [LSZ Theorem4.1 and Lemmas4.7/4.10](https://arxiv.org/html/1311.6424v4).

## 2. A genuine equivariant comparison chart

Over the finite descended reference, the tangent deck lattice is
regular. Its dual cotangent is projective over the Witt group ring.
Split the formal augmentation ideal onto its cotangent equivariantly.
Formal smoothness and the formal inverse-function theorem give actual
equivariant power-series coordinates. The same construction supplies
relative global-oper coordinates and equivariant cohomology frames.
This uses projectivity, never averaging by q. It is the all-precision
version of the [degree125 global-input chart](Sol_cyclic125_bootstrap.md).

The fixed subfunctor is actual lower geometry. On a fixed marked curve
deformation each deck automorphism has a lift because the marked class
is fixed, and that lift is unique by H0(T,T_T)=0. Its relations hold
by uniqueness. The action is free since its special-fiber action is
free; the quotient is the original lower etale-cover deformation.
Thus invariant coordinates really describe descended curves. The
corresponding assertion for the specified global oper follows by
descent of its equivariant data, with projective automorphisms trivial.

Use independent variables

    curve: p^(m+1)(x_ord,x),
    LOCAL output Hodge graphs: p^m u,
    GLOBAL input-oper scalar: p^m R.

For every curve/global-oper input the inverse-Cartier output is a
genuine global flat object. Nongluing output graphs never serve as
preceding input objects. Normalize their local cyclic vectors and
project the local scalar discrepancy onto global H0(omega²). The
integral scalar projection and normal contraction are those of the
regular-module chart; finite homological perturbation extends them
over this parameter ball.

Impose normal-boundary, projected global-scalar, and ordinary normal
cohomology equations first. Leave nil cohomology unimposed. If it also
vanishes, the exact normal graph equations glue the Hodge lines. The
output scalar is then global, so its global projection is itself and
the projected scalar equation is actual periodicity. Conversely the
given compatible tuple satisfies the entire system. Thus eliminating
these variables preserves its actual nil equation and its given
curve coordinate.

Scalar equality is imposed only at the preceding precision read by
the functor. Extra chosen auxiliary oper digits are representatives,
not new constraints: an unread last filtered-map digit is killed by
the factor p in its tilde transition, and an unread scalar digit by
the p² gain proved next. Reduction identifies the preceding Hodge
graph with the appropriate reduction of the SAME specified upper tuple.

## 3. Uniform termwise integrality

Before substituting weights, write the actual curve displacement as
pX and use unnormalized graph and scalar variables U,R. We prove
that every positive-degree comparison term has an integral presentation
as a finite sum of diagonals of additive multilinear maps. Coefficient
Frobenius and inverse Frobenius count as additive operations of degree1.
This is stronger than pointwise integrality on Witt coefficients.

### Divided Taylor operators

In oper coordinates put

    C_r=[[0,r],[1,0]], P_p=diag(p,1),
    L_0=I, L_(j+1)=partial L_j+C_r L_j.

For B_r=[[0,p²r],[1,0]] and K_(j+1)=p partial K_j+B_r K_j,
direct conjugation gives the EXACT differential-polynomial identity

    K_j=P_p p^j L_j P_p^-1
       =[[p^j L11,p^(j+1)L12],[p^(j-1)L21,p^j L22]].     (1)

Expand each ordered differential-polynomial product in L_j(r+Delta r).
Its multilinear presentation is integral without polarization. With
z=z0+Delta z, a term with ell changed displacement factors has the
complete coefficient1/(ell!(j-ell)!). Thus every ordered mixed term
has nonnegative p-valuation since

    j-1-v5(ell!)-v5((j-ell)!) >= j-1-v5(j!) >=0.          (2)

Legendre gives v5(j!)=(j-s5(j))/4<=(j-1)/4. For j>=3 the
bound is at least2. The two smaller matrices are

    K1=[[0,p²r],[1,0]],
    K2=[[p²r,p³r'],[0,p²r]].

Consequently ALL scalar-dependent output terms gain p², including
the divided Taylor terms. The bound tends to infinity with j, so
only finitely many terms contribute at any given precision. On a
torsion-free oper lift these are the actual divided operators; the
filtered/graded construction gives their well-defined reductions.
No arbitrary truncated p-connection is assumed to determine its
divided structure.

### Frobenius divisions and weighted curve coordinates

The remaining divisions by p occur in dF/p or differences of local
Frobenius lifts. Expand their numerators with the curve displacement
pX BEFORE division. Every positive-degree term of displacement degree
d contains p^d, including terms transported through Phi(X), and after
division still contains p^(d-1). The constant is the actual integral
reference Frobenius discrepancy. Thus this gives termwise integral
presentations, not merely integral values of a quotient.

For example the exact Witt-delta identity is

    delta(pX)=Phi(X)-p^4 X^5,
    delta(p^(m+1)x)=p^m Phi(x)-p^(5m+4)x^5.              (3)

There is no unweighted delta on Hodge repairs in this chart. A genuine
global preceding oper enters through the corrected matrices

    Jtilde=epsilon [[lambda,p lambda'/f'],[0,lambda^-1]],
    nablatilde=p partial+[[0,p²r],[1,0]], lambda²=f'.      (4)

The diagonal uses the NEW graded map, the upper entry the PREVIOUS
filtered map. This retains the actual flat epsilon. Its cancellation
on the normal coefficient line is not a global trivialization of it.

### Other operations and the all-degree conclusion

The graph equation c+d s_j-s_i a-s_i b s_j=0 is integral. Its
fractional-linear version expands at a unit a as

    (c+ds)/(a+bs)=c/a+(ad-bc)s/a²*sum_(j>=0)(-bs/a)^j.

Scalar normalization for H=(1,s)^t, V=nabla H and D=det(H,V) is

    det(nabla V,V)/D-D''/(2D)+3(D')²/(4D²).             (5)

All denominators are units at5; the required square-root series is
5-integral. Coordinate substitution uses the integral Hasse--Taylor
expansion on an etale coordinate patch, equivalently the completed
diagonal, not unsupported divisions partial^ell/ell! in a truncated
ring. Perturbation inverses of the actual coefficient complexes are
finite ordered integral series. No nongluing output is a complex input.

At each finite precision all the coefficients in question belong to a
finite unramified coefficient extension, since k=bar(F5). In a Z_p
basis Phi and Phi^-1 are integral additive linear maps. Equivalently
one can keep them as additive valuation-preserving operations over
W(k) throughout. They fix the abstract deck generator. Products,
ordered compositions and reference linear operations therefore give
the claimed integral additive presentations. The whole homogeneous
maps are deck-equivariant by the equivariant chart; individual
multilinear presentations need not be equivariant, as allowed by the
absorption theorem.

After substituting (X,U,R)=p^m(x,u,R) and dividing the normal discrepancy
by p^m, a degree-d term has valuation at least

    m(d-1).                                             (6)

No factorial polarization is used at degree5 or any larger degree.

## 4. Weighted elimination, with constants retained

Modulo p the auxiliary boundary/scalar/ordinary blocks are triangular
with invertible diagonal: the normal primitive, identity in the global
scalar variable, and the bijective part of Psi. The scalar feedback
has the p² gain above. The leading normal curve response is the actual
Psi, with convention rho(S+xi)=rho(S)-Psi(xi), as in
[LSYZ Theorem6.2](https://arxiv.org/html/1404.0538v2).

The following integral implicit-elimination argument keeps all weights.
First solve the auxiliary equations at x=0 by finite p-adic successive
approximation, since nonlinear terms are p^m-Lipschitz. Let that solution
be v0. Translate by v0. A term of degree D contributing external degree
d<=D keeps its coefficient p^(m(D-1)), which is divisible by
p^(m(d-1)). Absorb linear terms into the additive block. Its inverse is
the ordered finite series

    (B0+E)^-1=sum_(j>=0)(-B0^-1 E)^j B0^-1.             (7)

The inverse of B Phi is Phi^-1 B^-1, in that order. No commuting of
coefficient operators is assumed. In substitution trees the sum of
vertex arities minus one equals the number of external leaves minus
one. Hence compositions preserve(6) and integral d-additive
presentations. The finite nil equation is

    Lx=N eta+sum_(d=2)^(1+floor(a/m))p^(m(d-1))Q_d(x),   (8)

where L is additive and deck-equivariant, L modp=e²Phi, and each Q_d
has the presentation required by the absorption theorem. The variable
x remains the nil coordinate of the GIVEN combined curve displacement;
it is not an independently selected repair digit.

## 5. The norm coefficient is the actual lower obstruction

At x=0 the auxiliary solution is unique and equivariant, hence invariant.
Section2 identifies its curve and global-oper coordinates with actual
descended data. The constant residual in the rank-one regular normal
lattice is uniquely N eta. Restrict the same equations and projections
to invariant coordinates: they are the LOWER boundary, scalar and
ordinary equations. Thus their first remaining nil coefficient is the
zero-line obstruction of this actual lower reference:

    eta modp=epsilon_C.                                 (9)

The norm identification is made before taking the upper obstruction
cokernel. It is not deduced from the vanishing of a pulled-back lower
class there. If the initially chosen reference has an ordinary error,
the invariant auxiliary solution supplies its actual ordinary repair;
its zero-line obstruction is still the same cokernel class. All higher
constant feedback remains in eta. Displacement-dependent norm terms
remain in L or Q_d. For m=1 the initial reference already solves the
full finite comparison, so eta=0 exactly.

## 6. Apply absorption to the actual given truncation

Transport coefficient Frobenius once: y=Phi(x), A=L Phi^-1. Equation(8)
is the precise equation of uniform absorption with the same leading
curve digit. At n=2, m=1 and eta=0, so (A1) gives
y modp in k e^(q-1). For3<=n<=a, (A2) gives both that conclusion and
eta modp=0. The leading ordinary difference relative to the actual
descended reference is zero by its invertible ordinary equation.

Choose the lower zero-line digit whose pullback is the recovered
invariant leading nil digit, using h*(ker Psi_C)=k e^(q-1). Modify the
actual lower reference by it and lift the ORIGINAL finite etale cover.
Its upper leading deformation class is the given T_(n+1), with marking.
For n=2 lower compatibility follows from the compatible reference; for
n>=3 it follows from(9) and eta modp=0. Adding a kernel digit preserves it.

The compatible Hodge line is unique, projective graded automorphisms
are scalar, and the given flat square-trivial line has its unique
marked lift. Naturality therefore identifies all specified upper data
with the pullbacks. This proves(U), without asserting descent of the
given longest finite extension at its entire precision.

## 7. Independent local checks and full towers

The genuinely present degree5 graph term is

    [s^5](c+ds)/(a+bs)=(ad-bc)b^4/a^6.

For an actual jet coordinate change f(t)=t+t², at t=0 the unscaled
oper transition has a=b=d=1,c=0. Thus at m1 the normalized graph
series is u-pu²+p²u³-p³u4+p4u5 modulo p5. The sharp bound is attained;
the quintic has not been discarded by symmetry or polarization.
Independently, (K5)21=p4(r²+3r''), and division by5! leaves p3/24,
so the divided Taylor quintic is safely integral.

The supplied script scripts/uniform_early_descent_checks.py was saved
UNCHANGED and replayed using existing sage -python in0.53s. It checks
the exact conjugation through j7, K5, the quintic graph coefficient,
the scalar-normalization numerator, all501500 mixed factorial bounds
through j1000, and weighted delta over Z[w]/(w²-2) at m1..8. Here
Phi(w)=-w, and (1+w)^5=41+29w differs from Phi(1+w)=1-w. The finite
checks do not replace the all-order proof(2) or the geometric chart.

For a>=4 apply(U) successively for n2..a to a GIVEN full compatible
upper tower. The recovered lower curves can differ from the initial
reference; each step retains the one already recovered. Then apply
the known late theorem for every n>=a+1. For a<=3 use the existing
full-tower results. Uniqueness makes the descended maps and tuples an
inverse system. The established effectivity argument with compatible
ample canonical bundles and Grothendieck existence algebraizes the
ORIGINAL etale map, deck action and full tuple over W(k).

This is the simple-zero-base/source-defect-two cyclic theorem with its
specified initial reference. It is not a theorem about arbitrary
non-Galois spans, larger defects, or absent/dormant matches.

[Focused audit](../Research/audits/UNIFORM_EARLY_CYCLIC_COMPARISON_AUDIT_2026_09_10.md).
