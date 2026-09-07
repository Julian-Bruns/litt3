# Low pencils bound torsion with any fixed finite prime support

Let C/F_q be a smooth projective connected curve of genus g>=2 and
x:C->P1 a finite Galois map of degree n>=2. Assume its deck group G
is defined over F_q and there is a rational point O with x^*(infinity)=nO.
Let 1<=r<=n and suppose every rational function on C of degree at most
2r belongs to k(x), where k is the algebraic closure of F_q.
Write W_r={ [D-rO]: D effective of degree r } in J(C).

1. Every nonzero class in W_r has exactly one effective representative
   D of degree r. The only possible moving zero-class representatives
   occur when r=n, and then they are full fibers of x.

2. Suppose gamma permutes geometric points, acts compatibly on divisor
   classes, commutes with G, fixes O and every ramification point of x,
   and has finite orbits on divisors. Then

       alpha in W_r, (gamma-1)^2 alpha=0
       implies (gamma-1)alpha=0.

3. Let S be a finite set of primes different from char(k), and choose
   N so that q^N-Frobenius fixes the ramification points, J[ell] for
   every odd ell in S, and J[4] if 2 is in S. Every class in W_r whose
   order has prime divisors only in S belongs to J(C)(F_(q^N)).
   In particular these classes have bounded order and form a finite set.
   Their NONZERO classes have effective representatives rational as
   divisors over that field; individual support points need not be rational.

This includes mixed-primary torsion without assuming its primary
projections belong to W_r. There is no bound uniform in the prime set S.
No clump is asserted to exist or to have image size at most r.

A useful way to check the pencil hypothesis: if x has PRIME degree n
different from char(k), and its trace-zero bundle splits as

       ker Tr(x_*O_C)=direct_sum O_P1(-b_i),

then every function outside k(x) has degree at least max_i b_i.
Thus 2r<max_i b_i suffices. For a hyperelliptic curve of genus g>=2
in odd characteristic, max_i b_i=g+1; in particular r=1 always works.

Version1,2026-09-07. Author proof, not independently audited.
This generalizes the geometric mechanism in the audited cubic theorem;
the latter's specialized arithmetic and audits remain separate.
[Proof](../Solutions/Sol_low_pencil_torsion_rigidity.md).
