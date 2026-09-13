# A degree-independent finite sieve for singleton Cartier-zero roots

Let C be an ordinary genus-two curve over an algebraically closed field
of odd characteristic p. Fix a Weierstrass point O, let J=Pic^0(C),
J1=Pic^0(C^(1)), and let V=F_C^*:J1->J be Verschiebung. Put

    i(P)=O_C(2P-2O),
    T=C x_(i,J,V) J1, with projections a:T->C, b:T->J1.

Let Theta_B be the Raynaud divisor for locally exact differentials on
C^(1), not the principal theta divisor. Then T is a connected smooth
projective curve, etale of degree p^2 over C, of genus p^2+1. The
pullback b^*Theta_B is an effective divisor of degree8p(p-1).

For each of the six Weierstrass points P and every nonzero M in ker V,
(P,M) belongs to this divisor. Subtracting these6(p^2-1) DISTINCT points
once gives a well-defined EFFECTIVE residual divisor R of degree

    deg R=2(p-1)(p-3).

It need not be reduced or disjoint from those forced points.

Now suppose k=bar(F_p). The following conditions on a non-Weierstrass P
are equivalent:

1. For some n prime to p there is a nonzero section s of omega_C^n,
   div(s)=2nP, whose tautological one-form on the normalized canonical
   nth-root cover is Cartier-zero.
2. There is a PRIME-TO-p torsion point M in J1 with
   V(M)=i(P) and H^0(C^(1),B_C tensor M)!=0.

The root cover in(1) is actually etale, because every zero order is
divisible by n; no ramified map replaces it. No Weierstrass point can
satisfy(1). Consequently all such P lie in the projection of R and
there are at most2(p-1)(p-3) of them, independently of n.

In particular, for the backup C_alpha in characteristic5 there are at
most SIXTEEN possible nonbranch points, or at most EIGHT abscissas.
The set is Frobenius-stable. Over its field F125, every residual closed
point has degree at most16; no assertion that all lie in F_(125^16).
An actual coreless span with a singleton clump image on C_alpha and
Cartier-zero primitive generator necessarily gives one of these points.

Version1,2026-09-08. Author proof, with Raynaud's theta theorem as a
primary-source input; not independently audited. No claim that R is
empty, that its points are prime-to-p torsion, or that any candidate
extends to two actual etale legs. The original problem remains open.
[Proof](../../../Proofs/jacobians/theta_divisors/singleton_cartier_theta_bound.md).
