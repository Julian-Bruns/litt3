# Proof: one endpoint and the scalar field

[Statement](../../Theorems/cartier_and_spin/pole_fifteen_one_endpoint_exclusion.md).
Use the common-pole weights of the actual quotient, X=sum d_c c^2,
Y=sum d_c c^6 in K0=F_(5^14), and bar on K0. The two endpoint
multisets are Q,H, now of size five. The original first/second trace
calculation uses unaveraged sums and does not divide by their size.
It consequently gives, with eta=[22],
\[
\epsilon(E_Q-\eta\bar X)=C_H-\eta\bar Y,\qquad
\epsilon(C_Q-\eta Y)=E_H-\eta X.                     \tag{1}
\]
Here C and E are exactly the coefficients in the
[five-label rank theorem](five_label_endpoint_rank.md). Common-pole
residues and integrality elsewhere justify the same trace comparison
in degree five; no quartic endpoint exclusion is imported.

Suppose Q is concentrated. Its two sums vanish. Eliminating epsilon
from(1) gives
\[
Y C_H-\bar X E_H+\eta(\bar X X-Y\bar Y)=0.           \tag{2}
\]
If H is not concentrated, 1,C_H,E_H are K0-independent. Thus Y=X=0;
substitution in(1) then makes C_H=E_H=0, a contradiction. If H is
concentrated, the [fully concentrated theorem](concentrated_quintic_exclusion.md)
is already contradictory. Interchanging endpoints proves the result
at infinity too. Once neither endpoint is concentrated, C_Q is not
in K0. The second denominator in(1) cannot vanish, giving
\[
\epsilon=\frac{E_H-\eta X}{C_Q-\eta Y}\in\mathbf F_{5^{56}}.
\]
This is a consequence of actual trace identities, not an assumed bound
on geometric parameters.

## Local trace observability with only one concentrated endpoint

This separate lemma explains which part of the returned proof travels
without reciprocal concentration. Work at zero, with the notation
u=U(t,z), z=t^3v/b, Lambda and the five-function determinant from the
concentrated proof. Put h=[t^-1]Tr(v). The adjacent expansion gives
\[
\operatorname{Tr}(u)=(4a/b)h t^3+O(t^4),\qquad
[t^0]\operatorname{Tr}(v)=\Lambda h.
\]
For the first identity expand U=alpha+a t z^4+2r a^2t^2z^8+...:
the common coefficients sum to zero, and the first varying coefficient
contributes 4a sum(e_i/b) at t^3.

At each common pole R_v(c)=epsilon c^4 R_u(c); this factor has no
minus sign. If Tr(v)=0, all residues of Tr(u) vanish and h=0.
Then Tr(u) is a polynomial of degree at most3, by the other endpoint's
pole bound, while it vanishes to order at least4 at zero. Hence Tr(u)=0.
If Tr(u)=0 first, h=0 and all R_v vanish; Tr(v) can only be H0/t+C,
because v is integral at infinity. Its adjacent coefficients give
H0=h=0 and C=Lambda h=0. Again both traces vanish. The same local
five-function determinant, whose determinant is3, contradicts this.

The independent focused proof audit checked this extension and the
bridge(2). The finite rank theorem was completely enumerated locally
afterward. No assumption is made on unprescribed regular coefficients
at other branches or on a simultaneous Galois closure.
