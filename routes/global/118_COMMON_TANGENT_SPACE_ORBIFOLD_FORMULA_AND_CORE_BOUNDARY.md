# Common tangent spaces, tame orbifold quotients, and the core boundary

**Status: author proof, self-checked 2026-09-05; not independently audited.**

Let

\[
                   f:Z\longrightarrow X,
                   \qquad g:Z\longrightarrow Y
\]

be finite etale maps of smooth projective connected curves of genus at
least two over an algebraically closed field \(k\).  Write

\[
 V_C=H^1(C,T_C),\qquad
 U_f=f^*V_X\subset V_Z,\quad U_g=g^*V_Y\subset V_Z.
\]

Finite etale pullback is injective on these \(H^1(T)\)-spaces: after
passing to a Galois closure, this follows from the Cartan--Leray argument
used below.  Consequently, the intersection \(U_f\cap U_g\) is the
tangent space of the simultaneous
deformation functor in files 110 and 116.  It must not be replaced by an
intersection of function fields.  The results below give an exact answer
when both legs are Galois, an actual positive-dimensional example with
vanishing cross-Hom, and the precise limitation of the known coreless
families.

## 1. Exact formula for two Galois legs

### Proposition 118.1

Suppose \(f\) and \(g\) are Galois, with deck groups \(A\) and \(B\).
Set

\[
                         G_0=\langle A,B\rangle
                              \subset\operatorname{Aut}(Z).
\]

Then, in every characteristic,

\[
                  \boxed{U_f\cap U_g=H^1(Z,T_Z)^{G_0}.}
\tag{118.1}
\]

If moreover \(\operatorname{char}k\nmid |G_0|\), put
\(Q=Z/G_0\) and let \(R\) be the reduced branch divisor of \(Z\to Q\).
Then

\[
 U_f\cap U_g\simeq H^1\bigl(Q,T_Q(-R)\bigr).             \tag{118.2}
\]

When the pointed quotient is stable, i.e.
\(2g(Q)-2+\deg R>0\), this gives

\[
             \boxed{\dim(U_f\cap U_g)=3g(Q)-3+\deg R.}  \tag{118.3}
\]

#### Proof

For the etale \(A\)-torsor \(Z\to X\), the Cartan--Leray sequence and
\(H^0(Z,T_Z)=0\) identify

\[
                         H^1(X,T_X)\simeq H^1(Z,T_Z)^A.
\]

This does not require division by \(|A|\); the possible group-cohomology
terms in total degree one have coefficient \(H^0(Z,T_Z)=0\).  Under this
identification the map is the usual etale pullback.  The same argument for
\(B\) proves

\[
 U_f\cap U_g=H^1(T_Z)^A\cap H^1(T_Z)^B
             =H^1(T_Z)^{\langle A,B\rangle}.
\]

Now assume the \(G_0\)-action is tame.  Taking invariants is exact, so

\[
 H^1(Z,T_Z)^{G_0}=H^1\bigl(Q,(\pi_*T_Z)^{G_0}\bigr).
\]

At a branch point choose tame local coordinates \(x=z^e\).  An invariant
vector field upstairs is generated downstairs by
\(z\partial_z=e x\partial_x\), and hence vanishes once at the branch
point.  Away from \(R\) the quotient is etale.  Therefore

\[
                         (\pi_*T_Z)^{G_0}=T_Q(-R),
\]

which proves (118.2).  Stability gives
\(H^0(Q,T_Q(-R))=0\); Riemann--Roch then gives (118.3).  \(\square\)

This formula shows that the relevant object is the deformation space of
the **branched orbifold quotient**, not just the deformation space of an
unramified common quotient.

## 2. Hom-zero does not by itself annihilate the intersection

### Corollary 118.2

For every hyperelliptic curve \(Y\) of genus \(h\ge2\) in odd
characteristic with absolutely simple Jacobian, the actual bi-etale
correspondence of Theorem 110.2 satisfies

\[
             \operatorname{Hom}(J(X_{\rm aux}),J(Y))=0
\]

but

\[
       \boxed{\dim\bigl(U_f\cap U_g\bigr)=2h-1>0.}      \tag{118.4}
\]

#### Proof

In that construction the two free deck groups are the all-sign-change
subgroup \(A\simeq C_2\) and the even-sign subgroup
\(B\simeq C_2^2\).  They generate \(G_0=C_2^3\).  The quotient is
\(Q=\mathbf P^1\), branched at the \(2h+2\) hyperelliptic branch points.
The action is tame in odd characteristic.  Proposition 118.1 gives

\[
              \dim(U_f\cap U_g)=-3+(2h+2)=2h-1.
\]

The Hom-vanishing was proved in Theorem 110.2 from the character
decomposition of \(J(X_{\rm aux})\) and absolute simplicity of \(J(Y)\).
\(\square\)

Thus vanishing of homomorphisms between the target Jacobians does not force
infinitesimal rigidity.  In this example the surviving directions are the
motions of a rational core's branch points.

## 3. What Hom-zero says about a general core

### Proposition 118.3

Suppose the correspondence has a core \(Q\): there are finite generically
separable maps

\[
                  u:X\longrightarrow Q,\qquad
                  v:Y\longrightarrow Q,qquad uf=vg.
\]

If \(g(Q)>0\), then

\[
                         \operatorname{Hom}(JX,JY)\ne0. \tag{118.5}
\]

Consequently, under \(\operatorname{Hom}(JX,JY)=0\), every possible core
is rational.  This does not rule out a rational core.

#### Proof

The norm \(\operatorname{Nm}_u:JX\to JQ\) is surjective, while
\(v^*:JQ\to JY\) has finite kernel.  These facts follow from

\[
 \operatorname{Nm}_u u^*=[\deg u],\qquad
 \operatorname{Nm}_v v^*=[\deg v].
\]

Multiplication by a positive integer is a surjective isogeny even when the
integer is divisible by the characteristic.  Hence

\[
                     v^*\operatorname{Nm}_u:JX\to JY
\]

has positive-dimensional image when \(g(Q)>0\), proving (118.5).
\(\square\)

In particular, Hom-zero eliminates a positive-genus common etale quotient,
but Proposition 118.1 shows why it cannot eliminate deformations carried by
a branched rational quotient.

## 4. Coreless families and why adding levels does not impose Hom-zero

Krishnamoorthy's
[Correspondences without a Core](https://doi.org/10.2140/ant.2018.12.1173)
identifies the first-order deformation space of an etale correspondence
with the cohomology \(H^1(\mathscr T)\), which is exactly \(U_f\cap U_g\)
in the notation above.  Question 8.3 asks for a
bound on this space in characteristic \(p\).  Remark 8.4 carefully
distinguishes global isolation from possible infinitesimal deformation.
Example 3.19 supplies globally deforming coreless Hecke correspondences on
central leaves in characteristic \(p\), but its two targets are the same
central leaf and therefore have a manifest common Jacobian factor.

Adding distinct finite etale level covers cannot remove that factor as long
as the forgetful maps to the original leaf are retained.  More generally,
if \(u:X'\to C\) and \(v:Y'\to C\) are any finite covers of one
positive-genus curve \(C\), then

\[
                 v^*\operatorname{Nm}_u:JX'\longrightarrow JY'
\]

is nonzero by the proof of Proposition 118.3.  Thus any finite-level
modification of the central-leaf construction that still admits both
forgetful maps to the same leaf \(C\) can never yield
\(\operatorname{Hom}(JX',JY')=0\).

The presently justified boundary is therefore:

- no core alone does not give global rigidity in characteristic \(p\);
- Hom-zero alone does not force \(U_f\cap U_g=0\), by Corollary 118.2;
- Hom-zero rules out every positive-genus core, but not a rational one;
- the cited coreless families cannot be converted to Hom-zero examples by
  merely adding finite levels;
- no argument here proves or disproves
  \(U_f\cap U_g=0\) under the **combined** hypotheses of corelessness and
  \(\operatorname{Hom}(JX,JY)=0\).

Composing the Hom-zero construction of file 110 with a coreless Hecke
correspondence is a plausible source of examples, but it requires a separate
proof that the composite has no rational core and that its classifying map
has nonzero first derivative.  Neither property follows formally from
composition, so it is not asserted here.
