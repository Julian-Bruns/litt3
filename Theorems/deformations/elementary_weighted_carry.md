# Weighted additive carries for elementary five-groups

Version1, 2026-09-13. Independently audited algebraic statement.

Let k be a perfect field of characteristic5, r>=2, G=C5^r with FIXED
generators sigma_i, and Lambda_m=W_m(k)[G]. Give 5 weight4 and
e_i=sigma_i-1 weight1 in the original normal basis e^alpha, 0<=alpha_i<=4.
Write Wcal^d for the resulting decreasing filtration. Let

    L:Lambda_m -> Lambda_m

be additive and deck-equivariant, with reduction f*Phi, where Phi is
coefficient Frobenius fixing the original generators and
f=q+terms of augmentation degree>=3. Assume q is homogeneous quadratic
and q(a)!=0 for every nonzero ORIGINAL a in F5^r.

Then

    Lx=0 mod5^m => x in Wcal^(4m-1),  2<=m<=r;
    Lx=0 mod5^(r+1) => x in Wcal^(4r).

In Lambda=Lambda_(r+1), one also has

    Wcal^(4r+2) subset L(Wcal^(4r)).

The reduction of Wcal^(4r) is precisely the norm line k*N_G.
These assertions allow arbitrary higher mixed additive coefficient
operators; their commutativity is not required.

There is an explicit test at the preceding weight. The associated graded
algebra is

    k[tau,E_1,...,E_r]/(tau^(r+1), E_i^5+tau*E_i),
    deg(tau)=4, deg(E_i)=1.

For a homogeneous target Z of weight4r+1 set

    Theta_i(Z)=Phi^-1( (-1)^(r+1) *
        sum_[a in P^(r-1)(F5)] a_i*Z(-1,a)/q(a) ), 1<=i<=r.

Each summand is independent of the projective representative. Inverse
Frobenius is applied to the coefficient AFTER the entire sum. For every
R in Wcal^(4r+1),

    all Theta_i(gr_(4r+1)R)=0
    iff R belongs to L(5*Lambda+Wcal^(4r)).

For r=3 this gives thresholds7,11,12, tail absorption from weight14,
and the three positive-sign projective detectors at weight13. For even
r the sign is negative.

This is an ADDITIVE theorem, not a geometric remainder estimate. Neither
formal hypersurface type nor equivariance alone supplies its original-
rational-direction hypothesis. It does not place an actual nonlinear
Witt comparison in the required weights or prove its detectors vanish.

[Proof](../../Solutions/deformations/elementary_weighted_carry.md).
