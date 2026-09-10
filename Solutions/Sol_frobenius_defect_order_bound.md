# Short Frobenius strings bound a two-dimensional prime-to-five defect image

2026-09-10. Focused medium audit PASS,
/root/audit_frobenius_character_order, for the stated element-order
bound and main-pair stratum exclusion. The requested representation-
level Serre--Cartier identity is explicit in Section3. Inherited
inputs were not re-audited. No full-problem or Lean-verification claim.
[Statement](../Theorems/Thm_frobenius_defect_order_bound.md).

## 1. Claim and actual setup

Let X←f−Z−g→Y be actual finite etale maps of smooth projective connected
hyperbolic curves over k=bar(F5), with g Galois of order PRIME TO5.
Suppose active admissible nilpotent connections match, r_Y is ordinary,
and the source nilpotent tangent space U has dimension2. Assume
5 does not divide deg f and r_X is nonordinary. Write d=3g(X)-3.

For every element of the faithful image Gamma of Gal(Z/Y) on U,
either its order is at most2 or its order divides 5^ell-1 or 5^ell+1
for some 1<=ell<=d. Consequently

    |Gamma| <= max(48,4(5^d+1)).                          (1)

For g(X)=9, g(Y)=2 the condition on deg f is automatic from the
prime-to5 degree of g, since deg g=8 deg f. Put

    N=4(5^24+1), H=N+1<2^59.

There is an ACTUAL intermediate T=Z/ker(G→GL(U)) with g(T)<=H,
T→Y etale Galois of degree<=N, and the span X←Z→T has a core whose
atlas degree on X is at most64.

The existing bounded-atlas counting theorem then bounds the number of
possible genus-two curves Y in this stratum by 2^(2^800). This is
smaller than the ALREADY selected main parameter bound K. Hence this
whole prime-to5-Galois-Y/two-defect/nonordinary-X active branch is
excluded for the SAME Litt3 pair, with no degree bound on the
original source Z and no new parameter.

This does not treat ordinary r_X or a five-part of the actual Galois
group acting trivially on U. The nontrivial five-action/nonordinary-X
branch was independently excluded by two_leg_defect_orbit_bound.

## 2. The two-leg trace gives a short nilpotent string

Let V_S=H1(S,T_S), with the actual coefficient-Frobenius-semilinear
Hodge operator Psi_S. The natural trace projector for f,

    V_Z → (deg f)^-1 Tr_f V_Z = f*V_X,

commutes with Psi, including its relative twists. This is precisely
the operator/trace calculation already established in Section1 of
Solutions/Sol_defect_preserving_etale_descent.md: relative Frobenius
commutes with etale trace, and the pulled-back Hasse multiplier is
handled by the projection formula. No Galois hypothesis on f is used.

Thus V_X is a direct summand as a semilinear Psi-module. Since r_X is
nonordinary, its nilpotent Fitting part is nonzero. It contains a
nilpotent Jordan string of some length ell with 1<=ell<=dim V_X=d.
The same length occurs among the nilpotent strings of V_Z. Equivalently
the rank differences for the semilinear iterates add under the trace
decomposition. No kernel vector is merely presumed to have the same
image-depth after pullback; direct-summand preservation is essential.

Nilpotent semilinear Jordan strings over the perfect field can be
constructed as usual from successive kernels; the string matrices
have0 and1 entries. Their length multiset is determined by ranks of
Psi^j and is additive for direct sums.

## 3. The actual cyclic deck representation on V_Z is regular

Take any gamma in Gamma and lift it to sigma in G=Gal(Z/Y). Since
G has order prime to5, its cyclic subgroup J=<sigma> has prime-to5
order m0 and acts freely on Z. Put S=Z/J; Z→S is actual etale Galois.

The eigensheaves of q_*O_Z are degree-zero character lines L_chi.
Since T_Z=q*T_S, the chi-component of V_Z is

    H1(S,T_S tensor L_chi).

Every such space has dimension3g(S)-3 by negative degree, H0=0 and
Riemann--Roch, INCLUDING the trivial character. Therefore V_Z is a
multiple of the regular k[J]-module. Its Frobenius twist has the
same character: raising each character to its fifth power permutes
the characters of J.

Psi_Z is equivariant and Frobenius-semilinear. Its linearization gives
the exact sequence of k[J]-modules

    0→Frob(ker Psi_Z)→Frob(V_Z)→V_Z→D_Z→0,
    D_Z=coker Psi_Z.

Semisimplicity and regularity consequently give

    Frob(ker Psi_Z) ≅ D_Z as J-modules.                   (2)

Here is the representation-level duality, not just a dimension
comparison. Use the actual Cartier-kernel realization from Section7
of Solutions/Sol_symplectic_p_cover_section_growth.md:

    U=ker[C_1(s_Z -):H0(omega_Z²)→H0(omega_Z²)].

The Hodge operator on V_Z is Frobenius followed by multiplication by
the pulled-back quartic s_Z. Serre duality and the Cartier trace rule
give the intrinsic identity

    <Psi_Z(v),phi>=<v,C_1(s_Z*phi)>^5.                  (2a)

All relative twists are transported in this formula. Its annihilator
identity identifies D_Z^dual with U equivariantly, since Serre trace,
s_Z and Cartier are natural for deck transformations. A convention
changing Psi by a nonzero scalar changes neither this kernel nor its
characters. The identification with the descended tangent-bundle
section realization may use one common Frobenius twist; twisting
both characters together changes neither their orders nor(3).

The known actual self-duality of U restricted to any prime-to5 cyclic
deck subgroup says the two eigencharacters are either both quadratic
or a reciprocal pair. If gamma has order>2, the latter case occurs:
they are chi,chi^-1, and chi has order exactly m=ord(gamma). The
characters of D_Z are therefore chi,chi^-1 (up to the just mentioned
common Frobenius relabeling), and by(2) those of ker Psi_Z are
chi^(1/5),chi^(-1/5).

## 4. Read a graded Jordan string

Because J has prime-to5 order, the nilpotent Fitting part and its
kernel/image filtrations decompose into character spaces. A Jordan
string of the short length ell from Section2 may be chosen homogeneous
for this grading: choose an eigenvector in the appropriate head
quotient, lift it within ker Psi^ell, and apply Psi repeatedly.

More explicitly the heads of strings of length<=j form

    (ker Psi^j + im Psi)/im Psi ⊂ coker Psi.

Their successive quotients record strings of length exactly j. All
these spaces are J-stable, so the short-length head can be an
eigenvector. Its character is chi or chi^-1. Each application of Psi
raises the character to its fifth power. Its nonzero tail is in
ker Psi, whose characters are chi^(1/5),chi^(-1/5). It follows that

    chi^(5^ell)=chi or chi^-1,
    m divides 5^ell-1 or 5^ell+1.                        (3)

This argument applies separately to every gamma; the chosen short
length may depend on the homogeneous choice, but always lies in1..d.
There is no assumed bound on a Frobenius orbit from dimension2 alone.
The bounded string was supplied by the OTHER endpoint via trace.

## 5. Bound Gamma, not the entire deck group

The actual two-dimensional module U is self-dual and faithful for
Gamma, which has prime-to5 order. Every scalar in Gamma is +I or-I:
on its scalar cyclic subgroup reciprocity gives lambda=lambda^-1.
Thus the scalar kernel of Gamma→PGL2(k) has order at most2.

The prime-to5 finite projective image is cyclic, dihedral, A4 or S4;
A5 has order divisible by5. These are the same established Faber
classification inputs used in two_leg_defect_orbit_bound. For cyclic
or dihedral image, choose a lift of a generator of its rotation group.
The rotation order is no larger than that element's order, bounded
by5^d+1 from(3). The full image thus has order<=4(5^d+1). Exceptional
images have order<=24, and Gamma then has order<=48. This proves(1).

The kernel of G→Gamma can still be arbitrarily large; (1) must not
be misreported as a bound on deg(Z/Y).

## 6. Construct the cored intermediate, retaining actual maps

Put K=ker(G→Gamma) and T=Z/K. This is an actual connected etale
Galois cover of Y with group Gamma. The original map Z→T is etale.
Pick any nonzero nilpotent tangent quadratic phi_X and let phi=f*phi_X.
Since K acts trivially on U, phi descends to a regular quadratic phi_T
on T. The normalized quartics also match. Therefore

    a_X=phi_X²/s_X, a_T=phi_T²/s_T

give the SAME rational function in k(Z). The nonconstancy proof in
two_leg_defect_orbit_bound applies: a constant ratio would make a
multiple of phi_X a square root q of s_X, but the actual curvature
derivative evaluated at q is -q^5!=0. Thus

    [k(X):k(a_X)] <= 8(g(X)-1)=64.

The ACTUAL span X←Z→T is consequently cored. Its common effective
orbifold has coarse field k(X)∩k(T), which contains k(a_X). The atlas
degree of X equals this field-extension degree and is at most64.
This uses the existing cored-orbifold bridge, where the core hypothesis
has now actually been proved. We do NOT infer that X,Y have a core.

For genus-two Y, etale Hurwitz gives g(T)=|Gamma|+1<=N+1=H.

## 7. Count these actual intermediates and their quotients

Apply bounded_atlas_partner_finiteness to X with B=64, and for each
2<=h<=H to the cored intermediate T. Set

    D=63!<2^378, G0=1+8D<2^382, L=64²=2^12,
    M_h=floor((h-1)64/8)=8(h-1)<2^62.

The existing bound on genus-h possibilities is

    K_h=D(D!)^18 * 3^(4G0² L) * (M_h!)^(2G0+L).

Since log2(M_h!)<2^68, its binary logarithm is less than

    378 + 2^393 + 2^779 + 2^452 < 2^781.

There are fewer than2^59 possible h. For each T, its automorphism
group embeds into GL_(2h)(F3), by the same existing characteristic-five
automorphism bound used in the counting theorem; hence |Aut(T)|<3^(4H²).
The subgroup giving Y has order<=N<2^59 and is generated by at most
59 elements. Counting padded59-tuples gives at most

    |Aut(T)|^59 < 2^(2^127)

quotients. Thus the TOTAL number of genus-two isomorphism classes
arising this way is less than2^(2^782), and certainly2^(2^800).
No assumption that all intermediate curves of genus<=H are enumerated
or computable in practice is made.

## 8. Compare with the unchanged main parameter

For the main pair B0=336000, D0=(B0-1)!, G_big=1+8D0, L_big=B0²,
and its already fixed selection constant contains the factor

    K >= 3^(4G_big² L_big).

Since D0>=2^335998, this alone exceeds2^(2^671996), far above
2^(2^800). The finite set of genus-two quotients counted in Section7
is Frobenius-stable over F25: X is defined over F25 and the property
of admitting such cored intermediates and etale quotients is stable.
The high-prime-degree parameter gives a moduli Frobenius orbit of
length equal to that prime r>K, by the already established120-parameter
bound for a fixed genus-two class. This contradicts Section7.

The result excludes the entire stated PRIME-TO5 Galois Y-leg,
source-defect2, NONordinary-X branch, regardless of the degrees of
the original witness. It does not handle the branch where the actual
Galois group has a nontrivial cyclic five-part acting trivially on U:
then deg f is divisible by5 and the trace projector is unavailable.
No full common-cover theorem follows.

The small standard-library verifier
[verify_frobenius_defect_bounds.py](../scripts/verify_frobenius_defect_bounds.py)
checks15264 head/tail congruences and the exact integer counting
inequalities without constructing giant factorials. Its conservative
binary-log count bound has601bits, comfortably below2^800. This is
bookkeeping evidence only; the geometry is the proof and scoped audit.
