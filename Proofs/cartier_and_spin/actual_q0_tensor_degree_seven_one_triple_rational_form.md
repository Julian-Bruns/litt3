# Proof: all four-pole placements reduce to two factor-degree patterns

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_seven_one_triple_rational_form.md). No computation is used. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

The actual cubic coarse reduction gives z=t² on rational B and, after the common centered scaling, q(xi)=xi²+ONE. The [one-triple bound](actual_q0_tensor_one_triple_infinity_degree_bound.md) gives FOUR ordinary shared simple poles, all with z³=ρ². The [conjugate double-factor inequality](actual_q0_tensor_conjugate_ordinary_double_factor.md) excludes TWO conjugate pairs: q=TWO,v=TWO would require FIVE≥TEN. Therefore the FOUR poles occupy THREE coordinates with exactly ONE conjugate t-pair. Let that pair be λ,−λ,ρ=λ³. The remaining points are a choice of signs of λω and λω². Here ω=ONE+TWO ν,ν²=ν+THREE.

Set F±=x2±t³x1. The exact q identity gives F+F−=t6−ONE. At a shared pole tQ, the leading calibrated ratio is x2/x1=ρ. Therefore F+ has the pole when tQ³=ρ and F− when tQ³=−ρ. Opposite factors have a ZERO there; when tQ6=ONE that zero has the additional multiplicity from the simple root of t6−ONE. Both factors have triple poles at infinity, and neither has a pole at ZERO. If the numbers of plus and minus poles are a,b, then a+b=FOUR and the exact pole allocation is
\[
F_+=cS_-U/S_+,\quad F_-=c^{-1}S_+V/S_-,\quad
UV=t^6-1,\quad \deg U=2a-1,\quad\deg V=2b-1,
\]
where S± are the monic simple pole factors and U,V are monic complementary factors. Nonnegative degrees force a,b≥ONE. Replacing t by−t intrinsically interchanges the factor labels, while leaving BOTH xi unchanged. Thus a=ONE orTWO is sufficient; this operation does not identify the independent first-copy sign ε.

For a=ONE all other points are minus poles, so S+=t−λ,S−=(t+λ)(t+λω)(t+λω²) and U is LINEAR. For a=TWO, write S+=(t−λ)(t−ζλ),S−=(t+λ)(t+ζ′λ), with {ζ,ζ′}={ω,ω²}; both orientations are retained and U is CUBIC. All SIX linear and TWENTY cubic factors of the squarefree polynomial t6−ONE are retained. These allocations also retain coincidences with its roots, subject only to the actual pole opens below.

Let p²=ν and K=ελ³−ONE, where ε=±ONE is retained independently. The original fixed-tensor first jet prescribes the t-coordinate residue l1,t=tQ Kp/ρ. At the chosen plus pole A=λ it gives
\[
c=\frac{2A pK S_+'(A)}{S_-(A)U(A)}.
\]
At every other plus pole T it imposes
\[
A S_+'(A)S_-(T)U(T)-T S_+'(T)S_-(A)U(A)=0.
\]
At every minus pole S it imposes
\[
S_-(A)U(A)S_+(S)V(S)-4AS\nu K^2S_+'(A)S_-'(S)=0.
\]
Indeed at a plus pole the F+ residue is TWO tQ Kp; at a minus pole the F− residue is TWO tQ Kp. Substituting the value of c gives precisely the displayed equations. All coefficients lie in F25[λ]; no square root p remains. There are THREE remaining equations in every pattern, rather than treating the conjugate pair as one local condition.

The minimum genuine opens are λK, U(T) at EVERY plus pole and V(S) at EVERY minus pole. No λ6−ONE open is permitted. Pole factors and their derivatives at the listed distinct points are nonzero automatically when λ≠ZERO. Put C=S−(A)U(A) and N=FOUR ν A²K²S+'(A)², so c²=N/C². The actual triple pole of x2 at infinity requires
\[
N+C^2\ne0.
\]
The actual triple pole of x1 at ZERO requires
\[
N[S_-(0)U(0)]^2+C^2S_+(0)^2\ne0.
\]
These follow respectively from $c+c^{-1}$ and from $F_+(0)+1/F_+(0)$ being nonzero. Allowed leading cancellation of x1 at infinity remains retained. The centered sign ε stays independent in every pattern.

Thus the SIX linear cases and TWO groups of TWENTY cubic cases, each with TWO ε choices, give NINETY-TWO univariate necessary systems with the explicit genuine physical opens. Any surviving parameter would still require the full fixed-P cube, tensor and ramification identities. No consistency claim or actual source is inferred from this reduction, and any original Y-leg remains on the original source.
