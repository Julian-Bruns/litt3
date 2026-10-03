#!/usr/bin/env sage
"""Exact eight-H-variable original row/rank relaxation, degree<=25.

Multiply the original WG row by (x11-U11); use y11=rho(y3). This removes
all variable-dependent WG reconstruction coefficients and the omitted return
condition of the earlier cross-minor model. Genuine target authentication is
still a separate exact final test. No root extraction is executed here.
"""
import argparse,json,random,sys,time
from pathlib import Path
from sage.all import PolynomialRing
sys.path.insert(0,str(Path(__file__).parent))
from polynomial_rank_resolvent import rank_polynomials
from real_subfield_system import subfield_data,evaluator
from field import K
from finite import phi
from incidence import endpoint
from source_mobius import resolvent_matrix,candidate_rows,fourth_row_residual,semilinear_projective_solutions,m2det
from source_system import build,evaluate


def build_product(ep):
    aux=rank_polynomials(ep);KK=aux['field'];HH,beta,toH,fromH,split=subfield_data(aux)
    P=PolynomialRing(KK,names=('x0','x1','y0','y1','v0','v1','u0','u1','saturation'),order='degrevlex')
    a,b,c,d,e,f,g,h,sat=P.gens();betabar=beta**5
    x=a+beta*b;y=c+beta*d;xb=a+betabar*b;yb=c+betabar*d
    v=e+beta*f;u=g+beta*h;x8=a**5+beta*b**5;y8=c**5+beta*d**5
    z=e**5+beta*f**5;t=g**5+beta*h**5
    ev=lambda poly,r,q:sum(P(coef**(5**r))*q**i for i,coef in enumerate(poly.list()))
    row=lambda name,r:[P(coef**(5**r)) for coef in aux['rows'][name]]
    def mul(left,right,r):
        out=[P.zero() for _ in range(4)];m=aux['b'](21)**(5**r)
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=left[i]*right[j]*(m if i+j>=4 else 1)
        return out
    third=y*(ev(aux['bn'],8,x8)*y8+ev(aux['a'],8,x8))-ev(aux['d'],8,x8)*y8-ev(aux['c'],8,x8)
    subst=[P.zero() for r in range(14)]
    for r,value in ((0,x),(3,v),(8,x8),(11,z)):subst[r]=value
    unev=lambda p:sum(coef(*subst)*y**i for i,coef in enumerate(p.list()))
    jn,jd=unev(aux['Jn']),unev(aux['Jd']);rank=yb*jd-jn
    VV=row('V',0);VV[0]+=y;en=mul([ev(p,0,x) for p in aux['adj']],VV,0);n0=ev(aux['norm'],0,x)
    eps8=[ev(aux['A'][i],8,x8)+ev(aux['B'][i],8,x8)*y for i in range(4)]
    ld=ev(aux['d'],8,x8)-ev(aux['bn'],8,x8)*y;hd=ev(aux['bn'],0,x)*y+ev(aux['a'],0,x)
    EE=row('E1',8);EE[0]-=z;ZZ=mul(eps8,EE,8)
    Z=[aux['b'](gamma)*ZZ[i] for i,gamma in enumerate((13,17,7))]+[P.zero()]
    Z[0]+=(aux['b'](13)+1)*yb*ld
    D=n0*ld;w=[-q for q in mul(en,Z,0)];w[0]+=xb*D
    delta=[aux['b'](k) for k in (8,18,15)]
    gt=[w[i]/delta[i] for i in range(3)]+[P.zero()];gt[0]-=xb*D
    U11,C11,V11=[row(name,11) for name in ('U','C','V')]
    left=mul([z-U11[0]]+[-q for q in U11[1:]],gt,11)
    vc=mul(V11,C11,11);L=[left[i]-vc[i]*D for i in range(4)]
    # Original product row: L=t*C11-u*V11-u*t in coordinate zero.
    product=[L[i]-D*(t*C11[i]-u*V11[i]-(u*t if i==0 else 0)) for i in range(4)]
    # Universal constant-denominator recovery; V3=0,C3,V2!=0.
    assert V11[3]==0 and C11[3] and V11[2]
    T=L[3]/C11[3];Un=(C11[2]*T-L[2])/V11[2]
    assert all(exp[6]==exp[7]==0 for pol in (D,T,Un) for exp in pol.dict())
    RH=PolynomialRing(HH,names=P.variable_names(),order='degrevlex')
    def splitpoly(pol):
        out=[{},{}]
        for exp,coef in pol.dict().items():
            for i,zcoef in enumerate(split(coef)):
                if zcoef:out[i][exp]=zcoef
        return [RH(q) for q in out]
    eq=[];labels=[]
    for name,pol in [('source_G3_after_rho',third),('actual_rank_lift',rank)]+[(f'original_WG_product_{i}',q) for i,q in enumerate(product)]:
        for i,part in enumerate(splitpoly(pol)):eq.append(part);labels.append((name,i))
    for name,pol in [('v_actual_phi3',v-x**125),('u_actual_phi3',u-y**125)]:
        for i,part in enumerate(splitpoly(pol)):eq.append(part);labels.append((name,i))
    pole=n0*ev(aux['A'][3],0,x)*hd;pbar=P({exp:coef**(5**7) for exp,coef in pole.dict().items()})
    normH=splitpoly(pole*pbar);assert not normH[1]
    eq.append(RH.gen(8)*normH[0]-1);labels.append(('supplied_open_source_saturation',0))
    for i in range(4):eq.append(RH.gen(i)**(5**7)-RH.gen(i));labels.append(('fundamental_H_field',i))
    # Six-H model remains in compact factored form; do not expand degree139
    # Frobenius return or degree44 quadratic compatibility into giant files.
    rho_poly=lambda pol:P({tuple(5*j for j in exp):coef**(5**8) for exp,coef in pol.dict().items()})
    six=dict(third=third,rank=rank,D=D,T=T,U=Un,L=L,C11=C11,V11=V11,
        coordinate1=L[1]-C11[1]*T+V11[1]*Un,
        u_actual=y**125*D-Un,rho_D=rho_poly(D),rho_U=rho_poly(Un))
    return RH,eq,labels,dict(aux=aux,field=HH,beta=beta,split=split,fromH=fromH,
        K_equations=[third,rank]+product,norm_saturation=normH[0],D=D,L=L,T=T,U=Un,
        x=x,y=y,v=v,u=u,z=z,t=t,Jd=jd,mul=mul,source=ep,six=six)


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args();ep=json.loads(args.source);start=time.monotonic();R,eq,labels,data=build_product(ep)
    aux=data['aux'];rng=random.Random(129);source=endpoint(ep);spec=build(ep);rankchecks=0
    for sample in range(4):
        while True:
            x=K.decode(rng.randrange(5**14));M,Rx=resolvent_matrix(source,x)
            if m2det(M)==K.zero:continue
            candidates,stats=semilinear_projective_solutions(M)
            if any(q is not None for q in candidates):y=next(q for q in candidates if q is not None);break
        rows,eps,X,Y=candidate_rows(source,x,y,Rx);assert rows['E1'][3]==K.zero
        values=[aux['embed'](q) for q in (x,y,phi(x,3),phi(y,3))]
        actual=tuple(sum((data['split'](q) for q in values),()))+(R.base_ring().zero(),)
        point=list(map(data['fromH'],actual));kev=evaluator(point);hev=evaluator(actual)
        rr=[aux['embed'](q)/aux['b'](weight) for q,weight in zip(fourth_row_residual(rows),(8,18,15))]+[aux['field'].zero()]
        factor=[aux['embed'](phi(x,11))-aux['embed'](phi(source['U'][0],11))]+[-aux['embed'](phi(q,11)) for q in source['U'][1:]]
        scaled=data['mul'](factor,rr,11);den=kev(data['D'])
        for i,pol in enumerate(data['K_equations'][2:]):assert kev(pol)==kev(scaled[i])*den
        direct=evaluate(spec,list(eps)+[X,Y]);original_rank=aux['embed'](direct[spec['K_equations']['actual_rank_lift']])
        assert kev(data['K_equations'][1])==original_rank*kev(data['Jd'])/aux['b'](14);rankchecks+=1
        for i,pol in enumerate(data['K_equations']):
            parts=data['split'](kev(pol));assert all(hev(eq[2*i+j])==parts[j] for j in range(2))
        inverse=hev(data['norm_saturation']);assert inverse
        actual=actual[:8]+(1/inverse,);ev=evaluator(actual);assert all(ev(pol)==0 for pol in eq[12:])
        # Recovery formula is exactly the constant-coefficient linear solve,
        # even when the prospective original WG residuals do not vanish.
        C,V=[list(map(aux['embed'],source[n])) for n in ('C','V')]
        C11=[q**(5**11) for q in C];V11=[q**(5**11) for q in V]
        trec=kev(data['T'])/den;urec=kev(data['U'])/den;LL=[kev(q)/den for q in data['L']]
        assert LL[3]==C11[3]*trec and LL[2]==C11[2]*trec-V11[2]*urec
    six=data['six']
    meta=dict(source=ep,H_size=5**7,H_variables=8,variables_including_saturation=R.ngens(),equations=len(eq),
        degrees=[int(p.total_degree()) for p in eq],terms=[len(p.monomials()) for p in eq],
        original_G3_points=4,original_rank_checks=rankchecks,original_WG_product_coordinate_checks=16,
        omitted_return_conditions=[],six_H_factored_model=dict(H_variables=6,
            denominator_degree=int(six['D'].total_degree()),T_numerator_degree=int(six['T'].total_degree()),
            U_numerator_degree=int(six['U'].total_degree()),coordinate1_degree=int(six['coordinate1'].total_degree()),
            u_actual_return_degree=int(six['u_actual'].total_degree()),t_rho_return_degree_bound=139,coordinate0_degree_bound=44),
        seconds=time.monotonic()-start,
        scope='EXACT original source row/rank relaxation on supplied source opens; target authentication absent; no root extraction')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
