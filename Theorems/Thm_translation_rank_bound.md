# Artin--Schreier translation rank and fractional jumps

Let k be algebraically closed of characteristic p>0 and f in k[x]
have degree B>1 prime to p. Suppose a finite additive subgroup V of
order p^r>1 satisfies f(x+a)-f(x) in (F-1)k[x] for every a in V,
where F(h)=h^p. Then B=1 modulo p. Put Q=p^s, s=v_p(B-1). One has

    B=Q+1  => |V|<=Q^2,
    B>Q+1  => |V|<=Q.

These are necessary, not sufficient, conditions.

Consequently, for a faithful local inertia action on k[[z]] with
|I_2|=p<|I_1|=p^(r+1), let 1,B be its positive lower jumps. Exactly
one of the following necessary alternatives applies:

- p^r divides B-1; the upper jumps of I_1 are the integers
  1 and 1+(B-1)/p^r.
- B=p^s+1 with s<r<=2s; the second upper jump is 1+p^(s-r).

The local assertion uses HKG realization, not a claim that the auxiliary
curve is an etale cover of the endpoint or has its ordinarity properties.

Evidence: PASS, `/root/integral_jump_degree_bound_audit`, 2026-09-06;
275 exact polynomial checks also passed.
[Proof](../Solutions/Sol_translation_rank_bound.md).
