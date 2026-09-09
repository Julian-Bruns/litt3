# Proof: another odd spin supplies the missing endpoint coordinate

[Statement](../Theorems/Thm_prime_spin_probe_reduction.md).
Author /root,2026-09-08. Every upper map remains finite etale and all
field statements use the given embeddings into one source field.

## 1. The extra effective spin is a separating probe

Let O be the unique point at infinity on X. Tame ramification gives

    theta=dx/y^(a-1),  div(theta)=2(g(X)-1)O.

Thus A_0=O_X((g(X)-1)O) is spin with section e_0 satisfying e_0^2=theta.
Both e_0 and x e_0 are regular because ord_O(x)=-a and g(X)-1>=a.
In odd characteristic there are 2^(g-1)(2^g-1)>1 odd theta
characteristics, all effective. Choose an effective spin A'!=A_0 and
0!=e' in H0(X,A'), with eta'=e'^2.

Suppose eta'/theta were in k(x). Since theta has no finite zero or pole
on X and eta' is regular, this rational function has no finite pole,
so equals a polynomial P(x). Its zero multiplicities on X are even:
both div(eta') and div(theta) are even. At a finite root b of P the
ramification index of x is either1 or the ODD integer a. Therefore the
multiplicity of b in P is even. Over the algebraically closed field
P=c B(x)^2. It follows that

             div(e')=div(e_0)+div(B(x)),

which identifies A' with A_0, a contradiction. Hence eta'/theta is
not in k(x). Since [k(X):k(x)]=a is prime,

                    k(x,eta'/theta)=k(X).             (1)

For the actual trigonal curve this is even explicit: eta'/theta=A(x)+B(x)y
in the canonical basis, with B!=0, so y=(eta'/theta-A)/B.

The parity input is Mumford's theorem in characteristic not2:
[Theta characteristics of an algebraic curve, pp181--182](https://www.dam.brown.edu/people/mumford/alg_geom/papers/1971a--ThetaChar-Numdam.pdf).
Only the existence of a second effective spin is used.

## 2. Three etale double torsors and one normal closure

Let L_X,L_Y be the original compatible spins of the common span.
On the common source trivialize the pullbacks of the three two-torsion
lines, with their spin-induced square trivializations,

       L_X A_0^-1,   L_X A'^-1,   L_Y A_Y^-1.

Take a connected component V of the product of their mu_2 torsors.
Then V->Z is etale of degree at most8. Its original common spin contains
sections e_0, x e_0, e', and b whose squares are respectively theta,
x^2 theta, eta', and eta. The spin isomorphisms are compatible with
squaring; there is no ramification in this operation.

Take the Galois closure T->Y of V->Y. It is still finite etale over
both endpoints and carries these sections. Put E=H0(T,L_T). We have
dim E>=2. Its fixed divisor is invariant under Gal(T/Y), so it is the
pullback of an effective integral divisor B_Y on Y. If B_Y is nonzero,
L_T minus this divisor has degree at most zero because deg(L_Y)=1.
It would have at most one section, a contradiction. Thus L_T is
base-point-free.

Let S be the normalization of the complete-section image, M its
hyperplane line, and phi:T->S. Then phi^*M=L_T and H0(S,M)=E.
The ratio field k(S) contains

             (x e_0)/e_0=x,   (e'/e_0)^2=eta'/theta.

By (1) it contains the FULL embedded k(X). Consequently phi and S->X
are intermediate maps in the finite etale cover T->X. Both are finite
etale. In particular g(S)>=g(X)>=2. No prior separability assumption
on the section map and no clump argument is needed.

## 3. Recover Y and retain the original common spin

Etaleness gives deg(M)=g(S)-1. Put M'=omega_S M^-1. The spin on T
identifies phi^*M' with L_T, and Riemann--Roch gives h0(M')=h0(M).
Both spaces therefore pull back onto the same E. Matching one nonzero
section yields a rational isomorphism M->M' whose pullback is the fixed
global isomorphism upstairs. Its divisor is zero, so M^2=omega_S,
compatibly with the given spin on T.

The probe b descends to M, hence eta=b^2 descends to a regular form on S.
Cartier(eta) descends by naturality. These span the genus-two canonical
space, so cartier_endpoint_recovery gives k(Y) subset k(S). Thus S->Y
is also intermediate etale. The actual endpoint intersection is still k.

It remains essential to identify M with the original common spin, not
merely a spin with the same pullback. The common tensor h_X^2=h_Y^2
descends through the two actual maps to S. It has divisor2D_S, with D_S
nonempty reduced. The intrinsic root normal form gives the common spin

          L_S=O_S(D_S) tensor omega_S^(-(p+1)/2)

and the common section h_S. This identifies L_S with both endpoint
pullbacks and phi^*L_S with the original L_T. Source effectivity from
spin_primitive_matching_defect applies to the actual coreless span
through S, giving 0!=u in H0(S,L_S). Since every section of L_T descends
from M, phi^*u matches phi^*v for some v in H0(S,M), under the fixed
pullback identification. The rational map L_S->M sending u to v pulls
back to that global isomorphism. It has no zero or pole and is therefore
a global spin-compatible isomorphism. Hence the original h is retained.

The complete spin map of S is birational by its defining ratio field,
and base-point-free. Both properties persist in the restarted alternating
normal-closure tower by normal_closure_section_field. The argument
produces a more convenient ACTUAL common cover, not a contradiction.
