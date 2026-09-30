# Proof of the primitive trace-jet criterion

At P, ord(df)=r-1<p-1 implies that every negative term of the Laurent
expansion of f has exponent divisible by p. The coefficients of its
non-p-power terms of degrees1,...,r-1 vanish. Over the perfect constant
field its p-power principal part and constant can therefore be removed
by subtracting a formal p-th power. The remaining truncation through
degree p-1 is the specified f_P and begins in degree r.

Unramifiedness over Sigma identifies every completed local ring above P
with k[[t_P]].
At a selected point, ord(q)=r. Subtracting its local p-power summand
cannot change any coefficient of degree1,...,p-1. Consequently
q=f_P+O(t_P^p) after the same normalization. The ratio q/f_P equals
1+O(t_P^(p-r)); hence
\[
d\log q-d\log f_P=O(t_P^{p-r-1})dt_P.
\]
Thus the residue is r and every regular coefficient through degree
p-r-2 equals c_(P,j). This comparison is unaffected by higher formal
p-power terms.

At an unselected point, q has order<=0. Since dq=h^*df, the order of
dq/q is at least r-1. Its residue and regular coefficients through
degree r-2 are zero. The common range in which both conclusions hold
is exactly0<=j<=min(r-2,p-r-2).

Write m_P for the number of selected points over P. The trace sums
the actual local logarithmic germs without division by deg(h), so
\[
\operatorname{Res}_P\beta=m_Pr,\qquad
[t_P^jdt_P]\beta=m_Pc_{P,j}.
\]
Eliminating m_P gives the stated linear equations, even when m_P is
zero in k or the covering degree is divisible by p.

The identity beta=Tr_h(dq/q)=dlog Nm_h(q) follows from separability.
A logarithmic differential has at most simple poles. Outside Sigma
the divisor multiplicities of the norm are divisible by p, so these
poles have zero residue and are removable. Thus beta belongs to the
specified global section space. Every rational logarithmic differential
is Cartier-fixed. Any separately established homogeneous linear local
condition also survives the sum of germs.

If the resulting space has no nonzero Cartier-fixed vector, beta=0.
For the one-variable function field over a perfect field, the kernel
of d:k(X)->Omega_(k(X)/k) is k(X)^p. Therefore Nm_h(q) is a p-th
power. No construction of a Galois closure, averaging, torsion argument
or finite-degree enumeration occurs in this proof. Ramification away
from Sigma is irrelevant: divisor pushforward still makes the norm's
multiplicities there divisible by p. Thus the stated weakening from
global etaleness uses exactly the same proof.

For the fixed characteristic-five cubic example, r=3 gives J_P=0.
The local relation is four times the regular coefficient equals the
residue times P'/P+A''/A'. The additional infinity jet and the two
small endpoint determinants in
[the fixed-curve proof](uniform_admissible_norm.md) make the relevant
Cartier-fixed intersection zero. The abstract criterion itself has no
computational component; it does not assert that this intersection
vanishes for every endpoint.
