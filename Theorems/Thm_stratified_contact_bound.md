# Contact bounds summed over zero-multiplicity strata

Let k be algebraically closed of characteristic p>0. Let X,Y be smooth
projective connected curves of genus at least two, with nonzero regular
weight-d tensors s_X,s_Y, d>=1. Consider a nonempty finite REDUCED union
of distinct joint images whose normalizations are finite etale over
both endpoints and satisfy f*s_X=g*s_Y. Write A,B for its total degrees
over X,Y and T=A(g(X)-1)=B(g(Y)-1).

Let E be the common set of positive zero multiplicities of the endpoint
tensors. For e in E write u_e,v_e for the number of zeros of order e
on X,Y, respectively, and r_e for the prime-to-p part of e+d.

If p divides d but not some e in E, then

    B<=r_e u_e,             A<=r_e v_e.

Otherwise define m_e as the least integer >=2 satisfying e+d m_e=0
modulo p when p does not divide d; if p divides d and e, put m_e=2.
Thus 2<=m_e<=p+1. Put

    K=sum_(e in E)(1+(m_e-1)/r_e)-2.

Then

    K AB <= 2T + sum_e m_e A u_e.

If K>0, this yields

    B <= (2(g(X)-1)+sum_e m_e u_e)/K,
    A <= (2(g(Y)-1)+sum_e m_e v_e)/K.

In particular, two distinct positive zero multiplicities ALWAYS give
a bound of this kind, in every positive characteristic and every weight.
The bounds include intersections between different image components.

For a fixed pair (C,s) satisfying the hard-cap case or K>0, ALL exact
s-preserving self-images form one finite groupoid, with canonical
effective quotient S_s. The total atlas degree obeys the same bound
with X=Y=C. Actual tensor-preserving endpoints satisfying the criterion
have identified canonical quotients. Line preservation adds a finite
cyclic prime-to-p multiplier group; the resulting line quotient is
unchanged under connected finite etale refinements, scalars, and powers.

This is author prose, not yet independently audited. It does not
supersede the checked etale-root theorem: for equal weight and zero
order at large weight the displayed K can be nonpositive. Nor does it
produce a shared tensor for arbitrary common covers. Nonuniform zeros
already force a core by the literature's one-clump theorem; the new
content here is the explicit reduced-union bound and simultaneous quotient.

[Proof](../Solutions/Sol_stratified_contact_bound.md).
