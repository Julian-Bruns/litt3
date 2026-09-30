# Exact dormant theta divisors and their arithmetic separation

Version2, 19 September 2026. Exact certificates replayed and bounded
independent review passed for the equations, incidence and arithmetic
consequences. A further audited
[two-step double-cover theorem](backup_double_tower_dormant.md)
handles the first nonabelian family.

Let \(k_0=\mathbf F_{125}=\mathbf F_5[\alpha]/(\alpha^3+\alpha+1)\),
\[
Y:\ v^2=F(u)=u(u-1)(u-2)(u-3)(u-\alpha),\qquad C=Y^{(1)}.
\]
Use the five dormant potentials and their stable Bol-kernel bundles
\(\mathcal V_T\) of rank two and determinant \(\omega_C\), with the
[dormant quintic conventions](genus_two_dormant_quintic.md). Explicitly,
\[
W=T^2+3a_4T+3a_3,\quad
V=-a_2+(a_4+2T)W,\quad
\Psi=2a_0-2a_1T+a_2W-VW,\quad K=k_0[T]/(\Psi).
\]
Here \(F=\sum a_i u^i\), and relative Frobenius fixes K.

For \(\overline F=F^{(5)}=\sum c_i x^i\), put
\[
\mathcal F(x,y)=2c_0+c_1(x+y)+2c_2xy+c_3xy(x+y)
 +2c_4x^2y^2+c_5x^2y^2(x+y).
\]
The Kummer frame on \(J(C)\), for
\(L=\mathcal O_C(P_1+P_2-2O)\), is
\[
[\kappa_1:\kappa_2:\kappa_3:\kappa_4]
=[1:x_1+x_2:x_1x_2:
(\mathcal F(x_1,x_2)-2y_1y_2)/(x_1-x_2)^2].
\]
Write \([d_0+5d_1+25d_2]=d_0+d_1\alpha+d_2\alpha^2\).
The actual determinant theta divisor is
\[
\Theta_T:\ A_0\kappa_1+A_1\kappa_2+A_2\kappa_3+\kappa_4=0,
\]
where the following rows give the coefficients of \(1,T,T^2,T^3,T^4\):

| Coefficient | Field codes |
| --- | --- |
| \(A_0\) | \(55,82,104,115,87\) |
| \(A_1\) | \(67,74,82,45,60\) |
| \(A_2\) | \(19,60,68,13,18\) |

All five geometric conjugates \(\Theta_0,\ldots,\Theta_4\) are smooth
geometrically connected curves of genus five, with multiplicity one.
At EVERY geometric twist,
\[
h^0(C,\mathcal V_i\otimes L)=
\begin{cases}1&L\in\Theta_i,\\0&L\notin\Theta_i.\end{cases}
\tag{1}
\]
Every pair meets transversely in eight points, and no three meet.
The eighty distinct intersection points form four Frobenius orbits
of length twenty over \(k_0\). Thus a twist makes at most two of the
five dormant bundles have sections.
Every one of the eighty pair-intersection lines has five-primary
order exactly125. Consequently a line bundle trivialized by a
finite étale cover belongs to AT MOST ONE of the five theta
divisors.

It follows that a degree-zero finite-étale-trivial coefficient
bundle whose representation has only one-dimensional simple
constituents needs rank at least five to pass all five tests.
The bound is sharp: such a rank-five bundle exists with finite
cyclic monodromy. This applies in particular to abelian monodromy,
including nonsemisimple representations in characteristic five.
More strongly, one nested tower of connected cyclic étale covers
makes ALL FIVE dormant tangent dimensions arbitrarily large while
avoiding any prescribed finite set of primes. Such a tower can
also be pulled connectedly through any given actual second leg.
This follows from the
[simultaneous section theorem](../jacobians/ordinary_covers/prime_avoiding_section_growth.md).

The following consequences go beyond the returned equations.

1. If \(L\in J(C)(\mathbf F_{125^r})\) and \(5\nmid r\), all five
   spaces in (1) vanish.
2. All five spaces vanish for EVERY \(\{2,3\}\)-primary torsion line,
   with no bound on its order. More generally they vanish on
   \(J(C)[\ell^\infty]\) whenever \(\ell\ne5\) and the order of
   \(\operatorname{Frob}_{125}\) on \(J(C)[\ell]\) is prime to five;
   the same applies to mixed torsion supported on such primes.
3. Every connected finite abelian étale cover of Y with degree
   supported on 2,3,5 preserves zero tangent defect for each of its
   five pulled-back dormant connections. The same is true for an
   actual Galois cover whose group is an extension of such an abelian
   group by a five-group.

The last assertion is dormant tangent vanishing, not Jacobian
ordinariness. It does not assert the same for active connections,
arbitrary nonabelian covers, or the other candidate endpoint, and
does not itself exclude a common cover.

[Proof](../../Proofs/projective_connections/backup_dormant_theta_divisors.md).
