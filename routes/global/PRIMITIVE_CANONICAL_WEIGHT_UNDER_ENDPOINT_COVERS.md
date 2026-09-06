# Primitive canonical weight under compatible endpoint covers

Date: 2026-09-06. Author: /root.
Status: direct algebraic proof; not independently audited.
This retains information in the existing reduction. It is not a
nonexistence theorem.

## A degree-drop bound without a Galois assumption

Let k be algebraically closed of characteristic p. Consider a commuting
diagram of finite separable maps of smooth connected projective curves

    X' <- Z' -> Y'
     |     |     |
     X  <- Z  -> Y.

Assume both horizontal spans are finite etale and coreless. Use actual
differential pullbacks for all canonical rings. Suppose their intersections
are k[s] and k[t], with primitive weights d and d', respectively, and
p does not divide d. Put q_X=deg(X'/X), q_Y=deg(Y'/Y).

**Theorem.** There is a positive integer m such that

    d = m d',       m divides lcm(q_X,q_Y).

In particular, if gcd(d,q_X q_Y)=1, the primitive weight is unchanged.
The vertical covers need not be Galois, etale, or of degree prime to p.

**Proof.** The pulled-back s is a nonzero regular common d-differential
upstairs. Hence it equals c t^m, where d=m d'. Rescale t to absorb c.

Suppose m does not divide lcm(q_X,q_Y). Choose a prime ell with

    v_ell(m) > max(v_ell(q_X),v_ell(q_Y)).

For C=X or Y, choose a nonzero rational one-form theta_C and write
s_C=a_C theta_C^d. The corresponding endpoint t_C upstairs, divided by
the pullback of theta_C^{d'}, is an m-th root u_C of a_C in k(C').

Since k contains the m-th roots of unity and p does not divide m,
k(C)(u_C)/k(C) is cyclic Galois. If its degree is r_C, its Galois
action on u_C has image mu_{r_C}; consequently r_C divides m,
u_C^{r_C} belongs to k(C), and r_C divides q_C. Our choice of ell
therefore implies ell divides m/r_C. Thus

    a_C = (u_C^{r_C})^{m/r_C}

is an ell-th power already in k(C).

It follows that s_C is the ell-th power of a rational differential of
weight d/ell on C. This root is regular: its orders are the orders of
s_C divided by ell. The two endpoint roots pull back to roots of the
same s_Z; their ratio is a constant ell-th root of unity. Rescaling one
makes them equal on the ORIGINAL Z. This supplies a positive invariant
of weight d/ell<d, contradicting primitivity. Hence the claimed
divisibility holds. The coprime conclusion follows immediately. QED.

This proof does not confuse regular invariant tensors upstairs with
regular tensors downstairs across a ramified quotient. Regularity of
the descended roots follows specifically from their power being s_C.

## Apply it to the retained tame reduction

In the [core-preserving tame reduction](CORE_PRESERVING_TAME_REDUCTION_TO_TRANSVERSE_DORMANT_MIURA_DATA.md),
choose n with the slightly stronger requirement

    n(e+d) = d mod 5,       gcd(n,5abd)=1,

where a,b are the original leg degrees. This is possible by the same
Chinese remainder argument: prescribe n=1 modulo the prime-to-five
part of abd. The endpoint degrees divide n^{n+1}, so both are prime
to d. The theorem proves that the primitive weight remains EXACTLY d
after this reduction, in addition to all its previously proved outputs.

For the fixed candidate with ordinary Y, its Cartier-zero branch cannot
have d=1: injectivity of ordinary Cartier on H^0(Y,omega_Y) excludes a
nonzero exact shared one-form. Therefore the strengthened reduction's
output still has d>1. This distinguishes it from the original displayed
degree-one singleton example, but does not itself exclude the output.

In particular, the [degree-nine character-quotient construction](DEGREE_NINE_FREE_CHARACTER_QUOTIENT_COUNTEREXAMPLE.md)
is a separate test of that distinction. A statement that Tango plus
corelessness always forces d=1 cannot be inferred from the theorem here.
Nor does this theorem provide a positive invariant when the intersection
is k, or exclude any nonzero-Cartier branch.
