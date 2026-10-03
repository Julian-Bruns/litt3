# Proof: short Frobenius strings and the opposite endpoint

[Statement](../../../Theorems/deformations/section_growth/frobenius_defect_order_bound.md).

## 1. The representation-theoretic mechanism

Let k be algebraically closed of characteristic p>0, let G have order
prime to p, and let V be a finite-dimensional k[G]-module whose restriction
to each cyclic subgroup is a multiple of its regular representation.
Let Psi:V->V be equivariant and Frobenius-semilinear, with self-dual
cokernel D of dimension two. Suppose its nilpotent Fitting part has a
Jordan string of length at most d, where d>=1. Write Gamma for the image
of G on D.

Take gamma in Gamma and a lift sigma in G; put J=<sigma>. Regularity
and semisimplicity applied to the linearization sequence give

    0 -> Frob(ker Psi) -> Frob(V) -> V -> D -> 0,
    Frob(ker Psi) = D                         as J-modules.       (1)

The kernel/image filtrations of the nilpotent part are J-stable. Choose
character-homogeneous complements in their successive quotients to obtain
homogeneous Jordan strings with the same length multiset. In particular
there is such a string of length ell<=d. Its head is a character of D;
its tail, after ell-1 applications of Psi, is a character of ker Psi.
Each application raises the character to its p-th power.

Self-duality makes the two characters of D either both of order at most
two or a reciprocal pair chi,chi^(-1). In the latter case, if
m=ord(gamma)>2, then chi has order m. Formula (1) applied to the head
and tail therefore yields

    chi^(p^ell)=chi or chi^(-1),
    m divides p^ell-1 or p^ell+1.                              (2)

This bounds the image element, independently of the order of its lift.
Every scalar in Gamma has square one by self-duality. Its projective
image is cyclic, dihedral, A4, S4 or A5 by
[Faber, Theorem C](https://arxiv.org/pdf/1112.1999#page=4).
A lift of a cyclic or dihedral rotation has order at most p^d+1 by (2).
The scalar kernel has order at most two, so

    |Gamma| <= max(120,4(p^d+1)).                             (3)

For p=5, A5 is excluded and 120 improves to 48. In characteristic two
the scalar kernel is trivial, so the same general bound remains valid.

Bounded medium audit: PASS, /root/audit_extension_fiber_scope,
2026-09-14, for homogeneous strings, lift/image orders and all p.

## 2. The geometric inputs from the two actual legs

Use the characteristic-five hypotheses of the statement and put
V_S=H1(S,T_S), with its actual Frobenius-semilinear Hodge operator Psi_S.
The normalized f-trace splits f*V_X from V_Z and commutes with Psi:
relative Frobenius commutes with etale trace, and the pulled-back Hasse
multiplier is handled by the projection formula. See
[defect-preserving descent, Section 1](../defect_preserving_etale_descent.md).
Since r_X is nonordinary, V_X has a nonzero nilpotent part. A Jordan
string of length at most d=dim V_X=3g(X)-3 survives as a direct summand
in V_Z.

For any cyclic J<=G=Gal(Z/Y), let S=Z/J. The eigensheaves of q_*O_Z
are degree-zero character lines L_chi. By negative degree and
Riemann--Roch,

    (V_Z)_chi=H1(S,T_S tensor L_chi),
    dim (V_Z)_chi=3g(S)-3

for every character, including the trivial one. Thus V_Z has the
regularity required in Section 1.

The actual defect space is

    U=ker[C_1(s_Z -):H0(omega_Z^2)->H0(omega_Z^2)],

where s_Z is the normalized common quartic. Serre--Cartier duality gives

    <Psi_Z(v),phi>=<v,C_1(s_Z phi)>^5,                       (4)

with relative twists transported. Hence (coker Psi_Z)^dual=U
equivariantly. The [two-defect deck theorem](two_defect_deck_reduction.md)
gives its self-duality, so the faithful images on U and coker Psi_Z
have the same kernel and element orders. Section 1 now proves

    |Gamma| <= max(48,4(5^d+1)).                            (5)

The other endpoint supplied the short string; the source defect alone
does not supply it.

## 3. A bounded cored intermediate

Let K=ker(G->GL(U)) and T=Z/K. Then T->Y is an actual etale Galois
cover with group Gamma. Choose a nonzero X-defect quadratic phi_X.
Its pullback is K-invariant and descends to phi_T; the common quartic
also descends. Consequently

    a_X=phi_X^2/s_X = phi_T^2/s_T=a_T                    in k(Z).

The [defect-function lemma](two_leg_defect_orbit_bound.md#1-a-nonzero-defect-gives-a-nonconstant-function-of-bounded-degree)
shows this function is nonconstant and [k(X):k(a_X)]<=8(g(X)-1).
Thus X<-Z->T is cored, with X-atlas degree at most 8(g(X)-1).
This is a conclusion about T; the original X,Y span need not be cored.

For the main pair g(X)=9, g(Y)=2, Hurwitz gives deg g=8 deg f,
so the prime-to-five condition on f follows from that on g. Set

    N=4(5^24+1),    H=N+1<2^59.

Then g(T)<=H and the X-atlas degree is at most 64. The kernel K,
and hence the original source degree, has no asserted bound.

## 4. The actual joint degree gives the contradiction

Let $R$ be the smooth joint normalization of the original endpoint
fields in $k(Z)$. Its two induced maps are finite etale. The
[orbit theorem](two_leg_defect_orbit_bound.md) applies to the
nonzero X-defect and gives
\[
\deg(R/X)\le8b\le8|\Gamma|\le32(5^{24}+1)<2^{62}.
\]
Here $5^{24}<2^{56}$, since $5^3<2^7$, so the last bound is elementary.

The later [quotient-descent theorem](../../curve_arithmetic/genus_two_quotient_descent.md)
requires $\deg(R/X)>D^2$ for this SAME selected pair, with
$D=335999!$. But $D\ge2^{335998}$, hence $D^2>2^{62}$.
This contradiction replaces the entire bounded-atlas and quotient
census. The actual intermediate $T$ from Section3 still gives its
useful cored reduction, but no count of it is needed.

This excludes the stated prime-to-five Galois-Y, two-defect,
nonordinary-X branch. A nontrivial cyclic five-part acting trivially on
defects remains outside it: then deg f is divisible by five and the
normalized trace is unavailable.

The characteristic-five application retains its
[focused medium audit, PASS, 2026-09-10](../../../Research/audits/FROBENIUS_DEFECT_ORDER_AUDIT_2026_09_10.md).
