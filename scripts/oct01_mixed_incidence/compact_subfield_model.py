#!/usr/bin/env sage
"""Eight H variables, exact WG elimination with reconstruction returns.

The small polynomial system is necessary. Its H-points become exactly the
original row/rank relaxation only after the explicitly recorded y11 return and
denominator tests. Target pairs are authenticated separately.
"""
import argparse,json,random,sys,time
from pathlib import Path
from sage.all import PolynomialRing
sys.path.insert(0,str(Path(__file__).parent))
from polynomial_rank_resolvent import rank_polynomials
from real_subfield_system import subfield_data,evaluator
from field import K,F
from finite import phi
from incidence import endpoint
from source_mobius import resolvent_matrix,candidate_rows,fourth_row_residual,semilinear_projective_solutions,m2det
from source_rank_resolvent import rank_lift_map
from source_system import build,evaluate


def plucker_polynomials(aux):
    KK=aux['field'];S=PolynomialRing(KK,names=('z','u'),order='degrevlex');z,u=S.gens()
    ph=lambda p:sum(S(c**(5**11))*z**i for i,c in enumerate(p.list()))
    m=aux['b'](21)**(5**11)
    def mul(left,right):
        out=[S.zero() for _ in range(4)]
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=left[i]*right[j]*(m if i+j>=4 else 1)
        return out
    CC=[S(c**(5**11)) for c in aux['rows']['C']];CC[0]-=u
    VV=[S(c**(5**11)) for c in aux['rows']['V']]
    h=mul([ph(p) for p in aux['adj']],CC);a=mul(h,VV);n=ph(aux['norm'])
    minors={}
    for i,j in ((0,1),(0,2),(1,2)):
        q,r=(h[j]*a[i]-h[i]*a[j]).quo_rem(n);assert not r
        assert q.degree(z)<=2 and q.degree(u)<=2
        minors[i,j]=q
    return dict(ring=S,h=h,a=a,norm=n,minors=minors)


def build_compact(ep):
    aux=rank_polynomials(ep);KK=aux['field'];HH,beta,toH,fromH,split=subfield_data(aux)
    P=PolynomialRing(KK,names=('x0','x1','y0','y1','v0','v1','u0','u1','saturation'),order='degrevlex')
    a,b,c,d,e,f,g,h,sat=P.gens();betabar=beta**5
    x=a+beta*b;y=c+beta*d;xb=a+betabar*b;yb=c+betabar*d
    v=e+beta*f;u=g+beta*h;x8=a**5+beta*b**5;y8=c**5+beta*d**5;z=e**5+beta*f**5
    phpoly=lambda poly,r,q:sum(P(coef**(5**r))*q**i for i,coef in enumerate(poly.list()))
    row=lambda name,r:[P(coef**(5**r)) for coef in aux['rows'][name]]
    def mul(left,right,r):
        out=[P.zero() for _ in range(4)];m=aux['b'](21)**(5**r)
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=left[i]*right[j]*(m if i+j>=4 else 1)
        return out
    third=y*(phpoly(aux['bn'],8,x8)*y8+phpoly(aux['a'],8,x8))-phpoly(aux['d'],8,x8)*y8-phpoly(aux['c'],8,x8)
    subst=[P.zero() for r in range(14)]
    for r,value in ((0,x),(3,v),(8,x8),(11,z)):subst[r]=value
    unev=lambda p:sum(coef(*subst)*y**i for i,coef in enumerate(p.list()))
    jn,jd=unev(aux['Jn']),unev(aux['Jd']);rank=yb*jd-jn
    adj=[phpoly(p,0,x) for p in aux['adj']];VV=row('V',0);VV[0]+=y
    en=mul(adj,VV,0);n0=phpoly(aux['norm'],0,x)
    eps8=[phpoly(aux['A'][i],8,x8)+phpoly(aux['B'][i],8,x8)*y for i in range(4)]
    ld=phpoly(aux['d'],8,x8)-phpoly(aux['bn'],8,x8)*y
    EE=row('E1',8);EE[0]-=z
    ZZ=mul(eps8,EE,8)
    Z=[aux['b'](gamma)*ZZ[i] for i,gamma in enumerate((13,17,7))]+[P.zero()]
    Z[0]+=(aux['b'](13)+1)*yb*ld
    wd=n0*ld;wn=[-q for q in mul(en,Z,0)];wn[0]+=xb*wd
    pp=plucker_polynomials(aux)
    hp=[pol(z,u) for pol in pp['h']];ap=[pol(z,u) for pol in pp['a']];n11=pp['norm'](z,u)
    delta=[aux['b'](k) for k in (8,18,15)]
    wt=[wn[i]/delta[i]-(xb*wd if i==0 else 0) for i in range(3)]
    minors=[]
    for i,j in ((0,1),(0,2),(1,2)):
        minors.append(hp[j]*wt[i]-hp[i]*wt[j]-pp['minors'][i,j](z,u)*wd)
    RH=PolynomialRing(HH,names=P.variable_names(),order='degrevlex')
    def splitpoly(pol):
        parts=[{},{}]
        for exp,coef in pol.dict().items():
            for i,zcoef in enumerate(split(coef)):
                if zcoef:parts[i][exp]=zcoef
        return [RH(q) for q in parts]
    eq=[];labels=[]
    for name,pol in [('source_G3_after_rho',third),('actual_rank_lift',rank)]+[(f'WG_cross_minor_{i}',q) for i,q in enumerate(minors)]:
        for part,polH in enumerate(splitpoly(pol)):eq.append(polH);labels.append((name,part))
    for name,pol in [('v_actual_phi3',v-(a**125+betabar*b**125)),('u_actual_phi3',u-(c**125+betabar*d**125))]:
        for part,polH in enumerate(splitpoly(pol)):eq.append(polH);labels.append((name,part))
    # The incoming COMPLETE singular-first-moment exclusion permits A3!=0.
    # Hd=n0*epsilon3 is nonzero on every remaining actual source completion.
    # Saturate these supplied open conditions explicitly, rather than leaving
    # their rational-map base points in a geometric relaxation.
    hd=phpoly(aux['bn'],0,x)*y+phpoly(aux['a'],0,x)
    a3=phpoly(aux['A'][3],0,x)
    pole=n0*a3*hd
    nbar=P({exp:coef**(5**7) for exp,coef in pole.dict().items()})
    normH=splitpoly(pole*nbar);assert not normH[1]
    eq.append(RH.gen(8)*normH[0]-1);labels.append(('norm_denominator_saturation',0))
    for i in range(4):eq.append(RH.gen(i)**(5**7)-RH.gen(i));labels.append(('fundamental_H_field',i))
    return RH,eq,labels,dict(aux=aux,field=HH,beta=beta,split=split,fromH=fromH,
        K_equations=[third,rank]+minors,norm_saturation=normH[0],source=ep,
        removed_denominators=('quartic_norm','inherited_singular_first_moment','inherited_epsilon3_zero'),
        h=hp,a=ap,n11=n11,wn=wn,wd=wd,ld=ld,Jd=jd,
        reconstruction_numerators=[n11*wt[i]-ap[i]*wd for i in range(3)],
        reconstruction_denominators=[hp[i]*wd for i in range(3)],plucker=pp)


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args();ep=json.loads(args.source);start=time.monotonic();R,eq,labels,data=build_compact(ep)
    aux=data['aux'];rng=random.Random(126);checks=0;rankchecks=0;source=endpoint(ep);spec=build(ep)
    for sample in range(4):
        # Also verify rank equivalence on original G3 points, not just a formal
        # rational-map comparison away from the third equation.
        while True:
            x=K.decode(rng.randrange(5**14));M,Rx=resolvent_matrix(source,x)
            if m2det(M)==K.zero:continue
            candidates,stats=semilinear_projective_solutions(M)
            if any(q is not None for q in candidates):
                y=next(q for q in candidates if q is not None);break
        rows,eps,X,Y=candidate_rows(source,x,y,Rx)
        assert rows['E1'][3]==K.zero
        values=[aux['embed'](q) for q in (x,y,phi(x,3),phi(y,3))]
        actual=tuple(sum((data['split'](q) for q in values),()))+(R.base_ring().zero(),)
        point=list(map(data['fromH'],actual));kev=evaluator(point);hev=evaluator(actual)
        res=[aux['embed'](q) for q in fourth_row_residual(rows)]
        hp=[kev(p) for p in data['h']];wd=kev(data['wd']);delta=[aux['b'](k) for k in (8,18,15)]
        for k,(i,j) in enumerate(((0,1),(0,2),(1,2))):
            assert kev(data['K_equations'][k+2])==wd*(hp[j]*res[i]/delta[i]-hp[i]*res[j]/delta[j])
        # Native source invariants prove this coefficient vector is never zero.
        assert any(hp[:3])
        if rows['E1'][3]==K.zero and kev(data['Jd']):
            inp=list(eps)+[X,Y];direct=evaluate(spec,inp)
            rr=aux['embed'](direct[spec['K_equations']['actual_rank_lift']])
            assert kev(data['K_equations'][1])==rr*kev(data['Jd'])/aux['b'](14)
            rankchecks+=1
        for i,pol in enumerate(data['K_equations']):
            components=data['split'](kev(pol));assert all(hev(eq[2*i+j])==components[j] for j in range(2))
        denominator=hev(data['norm_saturation']);assert denominator
        actual=actual[:8]+(1/denominator,);ev=evaluator(actual)
        assert all(ev(q)==0 for q in eq[10:])
        checks+=1
    meta=dict(source=ep,H_size=5**7,H_variables=8,variables_including_saturation=R.ngens(),equations=len(eq),
        degrees=[int(p.total_degree()) for p in eq],terms=[len(p.monomials()) for p in eq],
        field_point_checks=checks,original_rank_checks_on_G3_locus=rankchecks,
        plucker_degrees={str(k):[int(p.degree(data['plucker']['ring'].gen(0))),int(p.degree(data['plucker']['ring'].gen(1)))] for k,p in data['plucker']['minors'].items()},
        reconstruction_charts=3,omitted_condition='reconstructed y11 must have phi3 return y; tested explicitly on each extracted root',
        seconds=time.monotonic()-start,scope='compact necessary polynomial model with exact root-verification algorithm; no root extraction/emptiness execution')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
