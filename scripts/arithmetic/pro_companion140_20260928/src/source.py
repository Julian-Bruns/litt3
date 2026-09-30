"""Reconstruct the affine-six source from equations (1)-(4)."""
from field import *
import json, math, os, time
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
I=json.loads((ROOT/'data/inputs.json').read_text())
P,A,Q,B0,L0=[I[n] for n in ['P','A','Q','B0','L0']]
r=I['r'];v=[neg(r),1]
t,rem=pdm(A,scale([neg(25),1],13));assert not rem
T3P3=pm(ppow(t,3),ppow(P,3))
EPS=sum(c*25**i for i,c in enumerate(I['epsilon']))
ETA=sum(c*25**i for i,c in enumerate(I['eta']))
CD=sum(c*25**i for i,c in enumerate(I['Cd']))
CA=sum(c*25**i for i,c in enumerate(I['Ca']))

def basis(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
LABELS=[(2,i,j) for i,j in basis(14)]+[(n,i,j) for n,degree in [(3,46),(4,57),(5,70)] for i,j in basis(degree)]
M=len(LABELS)

def mono(i,j):
    q,j=divmod(j,3)
    return j,[0]*i+ppow(P,q)

def constraints():
    rows={}
    def put(tag,j,p,col,mod=None):
        if mod:p=pdm(p,mod)[1]
        for l,c in enumerate(p):
            if c:
                key=(tag,j,l)
                if key not in rows:rows[key]=[0]*(M+1)
                rows[key][col]=add(rows[key][col],c)
    terms=[(-1,0,0,v)]+[(col,n,*mono(i,j+(2 if n==2 else 0))) for col,(n,i,j) in enumerate(LABELS)]
    # col=-1 is the constant term.
    for col,n,j,p in terms:
        for ell in range(max(1,n),6):
            fac=math.comb(5-n,ell-n)%5
            if fac and j<ell:
                put(f'y{ell}',j,scale(pm(p,ppow(pn(B0),ell-n)),fac),col,ppow(P,(ell-j+2)//3))
        for ell in range(min(4,5-n)+1):
            fac=math.comb(5-n,ell)%5
            if fac:
                pp=pm(ps(Q,ppow(L0,5)),pm(p,ppow(pn(L0),5-n-ell)))
                put(f't{ell}',j,scale(pp,fac),col,ppow(t,5-ell))
        if n==5:
            pp=pm(Q,p)
            for k,c in enumerate(pp):
                if 3*k+10*j>125:put('infty',j,[0]*k+[c],col)
        if n==2 and LABELS[col][2]==0:put('D2(r)',0,[power(r,LABELS[col][1])],col)
    put('t0',1,T3P3,-1,ppow(t,5))
    for k,c in enumerate(T3P3):
        if 3*k+10>125:put('infty',1,[0]*k+[c],-1)
    keys=sorted(rows)
    return keys,[rows[k] for k in keys]

def rref(rows,ncols):
    import numpy as np
    a=np.array(rows,dtype=np.int64)
    ea=np.array(EXP,dtype=np.int64);la=np.array(LOG,dtype=np.int64)
    aa=np.array(A625,dtype=np.int64);nn=np.array(NEG625,dtype=np.int64)
    def vmul(a,b):return np.where((a!=0)&(b!=0),ea[(la[a]+la[b])%N1],0)
    def vneg(a):return nn[a%625]+625*nn[a//625]
    def vadd(a,b):return aa[(a%625)*625+b%625]+625*aa[(a//625)*625+b//625]
    piv=[];row=0
    for col in range(ncols):
        nz=np.flatnonzero(a[row:,col])
        if not len(nz):continue
        rr=row+int(nz[0]);a[[row,rr]]=a[[rr,row]]
        a[row,col:]=vmul(a[row,col:],inv(int(a[row,col])))
        target=np.flatnonzero(a[:,col]);target=target[target!=row]
        change=vmul(a[target,col,None],a[None,row,col:])
        a[target,col:]=vadd(a[target,col:],vneg(change))
        piv.append(col);row+=1
    assert not np.any(a[row:,:])
    free=[c for c in range(ncols) if c not in piv]
    origin=[0]*ncols
    for rr,col in enumerate(piv):origin[col]=neg(int(a[rr,-1]))
    kernel=[]
    for ff in free:
        vec=[0]*ncols;vec[ff]=1
        for rr,col in enumerate(piv):vec[col]=neg(int(a[rr,ff]))
        kernel.append(vec)
    return origin,kernel,piv,free

def expand(vec):
    gs=[ [[],[],[]] for _ in range(4)]
    for coeff,(n,i,j) in zip(vec,LABELS):
        jj,pp=mono(i,j+(2 if n==2 else 0))
        gs[n-2][jj]=pa(gs[n-2][jj],scale(pp,coeff))
    return gs

def dot(a,b):
    z=0
    for x,y in zip(a,b):z=add(z,mul(x,y))
    return z

def run():
    ts=time.time();keys,rows=constraints()
    origin,kernel,piv,free=rref(rows,M)
    assert len(kernel)==6
    for row in rows:
        assert add(dot(row[:-1],origin),row[-1])==0
        for vv in kernel:assert dot(row[:-1],vv)==0
    def coord(n,i,j):return LABELS.index((n,i,j))
    ih=coord(2,1,1);iw=coord(4,19,0);ic=coord(3,15,0);ie=coord(4,12,2);iff=coord(5,16,2);ieps=coord(3,12,1)
    for num,vec in enumerate([origin]+kernel):
        assert vec[ic]==add(mul(CA,vec[ih]),mul(CD,vec[iw]))
        assert vec[ieps]==(EPS if num==0 else 0)
    # Change to coordinates h,w,e,f and two free remaining coordinates.
    cr=[[vv[j] for vv in kernel]+[0] for j in [ih,iw,ie,iff]]
    oo,kk,cp,cf=rref(cr,6)
    assert len(kk)==2
    # Solve the 6x6 map for each requested coordinate, retaining two original parameters.
    mat=[[vv[j] for vv in kernel] for j in [ih,iw,ie,iff]]
    mat += [[int(j==k) for j in range(6)] for k in cf]
    solutions=[]
    for n in range(7):
        rhs=[neg(origin[j]) for j in [ih,iw,ie,iff]]+[0,0] if n==0 else [int(i==n-1) for i in range(6)]
        lam,_,_,_=rref([rr+[neg(b)] for rr,b in zip(mat,rhs)],6)
        vv=[dot([v[j] for v in kernel],lam) for j in range(M)]
        if n==0:vv=[add(a,b) for a,b in zip(vv,origin)]
        solutions.append(vv)
    ex=[expand(v) for v in solutions]
    # Store G5 rather than N5; subtract vQ in the affine origin only.
    ex[0][3][0]=ps(ex[0][3][0],pm(v,Q))
    # WARNING: v above is global x-r; Python3 comprehension variables do not leak.
    data={'labels':[list(t) for t in LABELS], 'basis_order':['constant','h','w','e','f','k0','k1'], 'source_G':ex,
          'source_N_vectors':solutions,'equation_count':len(rows),'variable_count':M,'rank':len(piv),'dimension':len(kernel),'free_columns':free,
          'top_indices':{'h':ih,'w':iw,'c':ic,'e':ie,'f':iff,'epsilon':ieps}}
    (ROOT/'data/affine_source.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
    print(json.dumps({'variables':M,'equations':len(rows),'rank':len(piv),'affine_dimension':len(kernel),'all_linear_equations_checked':True,'top_identities_checked':True,'seconds':round(time.time()-ts,3)}))

if __name__=='__main__':run()
