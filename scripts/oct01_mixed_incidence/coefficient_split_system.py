#!/usr/bin/env sage
"""Sparse coefficient-conjugate source relaxation over K=F_(5^14).

Four independent14-cycles represent the four Kummer coefficients of epsilon.
Actual moments, row constants, and all nine mandatory K identities are retained.
"""
import argparse,json,random,sys,time
from pathlib import Path
from sage.all import GF,PolynomialRing
sys.path.insert(0,'/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')
from field import K,mat_inv,transpose
from incidence import endpoint,phase_polynomials,f5rank
from source_system import build,evaluate
CW,EW,UW,VW=(13,3,9,2),(4,3,14,0),(22,24,12,11),(6,21,11,0)


def build_coefficient_split(ep,direction=False,complete=False):
    A=endpoint(ep)
    if f5rank(phase_polynomials(ep))!=2:raise ValueError('span-two source required')
    KK=GF(5**14,name='z');T=PolynomialRing(KK,'s');s=T.gen()
    beta=(s*s-s-3).roots(multiplicities=False)[0]
    b=lambda code:KK(code%5)+(code//5)*beta
    xi=(s**7+b(24)*s**6+b(7)*s**5+b(21)*s**4+b(20)*s**3+b(7)*s**2+b(22)*s+b(4)).roots(multiplicities=False)[0]
    assert xi**29==1 and xi!=1
    k=lambda coeff:sum((b(c)*xi**i for i,c in enumerate(coeff)),KK.zero())
    names=[f'e{r:02}{l}' for r in range(14) for l in range(4)]+[f'x{r:02}' for r in range(14)]+[f'y{r:02}' for r in range(14)]
    R=PolynomialRing(KK,names=names,order='degrevlex');v=R.gens()
    eps=[list(v[4*r:4*r+4]) for r in range(14)];X=list(v[56:70]);Y=list(v[70:84])
    rows={n:[[k(A[n][l])**(5**r) for l in range(4)] for r in range(14)] for n in A}
    inv=mat_inv(transpose((A['E1'][1:],A['C'][1:],A['U'][1:])))
    inverse=[[[k(inv[i][j])**(5**r) for j in range(3)] for i in range(3)] for r in range(14)]
    def mul(a,c,r):
        out=[R.zero()]*4;m=b(21)**(5**r)
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=a[i]*c[j]*(m if i+j>=4 else 1)
        return out
    D=[];G=[];third=[]
    for r in range(14):
        dd=mul(eps[r],rows['E1'][r],r);gg=mul(eps[r],rows['C'][r],r);uu=mul(eps[r],rows['U'][r],r)
        for l in range(4):
            dd[l]-=X[(r+7)%14]*eps[r][l]
            gg[l]-=Y[r]*eps[r][l]
            uu[l]+=-X[(r+4)%14]*eps[r][l]+rows['V'][r][l]
        dd[0]+=Y[(r+7)%14];gg[0]+=X[r];uu[0]+=Y[(r+8)%14]
        D.append(dd);G.append(gg);third.append(uu)
    Z=[[b(VW[l])**(5**r)/b(CW[l])**(5**((r+8)%14))*D[(r+8)%14][l] if l<3 else R.zero() for l in range(4)] for r in range(14)]
    W=[]
    for r in range(14):
        zz=Z[r][:];zz[0]+=Y[(r+1)%14]
        ww=[-q for q in mul(eps[r],zz,r)];ww[0]+=X[(r+11)%14];W.append(ww)
    eq=[];labels=[]
    def put(name,p):labels.append(name);eq.append(p)
    for r in range(14):
        for l in range(4):put(f'original_third_{r}_{l}',third[r][l])
        put(f'G3_{r}',G[r][3])
        sh=(rows['E1'][r][0]-X[(r+7)%14],rows['C'][r][0]-Y[r],rows['U'][r][0]-X[(r+4)%14])
        ell=[sum((sh[i]*inverse[r][i][j] for i in range(3)),R.zero()) for j in range(3)]
        put(f'rank_lift_{r}',Z[r][0]+Y[(r+1)%14]-sum((ell[j]*Z[r][j+1] for j in range(3)),R.zero()))
        for l in range(3):put(f'W_G_{r}_{l}',W[r][l]-b(UW[l])**(5**r)/b(EW[l])**(5**((r+11)%14))*G[(r+11)%14][l])
    for r in range(14):
        put(f'X_field_{r}',X[r]**5-X[(r+1)%14]);put(f'Y_field_{r}',Y[r]**5-Y[(r+1)%14])
        for l in range(4):put(f'epsilon_field_{r}_{l}',eps[r][l]**5-eps[(r+1)%14][l])
    aux={'field':KK,'beta':beta,'xi':xi,'embedded':k,'rows':{'C':D,'E1':G,'U':W,'V':Z}}
    if direction:
        S=PolynomialRing(KK,names=[f'd{r:02}{l}' for r in range(14) for l in range(4)],order='degrevlex')
        ds=S.gens();dr=[list(ds[4*r:4*r+4]) for r in range(14)]
        maps=[]
        for r in range(14):maps.extend([dr[r][3]*dr[r][l] for l in range(3)]+[dr[r][3]])
        for r in range(14):
            sr=(r+10)%14
            maps.append(rows['U'][sr][0]+sum((rows['U'][sr][3-l]*dr[sr][l] for l in range(3)),S.zero()))
        for r in range(14):maps.append(rows['C'][r][0]+sum((rows['C'][r][3-l]*dr[r][l] for l in range(3)),S.zero()))
        hom=R.hom(maps,S)
        selected=[i for i,n in enumerate(labels[:126]) if not n.startswith('G3')
                  and not (n.startswith('original_third') and n.endswith('_3'))]
        # The dropped third-coordinate andG3 polynomials vanish identically.
        assert all(hom(eq[i])==0 for i in range(126) if i not in selected)
        eq=[hom(eq[i]) for i in selected];labels=[labels[i] for i in selected]
        for r in range(14):
            for l in range(4):eq.append(dr[r][l]**5-dr[(r+1)%14][l]);labels.append(f'direction_field_{r}_{l}')
        aux['rows']={n:[[hom(q) for q in row] for row in rr] for n,rr in aux['rows'].items()}
        R=S
    if complete:
        # Full target support removes the need for Moore determinant charts:
        # both-span-at-most-two rank exclusion then forces target span three.
        old_count=R.ngens();S=PolynomialRing(KK,names=list(R.variable_names())+[f'n{r:02}' for r in range(14)],order='degrevlex')
        sv=S.gens();hom=R.hom(sv[:old_count],S);iv=list(sv[old_count:]);R=S
        eq=[hom(q) for q in eq]
        aux['rows']={n:[[hom(q) for q in row] for row in rr] for n,rr in aux['rows'].items()}
        DD,WW=aux['rows']['C'],aux['rows']['U']
        cs=[[sum((KK(4)*KK(2)**(-l*i)*DD[r][l]/b(CW[l])**(5**r) for l in range(4)),R.zero()) for r in range(14)] for i in range(4)]
        us=[[sum((KK(4)*KK(2)**(-l*i)*WW[r][l]/b(UW[l])**(5**r) for l in range(4)),R.zero()) for r in range(14)] for i in range(4)]
        for i in range(4):
            for r in range(14):
                c,su,cb=cs[i][r],us[i][(r+9)%14],cs[i][(r+7)%14]
                eq.extend((cb*(c*c-su)-2*c,c*c*c-3*c*su+2*us[i][(r+13)%14]))
                labels.extend((f'auth_first_{i}_{r}',f'auth_second_{i}_{r}'))
        delta=sum((c[0]*c[8]*c[9]-c[0]*c[7]-c[8]*c[1]-c[9]*c[2] for c in cs),R.zero())
        eq.append(delta-4);labels.append('four_pairs_count')
        for r in range(14):
            eq.extend((iv[r]*DD[r][1]*DD[r][2]*DD[r][3]-1,iv[r]**5-iv[(r+1)%14]))
            labels.extend((f'target_support_{r}',f'inverse_field_{r}'))
        aux.update(root_C_sums=cs,root_U_sums=us)
    return R,eq,labels,aux


def main():
    p=argparse.ArgumentParser();p.add_argument('--source',required=True);p.add_argument('--output',type=Path,required=True)
    p.add_argument('--solve',action='store_true');p.add_argument('--algorithm',default='singular:slimgb')
    p.add_argument('--direction',action='store_true')
    p.add_argument('--complete',action='store_true')
    args=p.parse_args();ep=json.loads(args.source);start=time.monotonic()
    R,eq,labels,aux=build_coefficient_split(ep,args.direction,args.complete);rng=random.Random(103);spec=build(ep)
    for _ in range(3):
        if args.direction:
            sys.path.insert(0,str(Path(__file__).parent))
            from direction_system import check_direct
            direction_inputs=[K.decode(rng.randrange(5**14)) for i in range(4)]
            inp=check_direct(ep,direction_inputs)
            point=[aux['embedded'](direction_inputs[l])**(5**r) for r in range(14) for l in range(4)]
        else:
            inp=[K.decode(rng.randrange(5**14)) for i in range(6)]
            point=[aux['embedded'](inp[l])**(5**r) for r in range(14) for l in range(4)]+[aux['embedded'](inp[4])**(5**r) for r in range(14)]+[aux['embedded'](inp[5])**(5**r) for r in range(14)]
        direct=evaluate(spec,inp)
        if args.complete:
            inverse_input=K.decode(rng.randrange(5**14))
            point.extend(aux['embedded'](inverse_input)**(5**r) for r in range(14))
        for r in range(14):
            original=([f'original_third_{l}' for l in range(3)]+['actual_rank_lift'] if args.direction else [f'original_third_{l}' for l in range(4)]+['G3','actual_rank_lift'])+[f'actual_W_G_{l}' for l in range(3)]
            for j,name in enumerate(original):assert eq[len(original)*r+j](*point)==aux['embedded'](direct[spec['K_equations'][name]])**(5**r)
            for name,row in aux['rows'].items():
                for l in range(4):assert row[r][l](*point)==aux['embedded'](direct[spec['prospective_rows'][name][l]])**(5**r)
        assert all(q(*point)==0 for q,name in zip(eq,labels) if 'field' in name)
        if args.complete:
            from finite import phi
            from field import BINV,bm
            cs=[];us=[]
            for i in range(4):
                c=K.zero;u=K.zero
                for l in range(4):
                    scale=4*pow(2,-l*i,5)%5
                    c=K.add(c,K.scale(direct[spec['prospective_rows']['C'][l]],bm(scale,BINV[CW[l]])))
                    u=K.add(u,K.scale(direct[spec['prospective_rows']['U'][l]],bm(scale,BINV[UW[l]])))
                cs.append(c);us.append(u)
                for r in range(14):
                    assert aux['root_C_sums'][i][r](*point)==aux['embedded'](phi(c,r))
                    assert aux['root_U_sums'][i][r](*point)==aux['embedded'](phi(u,r))
                    su=phi(u,9);first=K.sub(K.mul(phi(c,7),K.sub(K.mul(c,c),su)),K.scale(c,2))
                    second=K.add(K.sub(K.mul(K.mul(c,c),c),K.scale(K.mul(c,su),3)),K.scale(phi(su,4),2))
                    pos=labels.index(f'auth_first_{i}_{r}');assert eq[pos](*point)==aux['embedded'](phi(first,r));assert eq[pos+1](*point)==aux['embedded'](phi(second,r))
    meta={'source':ep,'variables':R.ngens(),'equations':len(eq),'terms':sum(len(p.monomials()) for p in eq),
          'degree':int(max(p.total_degree() for p in eq)),'build_check_seconds':time.monotonic()-start,
          'status':'exact full incidence model (E restored globally); undecided' if args.complete else 'exact necessary row/rank relaxation; undecided','direct_point_checks':3,'algorithm':args.algorithm,
          'coefficient_field_polynomial':[int(c) for c in aux['field'].modulus()],
          'coefficient_marking':{n:[int(c) for c in aux[n].polynomial()] for n in ('beta','xi')}}
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)
    if args.solve:
        start=time.monotonic();gb=R.ideal(eq).groebner_basis(algorithm=args.algorithm)
        meta.update(solver_seconds=time.monotonic()-start,basis_length=len(gb),unit_ideal=gb==[R.one()])
        args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
