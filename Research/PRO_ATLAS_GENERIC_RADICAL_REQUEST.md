# Does an actual Frobenius atlas force the minimal generic radical?

Please prove or disprove the precise statement (R9) below. This is a
bounded geometric lemma needed to simplify an exact computation, not a
request to solve Litt's common-cover problem. A counterexample must
retain the actual nonsingular Frobenius form and its transverse flag;
an arbitrary alternating pencil or arbitrary stable rank-two bundle is
not a counterexample. You have no access to our local files.

## Actual geometric data

Work over k=bar(F5). Let C be a smooth projective curve of genus9 and
write omega=omega_C. Let E3 be a rank-three vector bundle with det E3=omega,
with a nowhere-vanishing section e, and an O_C-linear nonsingular pairing

    beta:E3 tensor F_C^*E3 -> omega^2.

Nonsingular means its adjoint is an isomorphism everywhere. In coordinates
the form is v^t A w^[5], A invertible; do NOT impose an additional symmetry
condition on A. Assume beta(e,F^*e)=0. Write

    q=beta(-,F^*e):E3 -> omega^2,
    K=ker q, V=E3/O_C e.

Assume the actual transverse osculating flag is

    0 -> O_C e -> K -> omega^-1 ->0,

with NONZERO extension class kappa in H1(omega)=k. Transverse means that
the second fundamental map of O_C e for the projective connection of
beta is an everywhere-isomorphism O_C -> (K/O_C e) tensor omega.
That projective connection is trivial on local projective frames carrying
beta to X0^6+X1^6+X2^6. Their transition group is PGU_3(5), finite etale.
These are genuine Hermitian-curve atlas data, not just a generic form.

Assume V is STABLE and H0(C,V)=H1(C,V)=0. Then det V=omega. The specified
inclusion K/O_C e=omega^-1 -> V defines a nowhere-zero section

    u in A=H0(C,V tensor omega), dim A=32.

The acyclicity hypothesis is intentional. Our expensive genus-nine
calculation has twelve such representatives, including its largest
coefficient field. Six nonacyclic representatives are a separate case;
you need not settle them here.

## The explicit square map and target

Let P=<s0,s1> be ANY basepoint-free pencil in H0(C,omega). For nonzero
s in P, put D_s=div(s), with its full length16 divisor scheme. Define

    M_s:H0(C,End_0(V) tensor omega)
      -> H0(D_s,(V tensor omega^2)|D_s)
           / { (r u)|D_s : r in H0(C,omega) },
    phi |-> [phi(u)|D_s].

Both spaces have dimension24. In the target, the scalar subspace has
dimension8: the kernel of r |-> (r u)|D_s is k s. No choices of lifts
or reduction of D_s are implicit.

**(R9): For every such actual (C,E3,e,beta) and every basepoint-free
pencil P, one has dim ker M_s=1 for general s in P.**

Equivalently, over k(t), M_(s0+t s1) has rank23. A single nonzero
22-by-22 minor suffices because the kernel is always odd-dimensional,
as supplied below. If the universal pencil quantifier is false, an
actual example explaining that failure is valuable; do not silently
replace it by genericity of C,V,u, or by testing a random matrix.

## Facts already proved; use them without rederiving

1. The actual extension 0->O_C -> V omega -> omega^3 ->0 defined by u
   yields an alternating form A_s on the32-dimensional A, linear in s.
   There is an exact radical identification

       rad A_s/k u = ker M_s.

   On every basepoint-free pencil the COMMON CONSTANT radical is exactly
   k u. This does NOT force the normal corank to be2: extra radicals
   could move with the pencil parameter. Normal coranks2,4,6,8,10 have
   not been excluded by the existing general pencil bounds.

2. The actual rank-three extension gives a Serre functional lambda on A
   with lambda(u)=1; ker lambda is precisely the liftable hyperplane
   image H0(E3 omega). Put H=ker lambda, of dimension31. Then

       rad A_s = k u direct-sum rad(A_s|H).

   The vector of30-by-30 principal Pfaffians of A_s|H is a polynomial
   vector of degree15 in a pencil parameter. It is nonzero precisely
   when dim ker M_s=1. Proving that it is not identically zero IS the
   missing assertion; the Pfaffian identities alone do not prove it.
   No division by15! is legitimate in characteristic5.

3. Every trace-free Higgs field phi on V lifts UNIQUELY to a trace-free
   Z:E3->E3 omega killing e. Membership in ker M_s means exactly:
   Z preserves K along D_s, and the induced scalar on (K/O_C e)|D_s
   extends to a global canonical section. In an adapted local frame

       Z=[0 a b; 0 c d; 0 f -c],

   these conditions are f|D_s=0 and c|D_s in image H0(omega).
   Such Z is NOT asserted horizontal or an infinitesimal isometry of
   beta. Requiring preservation of the fixed beta would force Z=0 and
   would incorrectly remove even the unavoidable radical line.

4. The full Frobenius form gives F^(2*)E3=E3 tensor omega^8. Thus E3 is
   strongly semistable, and stable here since rank3 and degree16 are
   coprime. This uses more than the rank-two extension alone.

5. Acyclicity gives unique covectors sigma_s in H0(E3^vee omega) with
   sigma_s(e)=s. For general s in any basepoint-free pencil, sigma_s is
   nowhere zero, so F_s=ker(E3->omega) has rank2, determinant O and no
   global sections. Stability of F_s is NOT known. Nor is
   ker M_s=End(F_s) known: its elementary-modification flag differs from
   the osculating line. If sigma_s(K)|D_s vanished identically, dividing
   sigma_s|K by s would split the nonsplit K, an immediate contradiction.

## Why this lemma helps, and its limit

Our exact atlas system retains the full semilinear Frobenius fixed-point
equations and normalization. They define a finite reduced scheme.
The rank problem above is a bottleneck in its specialized elimination:
(R9) would remove EVERY higher-normal-corank branch on all twelve acyclic
representatives. Degree15 then makes sixteen distinct pencil parameters
an exhaustive maximum-rank test, not a heuristic generic sample.
It would not by itself prove atlas emptiness or solve the common-cover
problem. No claimed running time depends on assuming (R9).

All33 actual genus-two atlas controls have the analogous minimal radical;
this is a control, not evidence of a genus-nine theorem. Conversely many
rank-two directions satisfy the weak incidence equations but fail the
Frobenius fixed-point equations. Such weak points cannot disprove (R9).

Aim at this actual generic-rank lemma. If undecided, isolate a verifiable
condition on the ACTUAL Frobenius bundle that would force the Pfaffian
vector nonzero, and explain why it follows or does not follow from the
given data. A new name for the same rank condition, an extra genericity
assumption, or a toy alternating pencil would not advance this task.
