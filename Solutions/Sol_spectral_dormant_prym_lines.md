# Proof: spectral line attached to a dormant pair

[Statement](../Theorems/Thm_spectral_dormant_prym_lines.md).
Author /root, 2026-09-08; global proof and exact symbolic checks, not an
independent audit. This is a spectral refinement of the existing Cartier
secant dictionary, not a claim of a new general spectral correspondence.

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
of (1)--(2) gives phi:V_s->V_s tensor omega_(C^(1)). Its characteristic
identity descends to phi^2=2q^(1)I: F_C^*q^(1) has coefficient q^5.
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

Write pi_1 for its twist. The spectral algebra on C^(1) is
O direct-sum omega^(-1), with multiplication prescribed by 2q^(1).
The Higgs field makes V_s a module for this algebra. It is generically
rank one over its quadratic function field and is torsion-free as a
sheaf on Sigma^(1): a torsion section would also be torsion over the
base. Since Sigma^(1) is smooth, this sheaf M is a line bundle. By
construction pi_(1*)M=V_s. Euler characteristics give

    deg M=g(Sigma)-1=4(g-1),

since chi(V_s)=0. For a finite flat double,
Nm(M)=det(pi_(1*)M) tensor det(pi_(1*)O)^(-1). Here pi_(1*)O is
O direct-sum omega^(-1), so Section 1 gives Nm(M)=omega^2.
Consequently N=M tensor pi_1^*omega^(-1) has degree zero and norm O.
The identity pi_1^*Nm(N)=N tensor tau^*N gives tau^*N=N^(-1).

## 3. Frobenius pullback, including every branch point

On Sigma the pullback Higgs matrix has eigenvalue a^5, since
(a^5)^2=2q^5. An eigen-quotient row is

    L=(2a^3-q',q).                                      (3)

It satisfies L Phi=a^5 L. Under the coordinate change above,
L_t=u^5 L_x T^(-1). Thus (3) defines a global map

    pi^*J -> pi^*omega_C^5.                              (4)

At q!=0 its second entry is a unit. At a simple zero of q, a=0 and
q' is a unit on C, hence also on Sigma, so its first entry is a unit.
Therefore (4) is surjective everywhere, not merely at the generic point.

The tautological spectral evaluation pi_1^*V_s->M is also surjective.
Pulling it back by F_Sigma gives an eigen-quotient of pi^*J with the same
eigenvalue a^5. Generically it agrees with (4) up to scalar. The kernel
of a surjection from a vector bundle to a line on a smooth curve is
saturated; saturated kernels with the same generic fiber coincide.
Their quotient lines are therefore isomorphic globally. It follows that

    F_Sigma^*M = pi^*omega_C^5,
    F_Sigma^*N = O_Sigma.                               (5)

This argument includes the ramification points where the Frobenius
base change of the spectral model is not normal. It uses the pullback
of its evaluation map on the actual smooth Sigma, not an identification
of that singular base change with Sigma.

## 4. The logarithmic differential and exact order

Differentiate (3), using a'=q'/a in the function field and the secant
equation. One obtains

    L'+L M_s=-a L.                                      (6)

For a horizontal w, the quotient coordinate z=Lw satisfies z'=-az.
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
and the simple branch divisor pulls back to a simple divisor. Thus M,
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
[Cartier secant checker](../scripts/check_cartier_dormant_secants.sage).
No new point-enumeration algorithm is needed.

The old Cartier-secant theorem already constructs eta from a pair;
the additional content here is the global Higgs realization, exact
spectral line, norm condition, and reconstruction
V_s=pi_(1*)N tensor omega. These do not make a pair exist on a common
source. The line's mu_5 torsor is not an etale cyclic cover, and the
known Igusa-type logarithmic counterexamples prevent treating a shared
Kummer class alone as a core criterion.

## 6. Two failed universal shortcuts

The existing [genus-seventeen Hecke counterexample](../routes/global/UNBOUNDED_DOUBLE_ZERO_HECKE_LEAVES_ON_A_FIXED_GENUS17_CURVE.md)
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
