# Proof: elementary weighted carries

Version1, 2026-09-13. The rank-three reduction came from the returned
rank125 partial certificate. The arbitrary-rank extension, signed
detector and finite lifting argument were proved locally and checked
in the [bounded independent audit, Section5](../../../Research/audits/RANK125_WEIGHTED_REDUCTION_AUDIT_2026_09_13.md).
The statement concerns additive operators only.

## Original normal basis and principal operator

The monic relation

    e_i^5=-5(e_i+2e_i^2+2e_i^3+e_i^4)

does not lower weight when wt(5)=4 and wt(e_i)=1. Its two weight5
terms give E_i^5+tau*E_i. The normal monomials, free over W_m(k),
prove there are no further graded relations. Work first without the
truncation tau^m, in

    A=k[tau,E_1,...,E_r]/(E_i^5+tau*E_i).

An additive deck-equivariant map commutes with every e_i and with
multiplication by5. Its correction divisible by5 therefore raises
weight at least4; the higher terms of f raise weight at least3.
The principal weighted operator of L is exactly q*Phi of order2.
This proof does not commute its higher coefficient operators.

Invert tau and adjoin c with c^4=-tau. The algebra is then the function
algebra on E=c*a, a in F5^r. Nonvanishing of q at every nonzero ORIGINAL
direction shows that its kernel is the origin component. Before
localization its generator is

    nu=product_i(E_i^4+tau),   deg(nu)=4r.

Indeed A is free over k[tau], and the top E-monomial of nu has
coefficient1. An element of the localized kernel with integral normal
coefficients cannot have a denominator in its coefficient of nu.
Thus ker(q:A->A)=k[tau]*nu.

## Homogeneous solution bounds

Let d be the lowest nonzero weight of x. If d+2<4m, the equation
Lx=0 forces its principal term into the untruncated kernel above.
If d+2=4m, the only possibly discarded term is a scalar multiple of
tau^m. But q*Phi(x_d) is augmented, and the augmented ideal has zero
intersection with k[tau], as seen by setting all E_i=0. That discarded
term cannot occur. Since the kernel starts at4r, source weights
d<=4m-2 are impossible when m<=r. This gives Wcal^(4m-1).
At m=r+1, all d<4r have output weight<4(r+1), giving Wcal^(4r).

## High-weight absorption

Let T be the augmented part of A/(q). The exact multiplication sequence
and the computed kernel give

    H_T(z)=((1-z^2)(1+z+z^2+z^3+z^4)^r+z^(4r+2)-1)/(1-z^4).

This is a polynomial: after inverting tau the augmented cokernel is
zero, so the finitely generated k[tau]-module T is tau-torsion. The
numerator has degree4r+1 and leading coefficient -r over the integers;
therefore H_T has degree4r-3. In particular q is onto the augmented
part at every output weight>=4r-2. This surjectivity passes to the
tau^(r+1) truncation.

In Lambda_(r+1), a nonzero coefficient-ring constant has weight<=4r.
Every target of weight>=4r+2 is therefore augmented. Cancel its lowest
weight by q*Phi using a source two weights lower, then apply the actual
L. The residual has strictly larger weight. Iteration terminates at
the maximal normal weight8r. The entire source stays in Wcal^(4r),
proving the stated absorption without dividing reduced classes.

## Critical coefficient extraction

Multiplication q*Phi from degree4r-1 to degree4r+1 is injective below
the norm kernel and surjective above the augmented cokernel. There is
no constant in the target degree, which is1 modulo4. Both spaces have
dimension (5^r-1)/4: after tau=-1 they are the scaling-character3 and
scaling-character1 functions on the nonzero F5^r vectors.

For a preimage H, specialization at tau=-1 leaves monomials of degrees
4r-1,4r-5,...,3. The sum over all a in F5^r of a_i*H(a) selects only
the coefficient of E_i^3 product_(j!=i)E_j^4. The top vector sum is
(-1)^r, while conversion to projective orbits divides by4=-1.
Multiplication by (-1)^(r+1) restores coefficient1. Substituting
H(a)=Z(-1,a)/q(a) with coefficient Frobenius still applied proves the
displayed detector. The Frobenius inverse belongs after the sum.

For R in Wcal^(4r+1), all detectors vanish exactly when the degree4r-1
preimage has no coefficient with tau-power0. The leading source is
then divisible by5. Subtract its actual L-image and absorb the tail
by the preceding argument. Conversely a source in 5*Lambda+Wcal^(4r)
with image in Wcal^(4r+1) cannot start below degree4r-1: its principal
image there would be nonzero. Its critical preimage has no tau-power0
part, so every detector vanishes. This proves the equivalence.

## Checks and limitation

The rank-three returned verifier passed its93 coefficient tests and
Hilbert calculations. A separate implementation tested the norm-kernel
formula in19 weighted degrees for a quadratic over F125. The local
generalization received independent checks at ranks2 and4: critical
dimensions6 and156, Hilbert endpoints5 and13, and636 signed coefficient
extractions. The proof, not these examples, gives arbitrary rank.

Applied to an actual geometric equation Lx+R=0, this theorem would be
useful only AFTER proving the stated weight bound and evaluating the
detectors of the WHOLE nonlinear R. The current rank125 comparison
does not supply either assertion. Its genuinely nonzero quadratic
channel is recorded in
[compatible_reference_quadratic_channel](fourth_hodge_quadratic_channel.md).
