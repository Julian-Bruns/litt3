# Recovering an etale quotient one Witt step later

Prove the delayed-descent statement below for an actual cyclic degree-five
cover with two indigenous defect directions. There is a concrete reason
to expect it: the integral deck relation detects a direction that both
ordinary trace and the characteristic-five Frobenius operator miss.
The relevant carry has already been computed exactly. The central task
is to identify it in the corrected higher inverse-Cartier gluing.

## 1. The actual curves and filtered data

Work over k=bar(F5), W_n=W(k)/(5^n), with t^5-t!=0. Put

    G=u(u-1)(u-2)(u-3), F=G(u-t), Y:v²=F, eta=du/v,
    A=(t+1)²G, a=A/F², r=3a''/a+(a'/a)².

Derivatives are in u; the scalar projective-connection convention is
U''=rU with the Schwarzian transformation law. This r is a regular
admissible active nilpotent connection and is indigenous-ordinary on Y.
Its square-Hasse quartic is s=A*eta^4. J(Y) is ordinary as well; these
are different notions of ordinariness.

For any pulled-back pair (S,r_S), its defect is
d(S)=dim T_(r_S)N(S), where N(S) is the fixed-curve nilpotent-connection
scheme. Equivalently d(S)=dim ker Psi_S=dim coker Psi_S for the
semilinear Hodge-projection operator on H1(S,T_S) used below.

Let C be the smooth projective curve

    k(C)=k(u,v,kappa), kappa²=u(u-3), gamma=v/kappa,
    gamma²=(u-1)(u-2)(u-t).

The original map pi:C→Y is connected finite etale of degree two and
g(C)=3. Its deck involution tau negates both kappa and gamma.

Choose a connected etale cyclic degree-five cover Y_1→Y. Form the
connected fiber product T=C×_Y Y_1, with ORIGINAL map h:T→C and deck
generator sigma. Thus g(T)=11. Assume the pulled connection has defect
exactly TWO on T. This is a nonempty hypothesis: at
t^4+4t^3+t²+4t+3=0, an actual Artin--Schreier cover has been checked by
complete Cech matrices at two Laurent precisions. The relevant
15-dimensional anti-tau block has ranks13,11,10,10,... under successive
semilinear iterates; its deck-fixed kernel has dimension one. The
other15-dimensional block is bijective.

Use the canonical marked W2 lifts. By a filtration-compatible W_n
curve lift mean that its full projective Higgs--de Rham tuple extends
through W_(n-1): original Hodge line, graded identification and the
lifted flat square-trivial periodicity twist. The twist on Y is
O(W_t-O); retain its actual pullback. Hodge lifts, when they exist,
are unique because H0(T_C)=H0(T_T)=0.

The canonical full ordinary lift of (Y,r) and the unique lifts of both
etale covers provide one full reference tower for C and T. The target
allows OTHER compatible lifts, including ones not preserving pi.

## 2. The single target: uniform one-step delayed descent

For every n>=2, let C_n be a compatible marked W_n lift of the above
initial C data. Lift the original h uniquely to T_n→C_n, with the
pulled-back full previous tuple. Suppose T_n extends to a compatible
marked W_(n+2) curve T_(n+2).

Prove:

    Its truncation T_(n+1) admits a finite etale map to a compatible
    C_(n+1), extending the GIVEN map T_n→C_n.                 (D5)

The original upper curve T_(n+1) must be retained, not replaced by some
other compatible lift. The finite map and the full previous tuple are
part of the conclusion. The genus-two map pi is not required to lift.

This is a two-step statement about a fixed degree-five cover, uniform
in the starting Witt level. If false, an actual finite-level example
within this construction, specifying the compatible upper lift and
its failure of h-descent, would decide the target in the other direction.

## 3. Established cohomological inputs

Write V_C=H1(C,T_C), V_T=H1(T,T_T). The Hodge variation operator Psi is
Frobenius-semilinear, with all relative twists retained. At each already
compatible level the next obstruction satisfies

    rho(C_(n+1)+xi)=rho(C_(n+1))-Psi_C(xi).

It is natural for the actual lifted etale maps. A compatible upper
lift therefore obeys Psi_T(xi_T)=h*rho_C for comparison with any lower
reference curve lift. The lower reference need not be compatible.

The operator on V_C has a five-dimensional bijective part and a zero
line. Set R=k[e]/(e^5), e=sigma-1. V_T is free of rank six over R.
Coefficient Frobenius fixes e; it does not send e to e^5. The actual
semilinear Fitting decomposition of V_T consists of a bijective free
rank-five summand and a free rank-one nilpotent summand. On that line

    Psi_T=e²*u(e)*Frob,  u(e) a unit.

Thus, up to the indicated source/target normalizations,

    ker Psi_T=e³R, coker Psi_T=R/(e²),
    h*(ker Psi_C)=k*e^4.

The map on cokernels induced by h is ZERO, so injectivity of trace
cannot supply (D5). The quotient V_T/h*V_C has a noninvertible Psi.
These facts already concern actual tangent cohomology, not a proposed
model for its dimension. They follow from etale Cartan--Leray, norm
base change and the simple-zero Fitting decomposition.

The involution tau lifts to T and acts as minus one on its two defect
directions and the obstruction cokernel: its invariant quotient is
Y_1, which remains indigenous-ordinary under the cyclic five-cover.
This symmetry is available on the canonical W2 reference; it is not
assumed to persist on an arbitrary later C_n.

## 4. The tested integral carry

Over the integral deck algebra put

    R_W=W(k)[e]/((1+e)^5-1),
    N=1+sigma+...+sigma^4=5+10e+10e²+5e³+e^4.

After eliminating the bijective block and normalizing the unit u,
the characteristic-five nilpotent map is e²*Frob. Let eta_0 be the
scalar component of the lower obstruction in coker Psi_C. Its norm
pullback is e^4*eta_0. The first compatibility equation has solutions

    xi=c*e²+d*e³+b*e^4,  c^5=eta_0.

For a mixed-characteristic scalar lift e²+5B(e), direct integral
reduction gives, modulo5 and e²,

    ((e^4-N)/5) = -(1+2e),
    e^5/5 = -e,   e^6/5 = 0.

Consequently its next divided residual on that affine solution space is

                     -eta_0*(1+2e)-d^5*e.                (I)

Every perturbation 5B(e) contributes zero in R/(e²), since xi is
divisible by e². The two coefficients in(I) force eta_0=0 and d=0,
leaving exactly b*e^4, the pulled-back lower kernel direction. These
integer identities, including independence of all coefficients of B,
have been executed exactly; the determinant on (eta_0,d^5) is one.

What needs proof is that the ACTUAL next Hodge obstruction detects
this carry, up to invertible changes and terms already accounted for,
with the complete lifted filtered data. An arbitrary chosen lift of a
cohomology matrix is not the higher inverse-Cartier construction.

The local weight-rescaled oper frame offers a starting point:

    nabla=d+[[0,r_x],[1,0]]dx,
    tilde_nabla=5d+[[0,25r_x],[1,0]]dx.

Use [Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/pdf/1404.0538), especially its
Taylor gluing and Proposition5.2. Hodge-generator corrections and their
linear divided carry must be retained. At n=2 products of corrections
can survive; the anti-tau symmetry is available there. At n>=3,
corrections of order5^(n-1) have products zero modulo5^(n+1), since
2n-2>=n+1. This suggests why the same calculation could work at every
later level without lifting tau. The task is to justify the geometric
comparison, including any additional terms, rather than infer it from
the integral identities alone.

## 5. Why this lemma changes the common-cover argument

An existing theorem descends every compatible Witt tower across any
prime-to-five etale map that preserves defect. It does not apply to h.
If (D5) holds, induction would descend every FULL compatible tower
on T along the ORIGINAL h, using one extra upper Witt digit at each
stage. It would therefore cross a genuine degree-divisible-by-five
barrier, not repeat the prime-to-five result.

For an actual common span X←Z→Y of the selected kind, suppose r_X is
ordinary and the Y-leg factors through Z→T→C→Y as above, with Z→T
prime to five and both Z,T of defect two. Lift the ORIGINAL X-leg to
its full canonical source. The established theorem first descends
that given source to T; (D5) would then descend it to genus-three C.
This produces an actual characteristic-zero span X^can←Z^lift→C^lift.
The two maps in this new span are constructed; C→Y need not lift.

A previously established uniform genus-three partner count then
excludes this new source-defect-two stratum for our fixed high-degree
Y parameter. The source-defect-one stratum is already excluded by the
prime-to-five argument. A finite-level failure of (D5) would instead
show exactly why integral deck carry does not extend that mechanism,
and stop an unsupported full-tower descent claim.
