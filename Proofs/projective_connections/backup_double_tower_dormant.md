# Proof: simultaneous theta separation and unbounded cover families

[Statement](../../Theorems/projective_connections/backup_double_tower_dormant.md).
The unchanged archive, manifest and successful local replay log are
in the external
[evidence directory](../../../litt3-computation-data/simultaneous_dormant_theta_20260916/).
The maintained standard-library
[verifier](../../scripts/genus_two/theta_intersection/verify.py)
takes an explicit `--data-dir` argument pointing to its
`package/theta_intersection` subdirectory. Changes from the returned
source only make external data paths explicit; its arithmetic is
unchanged. All fifteen homogeneous certificates replayed successfully.

## The actual determinant comparison

Use \(S=SU_C(2,\omega_C)=\mathbf P^3_z\) with
\[
z_i=(A_0(T_i):A_1(T_i):A_2(T_i):1)
\]
as in the [base theta theorem](backup_dormant_theta_divisors.md).
This space is dual to the displayed Kummer-coordinate space of J(C).
Its decomposable quartic K must be reconstructed in the z coordinates.

For an actual double \(\pi=q^{(1)}\), every \(E_L=\pi_*L\) is semistable
of rank two and degree zero. Projection formula identifies the five
tests with \(H^0(C,\mathcal V_i\otimes E_L)\). The
[determinant-cut theorem](genus_two_determinant_cuts.md) makes their
common nonvanishing imply a nonzero quadric Q satisfying
\[
Q(M_\kappa^{\mathsf T}z)=c_\kappa Q(z),\qquad
Q(A_0(T),A_1(T),A_2(T),1)=0\pmod\psi,
\tag{3}
\]
where \(M_\kappa^2=c_\kappa I\) is the actual two-torsion translation
matrix and \(\psi\) is the monic dormant polynomial. The sign follows
from connectedness of the whole family of L, evaluated at
\(E_0=\mathcal O_C\oplus\kappa\). The Kummer cut of an actual
determinant quadric must be singular.

## Exact identification, not a change of Kummer frame

In codes \([d_0+5d_1+25d_2]=d_0+d_1\alpha+d_2\alpha^2\),
\(\beta=\alpha^5=[106]\), and
\[
C:\ y^2=x(x-1)(x-2)(x-3)(x-\beta),\qquad
\psi=T^5+[6]T^4+[53]T^3+[75]T^2+[81]T+[63].
\]
The input theta coefficients still use \(\alpha,T\); relative Frobenius
does not raise T to its fifth power.

The character of a pair \(\{a,b\}\) has Mumford representation
\(((x-a^5)(x-b^5),0)\), or its linear version when \(b=\infty\).
Ten exact divisor additions impose rank fifteen on sixteen matrix
entries, uniquely identifying the known projectively linear
translation. The verifier recomputes each addition and its Kummer
coordinates. This uses interpolation only to identify a known linear
map, not to infer a nonlinear identity from samples.

The decomposable point \(j(0)=(1:0:0:0)\) has theta equation
\(\kappa_1=0\). The other fifteen nodes in S are the normalized first
rows of the matrices M. The four derivative conditions at these
sixteen nodes have rank 34 on the 35-dimensional quartic space.
The true decomposable Kummer is such a quartic, so the remaining line
identifies it as
\[
\begin{aligned}
G={}&(z_0z_2-z_1^2)^2\\
&+z_1z_3\bigl(z_0^2+[107]z_0z_1+[66]z_0z_2
+[66]z_1^2+[107]z_1z_2+[106]z_2^2\bigr)\\
&+z_3^2\bigl([107]z_0z_1+[68]z_0z_2
+[14]z_1^2+[74]z_1z_2\bigr)
+[37]z_1z_3^3+[93]z_3^4.
\end{aligned}
\tag{4}
\]
For each pair, the first equations in (3) have kernel dimension six.
The combined equations have rank nine on ten coefficients. Their
unique line remains unique after algebraic closure. In the order
\[
(z_0^2,z_0z_1,z_0z_2,z_0z_3,z_1^2,z_1z_2,z_1z_3,z_2^2,z_2z_3,z_3^2),
\]
the forced quadrics and certificate determinants are:

| Pair | Coefficient codes | Determinant |
| --- | --- | --- |
| 0,1 | 1,42,109,105,17,31,114,99,48,61 | 42 |
| 0,2 | 1,112,86,9,17,98,4,55,89,18 | 53 |
| 0,3 | 1,38,84,94,97,6,77,81,96,28 | 43 |
| 0,alpha | 1,39,23,85,78,100,11,89,113,111 | 42 |
| 0,infinity | 1,53,34,13,55,13,8,106,41,14 | 124 |
| 1,2 | 1,50,75,17,17,9,30,93,81,80 | 73 |
| 1,3 | 1,64,17,67,9,69,29,67,46,13 | 106 |
| 1,alpha | 1,44,54,2,101,106,45,18,50,78 | 124 |
| 1,infinity | 1,102,47,47,13,29,122,35,6,11 | 59 |
| 2,3 | 1,80,57,27,89,46,67,36,69,32 | 86 |
| 2,alpha | 1,0,72,39,6,49,13,72,117,67 | 19 |
| 2,infinity | 1,110,28,77,87,47,97,41,59,70 | 17 |
| 3,alpha | 1,94,55,102,46,98,30,17,101,39 | 82 |
| 3,infinity | 1,9,14,90,77,27,116,66,9,9 | 56 |
| alpha,infinity | 1,2,13,7,109,26,38,25,69,119 | 1 |

## Homogeneous smoothness certificate

For each forced Q, put
\[
I_Q=(Q,G,G_iQ_j-G_jQ_i:0\le i<j\le3).
\]
The certificate proves \((z_0,z_1,z_2,z_3)^9\subset I_Q\).
The degree-nine multiples have 512 rows and 220 columns: 120 multiples
of Q and 56 for each of G and the six quartic minors. Columns and
multiplier monomials use descending lexicographic order, and the minors
use lexicographic order of \((i,j)\). The external data select 220 rows
for each Q; exact Gaussian elimination gives the nonzero determinant
in the table. Every degree-nine monomial, hence each \(z_i^9\), lies
in the ideal. It has no projective geometric zero over any extension.

Since G is the irreducible Kummer quartic, its intersection with a
nonzero quadric is a complete-intersection curve. The Jacobian
criterion makes each forced cut smooth, including all coordinate
boundaries and excluding the Kummer nodes. This contradicts the
necessary singularity of the actual determinant cut. Equation (1)
follows for all L, without the earlier 960-twist test.

## Frobenius and unbounded two/three-primary torsion

Every first double has a standard hyperelliptic model over
\(k_2=\mathbf F_{125^2}\) with all eight branch points rational.
Frobenius over this field cycles the five dormant parameters.
If L is defined over a prime-to-five degree extension of \(k_2\),
nonvanishing for one i would therefore imply it for all five.
Equation (1) excludes this.

All \(J(D^{(1)})[2]\) is rational over \(k_2\). The kernel of
\(\mathrm{GL}_6(\mathbf Z/2^a)\to\mathrm{GL}_6(\mathbf F_2)\)
is a two-group, so every two-primary torsion point also has field
degree prime to five.

For three-primary torsion use the norm decomposition, over \(k_2\),
\[
J(C)\times P_D\longrightarrow J(D^{(1)}),
\]
whose degree is a power of two; \(P_D\) is the elliptic Prym.
It induces an isomorphism on three-adic Tate modules. The known
[base Weil polynomial](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md)
reduces modulo three to
\[
(X^2+2X+2)^2\mid X^{24}-1.
\]
Thus Frobenius on \(J(C)[3]\) has order dividing 24. Its square over
\(k_2\) still has order prime to five. Frobenius on \(P_D[3]\)
lies in \(\mathrm{GL}_2(\mathbf F_3)\), of order 48. Hence its action
on the whole \(J(D^{(1)})[3]\) has order prime to five.
Higher three-powers introduce only three-power factors. Mixed
two/three torsion consequently has the same field-degree property.
No individual Prym trace is needed.

## Larger nonabelian groups

First take an actual Galois cover \(W\to Y\) with group H of order
\(2^a3^b\) and an abelian subgroup A of index at most two. Its
dormant section module U is semisimple in characteristic five.
The abelian case is the [base theta theorem](backup_dormant_theta_divisors.md).

Otherwise A is normal of index two. Each irreducible of H is a
one-dimensional character, or induced from a character of A with
two-element orbit. An invariant character extends over H over the
algebraically closed field, giving only one-dimensional representations.
All one-dimensional multiplicities vanish by the base torsion result.
For an induced character, Frobenius reciprocity identifies its
multiplicity with the character-twisted section space on the actual
first double \(W/A\to Y\). Its line has \(\{2,3\}\)-primary order,
so this space vanishes by the preceding argument. Thus U=0.

If G has a normal five-group P with quotient H, a nonzero section
representation has nonzero P-invariants. These are the sections on
\(W/P\), which have just been shown to vanish. Finally, pullback of
sections to a dominating Galois closure is injective. This proves (2)
also for non-Galois covers, without assuming preservation of positive
defect upon taking a closure.
