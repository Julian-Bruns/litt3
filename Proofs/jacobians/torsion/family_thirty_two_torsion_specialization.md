# Proof: two coprime Hasse minors and a parameter bound

Apply the proved [polynomial Hasse-jet criterion](../../../Theorems/jacobians/torsion/superelliptic_single_point_torsion_test.md)
with covering exponent2, degree5 and N=32. Put F=F_t(x),
F_r=[z^r]F_t(x+z), and H(s)^2=F_t(x+F s)/F with H(0)=1.
Writing H=sum A_r s^r, its polynomial recursion is
2A_r=F_r F^(r-1)-sum_(j=1)^(r-1) A_j A_(r-j).
Induction gives deg_t A_r<=r and deg_x A_r<=4r.

The exact matrix has fifteen rows n=17,...,31 and fourteen
columns i=0,...,13, with entry A_(n-i). Let H1 be its determinant
after deleting row31, and H2 after deleting row17. Their t-degrees
are at most238 and252: the respective row-index sums minus the
common column-index sum91 have those values.

There is a strict x-degree improvement. The top coefficient at
degree4r in A_r vanishes whenever5 does not divide r. Indeed in
characteristic five F_1,...,F_4 have x-degree at most4-r, while
F_5=1. Taking the top part at weight4r in the recursion gives the
unique series H_top(s)^2=1+s^5 with constant coefficient1. It is
a series in s^5, so the claimed vanishing follows. Thus
deg_x A_r<=4r-1 when5 does not divide r.

For H1, the row residues modulo5 have counts (3,2,3,3,3),
whereas its column residues have counts (3,3,3,3,2). No
determinant permutation matches every residue. Each term loses
at least one x-degree from its bound4*238, giving deg_x H1<=951.
For H2 the row counts (3,3,2,3,3) are likewise incompatible
with the column counts, giving deg_x H2<=1007.

Now specialize t=alpha in F125 with alpha^3+alpha+1=0. The
[new exact source](../../../scripts/oct02_reciprocal_torsion32_specialization.sage)
checks every jet recursion, computes both determinants by Bareiss
elimination with every polynomial division exact, and verifies
u H1(alpha,x)+v H2(alpha,x)=1. Their specialized degrees are
EXACTLY951 and1007. Therefore both generic x-degree bounds are
equalities, neither degree drops at this specialization, and
R(t)=Res_x(H1,H2) is nonzero: its specialization is the nonzero
resultant of these coprime polynomials. This degree-preservation
step rules out a spurious inference from two determinants whose
common generic factor could disappear at infinity.

The Sylvester determinant gives
deg R<=951*252+1007*238=479318.
Every nonbranch thirty-two torsion Abel point annihilates every
maximal jet minor, hence H1 and H2, so its parameter is a root
of R. The resultant is over F5 and nonzero, proving the numerical
bound and Frobenius stability. An exceptional Frobenius orbit has
size at most479318. Every Weierstrass class P-O is killed by2,
so these six points always belong to the asserted packet.

For the alternate model, translation X=x+1 identifies its four
fixed branch roots with0,1,2,3 and replaces S by t=S-1. Infinity
and parameter field degree are preserved. The established selected
main parameter degree>(336000)^2 exceeds479318; no parameter is
changed. The low-degree backup is outside this consequence.

## Exact evidence and scope

The [certificate](../../../../litt3-computation-data/oct02_reciprocal_torsion32_specialization.json)
contains both determinants and both Bezout multipliers in the
basis1,alpha,alpha^2, including the modulus, row/column indices
and degree checks. Certificate SHA256:
7d8d83c55c89d30b24cf103bf162ff52b1c4b14d9da4b41c0fc438d64b26a303.
Source SHA256:
1a1c236a904b61efe7e4f8a8ffe4e8fdaf4395bc354722d97536c4b485c797a2.
Run the source with Sage, from the repository root, to reproduce
the polynomial identities and saved certificate. The successful
arithmetic took2.76sec on one leased core; startup included about
five seconds. A preceding run completed the mathematics and failed
only in JSON serialization of Sage integers; the corrected repeat
is the recorded successful certificate.

The [independent focused whole-argument review](../../../Research/audits/THIRTY_TWO_TORSION_FAMILY_AUDIT_2026_10_02.md)
passed the exact criterion, top-degree residue loss, specialization
degree preservation, resultant bound and selected-parameter scope;
no numerical program was replayed. The particular alpha fiber itself
has no nonbranch thirty-two torsion point, directly by its Bezout
identity. Other low-degree parameters have not been classified.

No resultant expansion or geometric point enumeration is needed.
The new specialization is independent of the earlier N=8 packet;
that theorem now uses the later backup torsion input directly.
The proof does not identify any
canonical-form divisor on an etale source, supply an X-map, or
exclude the distinct-phase primitive branch by itself.
