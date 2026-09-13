#!/usr/bin/env sage
"""Exact Raynaud-quadric certificate, one core and under a second.
See Sol_backup_raynaud_quadric.md for the geometric completeness argument.
This verifies the quadric, not the emptiness of the singleton residual locus.
"""
import json,time
from cysignals.alarm import alarm,cancel_alarm
started=time.monotonic();alarm(45)
try:
    k=GF(5**12,name='z');z=k.gen();R=PolynomialRing(k,'u');u=R.gen()
    alpha=sorted((u**3+u+1).roots(multiplicities=False),key=str)[0]
    F=u*(u-1)*(u-2)*(u-3)*(u-alpha)
    H=matrix(k,2,2,[(F**2)[5*i-j] for i in [1,2] for j in [1,2]])
    assert H.det() != 0
    h00,h01,h10,h11=H.list();assert h10
    additive=u**25-(h11**5+h00*h10**4)*u**5+(h00*h11*h10**4-h01*h10**5)*u
    bs=additive.roots(multiplicities=False);assert len(bs)==25
    pts=[];records=[]
    for b in bs:
        a=(b**5-h11*b)/h10
        assert vector(k,[a**5,b**5])==H*vector(k,[a,b])
        if not a and not b:continue
        image=[]
        for j in range(9):
            A=u**j if j<6 else R.zero()
            B=u**(j-6) if j>=6 else R.zero()
            image.append((A.derivative()-(a+b*u)*B,
                          F*B.derivative()+F.derivative()*B/2-(a+b*u)*A))
        M=matrix(k,[[im[h][i] for im in image] for h in range(2) for i in range(8)],implementation='generic')
        ker=M.right_kernel();assert ker.dimension()==1
        v0=list(ker.basis()[0]);A=R(v0[:6]);B=R(v0[6:]);assert A.degree()==5 and A[5]
        B/=A[5];A/=A[5]
        assert A.derivative()==(a+b*u)*B
        assert F*B.derivative()+F.derivative()*B/2==(a+b*u)*A
        norm=A**2-F*B**2;assert norm.degree()==10 and norm.is_monic()
        assert all(not norm[i] for i in range(11) if i%5)
        U=R([norm[5*i]**(5**11) for i in range(3)])
        assert U**5==norm
        common=A.gcd(B);Ar=A//common;Br=B//common
        assert Br.gcd(U)==1
        V=(-Ar*Br.inverse_mod(U))%U
        assert (V**2-F)%U==0
        sigma=-U[1];pi=U[0]
        k4=V[1]**2-F[2]-F[3]*sigma-F[4]*sigma**2-F[5]*sigma*(sigma**2-pi)
        # Direct check of the conventional symmetric-polar formula.
        polar=2*F[0]+F[1]*sigma+2*F[2]*pi+F[3]*pi*sigma+2*F[4]*pi**2+F[5]*pi**2*sigma
        product=V[0]**2+V[0]*V[1]*sigma+V[1]**2*pi
        assert (sigma**2-4*pi)*k4==polar-2*product
        point=(k.one(),sigma,pi,k4)
        if point not in pts:pts.append(point)
        records.append((a,b,U,V))
    assert len(records)==24 and len(pts)==12
    mons=[(i,j) for i in range(4) for j in range(i,4)]
    matrixQ=matrix(k,[[pt[i]*pt[j] for i,j in mons] for pt in pts],implementation='generic')
    kernelQ=matrixQ.right_kernel()
    assert kernelQ.dimension()==1
    expected=[[1,0,0],[1,3,4],[4,1,3],[2,3,4],[4,0,3],
              [2,4,4],[3,1,0],[0,2,0],[2,4,3],[4,4,4]]
    for vectorQ in kernelQ.basis():
        scale=next(c for c in vectorQ if c);vectorQ=vectorQ/scale
        assert all(c**125==c for c in vectorQ)
        # Express using the fixed alpha, rather than the large field generator.
        low=matrix(GF(5),[vector(GF(5),k(x).polynomial().padded_list(12)) for x in [1,alpha,alpha**2]]).transpose()
        cc=[list(low.solve_right(vector(GF(5),k(x).polynomial().padded_list(12)))) for x in vectorQ]
        assert cc==expected
        assert matrixQ*vectorQ==0
        print(json.dumps({'result':'PASS','nonzero_torsion_classes':24,
              'kummer_points':12,'evaluation_rank':9,'monomials':mons,
              'quadric_coefficients_in_alpha':cc,
              'seconds':time.monotonic()-started},default=int),flush=True)
finally:cancel_alarm()
