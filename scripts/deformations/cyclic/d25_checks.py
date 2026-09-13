#!/usr/bin/env python3
"""Exact local/algebraic checks for the uniform cyclic-25 comparison.

Run with Python 3 and SymPy. No geometric cover is simulated here: these
checks verify the symbolic oper variation, the Taylor precision bounds,
the n=3 normal graph equation, the regular cyclic-torsor product bound,
and the integral cyclic-relation divisions used in the proof.
"""
from math import comb, factorial
import sympy as S


def vp(n, p=5):
    assert n != 0
    a = 0
    while n % p == 0:
        n //= p
        a += 1
    return a


def coeff_trunc(expr, t, degree):
    expr = S.expand(expr)
    return sum(expr.coeff(t, i) * t**i for i in range(degree))


def oper_check():
    u, t = S.symbols('u t')
    r, a, b, c, s = [S.Function(name)(u) for name in ('r','a','b','c','s')]
    A = S.Matrix([[0, r], [1, 0]])
    At = A + t*S.Matrix([[a,b],[c,-a]])
    tr = lambda M: M.applyfunc(lambda z: coeff_trunc(z,t,2))
    nab = lambda v: tr(v.diff(u)+At*v)
    ell = S.Matrix([1-t*(c+S.diff(s,u))/2, t*s])
    m = nab(ell)
    dr = b+S.diff(a,u)+r*c-S.diff(c,u,2)/2 \
         +S.diff(r,u)*s+2*r*S.diff(s,u)-S.diff(s,u,3)/2
    assert tr(nab(m)-(r+t*dr)*ell) == S.zeros(2,1)
    assert coeff_trunc(S.det(S.Matrix.hstack(ell,m)),t,2) == 1
    # Independent Schwarzian derivation of the Hodge-only part.
    fp=1+t*S.diff(s,u); fpp=t*S.diff(s,u,2); fppp=t*S.diff(s,u,3)
    invfp=1-t*S.diff(s,u)
    schwarz=coeff_trunc(fppp*invfp-S.Rational(3,2)*(fpp*invfp)**2,t,2)
    transformed=coeff_trunc(fp**2*(r+t*s*S.diff(r,u))-schwarz/2,t,2)
    assert S.simplify(transformed.coeff(t,1)-(dr-b-S.diff(a,u)-r*c+S.diff(c,u,2)/2)) == 0
    print('PASS: general oper variation and independent Schwarzian variation')


def taylor_check():
    u,p,z,t=S.symbols('u p z t')
    r=S.Function('r')(u); q=S.Function('q')(u)
    A=S.Matrix([[0,r],[1,0]]); B=S.Matrix([[0,p*p*r],[1,0]])
    K=S.eye(2); Q=S.eye(2); Ks=[K]
    for j in range(1,9):
        K=(p*K.diff(u)+B*K).applyfunc(S.expand)
        Q=(Q.diff(u)+A*Q).applyfunc(S.expand)
        # Independent conjugation/scaling derivation of every entry.
        via=S.Matrix([[p**j*Q[0,0],p**(j+1)*Q[0,1]],
                      [p**(j-1)*Q[1,0],p**j*Q[1,1]]])
        assert (K-via).applyfunc(S.expand)==S.zeros(2)
        Ks.append(K)
    assert S.expand(Ks[5][1,0]-p**4*(r*r+3*S.diff(r,u,2)))==0
    # Exact first scalar response, modulo p^3; the general valuation
    # proof in the text excludes all j >= 4 from this coefficient.
    T=sum((Ks[j]*z**j/S.factorial(j) for j in range(4)), S.zeros(2))
    varied=T.subs(r,r+t*q).doit()
    dT=varied.applyfunc(lambda a:S.expand(a).coeff(t,1))
    dT=dT.applyfunc(lambda a:coeff_trunc(a,p,3))
    expected=p*p*q*S.Matrix([[z*z/2,z],[z**3/6,z*z/2]])
    assert (dT-expected).applyfunc(S.simplify)==S.zeros(2)
    # Factorials are counted after the binomial numerator is included.
    for j in range(2,251):
        for l in range(2,j+1):
            assert j-1-vp(factorial(l))-vp(factorial(j-l)) >= 1
    for j in range(4,251):
        assert j-1-vp(factorial(j-1)) >= 3
    print('PASS: companion recurrence, scalar response, K5, Taylor denominators')


def graph_check():
    p=S.symbols('p')
    a,b,d=S.symbols('a b d')
    aa=S.symbols('a0:3'); bb=S.symbols('b0:3')
    cc=S.symbols('c0:3'); dd=S.symbols('d0:3')
    si=S.symbols('si0:3'); sj=S.symbols('sj0:3')
    G=S.Matrix([[a,b],[0,d]])
    for k in range(3):
        G += p**(2+k)*S.Matrix([[aa[k],bb[k]],[cc[k],dd[k]]])
    Si=sum(p**(2+k)*si[k] for k in range(3))
    Sj=sum(p**(2+k)*sj[k] for k in range(3))
    obstruction=G[1,0]+G[1,1]*Sj-Si*(G[0,0]+G[0,1]*Sj)
    expected=sum(p**(2+k)*(cc[k]+d*sj[k]-a*si[k]) for k in range(3)) \
             +p**4*(dd[0]*sj[0]-aa[0]*si[0]-b*si[0]*sj[0])
    assert S.expand(coeff_trunc(obstruction,p,5)-expected)==0
    print('PASS: n=3 graph equation; no first-times-second terms modulo 5^5')


def mod5_rank(vectors):
    if not vectors:
        return 0
    mat=[[x%5 for x in row] for row in zip(*vectors)]
    rows,cols=len(mat),len(mat[0]); rank=0
    for j in range(cols):
        pivot=next((i for i in range(rank,rows) if mat[i][j]),None)
        if pivot is None: continue
        mat[rank],mat[pivot]=mat[pivot],mat[rank]
        inv=pow(mat[rank][j],-1,5)
        mat[rank]=[(inv*x)%5 for x in mat[rank]]
        for i in range(rows):
            if i!=rank:
                c=mat[i][j]
                mat[i]=[(x-c*y)%5 for x,y in zip(mat[i],mat[rank])]
        rank+=1
        if rank==rows: break
    return rank


def torsor_product_check():
    # A = functions on Z/25 with pointwise multiplication, not the
    # group algebra with its convolution multiplication.
    def e(v): return [(v[(i+1)%25]-v[i])%5 for i in range(25)]
    def columns(j):
        out=[]
        for k in range(25):
            v=[int(i==k) for i in range(25)]
            for _ in range(j): v=e(v)
            out.append(v)
        return out
    E22=columns(22); E20=columns(20)
    products=[[a*b%5 for a,b in zip(v,w)] for v in E22 for w in E22]
    assert mod5_rank(E22)==3
    assert mod5_rank(E20)==5
    assert mod5_rank(E20+products)==5
    print('PASS: (e^22 A)(e^22 A) subset e^20 A, in the torsor function algebra')


def cyclic_division_check():
    # Work with exact integer polynomials reduced by (1+e)^25-1.
    relation=[comb(25,k) for k in range(25)]
    relation[0]=0
    def reduce_poly(coeffs, mod=125):
        a=list(coeffs)+[0]*max(0,25-len(coeffs))
        for j in range(len(a)-1,24,-1):
            c=a[j]
            for k in range(25): a[j-25+k]-=c*relation[k]
        return [x%mod for x in a[:25]]
    def mon(k,c=1):
        a=[0]*(k+1);a[k]=c;return a
    def add(*polys):
        a=[0]*max(map(len,polys))
        for poly in polys:
            for i,c in enumerate(poly):a[i]+=c
        return a
    def shift(poly,k):return [0]*k+poly
    N=[comb(25,j+1) for j in range(25)]
    for first, eta, expected in [(22,1,(4,3)),(23,0,(0,4)),(24,0,(0,0))]:
        # c e22, d e23, b e24 respectively. Coefficients in F5 are
        # fixed by Frobenius; a general coefficient is transported
        # once by Witt Frobenius before reading this residue.
        first_repair=add(mon(first-20),mon(first-15,2),mon(first-10,2),mon(first-5))
        X=add(mon(first),[5*v for v in first_repair])
        rem=reduce_poly(add(shift(X,2),[-eta*v for v in N]))
        assert all(v%25==0 for v in rem)
        residue=[(v//25)%5 for v in rem]
        assert tuple(residue[:2])==expected
    # Explicitly verify the higher norm error is already an image.
    y=add(mon(22,5),mon(2,25),mon(7,50),mon(12,50),mon(17,25))
    assert reduce_poly(add(shift(y,2),[-5*v for v in N]))==[0]*25
    # A genuinely non-F5 coefficient: W_3(F25) = (Z/125)[a]/(a^2-2).
    # Its Witt Frobenius is sigma(a)=-a, not the literal fifth power
    # in characteristic 125. Thus sigma(a) mod 5 = a^5 = -a,
    # whereas sigma^2(a) = a. Apply sigma exactly once to all
    # coefficients of the repaired e23 input.
    repair=add(mon(3),mon(8,2),mon(13,2),mon(18))
    kernel=add(mon(23),[5*v for v in repair])
    # The following integer vector is the a-coordinate after sigma.
    rem_a=reduce_poly([-v for v in shift(kernel,2)])
    assert all(v%25==0 for v in rem_a)
    normal_a=[-(v//25)%5 for v in rem_a]
    assert normal_a[:2]==[0,4]  # normal obstruction is -a e.
    assert normal_a[1]!=1       # not sigma^2(a) e = a e.
    print('PASS: exact /25 residues and e^2 y = 5 N modulo 125')
    print('PASS: F25 coefficient transport gives d^5 e, not d^25 e')


def main():
    oper_check();taylor_check();graph_check()
    torsor_product_check();cyclic_division_check()
    print('All exact checks passed.')

if __name__=='__main__':
    main()
