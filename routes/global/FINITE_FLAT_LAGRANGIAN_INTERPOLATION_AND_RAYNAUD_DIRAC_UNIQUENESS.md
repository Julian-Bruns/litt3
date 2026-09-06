# Finite-flat Lagrangian interpolation and Raynaud Dirac uniqueness

**Status (2026-09-05):** standalone author proof, obtained by checking and extending the core Fourier argument in the ordinary interpolation note. The ingredients below were checked in their cited primary sources. No claim of publication novelty or independent external refereeing is made. No ordinarity assumption occurs in either theorem.

## 1. Interpolation theorem

Let $k$ be algebraically closed of characteristic $p>0$, let $(A,L)$ be a principally polarized abelian variety of dimension $g\geq1$, and let
\[
K\subset A[p]
\]
be a finite subgroup scheme of length $p^g$ that is isotropic for the commutator pairing of $L^{\otimes p}$. Thus $K$ is a scheme-theoretic maximal isotropic subgroup; it need not be reduced, connected, or étale.

**Theorem 1.** For every line bundle $T\equiv L^{\otimes m}$, where $1\leq m<p$, and every $a\in A(k)$, restriction is injective:
\[
H^0(A,T)\longrightarrow H^0(a+K,T|_{a+K}). \tag{1}
\]
The target is the space of sections on the full finite scheme. Replacing it by evaluations at its geometric points is not justified.

### Polarized quotient

The quotient $v:A\to Y=A/K$ is a finite flat isogeny of degree $p^g$. Polarization descent gives a polarization represented by an ample line bundle $M$ on $Y$, with
\[
\widehat v\lambda_Mv=p\lambda_L.
\]
The degree formula gives $\deg\lambda_M=p^{2g}/p^{2g}=1$, so $M$ is principal and $v^*M\equiv L^{\otimes p}$. Descent here is descent of the polarization homomorphism; it does not assume a linearization of the initially chosen representative $L^{\otimes p}$.

On the dual varieties put
\[
N_A=(\lambda_L^{-1})^*L,\qquad N_Y=(\lambda_M^{-1})^*M.
\]
Their polarization homomorphisms are respectively $\lambda_L^{-1}$ and $\lambda_M^{-1}$. Composing the preceding identity and cancelling the surjective isogeny $v$ gives
\[
v\lambda_L^{-1}\widehat v=p\lambda_M^{-1},\qquad
\widehat v^*N_A\equiv N_Y^{\otimes p}. \tag{2}
\]
All these assertions concern group schemes and remain valid for inseparable isogenies.

### Fourier transform and a positive splitting

First take $T=L^{\otimes m}$. Write $E=v_*T$. Finite flatness makes $E$ a vector bundle. For every $\alpha\in\operatorname{Pic}^0(Y)$,
\[
H^i(Y,E\otimes\alpha)=H^i(A,T\otimes v^*\alpha)=0\quad(i>0),
\]
by the index theorem for ample line bundles on abelian varieties. Consequently $E$ is IT$_0$, and its normalized Poincaré transform $F=\Phi_Y(E)$ is locally free of rank $m^g$. Set
\[
Q=F^\vee,\qquad Q_m=\Phi_A(T)^\vee,\qquad
W=H^0(A,T)^\vee.
\]
Compatibility of Fourier transform with isogenies gives
\[
Q\simeq\widehat v^*Q_m.
\]
The line-bundle transform formula gives
\[
\phi_T^*Q_m\simeq W\otimes T.
\]
Since $\phi_T=[m]\lambda_L$, transporting through the principal polarization and pulling back by $\widehat v$ yields
\[
[m]_{\widehat Y}^*Q\simeq W\otimes\widehat v^*N_A^{\otimes m}. \tag{3}
\]
Rigidification factors are constant one-dimensional vector spaces and can be absorbed into $W$.

Let $G=Q\otimes N_Y^{-1}$. Formula (3) identifies $[m]^*G$ with $W\otimes R$, where
\[
R=\widehat v^*N_A^{\otimes m}\otimes[m]^*N_Y^{-1}
\equiv N_Y^{\otimes m(p-m)}. \tag{4}
\]
This line bundle is ample. Thus $[m]^*(G\otimes\beta)$ has no higher cohomology for every $\beta\in\operatorname{Pic}^0(\widehat Y)$.

The degree $m^{2g}$ of $[m]$ is invertible in $k$. Its trace, divided by that degree, splits the unit $\mathcal O\to[m]_*\mathcal O$. By projection formula, $G\otimes\beta$ is a direct summand of $[m]_*[m]^*(G\otimes\beta)$. Hence $G$ is IT$_0$. Both $G$ and $N_Y$ are therefore M-regular, so the M-regularity global-generation theorem implies that
\[
Q=G\otimes N_Y\quad\text{is globally generated}. \tag{5}
\]
In particular, no trace splitting along $v$ or $\widehat v$ is used.

### Why Fourier global generation implies injective evaluation

We give the evaluation argument to fix its direction and its scheme-theoretic meaning. For an IT$_0$ vector bundle $E_0$ on a $g$-dimensional abelian variety $Z$, put $F_0=\Phi_Z(E_0)$ and $Q_0=F_0^\vee$. Evaluation of $E_0$ at zero is the composition pairing
\[
\operatorname{Hom}(\mathcal O_Z,E_0)\otimes
\operatorname{Hom}(E_0,k(0))\longrightarrow
\operatorname{Hom}(\mathcal O_Z,k(0)).
\]
Under Fourier equivalence, $\mathcal O_Z$ transforms to $k(0)[-g]$, up to a constant line, and $k(0)$ transforms to $\mathcal O_{\widehat Z}$. The pairing becomes
\[
\operatorname{Ext}^g(k(0),F_0)\otimes
\operatorname{Hom}(F_0,\mathcal O_{\widehat Z})
\longrightarrow\operatorname{Ext}^g(k(0),\mathcal O_{\widehat Z}).
\]
Let $D=\operatorname{Ext}^g(k(0),\mathcal O_{\widehat Z})$, a one-dimensional vector space. Since $F_0$ is locally free, a local Koszul resolution identifies the last pairing with
\[
((F_0)_0\otimes D)\otimes H^0(\widehat Z,Q_0)
\longrightarrow D,\qquad (u\otimes d,s)\longmapsto s(0)(u)d.
\]
Thus the original evaluation has the rank of the transpose of evaluation for $Q_0$. Global generation of $Q_0$ makes that transpose injective, and hence makes evaluation for $E_0$ injective.

Apply this to $E=v_*T$ using (5). Finite base change identifies evaluation with
\[
H^0(Y,E)=H^0(A,T)\longrightarrow
E\otimes k(0)=H^0(v^{-1}(0),T|_{v^{-1}(0)})=H^0(K,T|_K).
\]
The fiber is precisely the full kernel scheme, including its nilpotents. This proves (1) for $T=L^{\otimes m}$ and $a=0$.

### Numerical twists and cosets

Numerical triviality equals algebraic triviality for line bundles on an abelian variety. Write $T=L^{\otimes m}\otimes\alpha$. Since multiplication by $m$ on $\operatorname{Pic}^0(A)$ is surjective on $k$-points, choose $\beta^{\otimes m}=\alpha$. Replace $L$ by $L\otimes\beta$; this preserves its principal polarization homomorphism and the isotropic condition on $K$. The proved case applies to $T$. Finally apply it to $t_a^*T$; translation identifies its restriction to $K$ with that of $T$ to $a+K$. This proves Theorem 1.

## 2. The intrinsic Dirac line

Write $K=\coprod_{x\in K(k)}K_x$ as the disjoint union of its local components, and let $R_0=\mathcal O(K_0)$, with maximal ideal $\mathfrak m_0$. The local components are zero-dimensional complete intersections: $K$ is a fiber of an isogeny between smooth $g$-dimensional varieties, and the pullbacks of regular parameters on the target form a regular sequence. Consequently $R_0$ is Gorenstein and its socle has dimension one.

For an invertible sheaf $T|_K$, define the intrinsic one-dimensional subspace
\[
\Delta_0(T|_K)=\{u\in H^0(K,T|_K):
u|_{K_x}=0\ (x\ne0),\quad\mathfrak m_0u|_{K_0}=0\}.
\]
This definition is independent of a trivialization. Multiplication by a unit preserves the socle, acting on it by its residue scalar.

**Corollary 2.** Under Theorem 1,
\[
\dim\{s\in H^0(A,T):s|_K\in\Delta_0(T|_K)\}\leq1. \tag{6}
\]
If a nonzero section satisfying this condition exists, it spans this space and its restriction is a nonzero Dirac element. This follows immediately from injectivity into a one-dimensional space.

There is also a purely closed-subscheme formulation. Regard the untwisted Dirac line as an ideal $I_\Delta\subset\mathcal O_K$, and put $Z_\Delta=V(I_\Delta)\subset K$. It has length $p^g-1$; it consists of all nonidentity local components and the identity component with its socle removed. Condition (6) is exactly scheme-theoretic vanishing on $Z_\Delta$.

## 3. Verschiebung is a polarized quotient of the required type

Let $(P,L_P)$ be any ppav over $k$, put $A=P^{(p)}$, and equip $A$ with the Frobenius twist $L_A=L_P^{(p)}$. Let
\[
F:P\to A,\qquad V:A\to P
\]
be relative Frobenius and Verschiebung. These are finite flat isogenies of degree $p^g$, with $VF=[p]_P$ and $FV=[p]_A$. Relative Frobenius satisfies $F^*L_A\simeq L_P^{\otimes p}$. Therefore
\[
F^*V^*L_P=[p]^*L_P\equiv L_P^{\otimes p^2}
\equiv F^*(L_A^{\otimes p}).
\]
Pullback by an isogeny is injective on numerical divisor classes (the pushforward of a pullback multiplies the class by its degree), so
\[
V^*L_P\equiv L_A^{\otimes p}. \tag{7}
\]
Thus $V$ pulls the principal polarization on $P$ back to $p\lambda_{L_A}$. The necessary direction of polarization descent implies that $\ker V$ is isotropic for the pairing of $L_A^{\otimes p}$. It has length $p^g$ and is contained in $A[p]$. It satisfies every hypothesis of Theorem 1.

For a smooth proper connected curve $X/k$, the canonical principal polarization on $J_1=\operatorname{Pic}^0(X^{(p)})$ is the Frobenius twist of that on $J=\operatorname{Pic}^0(X)$. The map induced by pullback along relative Frobenius of the curve is $V:J_1\to J$. Hence the preceding argument applies to the precise kernel used in Raynaud's construction.

## 4. Uniqueness of the Raynaud determinant section for every smooth curve

Let $X/k$ be smooth, proper and connected of genus $g\geq1$. Define $B$ on $X^{(p)}$ by
\[
0\longrightarrow\mathcal O_{X^{(p)}}\longrightarrow F_*\mathcal O_X
\longrightarrow B\longrightarrow0.
\]
Let $s_B\in H^0(J_1,\mathscr L_B)$ be its determinant theta section, in its fixed determinant line bundle, and let $K=\ker(V:J_1\to J)$.

The established Raynaud theta properties used here are: $\mathscr L_B\equiv(p-1)\Theta_{\rm class}$, and $s_B|_K$ is a nonzero element of $\Delta_0(\mathscr L_B|_K)$. The latter is precisely Tong's Dirac theorem, interpreted in local trivializations; see Definition 1.2.7.1, Definition 1.2.7.4, and Theorem 1.2.7.7. No ordinarity hypothesis is imposed there. [Tong, *Diviseur thêta et formes différentielles*, introduction and §1.2.7](https://arxiv.org/pdf/0712.2046).

**Theorem 3.** For every such curve,
\[
\{s\in H^0(J_1,\mathscr L_B):
s|_K\in\Delta_0(\mathscr L_B|_K)\}=k\,s_B. \tag{8}
\]
Equivalently, the Raynaud divisor is the unique member of the fixed complete linear system $|\mathscr L_B|$ containing the length-$p^g-1$ subscheme $Z_\Delta\subset K$.

**Proof.** Section 3 verifies the maximal isotropic kernel hypothesis. Apply Theorem 1 and Corollary 2 with $m=p-1$, accommodating the numerical Picard twist as in the proof. They bound the left side of (8) by one dimension. The known section $s_B$, whose Dirac restriction is nonzero, supplies existence and spans it. The subscheme formulation follows from the definition of $Z_\Delta$.

For an ordinary curve $K$ is reduced and $Z_\Delta=K\setminus\{0\}$. For a nonordinary curve the socle condition at the identity is essential. The theorem does not characterize $s_B$ merely by geometric-point vanishing, nor merely by vanishing on all nonidentity local components. For example, when $K$ is connected the latter condition is empty. Also, a nonzero socle restriction can have zero value at the geometric origin; no assertion $s_B(0)\ne0$ is made in the nonordinary case.

## 5. Sources and audit boundaries

- Polarization descent, including nonreduced group schemes: Moonen, *Abelian varieties*, Chapter XI, Proposition 11.25; degree formula in Proposition 11.8. [Chapter XI](https://www.math.ru.nl/~bmoonen/BookAV/PolWp.pdf).
- Fourier equivalence, transforms of the structure and skyscraper sheaves, isogeny compatibility and the line-bundle formula: Mukai, *Duality between D(X) and D(X-hat) with its application to Picard sheaves*, Theorem 2.2, Example 2.6, formula (3.4), Proposition 3.11(1). The base field is arbitrary algebraically closed. [Primary source](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BDBEBAC584BE15236C2D62C383A34245/S002776300001922Xa.pdf/duality-between-d-x-and-with-its-application-to-picard-sheaves.pdf).
- Global generation of the tensor product of an M-regular sheaf and an M-regular line bundle: Pareschi–Popa, *Regularity on abelian varieties I*, Theorem 2.4. The theorem is over an arbitrary algebraically closed field; characteristic-zero applications later in the paper do not limit it. [Primary source](https://people.math.harvard.edu/~mpopa/papers/abv1.pdf).

The proof never decomposes $v^*v_*T$ as a direct sum indexed by geometric kernel points, and does not use simplicity of $v_*T$. Those ordinary-only shortcuts are unnecessary. Positivity in (4) and the invertible-degree trace both use $1\leq m<p$; this proof asserts nothing at $m=p$. Existence of Dirac sections on arbitrary ppav's is not supplied by the interpolation theorem. The curve application obtains existence from the established Raynaud construction.
