# A fixed smooth surface for all reduced spin-Cartier matches

Work over an algebraically closed field k of characteristic five.
Let A,B be smooth projective connected curves of genus at least two,
with nonzero exact regular forms alpha_i and div(alpha_i)=8D_i, where
each D_i is nonempty and reduced. There is a normal projective alpha_5
torsor S->A times B of degree5, depending only on these data. Its
singularities lie precisely over D_A times D_B and have completed equation

    z^5=t^9-s^9.

Its minimal resolution R has over each such point a central rational
curve of square-2 meeting nine disjoint rational curves of square-5.
The discrepancies are-27 centrally and-6 on each outer curve. If d_i=deg D_i,
then K_R²=478 d_A d_B and c2(R)=74 d_A d_B.

Every ACTUAL finite bi-etale span A<-W->B matching these forms has a
unique lift to S and an unramified lift i:W->R with normal line

    coker(T_W -> i*T_R) = O_W(-2D_W),
    D_W=f*D_A=g*D_B.

In particular the image need not be embedded or free of self-intersections.

Now fix reduced nonzero spin-Cartier data (X,L_X,h_X),(Y,L_Y,h_Y),
g(X),g(Y)>=2, as in [the definitions](../Definitions/Def_spin_cartier_roots.md).
For their seventh-root curves A,B and forms alpha_i, a fixed sequence
of four equivariant blowups on each outer exceptional branch, followed
by the diagonal order-seven quotient and resolution away from the
matching curves, produces a smooth projective surface T with morphisms
T->X,Y. EVERY compatible actual finite bi-etale span X<-Z->Y matching
h_X,h_Y has an unramified map j:Z->T factoring BOTH original maps and

    coker(T_Z -> j*T_T) = omega_Z^(-3).

T depends on the endpoint spin data, not on the unknown covering degree.
No coreless assumption, ordinarity, or Jacobian simplicity is needed.
No bound on degrees or exclusion of these unramified curves follows.
Here "unramified" does not mean a scheme-theoretic locally closed embedding.

Version1,2026-09-08. Author /root; independent medium audit PASS by
/root/audit_spin_matching_surface, with explicit algebraically closed
base and nonempty-branch hypotheses incorporated. The earlier root-cover
construction was a supplied audited input, not re-audited in this check.
[Reference-only audit](../Research/audits/SPIN_MATCHING_SURFACE_AUDIT_2026_09_08.md).
[Proof](../Solutions/Sol_spin_matching_surface.md).
