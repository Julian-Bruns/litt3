# Cubic descent of the scalar atlas and a uniform Q frame

Work on the fixed curve y^3=F(x) over F25. On the noninvariant oper
locus write

    c4=t, t^3=lambda, A=t^2 Ahat, C=t Chat,
    K=F25(Ahat,Chat,B,lambda),

as in [the oper census](../projective_connections/fixed_x_oper_enumeration.md).
Here t is an oper coefficient. Let zeta be a primitive cube root of
unity and sigma(x,y)=(x,zeta*y). The action on scalar atlas data is

    (t,U,eta) -> (zeta*t, sigma(U), zeta*sigma(eta)).

It preserves the full N/R equations, Wronskian1, compact normalization
and regularity at infinity.

Let M(t) represent Q:L64->L112 in the monomial bases ordered by pole
order. Write j_i,k_r in {0,1,2} for the input and output y exponents.
Then

    M(t)=diag(t^k_r) Mhat diag(t^-j_i),

where Mhat is polynomial in Ahat,Chat,B,lambda. Every minor satisfies

    det M(t)[J,I]=t^(sum k_J-sum j_I) det Mhat[J,I].

For any invertible frame minor, the substitutions

    v_i=t^j_i vhat_i,       b_l=t^-k_l bhat_l

descend the entire atlas scheme to K. Its equations are obtained by
removing each row's common power of t and using t^3=lambda; its
normalization is bhat^T Ghat vhat=2. Base change to K[t]/(t^3-lambda)
recovers the original schemes on all three cubic branches. This works
whether lambda is a cube in K. It preserves scheme structure, quotient
directions and all Frobenius equations.

One frame works on all twelve noninvariant representatives of the
completed census and all their Frobenius and cubic conjugates. Its
zero-indexed columns are

    I=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,
       21,22,26,27,31,32,36,37,41,42,46,47,51,52).

The rows are the monomials of pole orders112 down to36 congruent to1
or2 modulo5, in descending order. Universally this32-square minor has
26 constant pivots and determinant -det H, where H is6-square with
polynomial entries of degree at most9. The minor's determinant d is a unit
in the normalized census algebra R=F5[T]/(P), deg P=19290, certified by

    d(T)e(T)+P(T)f(T)=1.

The [verifier](../../scripts/atlases/verify_cubic_oper_frame.py)
checks this identity. The six invariant representatives are outside
this frame statement.

Version3. Author proof with exact computational evidence. The uniform
census result subsumes the former individual-orbit frame checks.
[Proof](../../Proofs/atlases/cubic_oper_atlas_descent.md).
