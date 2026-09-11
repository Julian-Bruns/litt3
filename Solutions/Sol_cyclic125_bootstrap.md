# Early bootstrap and full towers along an original cyclic125 cover

Version1,2026-09-10. Proved from the returned B125 answer, completed
by the explicit global auxiliary-oper chart below. Focused audit PASS
by /root/audit_cyclic125_finite_chart. This is audited prose, not Lean.
[Statement](../Theorems/Thm_cyclic125_bootstrap.md).

The finite comparison is new geometry; the supplied scripts test its
local algebra, not the passage from arbitrary functions to actual
Hodge repairs. In particular, the proof keeps genuine global preceding
opers even away from the compatibility locus.

## Inputs and scope

Keep the actual h:T→C, reference C7^0 and T7^0, W2 marking, full
filtered/graded tuple and actual flat square-trivial periodicity line
of the statement. Put p=5, O=W4(k), G=C125, e=sigma-1, N=sum sigma^i.
The source and normal integral lattices are free rankr=3g(C)-3 over
O[G]. Their Fitting parts have ranks r-1 and1. On the nil block,

    Psi=e²Phi, ker Psi=k e123+k e124, coker Psi=R/e²,
    R=k[e]/e125, h*(ker Psi_C)=k e124.                 (1)

Negative tangent H0, Cartan--Leray, the simple-zero base operator
and defect-two source give these facts as in the earlier cyclic
theorems. The base operator is identified on invariants first, then
on coinvariants by the norm. The integral two-affine normal Cech
sequence has a deck-linear section and primitive P. All these inputs
concern the actual cover, not an unrelated regular representation.

We use [mixed-additive norm](Sol_cyclic_power_additive_norm.md): for
A mod5=e², the norm equation Ay=Neta is soluble iff eta∈5O;
all solution reductions then lie exactly in k e124. We also use
[late descent](Sol_cyclic_power_late_descent.md), which at125 starts
at n4, but supplies neither of the early lower digits proved here.

## Proof

### 1. Equivariant charts and genuine global auxiliary inputs

Choose a descended smooth reference to the finite required height,
lifting the original etale cover and its deck action. At n3 it extends
the ACTUAL lower C3 to be recovered, not necessarily the old reference.
A smooth curve has unobstructed deformation; a projective oper on a
chosen smooth lift extends because its scalar gluing obstruction lies
in H1(omega²)=0. This extends a genuine filtered oper, not its next
periodicity equation. Spin and the actual flat two-torsion line lift
uniquely at the infinitesimal level since2 is invertible.

The reference gives a G-fixed point in the marked smooth-curve formal
deformation space. Let J be its relative augmentation ideal. The
cotangent J/J² is the contragredient of the free integral tangent
deck module, hence projective over the finite Witt group ring.
Split J→J/J² equivariantly. The resulting map from its completed
symmetric algebra is an isomorphism by formal smoothness and the
formal inverse-function theorem. Thus genuinely equivariant formal
coordinates are available; formal smoothness ALONE would not give
this conclusion in characteristic5. No averaging by125 is used.
The same projective-fiber argument gives equivariant cohomology frames.
Restrict to the finite ball where curve coordinates are p^(m+1)x.

Here is the essential global-oper completion of the finite chart.
Over this curve ball use the smooth space of GENUINE global projective
filtered opers extending the preceding one. Its affine scalar
coordinates are H0(omega²). Integral Serre duality identifies this
with the regular dual of tangent H1, so it is finite free over O[G].
The scalar sequence

    0→H0(omega²)→Cech0(omega²)→Cech1(omega²)→0          (2)

admits a deck-linear projection onto its first term. For example,
the truncated DVR O is self-injective; coinduction and the regular
duality of O[G] show that a finite free O[G]-module is injective.
Split the inclusion in(2). The pulled-back affine torsor cochains
are projective deck modules, so their identifications lift over the
finite ball. The resulting contraction extends by finite homological
perturbation: the changed boundary is divisible by p^(m+1), and all
inverses are finite series at the current precision. This also extends
the supplied normal primitive, equivariantly.

For every such global input oper its genuine higher inverse-Cartier
output exists. Introduce arbitrary LOCAL output Hodge graphs, and
normalize their cyclic vectors to obtain LOCAL output oper scalars.
These local graphs/scalars need not glue and are NOT used as preceding
input opers. Instead project the difference between local output
scalars and the genuine global input scalar to H0(omega²) using(2).
Impose equality there as the scalar equation. Its output dependence
on the input scalar gains25; hence it is an integral contracting
equation in the global scalar variables.

Solve that equation together with normal-boundary and ordinary-block
equations. Only afterward impose the remaining nil normal cohomology
equation. On its zero locus, the output graphs really glue; their
scalar is global, so the H0 projection is the identity and the scalar
equation is the ACTUAL periodicity comparison. Conversely any given
compatible upper tuple solves the system and therefore has the unique
eliminated scalar/boundary/ordinary variables. This identifies the
remaining equation with the actual tuple rather than a formal surrogate.

At finite height impose scalar equality only at the preceding precision
read by the next functor. Reduction-compatible local frames identify
that preceding graph with the same graph in the given upper tuple.
The unread top scalar digits cannot enter because of the extra25.
This is why no infinite compatible auxiliary reference is required.

The genuine input category and separate filtered/graded gluing are
those of [LSZ Theorem4.1 and Lemma4.10](https://arxiv.org/html/1311.6424v4).
The one-digit normal derivative is the actual Psi, as in
[LSYZ Theorem6.2](https://arxiv.org/html/1404.0538v2).

### 2. The finite weighted normal equation

Let n=2 or3, m=n-1. Given compatible T_(n+4), write curve, graph
and scalar displacements as p^(m+1)x, p^m u and p^m R.
Retain the exact graph equation for G_ij=((a,b),(c,d)):

    c+d s_j-s_i a-s_i b s_j=0.                        (3)

In a determinant-horizontal frame set H=(1,s)^t,
V=nabla H, D=det(H,V). The normalized vector is D^(-1/2)H, and

    r_new=det(nabla V,V)/D-D''/(2D)+3(D')²/(4D²).       (4)

For the unperturbed companion connection, D=1+s'-rs². Its linear
graph variation is r's+2rs'-s'''/2, and its complete quadratic part is

    r''s²/2+2r'ss'+r(s')²+s's'''/2+3(s'')²/4.          (5)

It need not vanish. All divisions are by units; the square-root series
is integral at5. Use corrected tilde matrices

    Jtilde=epsilon [[lambda,5lambda'/f'],[0,lambda^-1]],
    nablatilde=5partial+[[0,25r],[1,0]], lambda²=f'.     (6)

The diagonal uses the NEW graded map and the upper entry the PREVIOUS
filtered map. The actual flat epsilon remains present. The scalar
does not enter the jet transition and gains25 in the connection.

For K0=I, K_(j+1)=5partial K_j+B_rK_j, one has v5(K_j)>=j-1.
With ell changed displacement factors retain 1/(ell!(j-ell)!). A
normalized term of displacement degree d has valuation at least

    m(d-1)+j-1-v5(ell!)-v5((j-ell)!) >=m(d-1).         (7)

Graph and scalar normalization satisfy the same bound; coordinate
composition has an extra5 for each curve displacement. In particular
at m2 the quadratic curve contribution p^6/p=p^5 survives the last
digit after normalizing by p². It is not treated as square-zero.

Apply the integral equivariant boundary/scalar/ordinary inverse from
Section1. Its reduction is triangular with invertible diagonal:
normal primitive, identity in scalar feedback, bijective part of Psi.
After it the auxiliary variables v obey

    v=v0+B(x)+sum_(d>=2)p^(m(d-1))H_d(x,v).             (8)

Finite iteration modulo625 solves(8). Composition trees add the
exponents d_i-1 to the number of external factors minus one, so the
weight bound is preserved. Substituting descended constants can only
improve valuation relative to external degree; constants remain
descended and linear terms belong to the resulting L.

Coefficient Frobenius/inverse Frobenius are counted as additive
operations of degree one. At this precision only degrees2,3,4 survive
for m1, and only degree2 for m2. Thus polarization uses only units.
In the actual integral nil block the final equation is

    Lx=Neta+5Q2(x)+25Q3(x)+125Q4(x),       m1;
    Lx=Neta+25Q2(x),                       m2,          (9)

where L is additive/deck-equivariant, L mod5=e²Phi, and Q_d are
diagonals of equivariant d-additive operations at their needed
precision. The complete auxiliary error is invariant in the integral
free target, hence Neta BEFORE any obstruction-cokernel projection.
Its leading coefficient is the lower zero-line obstruction eta0.
At the initial compatible reference eta=0. This proves the finite
comparison needed here, not an all-order version of(9).

### 3. Integral binomial absorption and the given T3

Identify the regular nil deck module with Fun(Z/125,O), using
B_i(s)=binom(s,i). The exact wrap is

    eB_i=B_(i-1)-binom(125,i)B124,
    v5 binom(125,i)=3-v5(i).                           (10)

Transport coefficient Frobenius once: y=Phi(x), A=L Phi^-1.
For m1 the actual first two residual equations give

    y mod125∈P1+5P4+25P7.                             (11)

Indeed modulo5, y∈ker e²=P1. At the next digit the known nonlinear
residual has degree<=2; double integration gives P4. At the following
digit the largest cross degree is1+4=5, giving P7. The integral
binomial matrix is unitriangular; these polynomial modules are
saturated, so a divisible residual may be divided within them.
Wraps vanish at exactly the quotient precisions being used.

The complete nonlinear error therefore belongs to

    F1=5P2+25P5+125P8.

It has an A-preimage in E1=5P4+25P7+125P10. This is the a3 case
of [uniform nonlinear absorption](Sol_cyclic_power_nonlinear_absorption.md).
Directly, I(B_i)=B_(i+2) has e²If=f at these weighted precisions.
The canonical lower-precision map M=(A-e²)/5 preserves the necessary
degrees. Successive -I(5M) corrections raise valuation and remain in
E1. No division of an augmentation ideal has been asserted.

Thus Ay=f_nonlin implies A(y-z)=0 for z∈E1⊂5M. Its reduction is
unchanged. The integral norm theorem forces y mod5∈k e124, hence
d=0 in the given T3=T3^0+d e123+b e124. Applying this to GIVEN T6
recovers its GIVEN T3: change the compatible lower C3^0 by b e_C
and lift the ORIGINAL etale cover. The given marking and deformation
class identify its source with T3. Its tuple agrees by uniqueness.

This does NOT make (e23 A1)^2 harmless. The dangerous separate second
repair square is present. Equation(11) restricts the combined integral
variable, and only the combined nonlinear contribution is absorbed.

### 4. Exact initial obstruction, not merely its zero set

For arbitrary d,b, the first two residual stages can be repaired in
the chart: their degrees are P2 and P5, with primitives P4 and P7.
On the successive zero loci Section1 identifies these with genuine
compatible partial tuples through T5. Take any smooth terminal digit.
Its equation is known modulo625, and the partial equations already
give(11). Thus the complete nonlinear term is still absorbed as Az,
z divisible by5. The corrected LINEAR partial input has unchanged
leading d,b and is compatible through the preceding two residuals.

Its supplied third divided linear residue is -d^5e, independent of
partial repairs. With rho(S+xi)=rho(S)-Psi(xi), the actual normal
class is consequently

    Theta_initial(d,b)=d^5e.                          (12)

Changing a smooth terminal digit adds im Psi. There is one coefficient
Frobenius; dividing by5 or125 introduces no additional transport.
This partial-solution argument is necessary: applying absorption only
to a fully compatible T6 would prove a necessary zero set, not(12).

### 5. The second stage descends the given T4

Start from the ACTUAL compatible C3 recovered above. Normalize an
arbitrary smooth C4 auxiliary reference so its only obstruction is
eta0, and extend its genuine auxiliary oper/curve far enough. Apply
the m2 equation(9) to GIVEN T7:

    Ay=Neta+25Q2(y), eta mod5=eta0.                    (13)

The leading norm is a constant function, so y_0∈P2. The next
residual has degree<=2 and gives

    y mod25∈P2+5P4.

Hence 25Q2(y)∈F2=25P4+125P6, with A-preimage in
E2=25P6+125P8. Subtracting this preimage does not change the leading
input. The pure norm equation forces eta∈5 and leading input e124.
Equivalently eta0=c=d=0 in the primary difference
c e122+d e123+b e124, c^5=eta0.

The auxiliary C4 is therefore compatible as a CONCLUSION. Modify it
by b e_C. Lifting the original etale cover recovers the GIVEN T4,
extending its given T3 and the original marked h2. Negative normal H0,
injective tangent pullback, projective graded rigidity and unique flat
two-torsion lifting identify every specified datum. This proves B125.

### 6. Full towers and the main branch

For every GIVEN full upper tower, B125 supplies original h4:T4→C4.
Apply late descent at n4 using GIVEN T8 to recover T5→C5, then n5
using T9, and continue. Marked descents are unique and form an actual
inverse system. The already established canonical-ample algebraization
and Grothendieck existence argument produce the original finite etale
cyclic125 map over W(k), with the specified tuple and deck action.

In the main ordinary-X/source2/Galois-Y/nontrivial-five-action branch,
the exact application in
[degree25 descent Section7](Sol_cyclic_twentyfive_delayed_descent.md)
now works with actual Sylow5 order125. The deck reduction supplies
the original maps Z→T→Y'→C→Y, with cyclic125 T→Y', simple-zero Y'
of genus3 or5, prime-to5 neutral outer steps, and bad double C genus3.
The ordinary Y tower supplies the initial reference. The ordinary X
tower supplies the GIVEN upper tower, with the same canonical W2
marking. Descending it retains the same-source lifted span
X^can←Z^can→C^lift. No lift of C→Y is used.

The existing genus3 partner count <2^80000073<K applies unchanged.
Thus the reduced C250,D250,C2×D250 carriers with actual Sylow125
are excluded in this precise branch for the SAME main parameter.
Here Dn has order n. This is not a whole common-cover exclusion.

## Checks and scope

The supplied scripts were saved UNCHANGED and replayed with the
existing Sage Python:
[filtration](../scripts/b125_check_filtration.py) and
[oper normalization](../scripts/b125_check_oper.py).
All36+24 coefficient-basis absorption generators,400 nonlinear filtered
tests,25 F25 third-carry tests, independent Wronskian/cyclic-vector
normalizations and the exact K5 formula PASS. No package was installed.
They do not by themselves certify Section1's global geometric chart.

The main new proof completion is that chart's genuine GLOBAL input
oper space and scalar projection, audited in
[the finite-chart record](../Research/audits/CYCLIC125_FINITE_CHART_AUDIT_2026_09_10.md).
The all-power absorption proof is a separate algebraic advance; actual
geometric normal equations with displacement degree>=5 remain outside
the finite B125 argument. No arbitrary cyclic-power full-tower theorem
or unmarked common-cover verdict is inferred.
