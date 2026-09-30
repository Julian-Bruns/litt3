"""Reconstruct the full affine six-dimensional source from (1)--(4)."""
from algebra import *
from math import comb
import json,time
# G2=y^2 D2; pole(D2)<=12 imposes the zero xy coefficient.
BASIS=[]
for i in range(2,6):
    d={2:12,3:46,4:57,5:70}[i]
    for j in range(3):
        for m in range(max(0,(d-10*j)//3+1)):
            v=mon(m,j)
            if i==2:v=cmul(v,mon(0,2))
            BASIS.append((i,m,j,v))

def equations(G):
    N=[cscalar([1]),czero(),G[0],G[1],G[2],cadd(G[3],cscalar(Q))]
    out={}
    for j in range(1,6):
        v=czero()
        for i in range(j+1):
            sc=comb(5-i,j-i)%5
            if sc:v=cadd(v,cscale(cmul(cscalar(ppow(pneg(B0),j-i)),N[i]),sc))
        for r in range(3):
            powerp=max(0,(j-r+2)//3)
            mod=ppow(P,powerp)
            rem=pmod(v[r],mod)
            for m,c in enumerate(rem):
                if c:out[(1,j,r,m)]=c
    for j in range(5):
        v=czero()
        for i in range(6-j):
            sc=comb(5-i,j)%5
            if sc:v=cadd(v,cscale(cmul(cscalar(ppow(pneg(L0),5-i-j)),N[i]),sc))
        v=cmul(cscalar(psub(Q,ppow(L0,5))),v)
        if j==0:v=cadd(v,cmul(cscalar(ppow(t,3)),mon(0,1) if False else cpow(mon(0,1),10)))
        for r in range(3):
            rem=pmod(v[r],ppow(t,5-j))
            for m,c in enumerate(rem):
                if c:out[(2,j,r,m)]=c
    for j in range(11):
        v=N[j] if j<6 else czero()
        if 0<=j-5<6:v=cadd(v,cmul(cscalar(Q),N[j-5]))
        if j==10:v=cadd(v,cmul(cscalar(ppow(t,3)),cpow(mon(0,1),10)))
        d=10+12*j-max(0,j-5)
        for r in range(3):
            for m,c in enumerate(v[r]):
                if c and 3*m+10*r>d:out[(3,j,r,m)]=c
    return out

def main():
    start=time.time();n=len(BASIS)
    base=equations([czero() for _ in range(4)])
    cols=[];keys=set(base)
    for i,m,j,v in BASIS:
        G=[czero() for _ in range(4)];G[i-2]=v
        ev=equations(G);ks=set(ev)|set(base)
        col={k:sub(ev.get(k,0),base.get(k,0)) for k in ks}
        cols.append(col);keys.update(col)
    keys=sorted(keys)
    M=np.array([[c.get(k,0) for c in cols] for k in keys],dtype=np.int32)
    rhs=np.array([neg(base.get(k,0)) for k in keys],dtype=np.int32)
    part,ker,piv=affine_solve(M,rhs)
    print('variables',n,'equations',len(keys),'rank',len(piv),'affine_dimension',len(ker),flush=True)
    assert len(ker)==6
    # Add h,w,e,f=0 constraints to select a two-dimensional residual kernel.
    coord_specs=[(2,4,0),(4,19,0),(4,12,2),(5,16,2)]
    ids=[[ii for ii,(i,m,j,v) in enumerate(BASIS) if (i,m,j)==spec][0] for spec in coord_specs]
    M2=np.vstack([M,np.eye(n,dtype=np.int32)[ids]])
    # Six source vectors: particular, h,w,e,f, two residual directions.
    part2,ker2,piv2=affine_solve(M2,np.r_[rhs,[0]*4])
    assert len(ker2)==2
    vec=[]
    for ii in range(4):
        b=np.zeros(M2.shape[0],dtype=np.int32);b[-4+ii]=1
        vp,_,_=affine_solve(M2,b);vec.append(vp)
    vec.extend(ker2)
    names=['particular','h','w','e','f','u','v']
    vectors=[part2]+vec
    src={name:[[i,m,j,int(c)] for c,(i,m,j,_) in zip(vv,BASIS) if c] for name,vv in zip(names,vectors)}
    src['basis']=[[i,m,j] for i,m,j,_ in BASIS]
    (ROOT/'data/affine_source.json').write_text(json.dumps(src,indent=2)+'\n')
    for ii,vv in enumerate(vectors):
        check=np.zeros(len(M),dtype=np.int32)
        for j,c in enumerate(vv):
            if c:check=va(check,vm(M[:,j],c))
        assert np.array_equal(check,rhs if ii==0 else np.zeros(len(M),dtype=np.int32))
    # Recover epsilon and c/w from the actual coefficient representatives.
    def get(rep,i,m,j):
        z=czero()
        for c,(r,a,b,vv) in zip(rep,BASIS):
            if r==i and c:z=cadd(z,cscale(vv,int(c)))
        return z[j][m] if len(z[j])>m else 0
    assert get(part2,3,12,1)==Epsilon
    assert get(vec[1],3,15,0)==Cd
    print('all seven affine vectors verified; epsilon and c=C_d*w verified',flush=True)
    print('elapsed_seconds',round(time.time()-start,3),flush=True)
if __name__=='__main__':main()
