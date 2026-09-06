# Hermitian local rigidity, a scalar invariant, and a short-jet atlas test

Let k be algebraically closed of characteristic p>=3. Let a faithful finite
local action I=P semidirect C_t on k[[z]] have lower groups

    |I_1|=p^3, |I_2|=...=|I_(p+1)|=p, I_(p+2)=1,
    t>p+1, p not dividing t.

Then t divides p^2-1. Up to an unlabelled source-coordinate conjugacy the
action is the subgroup P semidirect C_t of the infinity stabilizer on the Hermitian curve

    H: y^p+y=x^(p+1).

Put u=x^(p^2)-x and use source uniformizer z=x/y. Let F_t(z)=u^(-t)
be its quotient series. Write

    E=p^3 t, A=p^3-p, B=(p+1)(p^2-1), delta=E+B-1,
    r=(p^2-1)/t, D=delta+p+1.

Every separating series f that realizes the displayed Galois filtration
is source-right-equivalent, over the FIXED target field, to a F_t for some
a in k^*. Two such models a F_t,b F_t give isomorphic fixed-base extensions
if and only if (a/b)^r=1.

In any source uniformizer the coefficients c_j of such an f satisfy

    c_E, c_(E+A), c_(E+B) nonzero,
    c_j=0 for E<j<E+A,
    J(f)=c_E^r (c_(E+A)/c_(E+B))^(p^3)=a^r.

J is independent of the source uniformizer. It is defined here on the
stated Galois locus, not on arbitrary series with the same different.

For an arbitrary series f, membership in this Galois locus is equivalent
to the existence of a,b_1,...,b_(p+1) in k, a b_1 nonzero, such that

    f(z)=a F_t(b_1 z+...+b_(p+1)z^(p+1)) modulo z^(D+1).

For several wild completions of a single curve map, they have this Galois
type and are mutually isomorphic over the SAME target exactly when these
finite tests hold and their J values agree. This is the local part of the
actual-atlas condition; the original curve map and its other branches must
still be present.

For p=5,t=8 or24, (E,delta,D)=(1000,1143,1149) or (3000,3143,3149).
Only six source-coordinate coefficients occur in each finite equivalence
test. The scalar is identified modulo mu_3 for t=8 and uniquely for t=24.

Major independent audit PASS, /root/hermitian_fixed_base_major_audit,
2026-09-06; the infinity-stabilizer subgroup wording was clarified.
No global quotient identification, atlas
existence, or Litt3 exclusion is asserted.

[Proof](../Solutions/Sol_hermitian_local_normality.md).
