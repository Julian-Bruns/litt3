"""Eliminate the two kernel coordinates exactly using the infinity series."""
import json,time
from pathlib import Path
from ff import *
from reconstruct import P,Q,t,epsilon,eta,Ca,Cd
from sparse import Sparse as S,series_mul,series_add,series_pow
ROOT=Path(__file__).resolve().parents[1]
N=7
h,w,k0,k1=[S.var(i) for i in range(4)]
z=mul(2,inv(epsilon))*w
c=Ca*h+Cd*w
e=-c*z-mul(eta,inv(24))*z**-1
f=neg(inv(epsilon))*w**2-mul(div(8,24),power(div(2,epsilon),5))*w**5
weights=[S(1),h,w,e,f,k0,k1]

def ya_series():
    # Y^3 = xi^30 P(xi^-3), Y(0)=1; only coefficients through xi^6 needed.
    yy=[0]*N;yy[0]=1
    rhs=[0]*N
    for i in range(len(P)):
        j=30-3*i
        if 0<=j<N:rhs[j]=P[i]
    for n in range(1,N):
        trial=Poly(yy).pow_trunc(3,N)
        yy[n]=div(sub(rhs[n],trial[n]),3)
    return [Poly(yy).pow_trunc(j,N) for j in range(3)]
YP=ya_series()

def expand(G,d):
    out=[S() for _ in range(N)]
    for j,row in enumerate(G):
        for i,a in enumerate(row):
            for k in range(N):
                m=d-3*i-10*j+k
                if 0<=m<N and YP[j][k]:out[m]=out[m]+YP[j][k]*a
    return out

def graph_source():
    data=json.loads((ROOT/'data'/'source_affine6.json').read_text())
    out=[]
    for gi in range(4):
        obj=[]
        for j in range(3):
            n=max(len(b['G'][gi][j]) for b in data['basis'])
            row=[]
            for i in range(n):
                a=S()
                for wt,b in zip(weights,data['basis']):
                    rr=b['G'][gi][j]
                    if i<len(rr):a=a+rr[i]*wt
                row.append(a)
            obj.append(row)
        out.append(obj)
    return data,out

def series_F(G):
    aa=[3*x for x in expand(G[0],35)]
    bb=[2*x for x in expand(G[1],46)]
    cc=expand(G[2],57)
    assert aa[0]==0 and bb[0]==mul(2,epsilon)
    rho=[z]+[S() for _ in range(N-1)]
    for i in range(1,N):
        res=series_add(series_add(series_mul(aa,series_pow(rho,2,N),N),series_mul(bb,rho,N),N),cc,N)
        rho[i]=neg(inv(mul(2,epsilon)))*res[i]
    assert all(not a for a in series_add(series_add(series_mul(aa,series_pow(rho,2,N),N),series_mul(bb,rho,N),N),cc,N))
    rr5=series_pow(rho,5,N)
    fac1=[S() for _ in range(N)]
    for i in range(len(Q)):
        j=57-3*i
        if 0<=j<N:fac1[j]=fac1[j]+Q[i]
    fac1=[fac1[i]+(rr5[i-2] if i>=2 else S()) for i in range(N)]
    fac2=expand(G[3],70)
    rr=series_add(series_mul(aa,series_pow(rho,3,N),N),[2*a for a in series_mul(bb,series_pow(rho,2,N),N)],N)
    fac2=[fac2[i]+(rr[i-2] if i>=2 else S()) for i in range(N)]
    out=series_mul(fac1,fac2,N)
    # xi^127 t^3 y^10 = xi^27 t(xi^-3)^3 * Y^10.
    ts=t**3;ta=[S() for _ in range(N)]
    for i in range(len(ts)):
        j=27-3*i
        if 0<=j<N:ta[j]=S(ts[i])
    y10=[S(a) for a in Poly(YP[1]).pow_trunc(10,N).tolist()]
    y10 += [S() for _ in range(N-len(y10))]
    return series_add(out,series_mul(ta,y10,N),N)

def substitute_kernel(poly,n0,n1,D):
    degree=max((m[2]+m[3] for m in poly.d),default=0)
    out=S()
    for m,a in poly.d.items():
        base=S({(m[0],m[1],0,0):a})
        out=out+base*(n0**m[2])*(n1**m[3])*(D**(degree-m[2]-m[3]))
    return out,degree

def main():
    start=time.time();data,G=graph_source();F=series_F(G)
    assert all(not a for a in F[:4])
    for j in [4,5]:assert max((m[2]+m[3] for m in F[j].d),default=0)==1
    a,b=[F[4].coefficient(i,1) for i in [2,3]]
    c0,d0=[F[5].coefficient(i,1) for i in [2,3]]
    p=F[4].coefficient(2,0).coefficient(3,0)
    r=F[5].coefficient(2,0).coefficient(3,0)
    det=a*d0-b*c0
    D=S(47171)+357608*w**3
    det_shift=det.shift((0,-2,0,0))
    scale=div(det_shift.d.get((0,0,0,0),0),47171)
    assert scale and det_shift==scale*D
    n0=inv(scale)*(-p*d0+b*r).shift((0,-2,0,0))
    n1=inv(scale)*(-a*r+p*c0).shift((0,-2,0,0))
    assert a*n0+b*n1+p*D==0 and c0*n0+d0*n1+r*D==0
    Gnum=[]
    for gi in G:
        oo=[]
        for row in gi:
            rr=[]
            for poly in row:
                pn,dd=substitute_kernel(poly,n0,n1,D)
                assert dd<=1
                rr.append(pn*D if dd==0 else pn)
            oo.append(rr)
        Gnum.append(oo)
    f6num,f6den=substitute_kernel(F[6],n0,n1,D)
    # Compare F6 against the supplied q,H cubic after h=wH, q=w^3.
    rows={'a0':[350365,93449],'b':[90885,339126,362701,194731,371097,144818],'c':[56518,278019,104390,351083,235630,246647,217983],'e':[0,324104,260238,219737,136154,199269,240524,27757,108951,319279]}
    rp={key:sum((a*w**(3*i) for i,a in enumerate(row)),S()) for key,row in rows.items()}
    # psi=a0*w^3*h^3 + b*w*h^2 + c*h/w + e/w^3.
    psi=rp['a0']*w**3*h**3+rp['b']*w*h**2+rp['c']*h*w**-1+rp['e']*w**-3
    assert f6num*w**3*D==psi*(D**f6den)
    out={'denominator_d':D.serialize(),'kernel_numerators':[n0.serialize(),n1.serialize()], 'kernel_denominator':'d(w^3)', 'determinant_scale':scale,'G_numerators':[[[s.serialize() for s in row] for row in gi] for gi in Gnum], 'F6_numerator':f6num.serialize(),'F6_denominator_power':f6den}
    (ROOT/'data'/'source_cramer.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    # Inspect w residues after substituting h=u/w^2, keeping each y component.
    residues=[]
    for gi in Gnum:
        residues.append([sorted({(m[1]-2*m[0])%3 for s in row for m in s.d}) for row in gi])
    checks={'F0_to_F3_zero':True,'F4_F5_Cramer_identities':True,'determinant_scale':scale,'F6_supplied_cubic_identity':True,'F6_denominator_power':f6den,'numerator_H_degree':max(s.maxdegree(0) for gi in Gnum for row in gi for s in row),'kernel_numerator_terms':[len(n0.d),len(n1.d)],'w_residue_by_G_and_y_component':residues,'elapsed_seconds':round(time.time()-start,3)}
    (ROOT/'checks'/'cramer_check.json').write_text(json.dumps(checks,indent=2)+'\n');print(json.dumps(checks,indent=2))
if __name__=='__main__':main()
