# Proof: reference-relative W4 escape and exact K9 fibre

Version1,2026-09-14. Original evidence is retained unchanged. This proof
uses the audited complete fourth comparison, not a guessed coefficient
lift of the canonical reference. It includes new local rank calculations.

## 1. Actual comparison and the two fixed regular coefficients

Use the geometry and normalizations in the
[quadratic-channel proof](fourth_hodge_quadratic_channel.md) and the
[complete additive audit](../../../Research/audits/HIGH_KERNEL_ADDITIVE_AUDIT_2026_09_14.md).
In the transported scalar coordinates the complete obstruction is

    E4(H)=Q(H)-[f_hat H_hat/5]+D_regular(H) in R/(f), H in K.

The whole integral product is formed before division. D_regular is
the actual fixed mixed-additive deck-equivariant correction and
preserves every J^d. Through degree five its possible terms lie in
RH+R Phi^-1(H)+R Phi(H). No higher unknown regular term is dropped.
The actual quadratic filtration is Q(K_i,K_j) subset J^(i+j-9) in
the relevant range, and J8 subset(f).

Use the completed RREF basis nu0,...,nu42 of K. Order columns first by
(014),(104),(113),(203), then by total degree and lexicographic order.
Order rows by pivots. The leading-degree blocks are

    5:0..3; 6:4..9; 7:10..17; 8:18..26;
    9:27..33; 10:34..38; 11:39..41; 12:42.

All vectors are actual full kernel completions. The normal form in
R/(f) is obtained by reducing the rows f*s^e in increasing total
degree/lex order. Its degree-five monomials are
(041),(131),(140),(221),(230),(311),(320),(410), and its degree-seven
monomials m0,...,m3 are (241),(331),(340),(430).

Set B0=[101]nu1+[14]nu2 and h=(B0)5. Exact reconstruction gives

    h=q2*([45]s1*s3²+[41]s1*s2*s3+[91]s1*s2²+[58]s1³).

Thus [h]5=0 in the associated quotient. The two transported classes are

    v_minus=[Phi^-1(h)]5=(0,16,115,0,0,19,108,0),
    v_plus =[Phi(h)]5  =(0,62,15,0,0,10,29,0),

in field-code notation. Their independence minor is[99]. Therefore
the actual degree-five regular correction uniquely defines alpha,beta:

    [D_regular(B0)]5=alpha*v_minus+beta*v_plus.

Every later seed differs from B0 by J7, so its degree-five regular
correction is the same, even if D_regular is not k-linear. A change
of integral scalar lift adds gH to the divided comparison; in degree
five this is a multiple of h and hence zero in the quotient. Remaining
unknown degree-seven terms will be retained as an actual residual.

## 2. An odd seed solves all lower output degrees

Define, in the actual fixed alpha,beta,

    b12=[34]+[64]alpha+[12]beta,
    b15=[6]+[111]alpha+[93]beta,
    b16=[15]+[100]alpha+[42]beta,
    b11=[103]-[34]b12,
    p=[55]alpha²+[123]alpha*beta+[59]beta²
      +[90]alpha+[81]beta+[124],

and put

    H_A=[101]nu1+[14]nu2+b11*nu11+b12*nu12
        +b15*nu15+b16*nu16+p*nu27.

The independent coefficient calculation proves [E4(H_A)]<=5=0 as
an identity in k0[alpha,beta], not at finite-field test points. The
calculation uses the actual Q, NEGATIVE whole carry, and the fixed
regular term above. It includes the higher terms in every nu_i.

There is a genuine order-two symmetry, not a presumed lifted wild
deck action. The involution (u,kappa,y)->(u,kappa,-y) preserves the
theta divisor, actual square-trivial flat line and ordinary canonical
reference. It sends W to -W and D=v*d/du to -D. After the normalized
Schur column and coefficient transport, both scalar source and target
transform by H(s)->-H(-s). Thus odd H_A has an odd COMPLETE E4, including
all actual regular terms. Since f is even, there is no degree-six
obstruction. The residual is therefore

    E4(H_A)=omega0*m0+omega1*m1+omega2*m2+omega3*m3.

The omega_i are defined from this actual seed and actual comparison.
No numerical value or vanishing is assumed for them.

## 3. The exact universal terminal repair

For V in K9, Q(V,V) and D_regular(V) are in J9 subset(f).
The audited whole K8 comparison gives E4(V)=-C(q2*V9). The divided
product is additive and k-linear modulo(f): lifts of sums and scalar
multiples may be chosen compatibly, and changing a lift adds only an
f-multiple. Consequently

    E4(H+V)-E4(H)=2 Q(H,V)-C(q2*V9)=L_H(V).

This is an EXACT relative formula, not its first derivative. Moreover
L_(H+V0)=L_H for every V0 in K9, since Q(K9,K9)=0 in the quotient.

Take the completed odd vectors

    gamma0=[29]nu28+nu29,
    gamma1=[11]nu27+nu30,
    gamma2=[87]nu27+nu31,
    gamma3=nu32.

Set

    A=[64]+[67]alpha+[33]beta, B=[81]+[68]alpha+[50]beta,
    C=[2]+[38]alpha+[70]beta, D=[8]+[67]alpha+[33]beta,
    G=[42]+[14]alpha+[66]beta.

All four images vanish below degree seven. Their rows in m0,...,m3 are

    [57]  0  0  G
    0     A  B  0
    0     C  D  0
    0     0  0  [107].

Exact polynomial identities give AD-BC=[58] and determinant[44],
both nonzero CONSTANTS. The correct transpose-oriented solution is

    c0=omega0/[57],
    c1=(D*omega1-C*omega2)/[58],
    c2=(A*omega2-B*omega1)/[58],
    c3=(omega3-G*c0)/[107].

Then H*=H_A-sum c_i*gamma_i satisfies E4(H*)=0. This is noncircular:
first fix alpha,beta, then H_A, then its actual omega, then apply the
universal inverse. The relative operator stays fixed throughout this
K9 translate. The degree-five part remains h, with pivot coefficients
(0,[101],[14],0), so is nonzero.

Vanishing of the COMPLETE obstruction permits a primary preimage as
the terminal fourth source digit with rho(S+xi)=rho(S)-Psi(xi). Whole
regular primitives then give actual Hodge generators, prescribed
grading and twisted periodicity. This proves a genuine compatible W4
extension of the specified X3(H*), not only a zero of low equations.

## 4. New exact eight-dimensional fourth-compatible fibre

The parent calculation evaluates L_H_A on all sixteen K9 directions
coefficientwise over k0[alpha,beta]. Translation invariance identifies
this with L_H*.

The odd subspace has dimension10 (seven degree-nine and three
degree-eleven directions). Its image has only degrees five and seven.
The degree-five matrix is constant and has rank2. In the above
degree-five quotient order its only nonzero rows, for nu27,...,nu31,
are respectively

    (0,0,0,0,0,[37],[116],0),
    (0,0,0,0,0,0,0,[65]),
    (0,0,0,0,0,0,0,[118]),
    (0,0,0,0,0,[5],[17],0),
    (0,0,0,0,0,[44],[5],0).

The four gamma images, in the kernel of this low matrix, are
universally onto the four-dimensional degree-seven target by the
constant determinant already proved. Therefore the odd relative rank
is EXACTLY6 for every geometric alpha,beta, not merely generically.

The even K9 subspace has dimension6 (five degree-ten directions plus
the norm). Its relative matrix is constant and supported in degree6.
The only nonzero rows are

    L(nu34)=[62]*(420),
    L(nu35)=[10]*(321)+[9]*(330),
    L(nu36)=[58]*(321)+[10]*(330).

They have rank2. Images of nu37,nu38 and the norm nu42 vanish. The
whole K11 also has zero relative image in this particular family.
Odd and even targets are disjoint, so the total relative rank is8.
Its kernel has dimension16-8=8 for every actual reference value.

Since the relative formula is exact, the ENTIRE fibre in H*+K9 is

    Z4 intersect(H*+K9)=H*+ker L_H*,

an eight-dimensional affine scalar space. This result makes no claim
about any other third jets, any fifth obstruction, or scheme reducedness.

## 5. New relative fifth comparison, without an absolute fifth claim

The earlier [relative fifth audit](../../../Research/audits/NODAL_RELATIVE_FIFTH_ADDITIVE_QUOTIENT_AUDIT_2026_09_13.md),
Sections3--4, proves a local precision/Riccati formula BEFORE using
any binary nodal quadratic cancellation. That calculation is independent
of the deck rank. The fresh rank125 geometric audit checks its applicability
to the present genuine reference and original source identifications.

For a fixed third scalar H and compatible fourth origin, change the fourth
curve digit by the actual n(V). In normalized combined curve coordinates
this is x->x+5*beta, with V the same primary coefficient transport of beta
as H was of x mod5. Witt Frobenius gives Phi(x+5*beta)=Phi(x)+5*Phi(beta).
The new graph and first flat response have order25. Their squares vanish
mod625, while products with the fixed first graph of order5 survive.

The new preceding scalar has order25 and enters with another25, hence
vanishes mod625. The old scalar, old second repair, absolute higher
Taylor and source-exponential terms remain in the ABSOLUTE fifth class;
they are not omitted from it. Their variations under the new fourth
digit start at625. The delayed linear comparison is exactly A4(V),
including ordinary terms and the divided primary carry. The surviving
mixed Riccati terms are exactly the polarization 2 Q(H,V).

Thus, in the actual primary cokernel and fixed source/target scalar
identifications,

    E5(H;beta+V)-E5(H;beta)=A4(V)+2 Q(H,V)=R_H(V).

This is not differentiation of the inseparable map x->x^5. The formula
is independent of the chosen compatible fourth origin; its changes only
translate the absolute fifth class by an element of the same additive
image. On K9, A4(V)=-C(q2V9), so the entire computed L_H is also an
actual relative fifth response. In particular its rank8 image, including
all degree-seven quotient coordinates, is available for fifth repairs.

The full R_H can retain mixed coefficient transports and is not identified
with an ordinary k-linear Jacobian. Nor does this argument evaluate any
absolute fifth component. It reduces the next task to testing the actual
absolute class modulo R_H(K), allowing ALL43 fourth-digit directions.

## 6. New exact four-coordinate odd fifth quotient

Restrict the preceding eight-dimensional scalar escape fibre to odd
H. The odd K9 source has dimension10 and relative rank6, so the odd
fourth-compatible fibre F_odd is a nonempty affine space of dimension4.
Fix H in it, and write H=H_A+V0 with odd V0 in K9.

Both the odd source K_odd and odd target O_odd=(R/(f))_odd have
dimension22. In the target normal form, the degree-one coordinates are
(001),(010),(100), and the degree-three coordinates are
(021),(030),(111),(120),(201),(210),(300). The new exact calculation
finds that the complete low relative image is annihilated by

    P5(E)=(E001,E010,E100,E030+[45]E021).

The identities hold coefficientwise over k0[alpha,beta] on all22 odd
kernel basis vectors. The low matrix has a constant six-by-six minor
[42], so its image is EXACTLY this six-dimensional subspace of the
ten-dimensional degree-one/three target, for all geometric reference
coefficients. D_regular starts in J5. Also replacing H_A by H changes
the relative map on K by 2Q(V0,K), in J5. Thus neither unknown actual
term affects these low equations or the minor.

It remains essential to show that all higher odd targets can be
repaired; a low-rank calculation alone would not give an iff criterion.
On the18-dimensional odd K7, the degree-three relative map is constant
of rank2. Its16-dimensional kernel is checked explicitly. The degree-five
map on that kernel has a constant eight-by-eight minor[104], hence is
onto all eight degree-five coordinates. On K7 the actual regular term
lies in odd J7, and the change 2Q(V0,K7) lies in J7 too. These may alter
the degree-seven tail but not this computed degree-five map. For any
desired degree-five vector, choose a source by the constant minor and
then cancel its ACTUAL degree-seven tail using the four gamma directions.
Their universal matrix remains unchanged at H and includes all four
degree-seven coordinates. This proves

    (J5/(f))_odd subset R_H(K_odd).

Now solve any allowable six-dimensional low vector using the constant
minor[42], and cancel its actual high tail by the preceding construction.
Conversely P5 kills all low relative outputs. Hence

    R_H(K_odd)=ker P5 subset O_odd, dimension18.

This is a constructive equality of geometric images despite possible
mixed-additive higher coefficients. It does NOT assert that R_H itself
is a k-linear matrix. The computations are finite polynomial identities,
not generic minors or finite-field point tests. The exact
[pure-Python verifier](../../../scripts/deformations/rank125/certify_w5_escape_quotient.py)
and [matrix/minor receipt](../../../Research/computations/rank125_w5_odd_relative_quotient.json)
record them. The independent
[quotient audit](../../../Research/audits/RANK125_W5_ODD_QUOTIENT_AUDIT_2026_09_14.md)
checks the constructive lifting argument, including the unknown regular
tails and the actual coefficient transports.

Finally choose a compatible fourth origin fixed by the tame involution.
It exists by averaging the nonempty affine actual K-torsor with its
involute, since1/2 belongs to F5. Hodge and tuple uniqueness retain the
specified twist and grading. Its intrinsic absolute fifth obstruction
is odd by naturality. R_H preserves the odd/even eigenspaces: even
fourth directions contribute only even targets, so cannot alter P5.
Thus P5(C5(H)) is independent of ALL fourth choices, and its vanishing
is equivalent to membership of the odd C5(H) in the actual relative
image. A suitable fourth translation then kills that class, and a
terminal primary fifth source repair and whole primitives complete
the genuine fifth tuple. This proves the iff criterion, not its truth
at any particular H.

The ordinary scalar trace cannot give a nonzero separator here. The
complete additive fourth channel A4(K) starts in J3: the minimum
product degree is7 and one odd-log carry lowers it by4, while regular
terms start in J5. Q(K,K) starts in J1. Hence augmentation of R_H(V)
is zero for EVERY V in K. At the invariant fourth origin, oddness
makes augmentation of C5(H) zero. It is therefore zero for every
fourth choice over every H in F_odd. The geometric audit Section9
checks this argument separately. The remaining four absolute values
and their common zero set have NOT been computed.

## 7. Evidence and independent verification

Incoming source is preserved at
`../litt3-computation-data/pro_rank125_W4_existence_20260914/rank125_W4/`.
Certificate SHA256:

    7ac9b4585cb7b05ccc616b04b5a6108f42f1e4e57f984c48f1239ed7e713482c.

The inspected NumPy/Numba source was not rerun: instead the previously
audited pure-Python actual-fibre engine independently reconstructs
ALL566 quadratic coefficient vectors, all43 carry images, the FULL
kernel and quotient. Every coefficient agrees, with the old engine's
documented scalar sign corrected. All eight incoming manifest files
also pass. This avoids treating a replay of certificate arithmetic as
an independent geometric reconstruction.

The fresh finite-field/polynomial verifier imports no incoming engine
and checks the completed kernel, carry, seed, relative matrix and
universal inverse. It uses the genuine polynomial ring k0[alpha,beta].
The two independent argument audits are
[algebra](../../../Research/audits/RANK125_W4_EXISTENCE_ALGEBRA_AUDIT_2026_09_14.md)
and [geometry](../../../Research/audits/RANK125_W4_EXISTENCE_GEOMETRY_AUDIT_2026_09_14.md).

Local scripts and receipts:

- [actual coefficient replay](../../../scripts/deformations/rank125/replay_w4_existence_geometry.py)
  and [receipt](../../../Research/computations/rank125_w4_existence_geometric_replay.json);
- [independent polynomial audit](../../../scripts/deformations/rank125/audit_w4_existence_polynomial.py);
- [exact affine-fibre calculation](../../../scripts/deformations/rank125/certify_w4_escape_family.py)
  and [rank certificate](../../../Research/computations/rank125_w4_escape_family.json).

One incoming supplementary field contains an unused fifth matrix row.
The operative four rows are reconstructed and verified independently;
the unused row is not included in this proof. Preserve the original
packet, including that stale field, for provenance.

The coefficients alpha,beta,omega are NOT numerically evaluated here.
The proof establishes existence for their actual values using a
uniform inverse. No compatible W5 lift has been constructed or excluded.
