# The twelve degree-one Lagrangians on the backup curve

Version1,23September2026. Work over k=algebraic closure of F5, with
alpha^3+alpha+1=0 and Y: v^2=u(u-1)(u-2)(u-3)(u-alpha).
Put F:Y->C=Y^(1), B=F_*O_Y/O_C, eta=du/v and O the infinity point.
The parameter on C is alpha^5. All statements concern actual
embedded saturated Lagrangian planes, not just determinant classes.

Put x=u+1, S=alpha+1, s_e=epsilon(alpha^2-2), epsilon=+1 or -1,
P_e=(alpha^25,epsilon*alpha^5), R_e=F(P_e), and
\[
T_e=O_C(2R_e-2O_C).
\]
The two T_e are inverse, nontrivial order-five line bundles, with
F^*T_e trivial. Let W range over the six Weierstrass points
O,W0,W1,W2,W3,Walpha. There are exactly TWELVE geometric degree-one
Lagrangians Pi_(e,W) in B. Their primitive source, determinant and
canonical second line are respectively
\[
M=T_e(-W_C),\qquad \det\Pi=T_e(W_C),\qquad A=T_e^2.
\]
Their evaluation is surjective and their second fundamental divisor
is W. Thus their canonical line has adjunction divisor 2W.
All twelve embedded planes are defined over F125.

Their embeddings can be reconstructed without any choice of an
unrecorded Frobenius root. Set
\[
h_s=2x^5+Sx^4+2S+s v x^2,\qquad
q_{s,O}=2h_s^2(sx^2-v),\qquad q_{s,x}=h_s^2/(2s).
\]
For W=Wlambda finite put q_(s,W)=q_(s,x)-(lambda+1)q_(s,O).
For W=O use q_(s,O). Then
\[
\Pi_{e,W}=\operatorname{Sat}_B
\langle[q_{s,W}],[q_{s,W}^2/2]\rangle_{k(C)}.
\]
Here primitive classes lie in k(Y)/F^*k(C). In particular
\[
d\log h_s=s(u+1)\eta,\quad
\operatorname{div}h_s=10P_e-10O,\quad
dq_{s,O}=h_s^2\eta,\quad dq_{s,x}=x h_s^2\eta.
\]
The natural zero-norm scheme, including its Frobenius-root data,
has length16: the two points over Walpha have local algebra
F125[epsilon]/epsilon^3; the other ten points are reduced.
This statement includes infinity tangent directions and the six
jumping source lines O_C(-W_C); none of those six is a solution.

Consequently the endpoint Pi forced by the actual positive
rank-three double-zero orbit must be one of these twelve. Its base
point is Weierstrass, A is one of two nontrivial order-five classes,
and the associated logarithmic differential spans
k*(u+1)eta. These facts do NOT imply descent of that differential
through an X-map. No common cover is constructed or excluded.

[Proof](../../Proofs/cartier_and_spin/backup_lagrangian_degree_one_census.md).
