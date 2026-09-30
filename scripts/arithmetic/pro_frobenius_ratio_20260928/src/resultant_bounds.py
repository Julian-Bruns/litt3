"""Exact pole bounds for three whole-curve scale-tail resultants.

Bounds come from checked prime-power divisibilities of the retained global
polynomial source and integer dual certificates for Sylvester assignments.
They do NOT assert that a resultant or the global square ideal is a unit.
"""
import json,time
from pathlib import Path
import numpy as np
from ff import Poly,X,inv
from global_curve import QC,Z0,Z1,b,c,e
from residual import RATIO
ROOT=Path(__file__).resolve().parents[1]
INF=10**9

def valuation(p,f,cap):
    if not p:return cap
    v=0
    while v<cap:
        a,r=divmod(p,f)
        if r:return v
        p=a;v+=1
    return cap

def lift_root(f,z0,m):
    z=z0%f;prec=1
    assert not (z*z-Z1*z-Z0)%f
    while prec<m:
        prec=min(2*prec,m);mod=f**prec
        der=(2*z-Z1)%mod;g,iv,_=der.xgcd(mod);assert g==1
        z=(z-(z*z-Z1*z-Z0)*iv)%mod
    assert not (z*z-Z1*z-Z0)%(f**m)
    return z

def convolution(a,bb,N=75,S=56):
    out={}
    for (n,s),v in a.items():
        for (m,t),w in bb.items():
            if n+m>=N or s+t>=S:continue
            at=(n+m,s+t);vv=v+w
            if vv<out.get(at,INF):out[at]=vv
    return out

def tropical_tails(vals,last=74):
    A={(n,s):int(vals[n,s])for n in range(last+1)for s in range(7)if vals[n,s]<INF}
    a2=convolution(A,A,last+1);a3=convolution(A,a2,last+1)
    p5={(5*n,5*s):5*v for (n,s),v in a2.items() if 5*n<=last and 5*s<56}
    p25={(25*n,25*s):25*v for (n,s),v in a2.items()if 25*n<=last and 25*s<56}
    aa=convolution(a3,p5,last+1);cc=convolution(aa,p25,last+1)
    return {n:[cc.get((n,s),INF)for s in range(3*n//4+1)]for n in range(71,last+1)}

def assignment_certificate(a,b):
    n=len(a)-1;m=len(b)-1;N=n+m
    costs=[[INF]*N for _ in range(N)]
    for i in range(m):
        for j,cost in enumerate(a):costs[i][i+j]=cost
    for i in range(n):
        for j,cost in enumerate(b):costs[m+i][i+j]=cost
    # Hungarian potentials, entirely integer; verification below is independent.
    u=[0]*(N+1);v=[0]*(N+1);p=[0]*(N+1);way=[0]*(N+1)
    for i in range(1,N+1):
        p[0]=i;j0=0;mins=[INF]*(N+1);used=[False]*(N+1)
        while True:
            used[j0]=True;i0=p[j0];delta=INF;j1=0
            for j in range(1,N+1):
                if not used[j]:
                    cur=costs[i0-1][j-1]-u[i0]-v[j]
                    if cur<mins[j]:mins[j]=cur;way[j]=j0
                    if mins[j]<delta:delta=mins[j];j1=j
            assert delta<INF//2
            for j in range(N+1):
                if used[j]:u[p[j]]+=delta;v[j]-=delta
                else:mins[j]-=delta
            j0=j1
            if p[j0]==0:break
        while True:
            j1=way[j0];p[j0]=p[j1];j0=j1
            if not j0:break
    perm=[0]*N
    for j in range(1,N+1):perm[p[j]-1]=j-1
    lower=sum(u[1:])+sum(v[1:]);assert lower==sum(costs[i][perm[i]]for i in range(N))
    assert len(set(perm))==N
    assert all(u[i+1]+v[j+1]<=costs[i][j]for i in range(N)for j in range(N))
    return {'bound':lower,'row_potentials':u[1:],'column_potentials':v[1:],'permutation':perm}

def compute(out='data/resultant_pole_bounds.json'):
    start=time.time();G=np.load(ROOT/'data/global_residual.npz')['coefficients']
    pp=[[[Poly(G[j,n,s])for s in range(7)]for n in range(75)]for j in range(2)]
    fs=[Poly(f)for f in json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors']]
    a0=Poly(RATIO['a0']);d=Poly(RATIO['d'])
    z=QC(0,1);jv=z**3*a0+z**2*(b*b)+z*(c*b*b)+QC(e*b**3)
    places=[]
    # infinity: both branches; Norm(G0) has degree 1044, and component bounds 522.
    norm0=QC(pp[0][0][0],pp[1][0][0]).norm();assert norm0.degree()==1044
    vals=np.full((75,7),INF,dtype=np.int64)
    for n in range(75):
        for s in range(7):
            if pp[0][n][s]or pp[1][n][s]:vals[n,s]=522-max(pp[0][n][s].degree(),pp[1][n][s].degree()+7 if pp[1][n][s]else -1)
    places.append({'name':'infinity','factor_index':None,'multiplicity':2,'leading_valuation':-522,'values':vals.tolist()})
    specs=[('q_small',0,'zero',96),('q_large',0,'large',84)]
    specs += [('b_infinite_'+str(i),i,'large',54)for i in (3,12,16)]
    specs += [('e_small_'+str(i),i,'zero',12)for i in (8,22)]
    specs += [('V_zero_'+str(i),i,'V',3)for i in (13,21,24)]
    # d: work in the full quadratic local algebra, bounding both branches.
    specs += [('cramer_d',11,'quadratic',33)]
    for name,fi,which,v0 in specs:
        f=fs[fi];m=v0+32;mod=f**m
        if which=='quadratic':zz=None
        else:
            if which=='zero':z0=Poly()
            elif which=='large':z0=Z1%f
            else:
                gg,iv,_=(jv.b%f).xgcd(f);assert gg==1;z0=(-jv.a*iv)%f
                assert not (jv.a+jv.b*z0)%f
            zz=lift_root(f,z0,m)
        vals=np.full((75,7),INF,dtype=np.int64);caps=0
        for n in range(75):
            for s in range(7):
                aa,bb=pp[0][n][s],pp[1][n][s]
                if not aa and not bb:continue
                if zz is None:val=min(valuation(aa,f,m),valuation(bb,f,m))
                else:val=valuation((aa+(bb*zz)%mod)%mod,f,m)
                vals[n,s]=val-v0
                if val==m:caps+=1
        assert vals[0,0]==0,(name,vals[0,0])
        place={'name':name,'factor_index':fi,'factor':f.tolist(),'multiplicity':2 if which=='quadratic'else 1,
          'branch':which,'leading_valuation':v0,'precision':m,'capped_coefficients':caps,'values':vals.tolist()}
        if zz is not None:place['lifted_root']=zz.tolist()
        places.append(place)
        print('POLE_PLACE_SOURCE',name,'degree',f.degree(),'capped',caps,'seconds',round(time.time()-start,3),flush=True)
    for place in places:
        tails=tropical_tails(np.array(place['values']),74);place['tail_bounds']={str(k):v for k,v in tails.items()};place['resultants']={}
        for n in (72,73,74):place['resultants'][str(n)]=assignment_certificate(tails[71],tails[n])
        print('POLE_RESULTANT_BOUNDS',place['name'],{k:v['bound']for k,v in place['resultants'].items()},round(time.time()-start,3),flush=True)
    res={}
    for n in (72,73,74):
        finite={};vinf=0
        for p in places:
            v=p['multiplicity']*p['resultants'][str(n)]['bound']
            if p['name']=='infinity':vinf=v
            else:finite[p['factor_index']]=finite.get(p['factor_index'],0)+v
        degree=-vinf-sum(v*fs[i].degree()for i,v in finite.items())
        res[str(n)]={'degree_bound':degree,'valuation_at_infinity_lower_bound':vinf,'finite_valuation_lower_bounds':finite,
                    'normalization':'P_n=Norm(Res_(53,floor(3*n/4))(C71,Cn))*product(f_i^(-v_i))'}
    data={'status':'proved polynomial degree bounds; no resultant polynomial or square decision yet','places':places,'resultants':res,'seconds':round(time.time()-start,3)}
    (ROOT/out).write_text(json.dumps(data,separators=(',',':'))+'\n')
    print('GLOBAL_RESULTANT_DEGREE_BOUNDS',res,flush=True)
    return data

if __name__=='__main__':compute()
