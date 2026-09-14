# Artin–Schreier translation bounds and fractional wild jumps

Version2,2026-09-14. The translation bounds are Lehr–Matignon,
Proposition6.6, with the genus-one boundary included below.

Let k be algebraically closed of characteristic p>0 and f in k[X] have
degree m>1 prime to p. Write F(h)=h^p. In the source notation, Ad_f is
the monic additive polynomial whose zero set is

    Z(Ad_f)={a in k:f(X+a)−f(X) in (F−Id)k[X]}.

For C_f:W^p−W=f(X), translation of X gives an exact sequence

    1 -> C_p -> G_(infinity,1)(f) -> Z(Ad_f) ->0,          (1)

where G_(infinity,1)(f) is the wild inertia at infinity.
Write m−1=ell p^s, with p not dividing ell. Then

    s=0:                 |Z(Ad_f)|=1;
    s>0, ell=1:          |Z(Ad_f)|<=p^(2s);
    s>0, ell>1, p>2:     |Z(Ad_f)|<=p^s;
    s>0, ell>1, p=2:     |Z(Ad_f)|<=2^(s−1).             (2)

In particular these bounds apply to every finite translation subgroup V.

For a faithful local inertia action on k[[z]] with
|I_2|=p<|I_1|=p^(r+1), put P=I_1 and let 1,i0 be its positive lower
jumps. Exactly one of the following necessary alternatives holds:

- p^r divides i0−1; the upper jumps of P are the integers
  1 and 1+(i0−1)/p^r.
- i0=1+p^s with s<r<=2s; the second upper jump is 1+p^(s−r).

In the fractional case the auxiliary HKG curve is an Artin–Schreier
curve with reduced equation

    W^p−W=X S(X)+cX,     S additive of degree p^s.

Its full wild inertia group is extraspecial of order p^(2s+1), and
P is the inverse image of an r-dimensional subspace V⊂Z(Ad_f) in(1).
This normal form is Matignon–Rocher, Proposition2.5 and Remark2.6.
The HKG curve is an auxiliary local realization, not an étale endpoint
cover.

[Sources and local application](../../../Proofs/quotient_geometry/local_actions/translation_rank_bound.md).
