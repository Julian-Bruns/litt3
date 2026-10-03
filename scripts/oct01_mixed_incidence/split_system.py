#!/usr/bin/env sage
"""Sparse exact split-coordinate row relaxation over F_(5^56).

The cycle equations retain the original finite fields. This is not target
authentication and no emptiness assertion is made merely by constructing it.
"""
import argparse,json,sys,time
from pathlib import Path
from sage.all import GF,PolynomialRing
sys.path.insert(0,'/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')
from field import mat_inv,transpose
from incidence import endpoint,phase_polynomials,f5rank

CW,EW,UW,VW=(13,3,9,2),(4,3,14,0),(22,24,12,11),(6,21,11,0)


def build_split(ep,field_equations=True):
    A=endpoint(ep)
    if f5rank(phase_polynomials(ep))!=2:raise ValueError('span-two source required')
    F=GF(5**56,name='z')
    T=PolynomialRing(F,'s');s=T.gen()
    beta=(s*s-s-3).roots(multiplicities=False)[0]
    b=lambda code:F(code%5)+(code//5)*beta
    xi=(s**7+b(24)*s**6+b(7)*s**5+b(21)*s**4+b(20)*s**3+b(7)*s**2+b(22)*s+b(4)).roots(multiplicities=False)[0]
    assert xi**29==1 and xi!=1
    t=(s**4-b(21)).roots(multiplicities=False)[0]
    k=lambda coeff:sum((b(c)*xi**i for i,c in enumerate(coeff)),F.zero())
    names=[f'e{r:02}{a}' for r in range(14) for a in range(4)]+[f'x{r:02}' for r in range(14)]+[f'y{r:02}' for r in range(14)]
    R=PolynomialRing(F,names=names,order='degrevlex')
    vs=R.gens();e=[list(vs[4*r:4*r+4]) for r in range(14)]
    X=list(vs[56:70]);Y=list(vs[70:84])
    tr=[t**(5**r) for r in range(14)]
    C={n:[[sum((k(A[n][l])**(5**r)*(tr[r]*F(2)**a)**l for l in range(4)),F.zero()) for a in range(4)] for r in range(14)] for n in A}
    constants={n:[[k(A[n][l])**(5**r) for l in range(4)] for r in range(14)] for n in A}
    inv=mat_inv(transpose((A['E1'][1:],A['C'][1:],A['U'][1:])))
    inverse=[[[k(inv[i][j])**(5**r) for j in range(3)] for i in range(3)] for r in range(14)]
    D=[[e[r][a]*(C['E1'][r][a]-X[(r+7)%14])+Y[(r+7)%14] for a in range(4)] for r in range(14)]
    G=[[e[r][a]*(C['C'][r][a]-Y[r])+X[r] for a in range(4)] for r in range(14)]
    def coeff(row,r,l):return F(4)/tr[r]**l*sum((F(2)**(-l*a)*row[r][a] for a in range(4)),R.zero())
    Z=[]
    for r in range(14):
        sr=(r+8)%14
        Z.append([sum((b(VW[l])**(5**r)/b(CW[l])**(5**sr)*coeff(D,sr,l)*(tr[r]*F(2)**a)**l for l in range(3)),R.zero()) for a in range(4)])
    W=[[X[(r+11)%14]-e[r][a]*(Z[r][a]+Y[(r+1)%14]) for a in range(4)] for r in range(14)]
    out=[];labels=[]
    def put(label,p):labels.append(label);out.append(p)
    for r in range(14):
        for a in range(4):put(f'original_third_{r}_{a}',e[r][a]*(C['U'][r][a]-X[(r+4)%14])+C['V'][r][a]+Y[(r+8)%14])
        put(f'G3_{r}',coeff(G,r,3))
        sh=(constants['E1'][r][0]-X[(r+7)%14],constants['C'][r][0]-Y[r],constants['U'][r][0]-X[(r+4)%14])
        ell=[sum((sh[i]*inverse[r][i][j] for i in range(3)),R.zero()) for j in range(3)]
        put(f'rank_lift_{r}',coeff(Z,r,0)+Y[(r+1)%14]-sum((ell[j]*coeff(Z,r,j+1) for j in range(3)),R.zero()))
        sr=(r+11)%14
        for l in range(3):put(f'W_G_{r}_{l}',coeff(W,r,l)-b(UW[l])**(5**r)/b(EW[l])**(5**sr)*coeff(G,sr,l))
    if field_equations:
        for r in range(14):
            put(f'X_field_{r}',X[r]**5-X[(r+1)%14])
            put(f'Y_field_{r}',Y[r]**5-Y[(r+1)%14])
            for a in range(4):put(f'epsilon_field_{r}_{a}',e[r][a]**5-(e[r+1][a] if r<13 else e[0][(a+3)%4]))
    return R,out,labels,{'beta':beta,'xi':xi,'t':t,'field':F,'embedded':k,'rows':{'D':D,'G':G,'W':W,'Z':Z}}


def main():
    p=argparse.ArgumentParser();p.add_argument('--source',required=True);p.add_argument('--solve',action='store_true')
    p.add_argument('--algorithm',default='singular:slimgb');p.add_argument('--output',type=Path,required=True)
    args=p.parse_args();ep=json.loads(args.source);start=time.monotonic()
    R,eq,labels,aux=build_split(ep)
    meta={'source':ep,'variables':84,'equations':len(eq),'terms':sum(len(p.monomials()) for p in eq),
          'degree':int(max(p.total_degree() for p in eq)),'build_seconds':time.monotonic()-start,
          'status':'exact necessary row/rank relaxation; undecided','algorithm':args.algorithm}
    # Compare against the direct marked circuit at three exact finite points.
    from source_system import build,evaluate
    from field import K,F as originalF
    import random
    spec=build(ep);rng=random.Random(101)
    for _ in range(3):
        inp=[K.decode(rng.randrange(5**14)) for i in range(6)]
        eps=sum((aux['embedded'](inp[l])*aux['t']**l for l in range(4)),aux['field'].zero())
        xx,yy=aux['embedded'](inp[4]),aux['embedded'](inp[5])
        point=[eps**(5**r*5**(42*a)) for r in range(14) for a in range(4)]+[xx**(5**r) for r in range(14)]+[yy**(5**r) for r in range(14)]
        direct=evaluate(spec,inp)
        for name,row in aux['rows'].items():
            original={'D':'C','G':'E1','W':'U','Z':'V'}[name]
            coords=[direct[g] for g in spec['prospective_rows'][original]]
            val=sum((aux['embedded'](coords[l])*aux['t']**l for l in range(4)),aux['field'].zero())
            for r in range(14):
                for a in range(4):assert row[r][a](*point)==val**(5**r*5**(42*a))
        assert all(eq[i](*point)==0 for i,n in enumerate(labels) if n.startswith(('X_field','Y_field','epsilon_field')))
        for r in range(14):
            third=[direct[spec['K_equations'][f'original_third_{l}']] for l in range(4)]
            val=sum((aux['embedded'](third[l])*aux['t']**l for l in range(4)),aux['field'].zero())
            for a in range(4):assert eq[9*r+a](*point)==val**(5**r*5**(42*a))
            remaining=['G3','actual_rank_lift']+[f'actual_W_G_{l}' for l in range(3)]
            for j,name in enumerate(remaining):
                assert eq[9*r+4+j](*point)==aux['embedded'](direct[spec['K_equations'][name]])**(5**r)
    meta['direct_point_checks']=3
    meta['coefficient_field_polynomial']=[int(c) for c in aux['field'].modulus()]
    meta['coefficient_marking']={name:[int(c) for c in aux[name].polynomial()] for name in ('beta','xi','t')}
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n')
    print(json.dumps(meta),flush=True)
    if args.solve:
        start=time.monotonic();gb=R.ideal(eq).groebner_basis(algorithm=args.algorithm)
        meta.update(solver_seconds=time.monotonic()-start,basis_length=len(gb),unit_ideal=gb==[R.one()])
        args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
