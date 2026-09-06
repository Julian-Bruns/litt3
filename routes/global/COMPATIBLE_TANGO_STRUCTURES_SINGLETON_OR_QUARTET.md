# Compatible Tango structures: zero, one, or p−1

Date: 2026-09-05. Status: direct proof for the actual coreless span.
Independent audit: **PASS**, /root/tango_count_structural_audit,
2026-09-05. No breaking objections; optional notation clarifications
incorporated below. [Audit record](audits/COMPATIBLE_TANGO_STRUCTURES_STRUCTURAL_AUDIT_2026_09_05.md)
is for investigating doubts, not routine context loading.

Both nonempty cases occur in characteristic five: the
[Igusa construction](IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md)
realizes four, and the [additive projective construction](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md)
realizes one. The classification is not a nonexistence obstruction.

Let \(k\) be algebraically closed of odd characteristic \(p\), and let \(X\leftarrow^f Z\to^g Y\)
be finite etale, smooth projective connected, with genera at least two
and \(k(X)\cap k(Y)=k\) inside \(k(Z)\). All pullbacks below are the
actual differential pullbacks. Count pairs of Tango structures whose
pullbacks agree, equivalently pairs of regular dormant connections on
\(\omega\) whose horizontal forms have Cartier image zero; see the
[Tango equivalence](TRANSVERSE_DORMANT_MIURA_TANGO_PRIMARY_SOURCE_SCREEN.md).

**Theorem.** The number of compatible pairs is \(0,1\), or \(p-1\).
It is \(p-1\) precisely when there is a nonzero shared holomorphic form
\(\eta=f^*\eta_X=g^*\eta_Y\) satisfying

\[
 C\eta=\eta,\qquad \operatorname{div}_Z(\eta)\in p\operatorname{Div}(Z).
\]

In that case the \(p-1\) endpoint connections, for \(c\in\mathbf F_p^*\),
are determined by

\[
 \nabla_c(r\eta_C)=(dr+c r\eta_C)\otimes\eta_C.
 \tag{1}
\]

Here the first tensor factor is the differential factor; \(r\) is any
rational function on the endpoint. The divisor condition is equivalent
on either endpoint by etaleness. Rescaling \(\eta\) by an element of
\(\mathbf F_p^*\) merely permutes these connections.

If the positive canonical intersection is nonempty, write it as
\(A=k[s]\), with primitive weight \(d\). Suppose at least one compatible
Tango pair exists. Then it is unique exactly when

\[
 C_n(s^r)=0,\qquad 1\le r\le p-1,\quad rd=pn+1.
 \tag{2}
\]

Here r is the unique indicated inverse of d modulo p and n=(rd-1)/p.
The inverse-Frobenius-semilinear operator
\(C_n:\omega^{pn+1}\to\omega^{n+1}\) is twisted Cartier,
characterized rationally by \(C_n(b^p\alpha^{pn+1})=b\alpha^n C(\alpha)\).
Otherwise \(d=1\), \(C(s)\ne0\), and the displayed divisor condition holds.
Existence of a shared pluriform alone is not an existence assertion
for a compatible Tango pair.

**Proof.** A dormant connection on a rational line has a nonzero
rational horizontal frame by Cartier descent. Consequently the
difference of two dormant connections on the same line is logarithmic:
if their horizontal frames have ratio \(h\), it is \(\pm d\log h\).
In particular its ordinary Cartier image equals itself. Conversely,
the standard rational Cartier criterion says that \(C\beta=\beta\)
exactly when \(\beta=d\log q\); equivalently \(d+\beta\) is dormant.

Two distinct compatible regular connections therefore give a nonzero
shared Cartier-fixed holomorphic form \(\eta\). The
[canonical intersection theorem](../../Theorems/Thm_canonical_intersection.md)
gives \(A=k[\eta]\). For any compatible connection, its value on
\(\eta\) is shared and regular, so \(\nabla\eta=c\eta^2\), \(c\in k\).
In the rational frame \(\eta\) its connection form is \(c\eta\).
Dormancy and Cartier semilinearity give
\(c^{1/p}\eta=c\eta\), hence \(c\in\mathbf F_p\). The case \(c=0\)
would make the Cartier-nonzero form \(\eta\) horizontal, contradicting
the Tango condition.

Locally write \(\eta=a\,dt\). Its connection form in the regular frame
\(dt\) is \((ca-a'/a)dt\). At a zero of order \(m\), the only possible
pole has residue \(-m\). Regularity is therefore equivalent to
\(p\mid m\) at every zero. This proves necessity of the divisor condition.

Conversely suppose that condition holds. Each endpoint form is
Cartier-fixed by injectivity of etale pullback, and can be written
\(\eta_C=d\log q_C\). Formula (1) is regular by the local computation.
For \(c\in\mathbf F_p^*\), interpreted as an integer from 1 to \(p-1\),
its rational horizontal frame is

\[
 q_C^{-c}\eta_C=-c^{-1}d(q_C^{-c}).
\]

It is exact, so the connection is dormant and all its horizontal
forms have Cartier image zero: they are \(p\)-th-power multiples of this
frame. The two pullbacks agree by (1). These \(p-1\) connections are
distinct, and the preceding argument proves exhaustion. Thus two
compatible pairs already force exactly \(p-1\); all other counts are
zero or one.

Finally \(p\nmid d\): if \(d=pm\), the canonical connection on
\(\omega^{pm}\) sends \(s\) into \(A_{d+1}=0\). Its horizontal endpoint
sections have unique regular \(p\)-th roots, which agree on \(Z\),
contradicting minimality of \(d\).
If \(d>1\), a compatible connection induces
\(\nabla^{(d)}s\in A_{d+1}=0\). In a rational horizontal Tango frame
\(\alpha\), write \(s=u\alpha^d\). Horizontality gives du=0,
so u=b^p in the endpoint function field. Then
\(C_n(s^r)=b^r\alpha^n C(\alpha)=0\).
If \(d=1\), write \(\nabla s=a s^2\), with \(a\in k\).
For \(a=0\), Tango gives \(C(s)=0\). For \(a\ne0\), dormancy makes
\(\eta=a s\) Cartier-fixed, and \(\nabla\eta=\eta^2\); regularity
gives its \(p\)-divisible zero divisor and hence \(p-1\) compatible pairs.
Conversely, that case has primitive weight one and nonzero Cartier
image. This proves (2) and its converse. \(\square\)
