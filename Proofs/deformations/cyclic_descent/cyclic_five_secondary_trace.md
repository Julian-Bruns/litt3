# Proof: relative repairs vanish in the cyclic coinvariant obstruction

[Statement](../../../Theorems/deformations/cyclic_descent/cyclic_five_secondary_trace.md).
Integrated2026-09-11 from the returned cyclic-five proof and the scoped
general-mechanism/selected-closure audit. No assertion about the absolute
secondary scalar is needed in this lemma.

## 1. Actual cochains and the first two filtrations

Use two affine charts pulled back from C. The tangent and Hodge-normal
cohomology modules are free over W2(k)[C5], of rank3(g(C)-1); the normal
line is the tangent line by the maximal Higgs identification. The
negative normal line has H0=0. Therefore its Cech complex has an exact
sequence 0→C0→C1→H1→0 with integral deck-linear cohomology section and
the associated unique boundary primitive. Projectivity of H1 supplies
the section; no averaging by five is used. These are the actual
descended-reference modules of neutral_galois_witt_descent.

On an AS chart w^5-Hw=f with sigma(w)=w+lambda, lambda^4=H≠0, let P_j
be polynomials in w of degree at most j. Finite differences give

    e²A=P2, e³A=P1, eA=P3,
    P2*P1+P1*P1 ⊂ P3.

The chart change adds a base function to w, so the filtration is
intrinsic to these pulled-back charts. Descended differential operators
and coefficient Frobenius preserve it, with their relative twists.
The same statements apply to pulled-back coefficient lines.

Choose any descended smooth third reference and a genuine global
auxiliary oper extending the existing input. Its possibly nonzero
next compatibility error is retained as a descended cochain, hence is
in the norm image e⁴. Smith factors (units,e²) imply that a solution
of the primary equation has tangent class in e²V_T and that differences
of two solutions lie in e³V_T. Pullback of the base obstruction is zero
in R/e², so solutions exist. Their space has dimension two.

The integral sections choose first curve representatives in e² and
relative representatives in e³. The primary normal gluing error is
exact and in the same respective images. The boundary primitive then
chooses actual first Hodge repairs in e², with differences in e³.
First frame and graded restorations are linear in these repairs and
their derivatives; square-root normalization only divides by two.
Thus first coefficients are P2-valued and relative ones P1-valued.

## 2. The full relative fourth comparison

Compare two genuine compatible third lifts, retaining their preceding
filtered objects, the prescribed next grading, and the flat twist.
The weight-one construction uses

    Mtilde=[[a_new,5b_old],[0,d_new]],
    nablatilde=5d+[[5alpha_old,25beta_old],[gamma_new,5delta_old]].

These are the filtered/graded maps of
[LSZ Lemma4.10](https://arxiv.org/html/1311.6424v4#S4), not a division
of an arbitrary raw graph overlap. Previous-tuple first changes enter
at order25, additively. In a local oper frame, the Taylor recursion
has v5(K_j)≥j-1; retaining the binomial numerator also controls changed
Taylor factors with factorials divisible by five. Modulo125, two
changes of divided Frobenius displacement contribute zero. All needed
linear, jet and cubic Taylor terms remain in the comparison.

The exact graph overlap separates the next normal difference into:

1. the first linear normal comparison after its integral repair and
   division by five;
2. additive final-digit expressions in relative first corrections;
3. ordinary quadratic differences of first corrections.

This is the normal obstruction of
[LSYZ Section6](https://arxiv.org/html/1404.0538v2#S6). The second terms
lie in e³. The third lie in P2*P1+P1²⊂P3=eA. Normal projection and
Cech cohomology preserve these images, so both vanish in O_T/eO_T.
Only the divided linear carry still requires an integral argument.
In particular a square of an ABSOLUTE P2 repair may survive; this proof
does not discard it or determine the constant.

## 3. Division loses powers, but leaves one e

For any free M over W2(k)[e]/((1+e)^5-1),

    ((e³M intersect 5M)/5) mod5 ⊂ e(M/5M).

Indeed if y=e³a lies in5M, then abar∈e²Mbar. Write a=e²b+5c and use

    e^5=-5e-10e²-10e³-5e⁴

to obtain

    y/5=-(e+2e²+2e³+e⁴)b+e³c mod5.

The actual relative first normal cochain and its integral primitive
lie in e³. With the chosen section s and primitive Q, its repaired
cochain is s*cl(z); its class belongs to e³M intersect5M because the
relative tangent direction lies in ker(Psi). The displayed inclusion
therefore puts the DIVIDED class in eMbar. No interchange of division
with an augmentation ideal is used. Coefficient Frobenius fixes the
abstract deck generator after the source/target twists are identified.

The last smooth curve digit changes rho by a Psi-image. Regular frame
changes and different primitives change the normal representative by
a boundary. Thus every term of the relative obstruction vanishes in
O_T/eO_T. This proves constancy on the complete plane, not just a
finite sample of parameter values.

Finally, on a regular module, ordinary trace is augmentation followed
by the norm identification with the downstairs module. Apply this on
both sides of the actual Hodge map. Right exactness identifies its
coinvariant cokernel with O_C. This gives the claimed trace formulation.
