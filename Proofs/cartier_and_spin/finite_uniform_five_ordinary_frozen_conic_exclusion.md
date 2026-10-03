# Proof: actual contact five and fresh lower principal subresultants

Version2, 3 October 2026. The complete local argument, including q0-zero points, and the fresh PSC3/4 certificate passed independent whole review with no required corrections. See the [statement](../../Theorems/cartier_and_spin/finite_uniform_five_ordinary_frozen_conic_exclusion.md) and [audit](../../Research/audits/OCT03_FINITE_FIVE_ORDINARY_FROZEN_CONIC_CONTACT_FIVE_WHOLE_AUDIT_2026_10_03.md).

## Actual local comparison

Use the fixed curve over k=bar F5 with β²=β+3 and encoding [a+5b]=a+bβ. Its monic P has ascending coefficients
\[
[11,22,18,5,19,20,15,16,9,22,1].
\]
At the stated finite ordinary point, Xi and y_i are units. Put v=ord(q1), which is zero or one because its derivative2X1 is a unit; q2 has the same valuation because z is a unit. The actual étale h1 makes dx1 a local differential frame because P(x1)≠0. Since z comes from Q and π has different at least eight, ord_P(dz)≥8; zeros of the Q-differential only increase this order.

Differentiate the ACTUAL q-comparison and use the ACTUAL θ-comparison:
\[
\left(\frac{q'_2y_2^2}{\kappa z^8y_1^2}-z^3q'_1\right)dx_1
=3z^2q_1\,dz.
\]
The two terms in parentheses are units and their difference has order at least8+v. Cubing and clearing the unit factors, with the stipulated κ³=1, gives
\[
K=X_2^3P(X_2-1)^2-z^{33}X_1^3P(X_1-1)^2,
\qquad \operatorname{ord}_P(K)\ge8+v.
\]
This is the original polynomial numerator; no freely chosen tensor phase or descended endpoint is introduced.

Put s=z(P)³. Choose the unique local frozen branch V with V(P)=X2(P) and
\[
V^2=sX_1^2+d_0(s-1),\qquad d_0=[23].
\]
It exists because2X2(P) is a unit. The actual π-index is five, so ord(z³−s)≥5. Consequently
\[
(X_2-V)(X_2+V)=(z^3-s)q_1
\]
has order at least5+v, while X2+V is a unit. Thus X2−V has order at least5+v. Also z³³−s¹¹ has order at least five. Combining these polynomial-evaluation estimates with ord(K)≥8+v gives
\[
\operatorname{ord}_P\bigl(V^3P(V-1)^2-s^{11}X_1^3P(X_1-1)^2\bigr)\ge5.
\]
Since X1−X1(P) is an actual source parameter, this is frozen polynomial contact at least five in X1, including v1 at q0-zero points. No q_i is divided out.

## The exact norm and the characteristic-five gcd threshold

Write R(V)=P(V−1)²=R_even(V²)+V R_odd(V²). Set
\[
T=sX^2+d_0(s-1),\quad A=T^2R_{\rm odd}(T),
\quad B=TR_{\rm even}(T),\quad
C=A-s^{11}X^3R(X).
\]
The frozen numerator is F=C+VB, and its exact quadratic norm is
\[
N(X,s)=C^2-TB^2.
\]
At the actual frozen branch, ord(F)≥5; its conjugate is regular. Thus N has a root of multiplicity at least five. Conjugate collisions may increase the norm multiplicity, so this remains a necessary condition only.

The fixed X-degrees are46 for N and45 for ∂N/∂X, with common leading coefficient s²²(1−s). They stay fixed for every geometric s outside0,1. A root of multiplicity exactly five makes the derivative vanish to order at least five because five is zero in k. A root of multiplicity at least six gives the usual derivative order at least five. Hence in ALL cases contact at least five forces
\[
\deg\gcd(N,\partial_XN)\ge5.
\]
The integral principal subresultant coefficients PSC0,…,PSC4 must then all vanish. In particular PSC3=PSC4=0. This is a genuinely lower contact threshold than the accepted contact-ten gate; PSC7/8 alone cannot exclude it.

## One fresh executed lower-threshold certificate

The [new source](../../scripts/oct03_frozen_conic_contact_five_psc_probe.sage) pins the SHA256 of the [accepted frozen setup](../../scripts/oct03_frozen_conic_principal_subresultant_probe.sage) and reuses ONLY its exact field/norm setup, exact helper definitions and tiny deficient-remainder calibration. It does not execute the old principal-subresultant recurrence or load its PSC7/8 arrays. The new process computes the recurrence afresh and continues to the NEW indices0,…,4, preserving the exact indexed scaling and missing-index zeros at a deficient remainder.

The same process's tiny calibration agrees with the installed Sage schoolbook subresultants and direct Sylvester principal minors for f=W⁴+W²+W+1, g=W³+W; in particular S2 has degree one and PSC2=0. Every new remainder checkpoint and the FULL newly used coefficient arrays are in the [fresh output](../../../litt3-computation-data/oct03_frozen_conic_contact_five_psc_probe/stdout.jsonl).

The new recurrence reaches PSC4 of s-degree1869 and PSC3 of s-degree1914. Their common factor after removing s and s−1 is ONE. Therefore no geometric s outside0,1 can make both zero, contradicting the necessary contact-five gate. The recorded arrays encode F25 by the stated coefficient convention; no finite-field parameter sample is used.

The [exact receipt](../../../litt3-computation-data/oct03_frozen_conic_contact_five_psc_probe/receipt.json) records source SHA256 3d3d13bbc6519bf972adf9b5f3e7f689e45e04d072fcc6f93fbdbdd2f09a758a, the sage-python command, eight numerical environment settings at one, the hard external process-group thirty-second timeout and soft twenty-five-second checkpoint budget. The ONE process exited successfully without timeout in6.7205 seconds, reaching its mathematical decision in3.9560 seconds. Its stderr is empty. No repeat, parameter enumeration, Gröbner basis or group calculation was performed.

The parent separately authorized ONE [independent standard-library verifier](../../scripts/verify_oct03_frozen_conic_contact_five_psc_certificate.py), executed by the earlier finite-ten auditor. It used only the newly recorded PSC3/4 arrays, without reconstructing N or replaying either successful recurrence. In0.5436 seconds externally (0.5166 seconds in its arithmetic), it stripped s¹⁰⁰⁸(s−1)⁸⁵ from PSC3 and s¹⁰⁰⁴(s−1)⁸³ from PSC4, leaving degrees821 and782, then checked an exact Bézout identity ONE in747 Euclidean steps. The [complete independent certificate](../../../litt3-computation-data/oct03_frozen_conic_contact_five_psc_probe/independent_gcd_bezout.json) stores stripped arrays and Bézout coefficients; the [independent receipt](../../../litt3-computation-data/oct03_frozen_conic_contact_five_psc_probe/independent_verification_receipt.json) records input/source hashes, one-thread settings, thirty-second external process-group timeout and successful exit. This author did not duplicate the verification.

## Retained scope

The necessity uses actual finite étale endpoint coordinates, exact κ³=1, unit Xi and P(x_i), and a finite unit z with s≠1. The degree-drop s0/1 parameters and special finite P/coordinate-zero branches are retained. The executed source's initial application metadata retained q0-zero points, but its generic polynomial certificate excludes norm contact≥5 for ALL geometric s outside0,1 independently of q0-values. Version2 extends the actual local application to q0-zero points by the explicit v1 estimates above and fresh static review, using the unchanged complete certificate; no numerical replay was performed. The original common-cover problem remains unresolved, and both actual endpoint legs stay on the SAME source.
