# Sources: translation bounds and their local application

## 1. The published translation theorem

[Lehr–Matignon, *Automorphism groups for p-cyclic covers of the affine
line*, Compositio141(2005), Corollaries3.4–3.5 and Proposition6.6](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/B8E251C6126CAFE62BA6F414F82E1AA3/S0010437X05001296a.pdf/div-class-title-automorphism-groups-for-em-class-italic-p-em-cyclic-covers-of-the-affine-line-div.pdf#page=13)
give(1) and(2) for g(C_f)>=2. The additive polynomial Ad_f and its
translation roots are constructed in their Proposition5.5. Dividing
their bounds for |G_(infinity,1)(f)| by p gives the displayed translation
bounds, including the sharper characteristic-two case.

Only (p,m)=(3,2),(2,3) have positive genus below2. For the former, the
reduced X coefficient of f(X+a)−f(X) is 2f_2 a, forcing a=0. For the
latter, the reduced X coefficient vanishes exactly when

    f_3² a^4+f_3 a=0,

a separable polynomial of degree4. This proves the boundary cases.
Constants are Artin–Schreier differences over k.

## 2. From local inertia to the translation theorem

Realize P=I_1 by its HKG curve H, with H/P=P1 and one totally ramified
point; see [Bleher–Chinburg–Poonen–Symonds, §1.B and Proposition4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).
[Matignon–Rocher, *On smooth curves endowed with a large automorphism
p-group in characteristic p>0*, Lemma2.4(1)](https://www.math.u-bordeaux.fr/~mmatigno/JANT-Ma-Ro.pdf#page=4)
gives H/P_2=P1. That lemma needs only the one-point P-cover, and its
Hurwitz identity, for every subgroup N⊂P, is

    2|N|g(H/N)=sum_(i>=2)(|P_i|−|N intersect P_i|).        (3)

Thus H has a reduced equation W^p−W=f(X) of degree i0 prime to p.
The last group P_2 is central, since [P_1,P_(i0)]⊂P_(i0+1)=1.
Hence P/P_2 acts on the quotient line by translations and lies in
Z(Ad_f). Applying(2) with m=i0 gives either r<=s or i0=1+p^s with
s<r<=2s. Herbrand's formula gives the two stated upper jumps.

In the latter case g(H)=(p−1)p^s/2 and

    |P|/g(H)=2p^(r+1−s)/(p−1)>2p/(p−1).

Therefore [Matignon–Rocher, Proposition2.5](https://www.math.u-bordeaux.fr/~mmatigno/JANT-Ma-Ro.pdf#page=4)
supplies f(X)=X S(X)+cX, the extraspecial wild group and the full inverse
image description. Their Remark2.6 includes genus1 because P fixes the
point at infinity.
