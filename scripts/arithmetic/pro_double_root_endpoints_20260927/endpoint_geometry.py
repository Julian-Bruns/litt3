"""Exact endpoint jets of the actual norm element (fixed source r=9).

All returned coefficients are global in K[u,q]/g.  No ratio, scale, cubic
branch point, or leading coefficient is inverted.  Division in the x
connection is only by the nonzero fixed field constant 3P(a).
"""
import gzip,struct,json,hashlib,time,sys
from exact import ROOT,DATA,add,mul,power,neg,div,trim,peval,pder,t
import rank9 as R
from branch_root import strip,weight,ud
from curve_eliminate import projection,remove_support

ENDPOINTS=[211895,211959,145049]
DEST=ROOT/'evidence/endpoint';DEST.mkdir(parents=True,exist_ok=True)

def qpoly(p):
    r=R.zero()
    for i,a in enumerate(p):r[i]=[a] if a else []
    return r

def cplus(a,b):return [R.plus(x,y) for x,y in zip(a,b)]
def cminus(a,b):return [R.minus(x,y) for x,y in zip(a,b)]
def ctimes(a,b,p):
    out=[R.zero() for _ in range(3)]
    for i in range(3):
      for j in range(3):
        z=R.times(a[i],b[j])
        if i+j>=3:z=R.times(z,p)
        out[(i+j)%3]=R.plus(out[(i+j)%3],z)
    return out

def cnorm(a,p):
    a0,a1,a2=a
    out=R.plus(R.power(a0,3),R.times(R.power(a1,3),p))
    out=R.plus(out,R.times(R.power(a2,3),R.power(p,2)))
    return R.minus(out,R.scalar(R.times(p,R.times(a0,R.times(a1,a2))),3))

def norm_linear(a,b,p):
    """Fixed-degree cubic Norm(a+b nu), ascending in nu."""
    a0,a1,a2=a;b0,b1,b2=b
    f1=R.plus(R.times(R.power(a0,2),b0),R.times(p,R.times(R.power(a1,2),b1)))
    f1=R.plus(f1,R.times(R.power(p,2),R.times(R.power(a2,2),b2)))
    mix=R.plus(R.times(b0,R.times(a1,a2)),R.plus(R.times(a0,R.times(b1,a2)),R.times(a0,R.times(a1,b2))))
    f1=R.scalar(R.minus(f1,R.times(p,mix)),3)
    f2=R.plus(R.times(a0,R.power(b0,2)),R.times(p,R.times(a1,R.power(b1,2))))
    f2=R.plus(f2,R.times(R.power(p,2),R.times(a2,R.power(b2,2))))
    mix=R.plus(R.times(a0,R.times(b1,b2)),R.plus(R.times(b0,R.times(a1,b2)),R.times(b0,R.times(b1,a2))))
    f2=R.scalar(R.minus(f2,R.times(p,mix)),3)
    return [cnorm(a,p),f1,f2,cnorm(b,p)]

def jets(x):
    assert x in ENDPOINTS and peval(t,x)==0 and peval(DATA['P'],x)!=0
    raw=gzip.open(ROOT/'evidence/norm_element.bin.gz','rb').read()
    ar=struct.unpack('<%dI'%(len(raw)//4),raw)
    rr=[];ss=[];gamma=div(peval(pder(DATA['P']),x),mul(3,peval(DATA['P'],x)))
    for j in range(3):
      vv=[];dd=[]
      for s in range(3):
        v=R.zero();d=R.zero()
        for i in range(45):
          for k in range(9):
            co=[ar[((((i*3+s)*3+j)*47+xx)*9+k)] for xx in range(47)]
            z=peval(co,x);dz=add(peval(pder(co),x),mul(mul(j,gamma),z))
            while len(v[k])<=i:v[k].append(0);d[k].append(0)
            v[k][i]=z;d[k][i]=dz
        qs=qpoly([0]*(2*s)+[1])
        vv.append(R.times([trim(c) for c in v],qs))
        dd.append(R.times([trim(c) for c in d],qs))
      rr.append(vv);ss.append(dd)
    return rr,ss

def discriminant_cubic(f):
    # d+c nu+b nu^2+a nu^3. Formula is for fixed binary degree three.
    d,c,b,a=f
    out=R.times(R.power(b,2),R.power(c,2))
    out=R.minus(out,R.scalar(R.times(a,R.power(c,3)),4))
    out=R.minus(out,R.scalar(R.times(R.power(b,3),d),4))
    out=R.minus(out,R.scalar(R.times(R.power(a,2),R.power(d,2)),27%5))
    out=R.plus(out,R.scalar(R.times(a,R.times(b,R.times(c,d))),18%5))
    return out

def build(x,verify=False):
    start=time.time();rr,ss=jets(x)
    for j in range(3):assert rr[j][2]==R.zero(),('unexpected quadratic endpoint value',x,j)
    # A common ratio-only unit normalization does not change x derivatives.
    arr,powers=strip([rr[j][s] for j in range(3) for s in range(2)]+[ss[j][s] for j in range(3) for s in range(3)])
    a=[arr[2*j] for j in range(3)];b=[arr[2*j+1] for j in range(3)]
    ap=[arr[6+3*j] for j in range(3)];bp=[arr[7+3*j] for j in range(3)];cp=[arr[8+3*j] for j in range(3)]
    p=qpoly([0,0,peval(DATA['P'],x)])
    W=cminus(cminus(ctimes(ctimes(a,b,p),bp,p),ctimes(ap,ctimes(b,b,p),p)),ctimes(ctimes(a,a,p),cp,p));ww,pw=strip(W)
    NW=cnorm(ww,p);nw,pnw=strip([NW]);nw=nw[0]
    print('ENDPOINT',x,'jets stripped',powers,'W powers',pw,'NW powers',pnw,'NW weight',weight(nw),'u',ud(nw),flush=True)
    ell01=R.minus(R.times(a[0],b[1]),R.times(a[1],b[0]))
    ell02=R.minus(R.times(a[0],b[2]),R.times(a[2],b[0]))
    ell12=R.minus(R.times(a[1],b[2]),R.times(a[2],b[1]))
    wedge,pell=strip([ell01,ell02,ell12]);ell01,ell02,ell12=wedge
    K=R.plus(R.minus(R.power(ell01,3),R.times(p,R.power(ell02,3))),R.times(R.power(p,2),R.power(ell12,3)))
    K=R.plus(K,R.scalar(R.times(p,R.times(ell01,R.times(ell02,ell12))),3))
    kk,pk=strip([K]);kk=kk[0]
    print('ENDPOINT',x,'wedge powers',pell,'K powers',pk,'K weight',weight(kk),'u',ud(kk),flush=True)
    # Projection through the quadratic ratio equation, with whole content
    # fibres explicitly retained by projection(). No new localisation here.
    unit=[1]
    from exact import pm
    unit=pm(pm([0,1],DATA['d']),DATA['b'])
    projections={}
    for name,h in [('same_sheet',nw),('different_sheets',kk)]:
      pr=projection(h,unit)
      projections[name]=pr
      print('ENDPOINT projection',x,name,'degrees content',len(pr['content'])-1,'allowed',len(pr['allowed_projection'])-1,
        'linear',[len(z)-1 for z in pr['primitive_linear_remainder']],
        'content not old units',len(remove_support(pr['content'],unit)[0])-1,flush=True)
    out={'x_code':x,'fixed_source_r_code':9,'P_at_x':peval(DATA['P'],x),
      'nu2_value_identically_zero':True,'nu2_derivative_retained':True,'common_jet_unit_powers':powers,
      'A':a,'B':b,'Aprime':ap,'Bprime':bp,'Cprime':cp,
      'W_unit_powers':pw,'W_primitive':ww,'norm_W_unit_powers':pnw,'norm_W_primitive':nw,
      'wedge_unit_powers':pell,'wedge_primitive':wedge,'K_unit_powers':pk,'K_primitive':kk,
      'projection_unit_polynomial':unit,'projections':projections,
      'actual_norm_array_sha256':hashlib.sha256(gzip.open(ROOT/'evidence/norm_element.bin.gz','rb').read()).hexdigest()}
    payload=json.dumps(out,separators=(',',':')).encode();dest=DEST/f'geometry_{x}.json.gz'
    if verify:assert gzip.open(dest,'rb').read()==payload
    else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
    print('ENDPOINT GEOMETRY DONE',x,'seconds',round(time.time()-start,3),flush=True)
    return out
if __name__=='__main__':
    args=[int(s) for s in sys.argv[1:] if not s.startswith('--')]
    for x in args or ENDPOINTS:build(x,'--verify' in sys.argv)
