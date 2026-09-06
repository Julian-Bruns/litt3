# Proof record: Linear-in-weight bounds via etale roots

Canonical statement: [`etale_root_contact_bound`](../Theorems/Thm_etale_root_contact_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Etale roots extend the contact bound to higher canonical weights

Author: /root, 2026-09-06. The linear-in-weight improvement in Section 4
is due to /root/contact_root_extension_audit. Status: independently
audited PASS by that agent, including the final version, 2026-09-06.
[Audit record](../routes/global/audits/ETALE_ROOT_REDUCTION_OF_THE_CONTACT_BOUND_AUDIT_2026_09_06.md).
This is a degree bound under a specified shared-tensor hypothesis, NOT
a bound on every common cover. Both original maps remain in the argument.

## Theorem

Let k be algebraically closed of characteristic five. Suppose
X <-f- Z -g-> Y is a jointly minimal span of finite etale maps of smooth
connected projective curves of genus at least two. Write

    a=deg f, b=deg g, sX=g(X)-1, sY=g(Y)-1.

Suppose nonzero regular tensors s_X,s_Y of weight d, with 5 not dividing d,
have equal actual differential pullbacks and

    div(s_X)=d D_X, div(s_Y)=d D_Y,

where D_X,D_Y are reduced. Then

    b <= 20 d sX,         a <= 20 d sY.                  (1)

More precisely, let hX,hY be the orders of omega_X(-D_X) and
omega_Y(-D_Y). These divide d, and

    b <= 20 lcm(hX,hY) sX, a <= 20 lcm(hX,hY) sY.       (2)

No hypothesis about Hom(JX,JY) or about corelessness is needed. The
parameter d in (1) is essential to the current statement: it has not
been bounded in the general Cartier-zero branch.

## 1. The contact inequality does not require Jacobian orthogonality

The [contact theorem](Sol_contact_degree_bound.md)
now includes the audited removal of Hom(JX,JY)=0. Its proof uses Hodge
index to obtain delta(C)<=ab+t, where t=a sX=b sY, instead of requiring
equality. In particular, for any jointly minimal span with a shared
one-form having only simple zeros,

    deg(Z/Y)<=20(g(X)-1), deg(Z/X)<=20(g(Y)-1).          (4)

The individual branches are still smooth graphs because BOTH maps are
etale. Nothing about the local proof or its double counting is changed.

## 2. A simultaneous etale root construction

Set L_X=omega_X(-D_X). The tensor s_X trivializes L_X^d, and defines its
finite etale mu_d root torsor T_X->X. There is a tautological root
alpha_X in the pullback of L_X; its image in omega_(T_X) is a regular
one-form whose zero divisor is exactly the inverse image of D_X.
The same construction gives T_Y,alpha_Y.

On Z, the reduced divisors f^*D_X and g^*D_Y agree: their multiples by
d are the same zero divisor, and the maps are etale. The canonical
identifications f^*omega_X=omega_Z=g^*omega_Y consequently identify
f^*L_X and g^*L_Y AND their d-th-power trivializations. Thus the entire
root torsors are canonically identified:

    T_Z=Z x_X T_X = Z x_Y T_Y.                         (5)

Choose a connected component W of T_Z. Its images lie in connected
components X' of T_X and Y' of T_Y. All these curves are smooth and
projective. The maps W->X',W->Y' are finite etale and surjective, being
restrictions of finite etale base changes to connected components.
Write hX=deg(X'/X),hY=deg(Y'/Y),c=deg(W/Z). Each divides d: the components
of a mu_d torsor are permuted transitively by mu_d, and a component is
a torsor under its stabilizer. In fact c divides each of hX,hY. The
connected component degrees hX,hY equal the orders of L_X,L_Y: a root
torsor over an algebraically closed constant field has monodromy of
exactly the order of its torsion line bundle.

The tautological one-forms on X',Y' have simple zeros and pull back to
the SAME form on W by (5). It is important to take components of this
single common torsor, rather than choosing unrelated covers of X and Y.

## 3. Joint minimality survives this construction

Let K=k(Z)=k(X)k(Y). A rational frame eta_X of omega_X writes
s_X=A_X eta_X^d. Inside k(W), let xi_X be the corresponding root;
then k(W)=K(xi_X), xi_X^d=A_X, and k(X')=k(X)(xi_X).
For a frame eta_Y, the tautological identity reads

    xi_X f^*eta_X = xi_Y g^*eta_Y.

Their frame ratio belongs to K, so xi_Y is a K-multiple of xi_X.
Consequently

    k(X')k(Y')=K(xi_X)=k(W).                            (6)

This proof allows every torsor in (5) to be disconnected; no unproved
irreducibility of a binomial is being used.

## 4. Keep all compatible components to obtain a linear bound

Applying (4) to just W would give a weaker quadratic-in-d bound. Instead
put h=gcd(hX,hY) and keep every component of T_Z whose image lies in the
chosen pair X',Y'. The diagonal mu_d action stabilizes X' through mu_hX
and Y' through mu_hY. Their common stabilizer is mu_h, whereas W has
stabilizer mu_c. Therefore the components in this pair form one orbit
of size h/c. Their total degree over Z is h.

The joint images of these components are DISTINCT. Indeed, over the
generic point the original endpoint coordinates recover k(Z) by joint
minimality, and either root coordinate recovers the point of T_Z.
Thus the joint map of the whole torsor is generically injective onto
its reduced image, not merely birational component by component.

Let C* be the reduced union of these images in X' times Y'. Its
normalization has h/c components W_i, and set

    A=deg(C*/X')=a h/hX,  B=deg(C*/Y')=b h/hY,
    T=sum_i(g(W_i)-1)=h t.

In particular A(g(X')-1)=B(g(Y')-1)=T. The contact proof also holds
for this reducible image: every normalized component is etale over
both endpoints and preserves the SAME simple-zero one-form. Hodge
index still gives C*^2<=2AB. The normalization genus formula is

    delta(C*)=p_a(C*)-sum_i g(W_i)+(h/c)-1=C*^2/2+T.

Consequently delta(C*)<=AB+T, exactly the upper bound required by the
same local contact count. The common inverse-image zero set has size 2T, and the
counts, including intersections between distinct components, are
unchanged. This proves B<=20(g(X')-1)=20hX sX and symmetrically for A.
Substitution yields

    b <= 20(hX hY/h)sX = 20 lcm(hX,hY)sX.

Since lcm(hX,hY) divides d, this proves (1)--(2). QED.

If the original span is coreless and d is its primitive shared weight,
then d=lcm(hX,hY). To see this, the torsion orders give tensors of
weights hX and hY with divisors hX D_X and hY D_Y. Raise them to weight
lcm(hX,hY); their pullbacks have the same divisor, so differ by a
constant and can be made equal. Primitivity and lcm(hX,hY)|d force
equality. This identifies the parameter, but does not bound it.

## Role in the current proof

This bound is a necessary intermediate lemma in the stronger audited
[simple-root tensors force a core theorem](Sol_shared_tensor_core.md).
Combined with unbounded joint-image growth, it excludes every coreless
span with uniform e=d, in all weights and all degrees. The former
degree-specific conclusions are superseded by that theorem.

Weight-two simple zeros and weight-four double zeros have e/d=1/2,
not 1; this root reduction does not bound them. It also does not settle
the absence of shared tensors.
