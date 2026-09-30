"""Eliminate the two kernel coordinates using the actual F4,F5 series."""
from source import *
from laurent import LP,H,W,sadd,sscale,smul,spow,shift


def y_series(n,coerce=LP.code):
    yp=[coerce(1)]+[coerce(0)]*(n-1)
    for i in range(1,n):
        target=P[10-i//3] if i%3==0 and i//3<=10 else 0
        yp[i]=(coerce(target)-spow(yp,3,i+1)[i])/3
    return yp

def aseries(g,d,n,Y,coerce=LP.code):
    ypow=[ [coerce(1)]+[coerce(0)]*(n-1),Y,spow(Y,2,n)]
    r=[coerce(0)]*n
    for j,poly in enumerate(g):
        for i,c in enumerate(poly):
            if c:
                off=d-3*i-10*j
                assert off>=0
                r=sadd(r,shift(sscale(ypow[j],coerce(c),n),off,n),n)
    return r

def series_basis(n,coerce=LP.code):
    ex=json.loads((ROOT/'data/affine_source.json').read_text())['source_G']
    Y=y_series(n,coerce)
    mat=[[aseries(g,d,n,Y,coerce) for g,d in zip(bb,[35,46,57,70])] for bb in ex]
    qs=[coerce(Q[19-i//3]) if i%3==0 and i//3<=19 else coerce(0) for i in range(n)]
    # t^3 y^10=P^3 y t^3, so xi^127 T3P3(x) y.
    ts=aseries([[],T3P3,[]],127,n,Y,coerce)
    return mat,qs,ts

def fseries(parameters,mat,qs,ts,n):
    gs=[[sum((parameters[i]*mat[i][j][k] for i in range(7)),0) for k in range(n)] for j in range(4)]
    aa=sscale(gs[0],3,n);bb=sscale(gs[1],2,n);cc=gs[2]
    rho=[-cc[0]/bb[0]]+[0]*(n-1)
    for i in range(1,n):
        term=sadd(sadd(smul(aa,smul(rho,rho,i+1),i+1),smul(bb,rho,i+1),i+1),cc,i+1)[i]
        rho[i]=-term/bb[0]
    first=sadd(qs,shift(spow(rho,5,n),2,n),n)
    second=sadd(gs[3],shift(sadd(smul(aa,spow(rho,3,n),n),sscale(smul(bb,spow(rho,2,n),n),2,n),n),2,n),n)
    return sadd(smul(first,second,n),ts,n)

def run():
    ts0=time.time();n=7
    eps,eta,ca,cd=map(LP.code,[EPS,ETA,CA,CD])
    z=2*W/eps;c=ca*H+cd*W
    ee=-c*z-eta/(LP.code(24)*z)
    ff=-W**2/eps-LP.code(div(8,24))*z**5
    mat,qs,ts=series_basis(n)
    par=[LP(1),H,W,ee,ff,LP(0),LP(0)]
    fs=fseries(par,mat,qs,ts,n)
    p0=list(par);p0[5]=LP(1)
    p1=list(par);p1[6]=LP(1)
    f0=fseries(p0,mat,qs,ts,n);f1=fseries(p1,mat,qs,ts,n)
    B=[[f0[i]-fs[i],f1[i]-fs[i]] for i in [4,5]]
    det=B[0][0]*B[1][1]-B[0][1]*B[1][0]
    k0=-fs[4]*B[1][1]+fs[5]*B[0][1]
    k1=-B[0][0]*fs[5]+B[1][0]*fs[4]
    assert not any(fs[:4]) and not any(f0[:4]) and not any(f1[:4])
    assert B[0][0]*k0+B[0][1]*k1+fs[4]*det==0
    assert B[1][0]*k0+B[1][1]*k1+fs[5]*det==0
    # F4,F5 are truly affine linear: verify the polynomial second differences including mixed term.
    for kk,ll in [(2,0),(0,2),(1,1),(2,3)]:
        pp=list(par);pp[5]=LP(kk);pp[6]=LP(ll)
        fz=fseries(pp,mat,qs,ts,n)
        for j in [4,5]:assert fz[j]==fs[j]+kk*(f0[j]-fs[j])+ll*(f1[j]-fs[j])
    # The source has small bounded kernel degree, making the difference check exact here.
    # A separate direct generic k-variable verification is not claimed by this check.
    data={'e':ee.to_json(),'f':ff.to_json(),'kernel_determinant':det.to_json(),'kernel0_numerator':k0.to_json(),'kernel1_numerator':k1.to_json(),
          'F4_origin':fs[4].to_json(),'F5_origin':fs[5].to_json(),'matrix':[[p.to_json() for p in row] for row in B]}
    (ROOT/'data/cramer.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
    print(json.dumps({'kernel_determinant':det.to_json(),'numerator_term_counts':[len(k0.t),len(k1.t)],'F0_to_F3_zero':True,'Cramer_identities_zero':True,'seconds':round(time.time()-ts0,3)}))

if __name__=='__main__':run()
