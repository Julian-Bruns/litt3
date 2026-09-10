# Uniform delayed descent along a cyclic-twenty-five cover

Establish a uniform descent theorem from the initial cyclic25 Hodge
calculation. The initial obstruction is now known exactly: a compatible
fifth Witt lift forces the given third truncation to descend. The new
opportunity is to turn that calculation into a mechanism that works at
every later level, where quadratic corrections become simpler but the
lower compatible reference is no longer available in advance.

The target is the single theorem (D25) below, including its full-tower
consequence. Give a proof, or an actual finite-level counterexample
within the geometric hypotheses. Use the established results as inputs
and concentrate on the later-level comparison. The objective task list
at the end describes the pieces of a complete resolution; alternative
geometric methods are welcome.

## 1. The actual geometric data and the target

Work over k=overline(F5), put p=5 and W_j=W(k)/(5^j). Let

    h:T→C

be an actual connected finite etale cyclic25 cover of smooth projective
curves, with g(C)>=2. On C fix an active admissible nilpotent projective
connection and its weight-one, maximal-Higgs, projective periodic
Higgs--de Rham data. Retain the full preceding filtered flat object,
the prescribed graded identification, and the actual square-trivial
flat periodicity line. All upper data are their original pullbacks.

A compatible W_j curve carries this specified tuple through W_(j-1),
with its graded identifications and periodicity twist. Compatibility
uses the higher inverse-Cartier construction, not just a lift of the
underlying curve or a new connection with the same reduction.

Let V_S=H^1(S,T_S). The actual Frobenius-semilinear Hodge-projection
operator is Psi_S, and the obstruction convention is

    rho(S+xi)=rho(S)-Psi_S(xi),   epsilon=[rho] in coker Psi_S.

Relative Frobenius twists are retained. Fix a generator sigma of the
original deck group; coefficient Witt Frobenius fixes its abstract
group algebra. Assume Psi_C has a bijective part of dimension3g(C)-4
and a one-dimensional zero part, and that the pulled-back connection
on T has defect2, meaning dim ker Psi_T=2.

Fix an initial compatible reference C5^0 and its lifted original cover
T5^0, and use their W2 marking. At later stages C_n may be ANY compatible
lift with this marking, not necessarily the truncation of C5^0.

**(D25).** For every n>=2, suppose compatible C_n and its pulled-back
cover T_n→C_n are given. If the GIVEN T_n has a compatible W_(n+3)
extension, then its GIVEN W_(n+1) truncation admits a finite etale map

    T_(n+1)→C_(n+1)

to a compatible lift of C_n, extending the original marked map. Its
Hodge line, projective graded identification and flat periodicity twist
are the pullbacks of the lower ones.

The assertion recovers this particular truncation of the supplied
upper lift, not a replacement upper curve. For n>=3 the existence of a
compatible C_(n+1) is part of the conclusion. The n2 case is established
in Section2. A proof for the later levels should also show that every
GIVEN full compatible Witt tower on T with this marking descends along
h, and that the resulting compatible maps algebraize to the original
finite etale cover over W(k).

## 2. Established inputs

These results, including their geometric identifications, are available.

### The actual operator and cochain modules

Write R=k[e]/e25, e=sigma-1 and r=3g(C)-3. The actual V_T is free of
rankr over R. Its semilinear Fitting parts are free of ranks r-1 and1;
the first is bijective. In normalized source and target nil-block bases,

    Psi_nil=e²Phi,
    ker Psi_T=k e23+k e24,
    D_T=coker Psi_T=R/e²,
    h*(ker Psi_C)=k e24,   h*:coker Psi_C→D_T is zero.       (1)

Here Phi is coefficient Frobenius. These are actual cohomology modules.
Negative H0 and Cartan--Leray give their freeness and identify the base
operator on invariants; the norm then identifies those invariants with
augmentation coinvariants. Source defect2 supplies the exponent2.

On any actual descended reference at a precision where the relevant
tuple exists, the tangent and normal H1 lattices are free over the
corresponding Witt deck ring. The pulled-back two-affine Cech complex
has an integral deck-linear section of Cech1→H1 and the resulting
normal primitive on boundaries. These preserve augmentation images
before division. The normal line is identified with the tangent line
by the specified maximal Higgs field. These statements do not create
a missing Hodge line on an incompatible lower reference.

Pullback on H1(T) for each finite etale map is injective, with no degree
restriction. A compatible Hodge line is unique when it exists, because
its normal line has H0=0. The actual flat two-torsion line is retained
in every previous tuple; it cancels only in the normal coefficient line.

### The completed initial cyclic25 theorem

Relative to the given C5^0,T5^0, every compatible third lift is

    T3(d,b)=T3^0+d e23+b e24.

Each has a compatible fourth extension. All such fourth extensions
have the same next obstruction, and the actual geometric calculation is

    Theta(T3(d,b))=d^5e in D_T.                            (2)

Consequently a compatible W5 extension exists exactly when d=0. Then
the GIVEN T3 descends to C3^0+b e_C, with h*e_C=e24. This initial
theorem holds under the general hypotheses of Section1, not only for
one explicit parameter or in the presence of an involution.

Its main new integral ingredient is, for the actual lifted torsor
function algebra A2 modulo25,

    (e23 A2)(e23 A2) ⊂ e22 A2+5e² A2.                     (3)

The proof chooses integral first repairs in e23, next linear repairs
in e3 and quadratic repairs in e20. After division, the quadratic
carry is killed in D_T. The remaining actual normal comparison is

    Theta=-[L(X0+5X1)/25] in D_T,

where L is additive and deck-equivariant, reducing to e²Phi. This
geometric identity is established for the initial compatible reference.
Its extension to non-reference later tuples is the new task.

### Integral algebra, including mixed additive corrections

For the function algebra A of any cyclic q=5^a torsor set
F_j=e^(q-1-j)A. Then F_i F_j⊂F_min(i+j,q-1). It follows by the
binomial-function basis after etale trivialization and descends to the
actual torsor, including pulled-back bundle coefficients. At q25,

    e22A*e22A⊂e20A,  e22A*e23A⊂e21A,
    e23A*e23A⊂e22A,  e23A*e3A⊂e²A.                       (4)

For a free integral deck module M,

    ((e^r M∩5M)/5) mod5 ⊂ e5(M/5M),  5<=r<=24.           (5)

This uses e25/5 mod5=-e5-2e10-2e15-e20. It is a controlled colon
identity, not a general permission to commute division with e^r.

The following stronger integral linear theorem is also established.
Let O=W3(k), R3=O[e]/((1+e)^25-1), N=sum_(i=0)^24 sigma^i. For ANY
additive deck-equivariant L:R3→R3 reducing to e²Phi, put Atilde=L Phi^-1.
As additive Z/125-modules,

    coker Atilde ≅ O⊕W2(k)e,  [N eta]=(25eta,0).           (6)

Thus L(x)=N eta is soluble exactly when eta is divisible by5, and
then the reductions of all solutions are exactly k e24. Arbitrary
mixed coefficient-linear/Frobenius corrections are allowed, including
noncommuting coefficient operators. In particular a higher error5N eta
has zero class in this cokernel. The theorem concerns the linear
operator once its geometric use has been justified.

For a kernel input a e23+b e24, the repaired second divided LINEAR
residue is -a^5e. The normal obstruction has the opposite sign. More
generally, for a leading norm equation with x=c e22+d e23+b e24 and
eta0=c^5, the pure multiplier residue is (-eta0,-2eta0-d^5). These
last coordinates are algebraic checks, not an assumed formula for
the unknown later geometric obstruction.

The cyclic-FIVE version of (D25), with one rather than two extra
digits, is already proved for every level. It uses comparison of
compatible upper objects and then their marked deck translates. It
does not apply directly to the degree-five factors of h: the middle
curve has a long nilpotent block rather than a simple zero line.

## 3. Local progress toward the new comparison

The following tests suggest a manageable uniform proof and pinpoint
the first later stage that needs particular care.

Normalize an arbitrary smooth next lower curve so its Hodge obstruction
has only the zero-line coordinate eta0. Lift the original map as a
curve cover. First compatibility of the given upper lift then gives

    xi=c e22+d e23+b e24,  c^5=eta0.                       (7)

Its marked deck translate is another compatible upper lift and

    [sigma T_(n+1)]-[T_(n+1)]=e xi=c e23+d e24.             (8)

This uses an action on the marked lifting torsor, not an assumed
extension of sigma to an automorphism of T_(n+1). It suggests comparing
two genuinely compatible upper objects before taking the deck
difference. A relative secondary formula a^5e would detect eta0 in
the constant coordinate by naturality. One must also show that, once
eta0=0, later lower-reference errors cannot cancel the d direction.

Put m=n-1. The first Hodge changes have order5^m; the three-digit
comparison reaches the normal digit5^(m+2). The elementary order counts
are:

| Induction stage | First square | First times second repair |
| --- | --- | --- |
| n=2 | one digit before the last; divided carry needed | at the last digit |
| n=3 | at the last digit; ordinary product | vanishes at this precision |
| n>=4 | vanishes at this precision | vanishes at this precision |

These counts and all relevant products in (4) have been checked
exactly. They do not yet identify every actual reference-dependent
cochain in the required augmentation image.

For n>=4 the common descended tuple includes its W3 data. At n=3 it
includes only W2: a compatible upper H3 can contain a non-descended
25-digit. It therefore takes an additional argument to treat the
three-digit relative coefficient as deck-equivariant. The actual oper
jet presentation is useful here. In a determinant-horizontal frame,
rescale a Hodge generator ell so det(ell,nabla_partial ell)=1, using a
unit square root, and put m=nabla_partial ell. Then

    nabla_partial ell=m,   nabla_partial m=r ell.

For a coordinate change f and lambda²=f', the corrected construction is

    Jtilde=epsilon [[lambda,5lambda'/f'],[0,lambda^-1]],
    nablatilde=5partial+[[0,25r],[1,0]].                    (9)

The diagonal transition uses the NEW prescribed graded map; the upper
entry uses the PREVIOUS filtered map. The actual flat twist epsilon
remains present. The first change r1 of the preceding scalar is linear
in first repairs; it acquires two extra factors of5 in (9). This may
control the n3 reference dependence, but that geometric conclusion is
part of the requested proof.

For Taylor gluing put K0=I and K_(j+1)=5partial K_j+B K_j, with
B=[[0,25r],[1,0]]. The bounds v5(K_j)>=j-1 hold. Exactly l changed
displacement factors contribute a denominator l!(j-l)!, rather than
j! without its binomial numerator. In particular

    (K5)_21=5^4(r²+3r'').

Terms with factorials divisible by5 must be included at their actual
precision. The initial K2,K3,K5 and previous-scalar precision have
independent exact checks.

One useful warning for the comparison: e23A*e2A and e22A*e3A need
not lie in e²A. The first norm repair in (7) can require e2, whereas
the kernel-only first repair needs e3. At n3 the problematic
first-times-second terms should disappear by their 5-adic order,
not by an incorrect multiplicative-filtration claim.

## 4. A concrete family for geometric testing

The hypotheses have actual examples. On

    Delta(t)=(t^5-t)(t²+2t+3)(t²+2t+4)!=0,

put R0=u(u-3), S=(u-1)(u-2)(u-t), F=R0S and take smooth models

    Y:v²=F,
    C:k(u,kappa,gamma), kappa²=R0, gamma²=S, v=kappa gamma,
    E:gamma²=S,   T=C×_E E^(25).

The map E^(25)→E is the composite of two ordinary Verschiebung
isogenies. Thus h:T→C is cyclic25 etale, g(C)=3 and g(T)=51.
The unique degree-five intermediate is given by

    w^5-(t²+2t+3)w=gamma(u+4-2t).

Use the pullback from Y of the active connection

    G=u(u-1)(u-2)(u-3), A=(t+1)²G, a=A/F²,
    r=3a''/a+(a'/a)²

in the scalar convention U''=rU. Its flat periodicity line comes from
O_Y(W_t-O). The connection on Y is indigenous-ordinary. Lifting the
original covers to its canonical tower supplies the initial reference.
On C there are five bijective dimensions and one zero line; T has
defect2 throughout Delta!=0. This example may be used for debugging
or a geometric counterexample, while the theorem asks for the stated
general simple-defect mechanism.

## 5. Complete the uniform theorem

Execute the following objective task list as parts of this one theorem.

1. Construct the relative three-digit normal comparison for compatible
   upper lifts over a common descended T_n, retaining the full previous
   tuple and corrected graded/jet maps. Establish exactly what reference
   data it sees. Treat n3 explicitly and then give a uniform precision
   argument for n>=4.

2. Account for all divided linear repairs and the surviving ordinary
   quadratic terms. Establish the existence/choice independence of any
   secondary obstruction used, and identify the geometric use of (6).
   Track the sign and the single coefficient-Frobenius transport; compare
   against the already known initial formula (2).

3. Use the actual marked deck action or an alternative intrinsic argument
   to decide whether compatible T_(n+3) forces eta0=d=0 in (7). This
   includes control of the later errors of a lower reference after it
   becomes compatible, rather than assuming it already extends further.
   Resolve the new comparison identities encountered along the way.

4. Recover the GIVEN T_(n+1) along the ORIGINAL map and prove the
   full-tower consequence. If the assertion fails, exhibit the actual
   compatible finite-level curve/tuple responsible and evaluate the
   surviving term; this determines whether a longer delay or a new
   hypothesis is required.

5. Independently verify the decisive new step: check the limiting n3
   precision, the reference-dependent contribution and any integral
   division by a second derivation or exact finite-precision test. Give
   a self-contained proof with enough detail to replay these checks.

The constructions are
[LSZ Lemmas4.7,4.10 and Proposition4.11](https://arxiv.org/html/1311.6424v4)
and [LSYZ, v2 Section6, including(6.0.1)](https://arxiv.org/html/1404.0538v2).
Use the previous filtered morphism AND the new prescribed graded
morphism in the tilde construction. Both objects in a relative
filtered comparison must genuinely exist at its asserted precision.

A proof supplies the missing uniform cyclic25 descent mechanism for
our bounded-genus carrier strategy; the subsequent counting argument
is separate and already available. An actual counterexample identifies
the first later-level failure and tells us whether to change the delay
or the carrier strategy. The initial calculation and pure linear
theorem are the starting point, not the requested new result.

Quality is more important than speed. Take the time needed to complete
the comparison and its independent checks. Avoid shortcuts at the
reference and division steps. If a promising argument reduces to a
concrete new identity, work on that identity and pursue the available
routes before concluding.
