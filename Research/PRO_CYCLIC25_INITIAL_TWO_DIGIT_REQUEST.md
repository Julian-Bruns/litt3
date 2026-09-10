# Evaluate the two-step Hodge obstruction on a cyclic twenty-five cover

Evaluate the two-step initial Hodge obstruction on the actual family
below. The new opportunity is a multiplication filtration on cyclic
torsor functions: it controls both the first quadratic repairs and
their products with the next repair. The first obstruction is already
zero. The target is the next one, where the integral cyclic relation
first reaches the obstruction quotient.

Calculate the intrinsic class Theta_t(d,b) defined below, including
its coefficient Frobenius, and determine its zero set. In particular,
decide whether a compatible W5 lift forces d=0 and hence the GIVEN W3
truncation to descend along the original degree25 map. Either a proof
of this criterion or a different evaluated zero set answers the task.

Carry the work through construction, proof and verification using the
task list in Section5. When a promising route reduces to an unproved
identity, take that identity as the next problem and work on it. Adapt
the approach when a route stalls. The filtration and integral calculation
below are starting points; an alternative geometric comparison is equally
welcome. Concentrate the work on the new two-step comparison, using the
established inputs.

## 1. Actual curves and reference tuple

Work over an algebraic closure of F5(t), then specialize on

    Delta(t)=(t^5-t)(t²+2t+3)(t²+2t+4)!=0.

Put R=u(u-3), S=(u-1)(u-2)(u-t), F=RS, H=t²+2t+3, and take
smooth projective models

    Y:v²=F,
    C:k(u,kappa,gamma), kappa²=R, gamma²=S, v=kappa*gamma,
    E:gamma²=S.

The map C→Y is the bad etale double, whereas C→E is ramified
quadratic. The elliptic curve E is ordinary. Let

    V²:E^(25)→E

be the composite of two Verschiebung isogenies, and set

    T=C×_E E^(25), h:T→C.

This is a connected etale CYCLIC25 cover, with g(C)=3, g(T)=51.
Its unique cyclic-five intermediate T5 is the previously calculated
curve

    k(T5)=k(C)(w), w^5-Hw=gamma*(u+4-2t).

The involution on C over Y lifts by [-1] on the elliptic cover and
reverses a generator sigma of Gal(T/C). Thus the original T→Y is
an actual D50 cover. The equations specify one family of covers, not
an abstract monodromy action to be geometrically realized later.

On Y use the active admissible connection

    G=u(u-1)(u-2)(u-3), A=(t+1)²G, a=A/F²,
    r=3a''/a+(a'/a)², eta=du/v.

Derivatives are in u, in the scalar oper convention U''=rU. This
connection is indigenous-ordinary on Y. Lift the ORIGINAL etale
covers to its full canonical ordinary tower. This gives compatible
reference towers C_j^0,T_j^0, with W_j=W(k)/(5^j).

Retain the whole preceding projective filtered Higgs--de Rham tuple,
its prescribed graded identification and its actual square-trivial
flat periodicity line pulled from O_Y(W_t-O). A compatible W_j curve
carries that tuple through W_(j-1). The problem concerns lifts with
the same canonical W2 marking as these references.

## 2. Established operator and deformation inputs

Use rho(S+xi)=rho(S)-Psi(xi), with epsilon=[rho] in coker Psi.
The actual Psi maps are Frobenius-semilinear with relative twists
retained; coefficient Frobenius fixes the abstract deck algebra.
An epsilon class vanishes exactly when the compatible preceding tuple
has a compatible next curve lift. Hodge lines are unique when they
exist, by vanishing of H0 of the negative normal line.

The following facts for this family may be used as established inputs.

* Psi_C has five bijective dimensions and one zero line. On T5 the
  source defect is2 on Delta!=0 (exact generic matrices and rank
  minors have been checked).
* The actual cyclic-tower Fitting theorem propagates that defect to T:
  with mathcal R=k[e]/e25, e=sigma-1, V_T=H1(T,T_T) is free of rank6.
  Its bijective part has module rank5 and its nilpotent part rank1.
  In normalized source and target bases Psi_nil=e²Frob. Thus

      ker Psi_T=k e23+k e24, D_T=coker Psi_T=mathcal R/e²,
      h*(ker Psi_C)=k e24, h*:coker Psi_C→D_T is zero.

* On the canonical reference, the tangent and normal integral lattices
  through W3 are free of rank6 over W3(k)[sigma]/(sigma^25-1).
  The pulled-back two-affine Cech complexes admit integral deck-linear
  sections and normal primitives. Such a primitive preserves an
  augmentation image before division; the original flat twist remains
  in the actual filtered object and cancels only in its normal line.
* The cyclic-FIVE simple-defect delayed-descent theorem is already
  proved, including the initial AS quadratic cancellation and the
  later compatible-object deck-translate argument. Its initial
  cancellation requires no involution. It does not apply directly
  to T→T5: Psi_(T5) has a long nilpotent block, not a single zero line.

In particular, no new150-dimensional matrix calculation is needed.
The constant defect2 for T follows from the established first-cover
defect2<5 and restriction of the cyclic module to its quotient.

## 3. The first obstruction is already zero

Write all compatible third lifts as

    T3(d,b)=T3^0+d e23+b e24.                            (1)

Every one has a compatible W4 extension. The actual initial comparison
proves this as follows: the divided linear carry of e23,e24 has zero
image in D_T by the integral relation in Section4; first Hodge repairs
are in e23 at cochain level, and their ordinary quadratic products
are in e22, hence killed in D_T. The corrected filtered/graded functor
does not divide these products by another5. Additive next-digit
contributions on e23 cochains also vanish there.

Moreover, for fixed(d,b), all compatible W4 extensions have the SAME
next obstruction class. Indeed their free top-digit difference is in
ker Psi_T=e23 mathcal R. At this later precision products of the
first25-order changes vanish modulo625. The compatible-object
relative comparison is the negative divided integral carry on that
difference, plus augmentation-preserving additive terms; both have
zero image in D_T. Its leading coefficients see the common descended
W2 tuple, not a presumed deck action on T3(d,b).

Consequently the following is well-defined: choose ANY compatible
T4 extending(1), choose any smooth T5 above it, and put

    Theta_t(d,b)=epsilon_T(T4) in D_T.                   (2)

The choices of both the fourth compatible digit and fifth smooth
digit do not change(2). Thus a compatible W5 above T3(d,b) exists
exactly when Theta_t(d,b)=0. This is the quantity to evaluate.

## 4. New algebraic leverage for the second comparison

For the function algebra mathscr A of any actual cyclic q=5^a torsor,
set F_r=e^(q-1-r)mathscr A. There is a multiplicative filtration

    F_r F_s⊂F_min(r+s,q-1).                             (3)

After etale trivialization, use the binomial functions
B_j(i)=binomial(i,j) mod5 on Z/q. They satisfy eB_j=B_(j-1),
and their integral product identity has degree at most r+s. This
proves(3) and descends to the actual torsor, with any pulled-back
bundle coefficients. No derivation rule for e is required.
For q25 this yields

    (e23 mathscr A)^2⊂e22 mathscr A,
    (e23 mathscr A)*(e³ mathscr A)⊂e² mathscr A,
    (e23 mathscr A)^3⊂e21 mathscr A.                     (4)

These are useful for the ordinary next-digit cross products and
cubics, if the second repairs are kept in e³ in the actual comparison.

In the integral deck ring,

    e25/5 mod5=-e5-2e10-2e15-e20.                       (5)

For a free integral deck module M, this also gives

    ((e23 M ∩5M)/5) mod5 ⊂ e5(M/5M).                    (6)

Indeed write e23 x divisible by5 as e25 y+5e23 z. A first repair
against Psi=e²Frob can therefore require e³, rather than retaining
e23. Equation(6) is a controlled divided carry, not an assertion that
division preserves every augmentation ideal.

An independently proved integral linear lemma also permits MIXED
coefficient-linear and coefficient-Frobenius corrections. Put
O=W3(k), R3=O[e]/((1+e)^25-1), N=sum sigma^i. Let Phi be coefficient
Witt Frobenius. For ANY additive deck-equivariant L:R3→R3 reducing
to e²Phi, set Atilde=L Phi^-1. As Z/125-modules,

    coker Atilde ≅ O ⊕ W2(k)e, [N eta]=(25 eta,0),
    image(ker L→R3/5)=k e24.

In particular L(x)=N eta is soluble exactly when eta is divisible
by5, and then the reductions of all solutions are precisely k e24.
The lemma allows arbitrary additive corrections; they need not have
one common coefficient-semilinearity. Its proof uses vector-valued
finite division for Atilde=e²I+5C(e), allowing noncommuting coefficient
operators on the free Z/125-module O. The rank-two remainder has
e²S⊂5S, F|S=25e and N|S=25(1+12e). This identifies its cokernel and
norm and gives the primitive kernel directly, including infinite
coefficient rank. Treat this lemma as an established input.

For orientation, in the pure multiplier calculation the last divided
coordinates on leading y=c e22+d e23+b e24, eta=c, are(-c,-2c-d).
Here c,d are already Frobenius-transported. These algebraic coordinates
are not a formula for Theta: the actual multi-digit comparison and
all its geometric repair terms still have to be identified.

## 5. Complete and verify the new comparison

Execute the following task list. Each item supplies a concrete part of
the single requested calculation of Theta_t(d,b). Use Sections1--4 as
established inputs and focus the proof detail on this new comparison.

1. **Construct the actual normal comparison through W5.** Derive it from
   the weight-one filtered/graded construction and higher Taylor gluing.
   Display the normal cocycle, or an equivalent intrinsic expression,
   retaining the first Hodge repairs, their divided linear carries, the
   second repairs, and the prescribed graded/jet transitions. Specify
   the precision at which each contribution is used.

2. **Account for the repair terms after every division.** Locate the
   first and second repairs in the function filtration at cochain level.
   Determine which linear, quadratic, cubic and higher Taylor terms
   survive in D_T, using explicit identities or uniform valuation bounds.
   Equations(3)--(6) can control whole groups of products without expanding
   every local coefficient. Establish the geometric use of the mixed
   additive lemma as part of this comparison.

3. **Evaluate both coordinates of Theta_t(d,b).** Give its coefficients
   in the basis 1,e of D_T, including their dependence on t,d,b and every
   coefficient-Frobenius transport. Derive the Frobenius exponents from
   the actual comparison. Record any additional specialization exclusions
   needed beyond Delta(t)!=0.

4. **Independently check the critical coefficient.** Use a second
   derivation or an exact finite-precision calculation and reconcile any
   discrepancy. Check the obstruction sign, coefficient Frobenius,
   Theta_t(0,0)=0, and independence from the free compatible fourth digit.
   Give enough detail for an expert to verify the divisions and repairs.
   Distinguish executed algebraic checks from the argument establishing
   their geometric meaning.

5. **Determine the zero set and recover its geometric consequence.**
   Solve Theta_t(d,b)=0 over the algebraically closed field. If a nonzero
   d survives, identify the corresponding actual compatible fifth lift
   via the obstruction criterion. If only d=0 survives, recover the GIVEN
   T3 along the ORIGINAL h from C3^0+b e_C, with h*e_C=e24. Present the
   evaluated class, proof, checks and this consequence together.

The relevant construction is in
[LSZ Lemmas4.7,4.10 and Proposition4.11](https://arxiv.org/pdf/1311.6424)
and [LSYZ Section5](https://arxiv.org/pdf/1404.0538). Use literature or
exact computation where it helps resolve a specific step in the
comparison. For a quadratic
variation of the nth Taylor displacement, the coefficient is
binomial(n,2)/n!=1/(2(n-2)!), not1/n! times n changed factors.
The tilde morphism uses the previous FILTERED map and the prescribed
new GRADED map; a raw rescaled graph matrix is not that morphism.

This evaluated class determines the next research step. A vanishing
criterion d=0 gives the initial two-digit descent mechanism to test
at later levels. A surviving nonzero d supplies an actual compatible
fifth lift outside initial descent, whose surviving term becomes the
next obstruction to study. The requested result is this complete
initial calculation and its finite-level geometric consequence.

Quality is more important than speed. Take as much time as you need to
carry out this task list and check the result. Do not take shortcuts on
the difficult comparison or its verification. Before concluding, revisit
any unresolved item for which a concrete calculation, lemma or alternative
approach remains available.
