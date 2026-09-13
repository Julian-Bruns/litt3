#!/usr/bin/env sage
"""Replay compressed Cartier matrices against full original section equations.
Finite tests supplement, not replace, the parameterized proof.
"""
import time
from cysignals.alarm import alarm,cancel_alarm
started=time.monotonic();alarm(50)
try:
    tests=0
    for p in [3,5,7]:
        k=GF(p**3,name='a');a=k.gen();R=PolynomialRing(k,'u');u=R.gen()
        F=u*(u-1)*(u-a)*(u-a-1)*(u-a**2)
        assert F.gcd(F.derivative())==1
        Fh=F**((p-1)//2)
        H=matrix(k,[[Fh[p*i-j] for j in [1,2]] for i in [1,2]],implementation='generic')
        if not H.det():
            print('nonordinary test curve skipped',p,flush=True);continue
        pts=[]
        for b in k:
            if F(b) and F(b).is_square():
                pts.append((b,F(b).sqrt()))
                if len(pts)==3:break
        assert len(pts)==3
        divisors=[]
        for i,j in [(0,1),(0,2),(1,2),(0,0)]:
            b,c=pts[i];d,e=pts[j]
            if i==j:V=c+(u-b)*F.derivative()(b)/(2*c)
            else:V=c+(u-b)*(e-c)/(d-b)
            U=(u-b)*(u-d);assert (V**2-F)%U==0
            divisors.append((U,V))
        for m in [1,2,3,4]:
            ca=p*m+2;cb=p*m-1
            C=matrix(k,[[Fh[p*i+p-1-j] if 0<=p*i+p-1-j<=Fh.degree() else 0
                         for j in range(ca)] for i in range(m+2)],implementation='generic')
            cols=[0,1]+[(p+3)//2+p*i for i in range(m)]
            assert C.matrix_from_columns(cols).det()==H.det()
            AA=matrix(k,C.right_kernel().basis_matrix().rows(),implementation='generic')
            assert AA.nrows()==(p-1)*m and AA.rank()==AA.nrows() and not C*AA.transpose()
            bc=[j for j in range(cb) if j%p!=p-1]
            for U,V in divisors:
                # Work in source coordinates z before substituting z=u^p.
                U1=R([c**p for c in U.list()]);F1=R([c**p for c in F.list()])
                V1=R([c**p for c in V.list()]);mod=U1**m
                if m==1:
                    cols=[];original_v=[]
                    for j in range(p+1):
                        cs=u**j*Fh
                        pairs=[R([cs[r+p*l] for l in range(cs.degree()//p+1)])%U1 for r in range(p)]
                        cols.append([pairs[p-1][0],pairs[p-1][1]]+
                            [V1[1]*pairs[r][0]-V1[0]*pairs[r][1] for r in range(p-1)])
                        original_v.append((cs%(U**p)).padded_list(2*p))
                    v_sub=R({p*i:c for i,c in enumerate(V1.list())})
                    for j in range(p-1):original_v.append(((-v_sub*u**j)%(U**p)).padded_list(2*p))
                    E=matrix(k,cols,implementation='generic').transpose()
                    full_v=matrix(k,original_v,implementation='generic').transpose()
                    assert E.ncols()-E.rank()==full_v.ncols()-full_v.rank()
                Vm=V1
                for _ in range(m):Vm=(Vm+(F1-Vm**2)*(2*Vm).inverse_mod(mod))%mod
                assert (Vm**2-F1)%mod==0 and (Vm-V1)%U1==0
                inv=Vm.inverse_mod(mod)
                reduced=[]
                for row in AA:
                    cs=R(row.list())*Fh
                    col=[]
                    for r in range(p-1):
                        cr=R([cs[r+p*j] for j in range(cs.degree()//p+1)])
                        br=(cr*inv)%mod
                        col.extend(br[j] for j in range(m,2*m))
                    reduced.append(col)
                small=matrix(k,reduced,implementation='generic').transpose()
                lift=R({p*i:c for i,c in enumerate(Vm.list())})
                original=[]
                for j in range(ca):original.append(((u**j*Fh)%(U**(p*m))).padded_list(2*p*m))
                for j in range(cb):original.append(((-lift*u**j)%(U**(p*m))).padded_list(2*p*m))
                full=matrix(k,original,implementation='generic').transpose()
                top=C.augment(zero_matrix(k,m+2,cb))
                bindices=[ca+j for j in range(cb) if j%p==p-1]
                bot=matrix(k,len(bindices),ca+cb,lambda i,j:k(j==bindices[i]),implementation='generic')
                full=full.stack(top).stack(bot)
                assert full.ncols()-full.rank()==small.ncols()-small.rank()
                # Replay each compressed kernel against original equations,
                # including all sheet-cancellation coefficients.
                kb=small.right_kernel().basis_matrix()
                KK=matrix(k,kb.nrows(),kb.ncols(),kb.list(),implementation='generic')
                assert not small*KK.transpose()
                for kk in KK:
                    Ap=R((kk*AA).list());cs=Ap*Fh;Bp=R.zero()
                    for r in range(p-1):
                        cr=R([cs[r+p*j] for j in range(cs.degree()//p+1)])
                        br=(cr*inv)%mod
                        assert br.degree()<m
                        Bp+=sum(br[j]*u**(r+p*j) for j in range(m))
                    vec=vector(k,Ap.padded_list(ca)+Bp.padded_list(cb))
                    assert not full*vec
                tests+=1
        print('PASS p',p,'including repeated support; elapsed',time.monotonic()-started,flush=True)
    assert tests>=32
    print('ALL ORIGINAL-MATRIX CHECKS PASS',tests,'seconds',time.monotonic()-started,flush=True)
except AlarmInterrupt:
    raise RuntimeError('TIME CAP; incomplete diagnostic')
finally:cancel_alarm()
