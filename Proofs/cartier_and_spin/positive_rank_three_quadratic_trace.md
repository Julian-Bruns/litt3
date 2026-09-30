# Proof: the positive rank-three quadratic trace

This integrates the last response in the returned message (the
reply to request2). Use C=Y^(1), A=E-perp, V=E/A, omega=omega_C.
All actual subbundles are retained on the given first-Y-Galois source.

## The intrinsic quadratic map

At the generic point identify B_Y with L/K for K=k(C) embedded
by relative Frobenius in L=k(Y). Represent A by [f] and set
eta=C_Y(f^4 df). The annihilator E has basis [f],[f^2],[f^3].
A containing Lagrangian is spanned by [f] and s[f^2]+t[f^3].
Its canonical line has primitive
\[
4s^2f+2stf^2+2t^2f^3,\qquad
d(4s^2f+2stf^2+2t^2f^3)=(2s+tf)^2df.
\]
This defines j on A^2*Sym^2 V*omega^-1, with eta as differential
frame. Replacing f by f+c changes s to s-3ct and the resulting
primitive only by a constant in K. Scaling f has precisely the
tensorial transformation of that source. These identities, including
the shift, have an independent symbolic
[check](../../scripts/arithmetic/check_flag_reply_algebra.py).
The projective image is the nonsingular conic X1^2=3X0X2.

At a zero of adjunction of multiplicity m choose f=z^(m+1),
tau=z^5. Then eta=(m+1)tau^m d tau.
For m=1 a regular basis of E is
(e1,e2,e3)=(f,f^2,f^3/tau), and in regular source frames
\[
j(v^2)=3\tau s^2e1+4st\,e2+4t^2e3.
\]
The image lattice is (tau e1,e2,e3).
For m=2 use (f,f^2/tau,f^3/tau); now
\[
j(v^2)=2s^2e1+\tau st\,e2+\tau t^2e3,
\]
with image (e1,tau e2,tau e3). Away from zeros the map is
invertible. This proves regularity and the exact colength2.
At a double zero j(H)=A+E(-P1). The multiplicity-two quotient
is killed by the maximal ideal; it is not O/(tau^2).

The actual canonical-line construction agrees with j on each
P_i. It is saturated, since a zero on the first twist would create
an adjunction zero of order at least5, whereas the orders are0 or2.
Thus lambda_i factors through H as the square of
L_i=P_i/q^*A, with the stipulated determinant twist.

## Full trace, not only generic span

At least eight distinct lambda_i lie on the conic; any three
distinct ones span E generically. Their trace I_lambda is a
rank-three quotient of q_*lambda_0, semistable of slope-1/4
after the usual actual Galois splitting. Thus deg I_lambda>=0.
It lies in j(H), whose degree is zero, so equality of image
sheaves follows. This is an integral equality, not just saturation.
The source Veronese lines therefore generate H in every fiber,
forcing at least three distinct L_i directions everywhere.
At the double zero all lambda_i can nevertheless coincide in E:
the two lost lattice directions in (e1,tau e2,tau e3) explain it.

## One common quotient for all contacts

The class [f^2] modulo A defines iota2:A^2->V independently of
adding a Frobenius constant to f. It lies in A-perp because
C_Y(f d(f^2))=0. The local bases above give no saturation defect
at a simple zero and defectP1 at a double zero. Pairing with this
map gives phi:V->omega A^-2, with fixed zero P1 only in the
double case. These facts give both exact sequences in the statement.

Projection of the quadratic primitive to V is2t times
s[f^2]+t[f^3]. Pairing [f^2] with that line is3t*eta.
The projection of lambda_i to L_i is therefore, up to a nonzero
constant, phi restricted to L_i. Its zeros are exactly the old
degree9d contact divisors, with the fixed degree8d fiber in the
double case and effective degree-d residuals. No additional
descent of an individual residual follows.

In the double case the two line bundles in V have degree one.
Every Frobenius pullback remains an extension of equal-degree
lines, proving strong semistability and minimum slope5^r.
The inverse image of A^2(P1) in E is also a degree-one
Lagrangian. It has surjective evaluation, simple branch at P,
and canonical second line A. It is an endpoint construction only.

## Exact limit of the slope tests

For an arbitrary rank-two degree-two V on a genus-two curve,
twist by a degree-one line to a degree-zero W. If F^*W is
semistable and W first destabilizes at n, then n>=2.
The positive HN line N in F^{n*}W is not horizontal for the
canonical connection: otherwise it would descend to a positive
line in the previous semistable bundle. Its nonzero second
fundamental map into the negative quotient tensor omega gives
deg N<=-deg N+2, hence deg N=1. Subsequent Frobenius pullbacks
have HN degrees +/-5^(r-n), since any competing line mapping
to the negative quotient has no larger degree. Undo the twist:
\[
\mu_{\min}(F^{r*}V)=5^r-5^{r-n}\ge24\,5^r/25.
\]
Before n the bundle is semistable; if n does not exist the
minimum slope is5^r throughout. Conversely the bound at r=1
excludes an integer-degree quotient at most4 in degree10.
This proves the claimed equivalence and closes the later-slope
shortcut. It supplies no missing two-map comparison.
