#!/usr/bin/env sage
"""Four ordinary F5^7 variables for the original source row/rank relaxation.

Conjugation is explicit, including on every source coefficient. No coefficient
is presumed fixed by it. Denominator boundaries are retained by saturation.
"""
import argparse,json,random,sys,time
from functools import lru_cache
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
sys.path.insert(0,str(Path(__file__).parent))
from polynomial_rank_resolvent import rank_polynomials
from field import K,F,xi
from finite import phi
from source_mobius import resolvent_matrix,candidate_rows,fourth_row_residual
from source_system import build,evaluate
from incidence import endpoint


def evaluator(point):
    cache=[{0:z.parent().one(),1:z} for z in point]
    def ev(pol):
        out=point[0].parent().zero()
        for exp,coef in pol.dict().items():
            term=coef
            for i,e in enumerate(exp):
                if e not in cache[i]:cache[i][e]=point[i]**e
                term*=cache[i][e]
            out+=term
        return out
    return ev


def subfield_data(aux):
    KK=aux['field'];beta=aux['b'](5);h=aux['embed'](xi)+1/aux['embed'](xi)
    assert h**(5**7)==h and h.minpoly().degree()==7
    HH=GF(5**7,name='h',modulus=h.minpoly());F5=GF(5)
    vec=lambda z:vector(F5,[z.polynomial()[i] for i in range(14)])
    mat=matrix(F5,[list(vec(h**i)) for i in range(7)]).transpose()
    pivots=mat.transpose().pivots();assert len(pivots)==7
    small=mat.matrix_from_rows(pivots).inverse()
    smallints=[[int(small[i,j]) for j in range(7)] for i in range(7)]
    hb=[h**i for i in range(7)]
    @lru_cache(None)
    def toH(z):
        assert z**(5**7)==z
        zp=z.polynomial();zv=[int(zp[i]) for i in pivots]
        v=[sum(smallints[i][j]*zv[j] for j in range(7))%5 for i in range(7)];out=HH(v)
        assert sum(KK(v[i])*hb[i] for i in range(7))==z
        return out
    @lru_cache(None)
    def fromH(z):return sum(KK(z.polynomial()[i])*hb[i] for i in range(7))
    @lru_cache(None)
    def split(z):
        z1=(z-z**(5**7))/(beta-beta**5)
        return (toH(z-beta*z1),toH(z1))
    return HH,beta,toH,fromH,split


def build_real(ep):
    aux=rank_polynomials(ep);KK=aux['field'];HH,beta,toH,fromH,split=subfield_data(aux)
    P=PolynomialRing(KK,names=('x0','x1','y0','y1','saturation'),order='degrevlex')
    a,b,c,d,sat=P.gens()
    xr=lambda r:a**(5**(r%7))+beta**(5**(r%2))*b**(5**(r%7))
    yr=lambda r:c**(5**(r%7))+beta**(5**(r%2))*d**(5**(r%7))
    def ev(poly,r):return sum(P(coef**(5**r))*xr(r)**i for i,coef in enumerate(poly.list()))
    def row(name,r):return [P(v**(5**r)) for v in aux['rows'][name]]
    def mul(u,v,r):
        out=[P.zero() for _ in range(4)];m=aux['b'](21)**(5**r)
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=u[i]*v[j]*(m if i+j>=4 else 1)
        return out
    # Apply rho to the source G3 relation, so inverse Frobenius on H becomes 5.
    third=yr(0)*(ev(aux['bn'],8)*yr(8)+ev(aux['a'],8))-ev(aux['d'],8)*yr(8)-ev(aux['c'],8)
    subst=[xr(r) for r in range(14)]
    coeffev=lambda q:q(*subst)
    uniev=lambda q:sum(coeffev(coef)*yr(0)**i for i,coef in enumerate(q.list()))
    rank=yr(7)*uniev(aux['Jd'])-uniev(aux['Jn'])
    eps=[];ns=[]
    for r in (0,8,11):
        n=ev(aux['norm'],r);ns.append(n)
        # Exact adjugate numerator from R=(x-U)^-1; its coordinates are
        # computed once by the quartic multiplication matrix.
        U=aux['rows']['U'];R=aux['ring'];ss=R.gen();m=aux['b'](21)
        def base_mul(u,v):
            out=[R.zero() for _ in range(4)]
            for i in range(4):
                for j in range(4):out[(i+j)%4]+=u[i]*v[j]*(m if i+j>=4 else 1)
            return out
        su=[ss-U[0]]+[-v for v in U[1:]]
        adj=matrix(R,[base_mul(su,[int(i==j) for i in range(4)]) for j in range(4)]).transpose().adjugate().column(0)
        vv=row('V',r);vv[0]+=yr(r)
        eps.append(mul([ev(p,r) for p in adj],vv,r))
    e0,e8,e11=eps;n0,n8,n11=ns
    EE=row('E1',8);EE[0]-=xr(11)
    zz=mul(e8,EE,8)
    Z=[aux['b'](g)*zz[i] for i,g in enumerate((13,17,7))]+[P.zero()]
    Z[0]+=(aux['b'](13)+1)*yr(7)*n8
    WGleft=mul(e0,Z,0)
    CC=row('C',11);CC[0]-=yr(3)
    GG=mul(e11,CC,11)
    wg=[]
    for l,delta in enumerate((8,18,15)):
        v=-WGleft[l]*n11-aux['b'](delta)*GG[l]*n0*n8
        if l==0:v+=(1-aux['b'](delta))*xr(7)*n0*n8*n11
        wg.append(v)
    # Split all coefficients, never the variables, into H+beta H.
    RH=PolynomialRing(HH,names=P.variable_names(),order='degrevlex')
    def splitpoly(pol):
        out=[{},{}]
        for exp,coef in pol.dict().items():
            for i,z in enumerate(split(coef)):
                if z:out[i][exp]=z
        return [RH(q) for q in out]
    eq=[];labels=[]
    for name,pol in [('source_G3_after_rho',third),('actual_rank_lift',rank)]+[(f'actual_W_G_{i}',q) for i,q in enumerate(wg)]:
        for i,part in enumerate(splitpoly(pol)):eq.append(part);labels.append((name,i))
    # In H coordinates n8=bar(n0)^5 and n11=bar(n0)^625.
    # Saturating Norm(K/H)(n0) therefore removes every norm pole without
    # expanding its redundant 631st power.
    norm=ns[0]
    # Norm(x-U) never vanishes at an actual K moment; saturation also permits
    # using this polynomial system without finite-field equations as a stronger
    # algebraic-closure relaxation.
    nbar=P({exp:coef**(5**7) for exp,coef in norm.dict().items()})
    hn=splitpoly(norm*nbar);assert not hn[1]
    eq.append(RH.gen(4)*hn[0]-1);labels.append(('norm_denominator_saturation',0))
    for i in range(4):eq.append(RH.gen(i)**(5**7)-RH.gen(i));labels.append(('H_field',i))
    return RH,eq,labels,dict(aux=aux,field=HH,beta=beta,toH=toH,fromH=fromH,split=split,
        K_equations=[third,rank]+wg,K_ring=P,norm_saturation=hn[0])


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args();ep=json.loads(args.source);start=time.monotonic();R,eq,labels,data=build_real(ep)
    aux=data['aux'];rng=random.Random(125);spec=build(ep)
    for sample in range(8):
        x,y=[K.decode(rng.randrange(5**14)) for i in range(2)]
        xx,yy=aux['embed'](x),aux['embed'](y)
        actual=tuple(data['split'](xx)+data['split'](yy)+(R.base_ring().zero(),))
        point=[data['fromH'](v) for v in actual]
        kev,hev=evaluator(point),evaluator(actual)
        M,Rx=resolvent_matrix(endpoint(ep),x)
        rows,eps,X,Y=candidate_rows(endpoint(ep),x,y,Rx)
        norm=[aux['norm'](xx)**(5**r) for r in (0,8,11)]
        expected_third=-aux['embed'](phi(rows['E1'][3],8))*norm[1]
        assert kev(data['K_equations'][0])==expected_third, dict(x=x,y=y,
            x_reconstruction=point[0]+data['beta']*point[1]==xx,
            y_reconstruction=point[2]+data['beta']*point[3]==yy,
            left=str(kev(data['K_equations'][0])),right=str(expected_third))
        expected=fourth_row_residual(rows)
        for i,pol in enumerate(data['K_equations'][2:]):assert kev(pol)==aux['embed'](expected[i])*norm[0]*norm[1]*norm[2]
        for i,pol in enumerate(data['K_equations']):
            value=kev(pol);parts=data['split'](value)
            assert all(hev(eq[2*i+j])==parts[j] for j in range(2))
        den=hev(data['norm_saturation']);assert den
        actual=actual[:4]+(1/den,)
        assert all(evaluator(actual)(pol)==0 for pol in eq[10:])
    meta=dict(source=ep,variables=R.ngens(),H_variables=4,H_size=5**7,equations=len(eq),
        degrees=[int(q.total_degree()) for q in eq],terms=[len(q.monomials()) for q in eq],
        checks=8,seconds=time.monotonic()-start,
        scope='exact necessary source row/rank model over H, target authentication absent; no solver decision')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
