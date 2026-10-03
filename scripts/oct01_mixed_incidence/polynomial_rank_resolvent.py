#!/usr/bin/env sage
"""Norm-free source resolvent and exact sparse rank polynomial.

This constructs necessary equations, not a full source decision. The variables
x_r represent the actual fifth-power conjugates of the SAME first moment.
"""
import argparse,json,random,sys,time
from pathlib import Path
from sage.all import PolynomialRing,matrix
sys.path.insert(0,str(Path(__file__).parent))
from direction_boundary import marked_field
from field import K
from incidence import endpoint
from source_mobius import resolvent_matrix,m2det
from source_rank_resolvent import rank_lift_map


def polynomial_resolvent(ep):
    KK,b,embed,unembed=marked_field()
    rows={name:list(map(embed,row)) for name,row in endpoint(ep).items()}
    R=PolynomialRing(KK,'s');s=R.gen();m=b(21)
    def mul(u,v):
        out=[R.zero() for _ in range(4)]
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=u[i]*v[j]*(m if i+j>=4 else 1)
        return out
    U,C,V=[rows[n] for n in ('U','C','V')]
    su=[s-U[0]]+[-c for c in U[1:]]
    basis=[[int(i==j) for i in range(4)] for j in range(4)]
    M=matrix(R,[mul(su,v) for v in basis]).transpose()
    norm=M.det();adj=M.adjugate().column(0).list()
    rv=mul(adj,V);rc=mul(adj,C);rvc=mul(rc,V)
    dn,cn,bn,an=rc[3],rvc[3],adj[3],rv[3]
    av=mul(adj,[V[i]*dn-(cn if i==0 else 0) for i in range(4)])
    bv=mul(adj,[(an if i==0 else 0)-V[i]*bn for i in range(4)])
    A=[];B=[]
    for left,out in ((av,A),(bv,B)):
        for value in left:
            q,r=value.quo_rem(norm);assert not r;out.append(q)
    assert max(p.degree() for p in A)<=2
    assert max(p.degree() for p in B)<=1
    Ti=matrix(KK,[rows[n][1:] for n in ('E1','C','U')]).transpose().inverse()
    return dict(field=KK,b=b,embed=embed,unembed=unembed,rows=rows,ring=R,
        norm=norm,adj=adj,d=dn,c=cn,bn=bn,a=an,A=A,B=B,Ti=Ti)


def rank_polynomials(ep):
    aux=polynomial_resolvent(ep);KK=aux['field'];b=aux['b']
    R=PolynomialRing(KK,names=[f'x{r:02d}' for r in range(14)],order='degrevlex')
    xs=R.gens();PT=PolynomialRing(R,'T');T=PT.gen()
    def phs(p,n):return sum((R(c**(5**n))*xs[n%14]**i for i,c in enumerate(p.list())),R.zero())
    def row(name,n):return [c**(5**n) for c in aux['rows'][name]]
    def mul(u,v,n):
        out=[PT.zero() for _ in range(4)];m=b(21)**(5**n)
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=u[i]*v[j]*(m if i+j>=4 else 1)
        return out
    d,c,an,bn=[aux[n] for n in ('d','c','a','bn')]
    Hn=phs(d,0)*T+phs(c,0);Hd=phs(bn,0)*T+phs(an,0)
    Ln=phs(an,8)*T-phs(c,8);Ld=-phs(bn,8)*T+phs(d,8)
    def zbase(n,den=None,num=None):
        if den is None:den=PT.one();num=T
        e=[phs(aux['A'][i],n)*den+phs(aux['B'][i],n)*num for i in range(4)]
        E=row('E1',n);E[0]-=xs[(n+3)%14]
        z=mul(e,E,n)
        return [z[i]*(b(gamma)**(5**((n-8)%14))) for i,gamma in enumerate((13,17,7))]+[PT.zero()]
    Ti=aux['Ti']
    def ell(n):
        E,C,U=[row(name,n) for name in ('E1','C','U')]
        shift=[E[0]-xs[(n+3)%14],R(C[0]),U[0]-xs[n%14]]
        return [sum(shift[i]*Ti[i,j]**(5**n) for i in range(3)) for j in range(3)]
    def dot(u,v):return sum((u[i]*v[i+1] for i in range(3)),PT.zero())
    Z=zbase(8);ell0=ell(0);h0=Ti.row(1)
    Jn=((dot(ell0,Z)-Z[0])*Hd-dot(h0,Z)*Hn)/b(14)
    Jd=Ld*Hd
    Q=zbase(2,Ld,Ln);ell8=ell(8);h8=[v**(5**8) for v in h0]
    Nden=-phs(bn,2)*Ln+phs(d,2)*Ld
    P=b(14)**(5**8)*T**5*Nden-(dot([ell8[i]-T*h8[i] for i in range(3)],Q)-Q[0])
    assert Jn.degree()<=2 and Jd.degree()<=2
    assert P.degree() in (5,6) and P[3]==P[4]==0
    aux.update(coefficient_ring=R,polynomial_ring=PT,x=xs,Jn=Jn,Jd=Jd,P=P)
    return aux


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args();ep=json.loads(args.source);start=time.monotonic();aux=rank_polynomials(ep)
    KK,embed,unembed=aux['field'],aux['embed'],aux['unembed'];rng=random.Random(121)
    from finite import phi
    for sample in range(8):
        x=K.decode(rng.randrange(5**14));M,Rx=resolvent_matrix(endpoint(ep),x)
        if m2det(M)==K.zero:continue
        J,actual=rank_lift_map(endpoint(ep),x,M,Rx)
        point=[embed(phi(x,r)) for r in range(14)]
        ev=lambda p:PolynomialRing(KK,'T')([v(*point) for v in p.list()])
        jn,jd,p=map(ev,(aux['Jn'],aux['Jd'],aux['P']))
        refn=jn.parent()([embed(c) for c in J.n]);refd=jn.parent()([embed(c) for c in J.d])
        assert jn*refd==jd*refn
        refp=jn.parent()([embed(c) for c in actual['special_eliminant']])
        assert p.monic()==refp.monic()
    coeffdeg=lambda p:max(int(v.total_degree()) for v in p.list() if v)
    meta=dict(source=ep,norm_degree=int(aux['norm'].degree()),
        A_coordinate_degrees=[int(p.degree()) for p in aux['A']],B_coordinate_degrees=[int(p.degree()) for p in aux['B']],
        J_numerator_T_degree=int(aux['Jn'].degree()),J_denominator_T_degree=int(aux['Jd'].degree()),
        J_numerator_coefficient_degree=coeffdeg(aux['Jn']),J_denominator_coefficient_degree=coeffdeg(aux['Jd']),
        sparse_rank_T_degree=int(aux['P'].degree()),sparse_rank_coefficient_degree=coeffdeg(aux['P']),
        sparse_rank_support=[i for i,p in enumerate(aux['P'].list()) if p],
        coefficient_terms={name:sum(len(v.monomials()) for v in aux[name].list()) for name in ('Jn','Jd','P')},
        fixed_first_moment_checks=8,seconds=time.monotonic()-start,
        scope='norm-free literal necessary equations; no all-first-moment decision or authentic target')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
