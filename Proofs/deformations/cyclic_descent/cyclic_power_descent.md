# Proof: cyclic descent from a weighted comparison and one terminal carry

Version2, 2026-09-13. The retained geometric construction and the
strengthened algebra have bounded independent audit PASS. This is
audited prose, not formal verification.
[Statement](../../../Theorems/deformations/cyclic_descent/cyclic_power_descent.md).

The two independent algebraic inputs are
[additive preparation](cyclic_power_additive_norm.md) and
[nonlinear absorption](cyclic_power_nonlinear_absorption.md).
The geometric work is to produce their equation from genuine global
input objects while preserving the given curve coordinate and tuple.

## 1. Actual lattices, reference and precision

Put p=5, m=n-1, J=n+a=m+a+1, O=W_(a+1)(k), and r=3g(C)-3.
A GIVEN compatible T_(J+1) has its new flat/Hodge member through W_J.
Graph/scalar differences begin at p^m and curve differences at p^(m+1),
leaving exactly a+1 normalized coefficient digits. All deformations are
marked and retain the full tuple, not just its tangent obstruction.

For either negative tangent or normal line, Cartan--Leray identifies
H1(T)^G with H1(C), of dimension r, while H1(T) has dimension qr.
Each indecomposable k[C_q]-module has dimension at most q and one invariant
dimension, so all r summands are regular. Equivalently the same spectral
sequence gives vanishing higher group cohomology. First identify the
base operator on invariants by naturality; the norm isomorphism from
coinvariants to invariants then identifies its augmentation reduction.
The deck-stable semilinear Fitting summands are direct summands of a
free module over the local group algebra and hence free. The simple
zero downstairs gives nil rank1 and bijective rank r-1. Source defect2
makes the nil multiplier e²u(e)Phi; separate source/target normalizations
remove the unit. This proves the displayed kernel, cokernel and pullback.

On any descended smooth finite reference, negative H0, duality and base
change make tangent and normal H1 free over the truncated Witt ring.
Lift a regular special-fiber basis and compare equal Witt ranks to obtain
free O[G] lattices. On a pulled-back two-affine cover,

    0→Cech0→Cech1→H1→0

has an equivariant section s of its free quotient. The unique inverse
on boundaries gives P=partial^-1(1-s cl). These integral contractions
preserve augmentation images BEFORE division by p.

For n>=3 extend the ACTUAL given C_n smoothly to C_(J+1)^a and extend
its genuine global filtered projective oper, prescribed grading and
flat line. The scalar obstruction to this extension is H1(omega²)=0.
This extends an oper, not its next periodicity equation. For n2 start
instead with the GIVEN compatible C3^0 and extend that actual curve and
tuple in the same way. Lift the ORIGINAL etale cover and its deck action.
Spin and the actual flat square-trivial line have unique infinitesimal
lifts since2 is invertible.

The higher inverse-Cartier input is a genuine previous filtered flat
object and a new graded object with its reduction identification; solving
periodicity is a separate equation. Use that actual category and its
corrected filtered/graded gluing (LSZ Theorem4.1 and Lemmas4.7/4.10).
Nongluing output Hodge graphs below will never be preceding input objects.

## 2. A genuine equivariant comparison chart

Over the finite descended reference, the tangent deck lattice is
regular. Its dual cotangent is projective over the Witt group ring.
Split the formal augmentation ideal onto its cotangent equivariantly.
Formal smoothness and the formal inverse-function theorem give actual
equivariant power-series coordinates. The same construction supplies
relative global-oper coordinates and equivariant cohomology frames.
This uses projectivity, never averaging by q. For the scalar projection used
below, integral Serre duality identifies H0(omega²) with the regular dual
of tangent H1. The exact scalar sequence

    0→H0(omega²)→Cech0(omega²)→Cech1(omega²)→0

admits a deck-linear projection onto its first term: O is self-injective,
and coinduction identifies the regular dual of O[G] with the injective
module O[G]. Finite free copies are injective, so the inclusion splits.
The pulled-back affine torsor cochains are projective deck modules; their
identifications and these contractions extend over the parameter ball
by finite homological perturbation. Changed boundaries are divisible by
p^(m+1), and their inverses are finite series at the current precision.

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
the claimed integral additive presentations. The homogeneous
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
presentations. The linear scalar block can equivalently be written

    R=V_aux+A_1(X)+D_1(u)+K_r(R),  v5(K_r(v))>=v5(v)+2.

Its inverse is the finite sum of iterates of K_r, with all coefficient
digits retained. This uses the preceding graph's identification with the
reduction of the same specified upper tuple. It applies to both members
when both periodic members are displayed. Nonlinear scalar terms remain
in the weighted higher-degree terms; in the late regime their extra p²
factor makes them vanish at the precision used by finite-abelian descent.
The boundary equation similarly uses the finite inverse of I+P H when
the additive feedback H is divisible by p. These constructions require
only regular deck lattices and the displayed gains, not cyclicity.

The finite nil equation is

    Lx=N eta+sum_(d=2)^(1+floor(a/m))p^(m(d-1))Q_d(x),   (8)

where L is additive and deck-equivariant, L modp=e²Phi, and each Q_d
has the presentation required by the absorption theorem. The variable
x remains the nil coordinate of the GIVEN combined curve displacement;
it is not an independently selected repair digit.

## 5. The norm coefficient is the actual lower obstruction

At x=0 the auxiliary solution is unique and equivariant, hence invariant.
Section2 identifies its curve and global-oper coordinates with actual
descended data. The constant residual in the rank-one regular normal
lattice is uniquely N eta, where N=1+sigma+...+sigma^(q-1). Restrict the same equations and projections
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
remain in L or Q_d. For m=1 choose all local comparison frames to extend the ACTUAL W2
identification supplied by compatible C3^0. At x=0 and zero leading
auxiliary coordinates, all normalized auxiliary equations are zero modp.
Their unique implicit solution therefore has v0=0 modp. Its ordinary
curve displacement starts at p³ and its graph/scalar displacement at p²;
it preserves C3^0 and the tuple through W2. Thus the constant normal
error starts at p² before normalization, and eta is in pO. Higher eta
digits need not vanish. No compatible higher reference was used.

## 6. Apply absorption to the actual given truncation

Transport coefficient Frobenius once: y=Phi(x), A=L Phi^-1. Equation(8)
is the equation of [uniform absorption](cyclic_power_nonlinear_absorption.md) with the same leading
curve digit. At n=2, m=1 and eta is in pO. The strengthened initial absorption
lemma absorbs Neta together with the nonlinear error: norm digits have
degree zero, so both lie in F1, whose preimages in E1 are divisible by p.
It gives y modp in k e^(q-1). For every n>=3, the unrestricted-norm absorption clause gives that conclusion and
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
with the pullbacks. This proves uniform finite descent, without asserting descent of the
given longest finite extension at its entire precision.

## 7. Full towers and what the uniform mechanism preserves

For a GIVEN full upper tower, its T_(a+3) recovers GIVEN T3 using C3^0.
Then for every n>=3 apply the finite result to its GIVEN T_(n+a+1),
recovering GIVEN T_(n+1) over the lower stage already recovered. Etale
tangent pullback is injective by negative-H0 Cartan--Leray. Marked maps
and their source identifications are unique because H0(T,h*T_C)=0;
the same negative normal H0, projective graded rigidity and unique flat
two-torsion lifting identify the specified tuple. The maps form an actual
inverse system along the ORIGINAL cover.

Compatible relative canonical bundles are ample. Grothendieck existence
algebraizes the smooth projective curves over the complete DVR W(k),
and the compatible finite locally free algebras (h_j)_*O_(T_j), with
multiplication, unit and deck action, give the original finite map. Its
non-etale locus is closed and proper over W(k) with empty special fiber,
hence empty. The periodic objects and their specified maps algebraize too.

The genuine-input chart, scalar projection, reduction-compatible feedback
and invariant norm comparison in Sections1–5 are the constructions also
used by finite-abelian late descent and defect-neutral Galois descent.
They do not rely on an arbitrary abstract gradient being geometric, a
simultaneous Galois closure, or a globally trivialized periodicity line.
If both periodic members are displayed, keep both scalar variables; every
feedback cycle still gains p² and the same finite inverse applies.

## 8. Exact obstructions on every partial zero locus

For Part2 fix a compatible next reference C_(n+1)^0, extend its smooth
curve and genuine global input oper, and preserve its actual tuple
through W_n in the comparison frames. Section5 then gives eta in pO.
For Part3, where n>=3, use instead the invariant ordinary-repaired
smooth reference of Sections1–5; eta can be arbitrary and eta modp=eta0.

Boundary, scalar and ordinary elimination commutes with reduction in
both cases. At every intermediate precision its nil zero locus therefore
represents genuine compatible tuples: normal graphs glue, the output
scalar is global, and its projected equation is periodicity. No locally
chosen unread graph becomes a preceding global input. Vanishing of (8)
modulo p^j means compatibility through T_(n+j), since the unnormalized
normal discrepancy starts at p^m and the tuple extends through W_(m+j).
Compatibility of the lower reference supplied norm divisibility in
Part2; it is not needed for this zero-locus identification.

Relative to the adjusted actual lower curve reference, the leading
ordinary coordinate of a compatible next upper lift is zero, by the
special-fiber block decomposition and invertible ordinary block. Its
nil coordinate is

    xbar=c e^(q-3)+d e^(q-2)+b e^(q-1),  c^5=eta0.

For Part2 eta0=c=0. Transport Phi once, setting y=Phi(x), A=L Phi^-1.
The partial-solution theorem of
[nonlinear absorption](cyclic_power_nonlinear_absorption.md)
constructs all intervening stages through modulus p^a. For every such
partial solution it absorbs the whole nonlinear error as Az, with z
divisible by p and the leading coefficients unchanged. The remaining
equation is

    A(y-z)-Neta=p^a r,
    (y-z) modp=eta0 e^(q-3)+d^5 e^(q-2)+b^5 e^(q-1).

The [additive terminal-residue lemma](cyclic_power_additive_norm.md)
gives [r modp]=-eta0-(2eta0+d^5)e in R/e². It follows from the two
identities F|S=p^a e and N|S=p^a(1+(q-1)e/2) in the free preparation
quotient S=K[[e]]/A K[[e]]. It evaluates partial solutions without
assuming that their terminal obstruction vanishes. When eta is divisible
by p, one may equivalently absorb the norm together with the nonlinear
error; the same class is then -d^5e.

Fix the displayed special-fiber nil source and target bases before
lifting them in the chart. The normal projection is actual Cech
cohomology. Boundary, scalar and ordinary elimination induces the
identity on that nil cokernel modulo p: the Fitting decomposition is
already fixed and scalar feedback gains p². Translation by the invariant
auxiliary constant changes the actual curve by p^(m+1) and graph/scalar
data by p^m, so it preserves these special-fiber bases even if its
normalized coordinate v0 is nonzero modulo p. Its nonlinear terms
retain their weights by Section4.

After preceding actual upper discrepancies vanish, a frame or elimination
change equal to the identity modulo p leaves the p^a residual unchanged
modulo p^(a+1). A nonzero lower-reference norm causes no exception: the
partial upper solution has canceled it at every earlier digit. There
is therefore no unrecorded scalar or shear in the terminal coordinates.

The normal orientation in (8) is Neta+nonlinear-Ay. Consequently

    Theta=-[r modp]=eta0+(2eta0+d^5)e.                    (10)

Every free intervening repair was included in the combined degree bound;
a smooth terminal digit adds im Psi. Such a digit can kill the class
iff eta0=d=0, in which case the nil zero-locus interpretation supplies
the genuine compatible final tuple. Exactly one coefficient Frobenius
occurs, and no additional Frobenius acts on eta0.

For Part2 this is d^5e, including a=1 (no intermediate repairs) and
n=2 using only C3^0. For Part3 it is the displayed unrestricted-norm
formula at every n>=3. Two next upper lifts have the same c because
c^5=eta0, so their terminal classes differ by (d_2-d_1)^5e. At q=5
this gives precisely the former arbitrary-reference next-obstruction
formula and constant transfer eta0. Replacing e by log(sigma) in the
degree-five compatible-reference case changes the invariant coordinate
b, not the noninvariant coefficient or its displayed class.

## 9. The explicit cyclic25 family

Over bar(F5), let

    Delta=(t^5-t)(t²+2t+3)(t²+2t+4)!=0,
    R=u(u-3), S=(u-1)(u-2)(u-t), F=RS, H=t²+2t+3.

Use smooth projective models

    Y:v²=F,
    C:k(u,kappa,gamma), kappa²=R, gamma²=S, v=kappa*gamma,
    E:gamma²=S.

The original C→Y is a connected etale double and g(C)=3; C→E is
ramified quadratic. The elliptic curve E is ordinary because its
Hasse coefficient [u4]S²=H is nonzero. Pull back V²:E^(25)→E to C:

    T=C×_E E^(25) →h C.

Over the algebraically closed field, ordinary elliptic Verschiebung
has cyclic kernel of order25. The ramified quadratic and etale
25-extensions are linearly disjoint; hence h is connected finite
etale cyclic25 and g(T)=51. The involution over Y acts by [-1] on
the elliptic cover and reverses translations, giving the actual
etale D50 map T→Y.

Its first cyclic-five intermediate has equation

    w5-Hw=gamma(u+4-2t).

For a direct etaleness check at elliptic infinity put z=u/gamma.
The right side is the affine part of z^-5-Hz^-1; the remainder is
regular of positive valuation. Thus w_O=w_U-z^-1 gives a regular
equation there, while its affine derivative is -H. The nonzero
H1(O_E) class z^-1 proves connectedness. The involution is explicitly
(kappa,gamma,w)↦(-kappa,-gamma,-w).

On Y retain the established active connection

    G=u(u-1)(u-2)(u-3), A=(t+1)²G, a=A/F²,
    r=3a''/a+(a'/a)², eta=du/v,

in the scalar convention U''=rU, with actual flat periodicity line
O_Y(W_t-O). The [genus-two active-twist theorem](../../projective_connections/genus_two_active_twists.md)
and [bad-double operator](../abelian_covers/bad_double_cubic_defect.md) give
ordinariness on Y and the five-bijective-plus-one-zero operator on C.
The canonical ordinary Y tower lifts the original etale covers and
their full tuple, supplying the required compatible reference.

For completeness the first cyclic-five source defect is certified on
exactly Delta!=0. In the D0=eta^-1 and kappa D0 frames, the two-chart
normal lattices are z² and z4; their Cech representatives are respectively
(z^-1,z) and (z^-1,z,z²,z³). Five AS powers give the actual30-dimensional
upper cohomology. Its Psi multipliers are A and A R². The original
gluing retains w_O=w_U-z^-1 and the displayed equation for w_U5.
The [generic matrices](../../../Research/computations/bad_double_dihedral5_defect_generic.json)
and [their construction](../../../scripts/deformations/cyclic/bad_double_dihedral5_defect.sage)
have block ranks10 and18, with all larger minors identically zero and
the following nonzero minors:

    det10=(t+3)^5(t+4)^5(t+1)^20 H^20,
    minor18=2 t8(t+2)^8(t+3)^8(t+4)^8(t+1)^43
              *(t²+2t+4) H^32.

They prove defect2 on the stated open set. The
[cyclic-tower section-growth theorem, Section8](../section_growth/symplectic_p_cover_section_growth.md)
propagates the first defect2<5 to the full cyclic25 source: the
nil module length below5 is unchanged by higher cyclic base change.
Thus this family satisfies every hypothesis, with no new exceptional
parameters. No new150-dimensional computation is required.

## Evidence and dependency boundary

The common geometric construction consolidates the previously audited
degree-five,25,125 and all-order comparisons. Its geometric primary
inputs are [LSZ Section4](https://arxiv.org/html/1311.6424v4#S4) for the
actual input category and corrected morphisms, and
[LSYZ Section6](https://arxiv.org/html/1404.0538v2#S6) for the obstruction
orientation and criterion. The independent
[consolidation audit](../../../Research/audits/CYCLIC_UNIFICATION_SCOPE_AUDIT_2026_09_13.md)
checks the smaller reference, all-n range and exact partial residue.
The separate [unrestricted-norm audit](../../../Research/audits/CYCLIC_UNRESTRICTED_NORM_AUDIT_2026_09_13.md)
checks both later coordinates and every partial repair without a
compatible next lower reference.
Original returned evidence and earlier independent audits remain.

The [bounded algebra checks](../../../scripts/deformations/verify_uniform_binomial_absorption.py)
pass240 basis generators,80 nonlinear equations,166650 weight budgets,
125 nonprime-field Frobenius scalings and108 exact partial carries at
q=5,25,125,625. The latter include free repairs and divisible norm
constants; another112 cases have unrestricted later norms. Degree-five
nonlinear terms occur at625. These checks take about2.62seconds and are diagnostics, not geometric or Lean verification.

The old small-power common-cover exclusions use this theorem only for
full-tower descent. They are already contained in the separate
[all-power matched two-defect exclusion](../section_growth/two_defect_nontrivial_five_exclusion.md).
That application is not an input to this proof. An arbitrary unmarked
common cover need not have a matched active connection, a compatible
next lower reference, or a full upper tower.
