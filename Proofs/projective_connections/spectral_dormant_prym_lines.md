# Proof: spectral line attached to a dormant pair

[Statement](../../Theorems/projective_connections/spectral_dormant_prym_lines.md).
Author /root, 2026-09-08; global proof and exact symbolic checks, not an
independent audit. The BNR correspondence is cited below; the explicit
Frobenius-trivial five-torsion line is the additional construction here.

## 1. A horizontal matrix with no denominators

In a local separating coordinate t put J=J^1(omega_C^2) and
M_s=[[0,1],[s,0]], so horizontal columns satisfy w'=M_s w. Subtracting
the two dormant equations gives

    q''=s q+3q^2,  q=r-s.

Set Phi as in the statement. Direct multiplication and differentiation
give

    Phi'=M_s Phi-Phi M_s,  Phi^2=2q^5 I,  trace(Phi)=0.        (1)

For x=x(t), u=x', quadratic jets transform by

    T=[[u^2,0],[2uu',u^3]],
    q_t=u^2 q_x,  (q_t)'=u^3(q_x)'+2uu' q_x.

Substitution in the polynomial matrix gives

    Phi_t=u^5 T Phi_x T^(-1).                              (2)

Thus Phi is a regular global morphism J->J tensor omega_C^5. Its
horizontality in (1) is with respect to the canonical connection on
omega_C^5, whose coordinate frame (dt)^5 is horizontal. Cartier descent
of (1)--(2) gives theta:V_s->V_s tensor omega_(C^(1)). Its characteristic
identity descends to theta^2=2q^(1)I: F_C^*q^(1) has coefficient q^5.
This is a twist identity, not an unlabelled coefficientwise fifth root.

The determinant of J is omega_C^5, and the trace of M_s is zero.
The determinant connection is therefore precisely this canonical
connection, not an arbitrary connection on the same line. Cartier
descent proves det V_s=omega_(C^(1)), not just equality of degrees.

## 2. The line on the smooth spectral double

When q has simple zeros, the spectral equation a^2=2q defines a smooth
double cover Sigma of C, branched at div(q). It is connected: a square
has even valuation, whereas q has simple zeros. There are 4g-4 branch
points, and Riemann--Hurwitz gives g(Sigma)=4g-3.

Write pi_1 for its twist. Apply the BNR correspondence in
[Groechenig, Theorem3.2, pp.9–10](https://arxiv.org/pdf/1201.0741#page=9),
which is stated in positive characteristic. In that notation take
X=C^(1), E=V_s, theta as above, and spectral sheaf L on Sigma^(1).
The smooth integral spectral curve makes L a line bundle, with
pi_(1*)L=V_s. Riemann–Roch and the determinant–norm identity give

    deg L=4(g−1),       Nm(L)=det(V_s) det(pi_(1*)O)^(-1)=omega²,

since chi(V_s)=0 and pi_(1*)O=O direct-sum omega^(-1).
Consequently N=L tensor pi_1^*omega^(-1) has degree zero and norm O.
The identity pi_1^*Nm(N)=N tensor tau^*N gives tau^*N=N^(-1).

## 3. Frobenius pullback, including every branch point

On Sigma the pullback Higgs matrix has eigenvalue a^5, since
(a^5)^2=2q^5. An eigen-quotient row is

    ell=(2a^3-q',q).                                      (3)

It satisfies ell Phi=a^5 ell. Under the coordinate change above,
ell_t=u^5 ell_x T^(-1). Thus (3) defines a global map

    pi^*J -> pi^*omega_C^5.                              (4)

At q!=0 its second entry is a unit. At a simple zero of q, a=0 and
q' is a unit on C, hence also on Sigma, so its first entry is a unit.
Therefore (4) is surjective everywhere, not merely at the generic point.

The tautological spectral evaluation pi_1^*V_s->L is also surjective.
Pulling it back by F_Sigma gives an eigen-quotient of pi^*J with the same
eigenvalue a^5. Generically it agrees with (4) up to scalar. The kernel
of a surjection from a vector bundle to a line on a smooth curve is
saturated; saturated kernels with the same generic fiber coincide.
Their quotient lines are therefore isomorphic globally. It follows that

    F_Sigma^*L = pi^*omega_C^5,
    F_Sigma^*N = O_Sigma.                               (5)

This argument includes the ramification points where the Frobenius
base change of the spectral model is not normal. It uses the pullback
of its evaluation map on the actual smooth Sigma, not an identification
of that singular base change with Sigma.

## 4. The logarithmic differential and exact order

Differentiate (3), using a'=q'/a in the function field and the secant
equation. One obtains

    ell'+ell M_s=-a ell.                                      (6)

For a horizontal w, the quotient coordinate z=ell w satisfies z'=-az.
After tensoring by pi^*omega_C^(-5), the trivial line in (5) therefore
has its Cartier connection d+eta, with eta=a dt. The expression is
intrinsic. At a simple branch point q=t times a unit, a has order one
on Sigma and dt has order one. Hence eta has order two there; away
from the branch divisor a dt is nowhere zero in the pulled-back
canonical frame. Thus div(eta)=2R.

The connection is descended, so has zero p-curvature. The rank-one
Cartier criterion gives Cartier(eta)=eta. Equivalently, over the function
field its nonzero horizontal section h satisfies dh/h=-eta. Since eta
is holomorphic, every valuation of h is divisible by five; this is the
usual Kummer description of the line N. The regular extension across
all points is already supplied by (5).

Under inverse Frobenius twist, (5) means N^5=O, so its order divides
five. If N were trivial, its pulled-back Cartier connection would admit
a nowhere-zero global horizontal section. Under (5) this would be a
unit on the projective connected Sigma, hence a nonzero constant. But
(d+eta)(constant) is nonzero since eta!=0. Therefore N has exact order
five. More generally a trivialization of F^*N is unique up to a constant,
so its connection form eta determines N by Cartier descent.

Changing the square root a to -a changes eta to -eta, and hence N to
N^(-1). Swapping r and s negates q; the identification a_new=2a is
valid because 2^2=-1 in characteristic five. It sends eta to 2eta, hence
N to N^2. These operations preserve the cyclic subgroup generated by N.

## 5. Both actual legs, and the remaining boundary

Jets, the polynomial matrix, Cartier descent and the spectral algebra
all commute with etale base change. The evaluation quotient is unique
and the simple branch divisor pulls back to a simple divisor. Thus L,
N and eta are pulled back as claimed, including covers of degree
divisible by five and non-Galois covers.

If r_X,s_X and r_Y,s_Y actually agree through X<-Z->Y, their differences
are the same quadratic on Z. Its spectral double is simultaneously
Z times_X Sigma_X and Z times_Y Sigma_Y. Both projections to the spectral
endpoints are finite etale base changes of the ORIGINAL maps. This
preserves a single actual common source and both line identifications.
The spectral endpoint maps to X,Y are instead ramified doubles.

The exact identities (1), (2), (3), and (6), including the quotient
transition formula, are checked by the augmented existing
[Cartier secant checker](../../scripts/connections/check_cartier_dormant_secants.sage).
No new point-enumeration algorithm is needed.

## 6. Two failed universal shortcuts

The existing [genus-seventeen Hecke counterexample](../examples/igusa_hecke_correspondences.md)
also tests the present, stronger construction. In its notation the
ramified double P->C has a deck-anti-invariant Cartier-fixed form alpha
with div(alpha)=2D. Its square descends to a quadratic s on the genus-five
C. At each branch point the pullback order is 4=2 ord(s)+2, so s has
a simple zero. The Cartier-secant dictionary therefore gives two distinct
REGULAR dormant connections on C. The actual coreless Hecke spans in
that construction preserve both connections. Thus adding a compatible
second dormant connection and its spectral five-torsion line does not
repair a universal core criterion. The obstruction sought here must use
additional endpoint information. This corollary is an author deduction
from the retained audited construction, not an extension of its audit.

There is also an elementary obstruction to using only affine relative
Sym^3 invariants. In cubic-moment coordinates the jet comparison is

    Q_r=[[1,0,0,0],[0,3,0,0],[3r,0,1,0],[3r',r,0,1]],
    Q_s^(-1)Q_r=I+3q E20+3q' E30+q E31.

The latter is symplectic for J03=1,J12=2. Conjugation by
diag(z^(-3),z^(-1),z,z^3), a cocharacter of Sym^3(SL2), multiplies
its three off-diagonal entries by z^4,z^6,z^4. It therefore tends to
I at z=0. Every REGULAR left/right Sym^3(SL2)-invariant function has
the same value here as at I. This proves neither equality of actual
double orbits nor constancy of rational invariants with poles at I.
All displayed matrix identities are checked in the existing secant script.

## 7. Genus-two ordinarity from dormant tangents

Put a=(r−s)/2 and r0=(r+s)/2. The
[Cartier-secant dictionary](cartier_dormant_secants.md) gives
C_1(a³)=a and zero orders congruent to0 or1 modulo5. In genus two
deg div(a)=4, so all four zeros are simple. Choose a Weierstrass point
as infinity and write a=P(u)(du/v)², v²=F(u), deg F=5. Its order at
infinity is4−2deg P, which is even and at most one, hence zero.
Thus deg P=2; simple zeros also force P squarefree and coprime to F.

The [hyperelliptic root quotient](../cartier_and_spin/hyperelliptic_root_quotients.md)
now gives an etale double onto E0:z²=FP and the descended form P du/z.
The spectral convention uses q=r−s=2a and b²=2q=4a, so E:w²=2AF,
A=2P, is E0 under w=2z. Its form is eta_E=2A du/w, of divisor type(2,2).
This supplies the geometry and marked form without pairwise tests.

For a regular quadratic xi, the
[linearized-curvature factorization](etale_double_dormant_pairs.md) gives

    T_nil(r0)=ker(xi↦D^4(a²xi))=ker(xi↦C_1(a²xi)),
    T_nil(r0)=T_dorm(r) direct-sum T_dorm(s).

On the root double, division of the pulled-back xi by the root form
identifies regular quadratics with the E0-character space of regular
one-forms. Explicitly, xi=Q(u)(du/v)² maps to Q(u)du/z, deg Q<=2.
Cartier's projection formula identifies the displayed kernel with
ker Cartier on E0, as in the root-quotient proof. Hence

    a(E)=dim T_dorm(r)+dim T_dorm(s).

The [genus-two dormant scheme](genus_two_dormant_quintic.md) has length
five, so a point is reduced exactly when its tangent is zero. Its
family resultant Res(Psi,Psi')=−[t(t−1)(t−2)(t−3)]² is nonzero at every
smooth parameter. All ten quotients in that family are therefore ordinary.
The tangent/Cartier identification received a bounded independent check
by /root/audit_secant_cartier_dimension,2026-09-13; this is not an audit
of the general spectral-line construction.

For the cubic backup, the quintic roots are z_i=z^(125^i), i modulo5.
Its explicit models use

    A_ij=(z_i−z_j)u²+(W(z_i)−W(z_j))u+V(z_i)−V(z_j), i<j,

with W,V from the quintic theorem. The
[original packet](../../Research/computations/backup_genus_two_secant_curves.json)
and [generator](../../scripts/genus_two/backup_genus_two_secant_curves.sage)
retain the field moduli, all ten models and marked Cartier matrices.
They independently verify the forms and ordinarity now proved uniformly.
F125-Frobenius has two orbits on unordered pairs, represented by(0,1)
and(0,2). Reversal negates A; w↦2w identifies the curves and scales the
marked form by2. This describes coefficient symmetry, not all genus-three
isomorphisms.
