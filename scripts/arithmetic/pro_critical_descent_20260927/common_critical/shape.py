"""Extract and verify a univariate presentation of the finite incidence algebra."""
from algebra import *
import json,time

def matvec(M,v):
    T=vm(M,v[None,:]);out=np.zeros(M.shape[0],dtype=np.int32)
    for p in (1,5,25,125,625,3125,15625,78125):
        out+=(np.sum(T//p%5,axis=1)%5).astype(np.int32)*p
    return out

def relation(M,v0):
    n=len(v0);basis=[];pivs=[];hist=[];powers=[];v=v0.copy()
    for k in range(n+1):
        rr=v.copy();hh=np.zeros(n+1,dtype=np.int32);hh[k]=1
        for p,b,bb in zip(pivs,basis,hist):
            c=rr[p]
            if c:
                rr=va(rr,vn(vm(b,c)));hh=va(hh,vn(vm(bb,c)))
        ids=np.nonzero(rr)[0]
        if not len(ids):return hh[:k+1].tolist(),np.array(powers,dtype=np.int32).T
        p=int(ids[0]);c=inv(int(rr[p]));rr=vm(rr,c);hh=vm(hh,c)
        basis.append(rr);pivs.append(p);hist.append(hh);powers.append(v)
        v=matvec(M,v)
    raise AssertionError('no relation')

def poly_matvec(poly,M,v0):
    vv=np.zeros_like(v0)
    for c in reversed(poly):vv=va(matvec(M,vv),vm(v0,c))
    return vv

def load(path):
    it=iter(map(int,Path(path).read_text().split()));nv=next(it);n=next(it)
    bas=[tuple(next(it) for _ in range(nv)) for j in range(n)]
    mats=np.array([[[next(it) for j in range(n)] for i in range(n)] for v in range(nv)],dtype=np.int32)
    return bas,mats

def main():
    st=time.time();bas,mats=load(ROOT/'data/matrices.txt');n=len(bas)
    one=np.zeros(n,dtype=np.int32);one[bas.index((0,)*len(mats))]=1
    F,V=relation(mats[1],one)
    print('q minimal polynomial degree',len(F)-1,'algebra dimension',n,flush=True)
    if len(F)-1<n:
        print('q not a primitive algebra coordinate')
        return
    # Unique q-polynomials representing H, incidence x, inverse(qt).
    rhs=np.column_stack([matvec(M,one) for M in mats])
    R,piv=rref(np.column_stack([V,rhs]),n)
    assert piv==list(range(n))
    coords=R[:,-len(mats):].T.tolist()
    for i,p in enumerate(coords):assert np.array_equal(poly_matvec(p,mats[1],one),rhs[:,i])
    dF=[mul(c,i%5) for i,c in enumerate(F)][1:]
    gcd=pgcd(F,trim(dF));print('gcd(F,Fprime) degree',len(gcd)-1,flush=True)
    # All input polynomials reduce to zero in K[q]/F.
    inc=json.loads((ROOT/'data/incidence.json').read_text())
    def prod(a,b):return pmod(pmul(a,b),F)
    def pw(a,n):
        b=[1]
        while n:
            if n&1:b=prod(a,b)
            n>>=1
            if n:a=prod(a,a)
        return b
    Hp=[pw(coords[0],i) for i in range(4)];Qp=[pw([0,1],i) for i in range(16)];Xp=[pw(coords[2],i) for i in range(13)]
    for name in ['E1','E2','E3']:
        v=[]
        for h,q,x,c in inc[name]:v=padd(v,pscale(prod(prod(Hp[h],Qp[q]),Xp[x]),c))
        assert not v,name
        print(name,'verified in univariate presentation',flush=True)
    # Test localization by each requested open factor.
    ao=[89654,311173,214299,163299,315361,33043,356725,245794]
    a1=[0,299833,232505]
    ps=pmod(padd(ao,prod(a1,coords[0])),F)
    opens={'H':coords[0],'q':[0,1],'Psi':ps,'q_minus_15383':[neg(15383),1],'q_minus_1':[4,1],'a0':ao}
    for name,a in opens.items():print('open gcd',name,'degree',len(pgcd(a,F))-1,flush=True)
    data={'minimal_polynomial':F,'coordinates':dict(zip(['H','q','x','inverse_qt'],coords)),'derivative_gcd':gcd,'open_factors':opens}
    (ROOT/'data/shape.json').write_text(json.dumps(data,indent=2)+'\n')
    (ROOT/'data/shape_poly.txt').write_text(str(len(F))+'\n'+' '.join(map(str,F))+'\n')
    print('elapsed_seconds',round(time.time()-st,3),flush=True)
if __name__=='__main__':main()
