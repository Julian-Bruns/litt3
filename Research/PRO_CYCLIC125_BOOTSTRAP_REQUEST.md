# The early nonlinear bootstrap for cyclic degree 125

Establish the finite bootstrap (B125) below. A uniform mechanism now
handles all later Witt stages for every cyclic power of five. At125,
the remaining opportunity is to recover the first two lower digits
from a sufficiently long given upper lift. This would turn the current
degree25 full-tower theorem into a degree125 theorem and test a genuinely
new nonlinear mechanism: a square of the second Hodge repair can survive
where all the first-repair product estimates still look favorable.

Give a proof of (B125), or construct an actual finite-level geometric
counterexample under its hypotheses. Use the established results below
as inputs and focus on the early coupled repairs. The objective task
list at the end specifies the parts of a complete resolution. A method
that avoids explicit repair coordinates is equally welcome.

## 1. Geometry, marking and the single target

Work over k=overline(F5), p=5, W_j=W(k)/(5^j). Let

    h:T→C

be an ACTUAL connected finite etale cyclic125 cover of smooth projective
curves with g(C)>=2. Fix on C an active admissible nilpotent projective
connection and its weight-one maximal-Higgs projective periodic
Higgs--de Rham tuple. Retain the full preceding filtered flat object,
the prescribed graded identification, and its actual square-trivial
flat periodicity line. All upper special-fiber data are original
pullbacks. A compatible W_j curve carries this specified tuple through
W_(j-1), including those identifications and the flat twist.

Let V_S=H^1(S,T_S) and let Psi_S be the actual Frobenius-semilinear
Hodge-projection operator. Assume Psi_C has a bijective part of
dimension3g(C)-4 and a one-dimensional zero part, while
dim ker Psi_T=2. Use the convention

    rho(S+xi)=rho(S)-Psi_S(xi),   epsilon=[rho] in coker Psi_S.

Retain relative Frobenius twists. A coefficient Witt-Frobenius transport
fixes the abstract deck generator sigma; it does not replace sigma by
sigma^5. Put e=sigma-1.

Fix a GIVEN compatible initial reference C7^0 and its lifted ORIGINAL
cover T7^0. Use their W2 marking. The upper lift in the target can differ
from this reference at every later digit.

**(B125).** Every GIVEN compatible W7-extension T7 of this marked T2
has its GIVEN W4 truncation descend along the original map: there is a
compatible C4 extending C2^0 and a finite etale map

    h4:T4→C4

extending h2:T2→C2^0. The specified upper Hodge line, projective graded
identification and actual flat periodicity line are pullbacks.

The target recovers this particular T4, not a replacement upper curve.
It does not require the given T7 itself to descend. Its W3 truncation
must descend as part of the same conclusion; the lower C3 and C4 may
differ from the truncations of C7^0.

A positive answer starts the established late induction in Section2
and gives descent and algebraization of EVERY GIVEN full cyclic125
tower. This removes the actual five-part125 carriers in the existing
ordinary-opposite-endpoint common-cover reduction. A finite-level
counterexample would instead show that this bootstrap precision is
insufficient and identify the geometric correction or additional
look-ahead that must be studied. Such a counterexample need not claim
failure of infinite-tower descent.

## 2. Established results to use

### Actual modules, primitives and earlier descent

Put R=k[e]/e125, r=3g(C)-3. The actual V_T is free rankr over R.
Its semilinear Fitting parts are free of ranks r-1 and1. In normalized
source and target nil-block bases,

    Psi_nil=e²Phi,
    ker Psi_T=k e123+k e124,
    D_T=coker Psi_T=R/e²,
    h*(ker Psi_C)=k e124,
    h*:coker Psi_C→D_T is zero.                         (1)

Phi denotes coefficient Frobenius. These are geometric cohomology
modules, not an abstract surrogate: negative H0 and Cartan--Leray give
freeness; identify the base operator first on invariants and then use
the norm isomorphism with augmentation coinvariants. The simple base
zero and source defect2 force the exponent2.

On any genuine descended reference with the relevant oper tuple, the
integral tangent/normal H1 lattices are free over the Witt deck ring.
The pulled-back two-affine Cech complexes admit integral deck-linear
sections of Cech1→H1 and the resulting normal primitive on boundaries.
They preserve augmentation images BEFORE division. The normal line is
identified with the tangent line by the specified maximal Higgs field.
Pullback on H1(Tangent) is injective for each original etale map.
Compatible Hodge lines and marked maps are unique when they exist;
maximal graded Higgs automorphisms are scalar, hence projectively trivial.

Uniform delayed descent is already proved for degrees5 and25, including
their full-tower assertions. At25 the initial obstruction is exactly
d^5e: compatible W5 forces the GIVEN T3 to descend. The theorem cannot
simply be applied to the degree25 factor over the degree5 intermediate
of h: that intermediate has a long nilpotent part, not a simple zero.

### The later stages are already solved for every cyclic power

The following geometric theorem is established for any q=5^a, a>=2,
under the same simple-zero/source-defect2 hypotheses:

    For n>=a+1, given compatible C_n and its original T_n→C_n,
    a GIVEN compatible T_(n+a+1) forces the GIVEN T_(n+1)
    to descend compatibly along the original map.         (2)

It includes lower compatibility as a conclusion and does not assume
the existence of a compatible lower next reference.

Its mechanism is a genuine auxiliary filtered oper on a chosen smooth
lower reference, retaining its inverse-Cartier compatibility error as
a norm. All relevant preceding-scalar digits are eliminated by the
additive recurrence described in Section3. At the boundary n=a+1,
the only nonlinear term is an ordinary final product in e^(q-5),
which is a Psi-image. The all-power integral norm theorem then applies.

For q125 this covers n>=4. Thus (B125) supplies exactly the missing
starting C4. From a full upper tower, apply (2) to T8 to descend T5,
then to T9 to descend T6, and continue. Uniqueness and Grothendieck
algebraization give the full original finite etale map over W(k).
These later steps are inputs, not the new task.

### The mixed-additive integral norm theorem

Let O=W4(k), R4=O[e]/((1+e)^125-1), N=sum_(i=0)^124 sigma^i. For ANY
additive deck-equivariant L:R4→R4 reducing to e²Phi, the following
description is established as additive Z/625-modules:

    coker(L Phi^-1)≅O⊕e W3(k),  [N eta]=(125eta,0).      (3)

Therefore L(X)=N eta is soluble exactly when eta∈5O, and then the
reductions of ALL its solutions are exactly k e124. Mixed coefficient-
linear/Frobenius corrections and noncommuting coefficient operators
are allowed. Higher norm errors5Neta have zero class in this cokernel.

For the LINEAR kernel input d e123+b e124, the first two divided
cokernel classes can be repaired; the third divided linear residue is
-d^5e. The normal obstruction has the opposite sign. For a leading
norm equation with c e122+d e123+b e124 and eta0=c^5, the pure
multiplier third residue is (-eta0,-2eta0-d^5).

These are established integral algebra statements. The early ACTUAL
comparison may have coupled nonlinear terms and free-digit dependence;
neither is being assumed away by (3).

## 3. Genuine oper tools and the early precision boundary

A specified projective filtered oper extends on any chosen smooth
lower curve lift: its scalar gluing obstruction is in H1(omega²)=0.
Retain the prescribed grading and actual flat two-torsion line. The
result is a genuine higher inverse-Cartier input even when its next
periodicity equation fails. Its descended error must be kept; the
auxiliary Hodge line is not placed globally inside its incompatible
inverse-Cartier output.

In determinant-horizontal oper frames, the exact first variation for
connection perturbation ((alpha,beta),(gamma,-alpha)) and Hodge graph s is

    delta r=beta+alpha'+r gamma-gamma''/2
             +r's+2rs'-s'''/2.                         (4)

The normalization uses unit square roots, never division by5. With
lambda²=f' and the actual flat transition epsilon, the corrected
filtered/graded construction is

    Jtilde=epsilon [[lambda,5lambda'/f'],[0,lambda^-1]],
    nablatilde=5partial+[[0,25r],[1,0]].                 (5)

The diagonal uses the NEW prescribed graded map; the upper entry uses
the PREVIOUS filtered map. The scalar is absent from the jet transition.
For K0=I, K_(j+1)=5partial K_j+B_rK_j, v5(K_j)>=j-1 and

    (K5)21=5^4(r²+3r'').

With exactly l changed displacement factors, retain the coefficient
1/(l!(j-l)!), including the binomial numerator. At low levels those
terms can survive even when their counterparts vanish in (2).

Reduction-compatible local module identifications make the preceding
Hodge graph the reduction of the SAME graph in the supplied upper tuple.
In the late range, writing r_actual-r_aux=5^m R, the scalar needed by
the final transform satisfies an additive recurrence

    R=V_aux+A(X)+D(u)+K_r(R),                           (6)

where K_r raises valuation by at least2. Its finite geometric inverse
controls all scalar-feedback digits. At the early stages, retain the
nonlinear scalar normalization terms that the late precision had
discarded; establishing their combined contribution is part of the task.

Two early stages need attention. Initially every compatible third lift is

    T3=T3^0+d e123+b e124.                              (7)

Its first Hodge repair has order5. A second repair has order25, and
its square has order625, precisely the normal digit of the third carry.
Free compatible fourth/fifth digits must be eliminated as actual
deformation choices; a choice-independent scalar on (d,b) is not an
input here. The additional W7 digit may be used by the bootstrap.

Once the GIVEN T3 has descended, start from that actual compatible C3.
Normalize an arbitrary smooth C4 reference to its zero-line obstruction
eta0. Primary upper compatibility then gives a leading difference
c e122+d e123+b e124 with c^5=eta0. The auxiliary lower reference
need not be the old C7^0 truncation. At this stage the first graph square
occurs one digit before the last, and first-times-second repairs at the
last digit. Also 5^3/5^7 is NOT square-zero: quadratic curve gluing can
contribute after the Frobenius-displacement division.

## 4. New function-algebra information, already tested

Let A_j be the ACTUAL torsor function algebra modulo5^j. After etale
trivialization use binomial functions B_i(s)=binom(s,i), 0<=i,s<=124,
with pointwise multiplication. Their integral deck action satisfies

    e B_i=B_(i-1)-binom(125,i) B124, i>=1; e B0=0.

On A1, P_j=span(B0,...,Bj)=e^(124-j)A1 and P_i P_j⊂P_min(i+j,124).
These inclusions descend to the torsor and pulled-back coefficient lines.

The following integral first-product estimates are now proved:

    (e123 A2)^2⊂e122 A2+5e22 A2,
    (e122 A2)^2⊂e120 A2+5e20 A2.                       (8)

Here is a short proof to fix their precise strength. Modulo25 only the
wraps i=25,50,75,100 are nonzero, each divisible by5, so at most one
wrap survives. For c=2,3,4,5 this gives

    e^(125-c)A2⊂P_(c-1)+5P_(100+c-1).

For c2 or3, a product lies in P_(2c-2)+5P_(100+2c-2). Match its
mod-five part by e^(126-2c)B_(126-2c+j), 0<=j<=2c-2. The residual
divided by5 lies in P_(100+2c-2)=e^(26-2c)A1, proving (8).
Exact regular-function checks verify every delta-basis product:125
relative shifts account for all15,625 pairs in each inclusion.

However the second repair allowed by the first linear carry can lie
in e23A1=P101. It need not have a harmless square:

    B100*B24=B124,
    coefficient_B124((B100+B24)^2)=2 modulo5.            (9)

Both factors belong to P101; the square is outside even eA1. These
identities are exact, but (9) is not asserted to be an actual Hodge
repair. The useful question is what the ACTUAL repair equations force
on its dangerous component, including divided carries and compensating
curve/jet terms. A general assertion that all e23-products vanish in
D_T would be false.

For debugging the linear part, the pure input e123 has first repair

    e23+2e48+2e73+e98,

a second repair starting at e3, and final divided residue -e. Tests
with noncommuting operators over W4(F25), Phi(a)=-a for a²=2,
also give one coefficient Frobenius in the linear residue. Dividing
by5 does not by itself apply another coefficient Frobenius.

## 5. Actual family available for testing

The hypotheses have geometric examples. For
Delta(t)=(t^5-t)(t²+2t+3)(t²+2t+4)!=0, put

    R0=u(u-3), S=(u-1)(u-2)(u-t), F=R0S,
    Y:v²=F,
    C:k(u,kappa,gamma), kappa²=R0, gamma²=S, v=kappa gamma,
    E:gamma²=S,
    T=C×_E E^(125).

Use the composite of three ordinary Verschiebung isogenies E^(125)→E.
Then T→C is connected cyclic125 etale, g(C)=3, g(T)=251, and
T→Y has dihedral group of order250. The degree-five intermediate is
w^5-(t²+2t+3)w=gamma(u+4-2t).

On Y put G=u(u-1)(u-2)(u-3), A=(t+1)²G, a=A/F² and
r=3a''/a+(a'/a)² in U''=rU, with periodicity line O_Y(W_t-O).
The connection on Y is indigenous-ordinary. Its canonical tower lifts
the original covers and supplies the initial compatible reference.
Psi_C has five bijective dimensions and one zero line. The established
cyclic-tower Fitting theorem propagates the known degree-five source
defect2 to T; no750-dimensional matrix recomputation is needed.

This family can test the new terms or furnish a geometric counterexample;
the target concerns all actual covers with the stated hypotheses.

## 6. Objective completion list

1. Construct the early comparison from the full prescribed tuple through
   the precision used by T7, retaining coefficient Frobenius, filtered/
   graded jets, reduction identifications and the actual flat twist.
2. Track the first and later repairs together, including the divided
   first-product corrections and the surviving square of the second
   repair. Determine its actual combined normal contribution, rather
   than infer it from the unrestricted filtration alone.
3. Eliminate the available intermediate curve/Hodge digits and decide
   whether the GIVEN T4 descends. Retain lower-reference norm errors
   once the first lower digit has been recovered. The target allows
   the W7 digit to constrain earlier truncations.
4. Independently check the decisive surviving coefficient or cancellation,
   preferably by a second local derivation and an exact finite-ring test
   with a coefficient outside F5. State which checks concern algebra
   and where the actual geometric comparison is proved.
5. Give the resulting original-map bootstrap theorem or a geometric
   finite-level counterexample, and its precise implication for the
   already established late induction. Concentrate the write-up on the
   new argument; cite the supplied inputs where they suffice.

If the calculation isolates a new technical identity, pursue that
identity as the next part of this task. The equations and finite window
above are intended to support a substantial construction, calculation,
and independent review. Quality is more important than speed: take the
time needed, work through the difficult repair terms carefully, and
follow the concrete mathematical routes available before concluding.

The underlying constructions are in
[LSZ, Section4, especially Lemmas4.7/4.10 and Theorem4.1](https://arxiv.org/html/1311.6424v4)
and [LSYZ, current v2 Section6](https://arxiv.org/html/1404.0538v2).
