"""Small polynomial-matrix certificates for the finite degree-138 base algebras.
All matrix entries lie in K[S]. Determinants and identities have no specialization
assumptions; only the separately recorded units S and D(S) are cancelled.
"""
from weighted_elimination import *
from factor import is_irreducible
import itertools

def det(A):
    n=len(A)
    if n==0:return FP(1)
    a=[[FP(x) for x in r] for r in A];old=FP(1);sgn=1
    for k in range(n-1):
        pivot=next((i for i in range(k,n) if a[i][k]),None)
        if pivot is None:return FP()
        if pivot!=k:a[k],a[pivot]=a[pivot],a[k];sgn=neg(sgn)
        d=a[k][k]
        for i in range(k+1,n):
            for j in range(k+1,n):a[i][j]=(a[i][j]*d-a[i][k]*a[k][j])//old
        for i in range(k+1,n):a[i][k]=FP()
        old=d
    return a[-1][-1].scale(sgn)

def minor(A,row,col):return [[v for j,v in enumerate(rr) if j!=col] for i,rr in enumerate(A) if i!=row]
def coeff_l(f):
    out=[]
    for j in range(f.degree(ll)+1):
        rows=[(e[0],c.v) for e,c in f.items() if e[1]==j];p=[0]*(max([i for i,c in rows],default=-1)+1)
        for i,c in rows:p[i]=c
        out.append(FP(p))
    return out

def shifted_cols(f,g,df,dg):
    cols=[]
    for pol,nb in [(f,df),(g,dg)]:
        for j in range(nb):cols.append([FP()]*j+pol)
    nr=max(map(len,cols));return [[v[i] if i<len(v) else FP() for v in cols] for i in range(nr)]

def matvec(A,v):return [sum((a*b for a,b in zip(r,v)),FP()) for r in A]

def data_fp(p):return list(p.c)
def evaluate_sl(f,lv,mod):
    s=x%mod;out=FP()
    for e,c in f.items():out=(out+(s.powmod(e[0],mod)*lv.powmod(e[1],mod)).scale(c.v))%mod
    return out

def run(index):
    st=time.monotonic()
    j=json.loads((ROOT/'data'/f'degree_strata_{index}.json').read_text())
    shape=json.loads((ROOT/'data'/f'linear_138_shape_{index}.json').read_text())
    f6,f7,f8=[compress(deserialize_poly(f),1)[0] for f in j['reduced_F'][:3]]
    g=FP(shape['parameter_polynomial']);lv=FP(shape['lambda_polynomial'])
    df=coeff_l(compress(deserialize_poly(j['denominator']),1)[0])[0]
    f,h=coeff_l(f6),coeff_l(f7);n,m=len(f)-1,len(h)-1
    M=shifted_cols(f,h,m,n);assert len(M)==len(M[0])==n+m
    res=det(M)
    cof=[det(minor(M,0,jj)).scale(1 if jj%2==0 else 4) for jj in range(n+m)]
    assert matvec(M,cof)==[res]+[FP()]*(n+m-1)
    extra=res//g;spower=dpower=0
    while extra and not extra%x:extra=extra//x;spower+=1
    while extra and not extra%df:extra=extra//df;dpower+=1
    print('index',index,'resultant degree',res.deg,'unit powers S,D',spower,dpower,'remaining degree',extra.deg,flush=True)
    assert extra.deg==0
    # A linear subresultant represented by signed maximal minors.
    M1=shifted_cols(f,h,m-1,n-1)
    Bmat=M1[2:];assert len(Bmat)+1==len(Bmat[0])
    cof1=[det([[a for k,a in enumerate(row) if k!=jj] for row in Bmat]).scale(1 if jj%2==0 else 4) for jj in range(len(Bmat[0]))]
    lin=matvec(M1,cof1);assert all(not a for a in lin[2:])
    b,a=lin[:2]
    gd,aa,bb=a.xgcd(g);assert gd==1
    assert (a*lv+b)%g==0
    assert evaluate_sl(f6,lv,g)==evaluate_sl(f7,lv,g)==0
    f8v=evaluate_sl(f8,lv,g);gd8,u,vv=f8v.xgcd(g);assert gd8==1
    assert (x*df*lv).gcd(g)==1
    out={'space_index':index,'variables':['S','lambda'],'F6':data2(f6),'F7':data2(f7),'F8':data2(f8),'D':data_fp(df),'g':data_fp(g),'lambda':data_fp(lv),'resultant':data_fp(res),'resultant_factorization':{'constant':extra[0],'S_power':spower,'D_power':dpower},'resultant_bezout':[data_fp(z) for z in cof],'resultant_matrix_layout':{'first_block':'lambda^i F6, 0<=i<deg_lambda F7','second_block':'lambda^i F7, 0<=i<deg_lambda F6','rows':'coefficients lambda^0 through lambda^(n+m-1)'},'linear_subresultant':[data_fp(b),data_fp(a)],'linear_bezout':[data_fp(z) for z in cof1],'linear_pivot_bezout':[data_fp(aa),data_fp(bb)],'F8_mod_g':data_fp(f8v),'F8_bezout':[data_fp(u),data_fp(vv)]}
    (ROOT/'data'/f'linear_elimination_certificate_{index}.json').write_text(json.dumps(out,indent=2)+'\n')
    print('exact determinant, Bezout and all-boundary certificates PASS',index,'seconds',round(time.monotonic()-st,3),flush=True)
    return out

if __name__=='__main__':
    a=argparse.ArgumentParser();a.add_argument('--index',type=int,default=1);args=a.parse_args();run(args.index)
