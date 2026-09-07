# Proof: retain the actual rank-three extension while interpreting the radical

[Statement](../Theorems/Thm_atlas_liftable_radical.md).
This record supplies an intrinsic geometric interpretation of the
remaining rank problem. It does not settle its generic-rank assertion.
Use the ACTUAL extension and nonsingular Frobenius form reconstructed by
`intrinsic_atlas_incidence` and `hermitian_atlas_extension_criterion`.
The fixed-curve scalar comparison includes every R equation and the
normalization; no weak N point is substituted for this hypothesis.

Write pi:E3->V. In the untwisted case det V=det E3=omega. Its actual
osculating flag has K=pi^-1(omega^-1 u). Here u:omega^-1->V is a
subbundle injection, equivalently a nowhere-zero section of E2=V omega.
The nonzero class of O->K->omega^-1 is the fixed kappa in H1(omega).

## 1. The Serre hyperplane consists exactly of liftable sections

Tensor the actual extension alpha by omega. The cohomology sequence
contains

    H0(E3 omega) -> A --partial_alpha--> H1(omega).

The connecting map on v is precisely the Serre pairing of alpha with
v, with the determinant identification V^vee omega=V. Moreover
partial_alpha(u)=kappa, by the normalized actual osculating extension.
After identifying kappa with1, denote this functional by lambda_alpha.
It follows directly that

    H_alpha=ker lambda_alpha=image H0(E3 omega),
    A=ku direct-sum H_alpha.

Since dim A=4n, H_alpha has dimension4n-1. This is an intrinsic
hyperplane supplied by the actual rank-three extension. It is not an
arbitrary complement to ku chosen to make a matrix invertible.

Every A_s kills u. Thus in the displayed direct sum it has zero first
row and column and restriction B_s on H_alpha. Consequently

    rad A_s=ku direct-sum rad B_s.                         (2)

The scalar-Higgs quotient theorem identifies ker M_s with rad A_s/ku.
More explicitly, for a trace-free phi in ker M_s choose a global r
with phi(u)|D_s=(r u)|D_s and put

    v=(phi-r Id)(u)/s.

Its class modulo ku is independent of r: another choice differs by a
multiple of s. Subtract lambda_alpha(v)u to obtain its UNIQUE liftable
representative. This gives (1) without choices of sections over D_s.
Conversely the preceding radical theorem constructs the unique Higgs
evaluation preimage of s v; taking its trace-free part inverts this map.

The kernel is odd-dimensional, at least1. This parity statement still
does not distinguish dimensions1,3,5,7,9 on the previously allowed
normal-corank strata.

## 2. Lift every Higgs field to the ACTUAL atlas bundle

Tensor O->E3->V by V^vee omega. The resulting exact sequence is

    0 -> V -> Hom(V,E3) omega -> End(V) omega ->0.          (3)

The left term is V because det V=omega. Since V is acyclic, both its
H0 and H1 vanish. Thus the middle map induces an isomorphism on H0.
For a Higgs field phi on V let Z:E3->E3 omega be its unique lift,
factoring through pi and the middle section of (3). It kills e.
Conversely every such Z factors through V and induces phi. In a local
frame beginning with e, its trace equals trace phi. Hence the same
isomorphism holds on trace-free fields.

This lift is a holomorphic bundle map, not a horizontal map for the
projective connection, and not an infinitesimal unitary automorphism.
No connection or Frobenius-compatibility condition is silently added.

## 3. The extra kernel is an exact parabolic-Higgs condition

Let D=D_s with its full Cartier-divisor structure. Because u defines
a line SUBBUNDLE and K is its actual inverse image in E3, the following
conditions on the restrictions to D are equivalent:

    Z(K)|D subset K omega|D;
    phi preserves (omega^-1 u)|D;
    phi(u)|D=r_D u|D for a unique r_D in H0(omega|D).

The uniqueness uses that u remains a direct summand locally over O_D,
also when D is nonreduced. The scalar-Higgs quotient M_s requires
exactly that this r_D belong to the image of H0(omega). This proves
both conditions of part2, with their converse.

For a concrete local description, use a frame of E3 adapted to
O e subset K subset E3 and trivialize omega. A trace-free lift killing
e has matrix

    [0 a b; 0 c d; 0 f -c].

The first condition is f|D=0. The second is that c|D be the restriction
of a global canonical differential. The entries a,b,d are not silently
discarded: they are fixed by the UNIQUE global lift (3), not extra
independent variables. This is a precise geometric description of the
additional vectors whose existence would make nullity exceed1.

The ambient trace-free space has dimension3n. The first condition is
a linear map to a length2n line-bundle restriction on D. The second,
after the first is imposed, is a map to

    H0(omega|D)/image H0(omega),

of dimension n. This explains the same3n-square rank count intrinsically.
It does NOT assert that these two groups of conditions are independent.
Their exact failure of independence is the unresolved kernel.

## 4. The canonical Pfaffian candidate and its exact zero locus

Put dim H_alpha=2r+1, where r=2n-1. In a basis of H_alpha form the
vector with i-th coordinate (-1)^(i+1) times the Pfaffian of the even
principal submatrix obtained from B_s by deleting row and column i.
The ordinary Pfaffian identities, valid integrally and hence in
characteristic5, show that B_s kills this vector.

Under a basis change the vector transforms in
H_alpha tensor det(H_alpha)^vee. Thus it is an intrinsic polynomial
section with this determinant-line factor. It is homogeneous of degree
r in s, since B_s depends linearly on the canonical section. This uses
the integral Pfaffian polynomial, NOT division by r!, which would be
invalid when r>=5 in characteristic5.

An alternating matrix has a nonsingular principal submatrix of size
equal to its rank. Therefore this vector is nonzero exactly when
rank B_s=2r, and then it spans its kernel. It vanishes exactly when
rank B_s<=2r-2, equivalently dim ker M_s>=3. Thus it is a canonical
CANDIDATE for the unavoidable line. Its generic nonvanishing is exactly
the requested generic-nullity1 assertion; it cannot be assumed while
purporting to prove that assertion.

One need not first choose a basis of H_alpha to construct the same
candidate. In the original even-dimensional A use

    q_s=PfaffAdj(A_s) lambda_alpha.                       (4)

Since Pfaff(A_s)=0, the Pfaffian-adjugate identity gives A_s q_s=0.
Its alternating adjugate also gives lambda_alpha(q_s)=0. If corank A_s
is2, write its radical as ku+kv. Its adjugate is a nonzero multiple
of u v^t-v u^t; lambda_alpha(u)=1 then makes (4) nonzero. If the corank
is at least4, all its maximal sub-Pfaffians vanish and (4)=0. This
checks the same zero locus without a basis-dependent complement.

The vector q_s, when nonzero, is emphatically NOT the atlas direction u:
it belongs to H_alpha, whereas lambda_alpha(u)=1. Nor is it a common
constant kernel vector. The common radical of a basepoint-free canonical
pencil is ku by stability and acyclicity, so no nonzero q_s can lie in it.
This avoids confusing the second single-member radical with the common
line used to reconstruct actual atlas coordinates in earlier charts.

For genus9 the candidate has degree15 in the canonical-pencil parameter.
The generic-nullity1 claim is equivalent to this vector polynomial not
being identically zero. No proof of that nonvanishing for orbit0011, or
for all actual atlases, is supplied by the present construction.

## 5. Canonical dual lifts provide a useful nonradical control

Dualizing the actual rank-three extension and tensoring by omega gives

    0 -> V -> E3^vee omega --evaluation at e--> omega ->0.

Acyclicity of V says that evaluation induces an isomorphism on H0.
For every s there is therefore a unique global sigma_s with
sigma_s(e)=s. For a basepoint-free canonical pencil s0,s1, their wedge
is a global section of

    wedge^2(E3^vee) omega^2 = E3 omega,

using det E3=omega. Its image in V omega, under the determinant
identifications, is the covector combination s0 sigma_s1-s1 sigma_s0.
It is liftable by construction.

This image is NONZERO. Otherwise sigma_s1=(s1/s0)sigma_s0 rationally.
Because s0,s1 have no common zero, regularity forces sigma_s0 to vanish
on all of D_s0. Thus sigma_s0/s0 is a global section of E3^vee taking
the value1 on e. It splits O->E3->V, contradicting
lambda_alpha(u)=1. This argument includes multiple canonical zeros.

The resulting nonzero section lies in H_alpha and hence cannot be in
the common radical ku. Consequently the natural wedge of canonical
dual lifts is NOT a universal replacement for the Pfaffian candidate.
This exact control rules out one tempting but false shortcut from
"lifts to the actual rank-three bundle" to "belongs to every radical."

## 6. A genuine consequence of the Frobenius form and an actual kernel family

The nonsingular Frobenius form supplies F^*E3=E3^vee omega^2. Pulling
back again and dualizing gives

    F^(2*)E3=E3 omega^8.                                  (5)

This forces strong semistability. Indeed write mu=deg(E3)/3=2n/3.
For any subbundle S of E3, flat Frobenius pullback and (5) give

    25^j mu(S) <= mu_max(E3)+(25^j-1)mu.

Divide by25^j and let j grow to obtain mu(S)<=mu. The same argument
applies to every F^(a*)E3, whose two-step pullback is again a scalar
twist of itself. Hence all Frobenius pullbacks are semistable. For
genus9, rank3 and degree16 are coprime, so semistability is stability.
Unlike the diagram lemmas, this uses the actual nonsingular Frobenius
form, not only the extension alpha.

For a chosen basepoint-free canonical pencil, Section5 proves that
sigma_s0,sigma_s1 are generically independent. At any point at least
one is nonzero, since their evaluations on e are s0,s1. Their two-
dimensional evaluation space has rank2 away from finitely many points,
and rank1 at the remaining points. A member can vanish only at one of
those finitely many points, each of which forbids one pencil parameter.
Thus a general sigma_s is nowhere zero, without a generic-bundle claim.

For those parameters, the exact sequence

    0 -> F_s -> E3 --sigma_s--> omega ->0

has F_s locally free of rank2 and determinant O. Acyclicity of V gives
H0(E3)=k e, and sigma_s(e)=s!=0, so H0(F_s)=0. This constructs a
degree-zero rank-two family directly from the actual atlas and the
chosen canonical pencil. It does NOT prove F_s stable: a degree-zero
line subbundle can have no sections. Nor has an isomorphism between
the extra radical and End(F_s) been established. Either assertion
would require a separate argument, not a dimension analogy.

These restrictions supply real Frobenius geometry, but currently do
not prove nonvanishing of the Pfaffian section in Section4.

## 7. Why the full Frobenius equations remain essential

The full atlas equations provide the actual alpha, nonsingular beta,
and identification of the preimage of the u-line with K. Their rank
and normalization are not inferred from the conditions in Section3.
In particular a parabolic Higgs field is not automatically a variation
that preserves beta or the R fixed point.

Locally trivialize omega and consider 1+epsilon Z over dual numbers.
Absolute Frobenius sends this matrix to1, because epsilon^5=0.
Infinitesimal preservation of the FIXED nonsingular Frobenius form
would therefore require beta(Zx,F^*y)=0 for all x,y, hence Z=0.
Allowing a projective scalar gives only scalar Z, again zero if Z(e)=0.
It would be invalid to impose this on every field in Section3: such
fields were constructed as arbitrary holomorphic Higgs fields with
specified flag behavior, not as Frobenius-isometry deformations.

Likewise the full atlas Jacobian proof only uses the common kernel ku.
It does not make the single-member extra vectors into atlas tangent
vectors, and it does not imply the Pfaffian candidate is generically
nonzero. The missing implication remains a genuine geometric constraint
on this parabolic-Higgs space at the actual Frobenius fixed points.

## 8. Exact positive control

The existing `scripts/alternating_kernel_genus_two_check.sage` checks
all original13 equations at all33 known normalized genus-two points.
At each of26 F25 canonical-pencil parameters it now also constructs
(4), verifies that it is nonzero, lies in the single-member radical,
and is killed by lambda_alpha. It checks that the two stacked N blocks
do NOT kill this extra vector. These are exactly the liftable-but-not-
common-kernel distinctions above. The3-square Higgs quotient and the
33 R-sensitive negative controls remain in the same run.

The report is the existing external
`orbit11-structure/constant_kernel_genus_two_check.json`. This is a
cohomological tensor-interface check, not a separately rebuilt rank-three
bundle chart. No orbit0011 tensor, new atlas search, or production change
was made. No geometric higher-normal-corank counterexample is claimed.
