#!/usr/bin/env sage-python
"""Independent actual W2 corrected-frame audit for a generalized neutral model.

Reconstruct the stored matrices in the nonsplit double algebra and check
their determinant, covariant derivatives, and original corrected Hodge line.
Uses Sage arithmetic only, not the producer Laurent or convolution engines.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time

from sage.all import GF, Integers, LaurentSeriesRing, PolynomialRing


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--model',required=True); ap.add_argument('--run',required=True)
    ap.add_argument('--precision',type=int,default=350); ap.add_argument('--output',required=True)
    args=ap.parse_args(); start=time.monotonic(); run=Path(args.run)
    model=json.loads(Path(args.model).read_text())
    first=json.loads((run/'genus6_first_stage.json').read_text())
    localpath=run/'genus6_local_comparison.json'; local=json.loads(localpath.read_text())
    previous=next(a for a in json.loads(Path('Research/computations/dihedral5_family_model_independent_audit.json').read_text())['rows'] if a['label']==model['label'])
    assert previous['entire_first_marking_and_flat_comparison']
    fp=PolynomialRing(GF(5),'t'); k=GF(625,'t',modulus=fp(model['field_modulus'])); t=k.gen()
    pol=PolynomialRing(k,'s'); s=pol.gen(); fpoly=lambda name:pol([k(a) for a in model[name]])
    G=fpoly('hyperelliptic_polynomial'); L=fpoly('double_polynomial'); ldeg=L.degree()
    def unram(n):
        b=PolynomialRing(Integers(n),'T'); return b.quotient(b(model['field_modulus']),'T')
    O3=unram(125); T3=O3.gen(); O=unram(25); T=O.gen()
    encode=lambda a,n:[int(a.lift()[i])%n for i in range(4)]
    c3=lambda a:sum(O3(int(x))*T3**i for i,x in enumerate(a))
    c=lambda a:sum(O(int(x))*T**i for i,x in enumerate(a))
    lf3=lambda a:c3([int(a.polynomial()[i]) for i in range(4)])
    lf=lambda a:c([int(a.polynomial()[i]) for i in range(4)])
    sig=T3**5
    for _ in range(4):sig-=(sig**4+4*sig**3+sig**2+4*sig+3)/(4*sig**3+12*sig**2+2*sig+4)
    sigcoeff=lambda a:sum(O3(int(a.polynomial()[i]))*sig**i for i in range(4))
    mp3=PolynomialRing(O3,'s'); sm3=mp3.gen(); mp=PolynomialRing(O,'s'); sm=mp.gen()
    G3=mp3([lf3(a) for a in G]); GS=mp3([sigcoeff(a) for a in G]); GG=mp([lf(a) for a in G])
    fu=sm3**5; bv=G3**2; inv=(G.derivative()**5).inverse_mod(G**3)
    for power in [5,25]:
        err=GS(fu)-G3*bv*bv; ee=[]
        for a in err:
            ac=encode(a,125); assert all(x%power==0 for x in ac)
            ee.append(k([x//power%5 for x in ac]))
        E=pol(ee); aa=(-E*inv).mod(G**3)
        bb,rem=(E+G.derivative()**5*aa).quo_rem(2*G**3); assert rem==0
        fu+=power*mp3([lf3(x) for x in aa]); bv+=power*mp3([lf3(x) for x in bb])
    assert GS(fu)-G3*bv*bv==0
    num=[]
    for a in fu.derivative():
        aa=encode(a,125); assert all(x%5==0 for x in aa)
        num.append(c([x//5%25 for x in aa]))
    num=mp(num); den=mp([c(encode(a,25)) for a in bv])
    num0=pol([k(encode(a,5)) for a in num]); den0=pol([k(encode(a,5)) for a in den])
    zeta0,rem=num0.quo_rem(den0); assert rem==0
    zetau=mp([lf(a) for a in zeta0]); rr=num-zetau*den; rr1=[]
    for a in rr:
        aa=encode(a,25); assert all(x%5==0 for x in aa); rr1.append(k([x//5 for x in aa]))
    zeta1,rem=pol(rr1).quo_rem(den0); assert rem==0
    zetau+=5*mp([lf(a) for a in zeta1]); assert num-zetau*den==0
    print('Independent affine Frobenius connection rebuilt',model['label'],flush=True)
    RR=mp([c(a) for a in first['double_polynomial_lift']])
    assert pol([k(encode(a,5)) for a in RR])==L
    SC,rem=GG.quo_rem(RR); assert rem==0
    mu=c(first['mu']); mui=~mu; N=args.precision
    ls=LaurentSeriesRing(O,'z',default_prec=N+200); z=ls.gen()
    def invseries(f):
        valuation=int(f.valuation()); lead=f[valuation]
        unit=f*z**(-valuation)*(~lead); assert unit[0]==1
        return (~lead)*unit**(-1)*z**(-valuation)
    rev=mp(list(reversed(GG.list()))); x=GG.leading_coefficient()*z*z
    for _ in range(12):x=(x-(x-z*z*rev(x))/(1-z*z*rev.derivative()(x))).add_bigoh(N+150)
    u=invseries(x); Y=u**6/z; eta=-z*x**4*x.derivative()
    ww2=RR(u)*z**(2*ldeg); lead0=k(encode(ww2[0],5))
    root0=next(k([j%5,(j//5)%5,(j//25)%5,j//125]) for j in range(625)
               if k([j%5,(j//5)%5,(j//25)%5,j//125])**2==lead0)
    wc=lf(root0)
    for _ in range(3):wc=(wc+ww2[0]/wc)/2
    assert wc*wc==ww2[0]
    unit=ww2*(~(wc*wc)); ws=ls(1)
    for _ in range(11):ws=((ws+unit/ws)/2).add_bigoh(N+100)
    ww=wc*ws/z**ldeg; yy=Y*invseries(ww)
    print('Independent mixed-characteristic double series rebuilt',flush=True)
    def load(a):
        lo=a['low']; precision=min(a['precision'],N)
        cc=[c(v) for v in a['coefficients'][:max(0,precision-lo)]]
        return (ls(cc,prec=precision-lo)*z**lo).add_bigoh(precision)
    UU=[[load(a) for a in row] for row in local['I2U']]
    OO=[[load(a) for a in row] for row in local['I2O']]
    upowers=[ls(1)]
    for i in range(110):upowers.append(upowers[-1]*u)
    def af_reduce(a,anti):
        f=a; pp=mp(0); qq=mp(0)
        for j in range(int(f.valuation()),1):
            cc=f[j]
            if not cc:continue
            if anti:
                if j<=-ldeg and (j+ldeg)%2==0:kind=0; degree=(-j-ldeg)//2; base=ww*upowers[degree]
                elif j<=-(13-ldeg) and (j+13-ldeg)%2==0:kind=1; degree=(-j-13+ldeg)//2; base=yy*upowers[degree]
                else:raise AssertionError(('non-affine anti pole',j,cc))
            else:
                if j<=-13 and j%2:kind=1; degree=(-j-13)//2; base=Y*upowers[degree]
                elif not j%2:kind=0; degree=-j//2; base=upowers[degree]
                else:raise AssertionError(('non-affine ordinary pole',j,cc))
            coefficient=cc/base[j]
            if kind==0:pp+=coefficient*sm**degree
            else:qq+=coefficient*sm**degree
            f-=coefficient*base
        assert f.add_bigoh(200)==0,('affine reconstruction',anti,f.valuation())
        return (pp,qq)
    AA=[[af_reduce(a,True) for a in row] for row in UU]
    normal=af_reduce(load(local['first_hodge_normal_U']),False)
    add=lambda a,b:(a[0]+b[0],a[1]+b[1])
    neg=lambda a:(-a[0],-a[1])
    sub=lambda a,b:add(a,neg(b))
    scale=lambda a,f:(a[0]*f,a[1]*f)
    deriv=lambda a:(SC*a[1].derivative()+SC.derivative()*a[1]/2,RR*a[0].derivative()+RR.derivative()*a[0]/2)
    aprod=lambda a,b:(RR*a[0]*b[0]+SC*a[1]*b[1],a[0]*b[1]+a[1]*b[0])
    eprod=lambda a,b:(a[0]*b[0]+GG*a[1]*b[1],a[0]*b[1]+a[1]*b[0])
    epanti=lambda a,b:(a[0]*b[0]+SC*a[1]*b[1],a[0]*b[1]+RR*a[1]*b[0])
    assert sub(aprod(AA[0][0],AA[1][1]),aprod(AA[0][1],AA[1][0]))==(mp(mui),mp(0))
    assert AA[0][0]==add(neg(deriv(AA[0][1])),scale(AA[1][1],zetau))
    assert AA[1][0]==neg(deriv(AA[1][1]))
    pp=mp([c(a) for a in previous['first_bezout_p']]); pq=mp([c(a) for a in previous['first_bezout_q']])
    qU=(mp(0),mp([c(a) for a in previous['first_affine_comparison']]))
    kp=mp([lf(a) for a in fpoly('double_section')]); bp=mp([lf(a) for a in fpoly('double_derivative')])
    avec=(kp,mp(0)); bvec=(mp(0),bp); cvec=(mp(0),-bp*pq); dvec=(kp*pp,mp(0))
    hh=[AA[0][1],AA[1][1]]; mh=[sub(hh[0],epanti(qU,hh[1])),hh[1]]
    sh0=add(aprod(avec,mh[0]),scale(aprod(cvec,mh[1]),mu))
    sh1=add(aprod(bvec,mh[0]),scale(aprod(dvec,mh[1]),mu))
    assert sub(sh0,scale(eprod(normal,sh1),5))==(mp(0),mp(0))
    print('PASS exact affine determinant, covariant derivative and original corrected line',flush=True)
    sig2=c(encode(sig,25))
    cfrob=lambda a:sum(O(int(a.lift()[i]))*sig2**i for i in range(4))
    def frob(f):
        vals={5*i:cfrob(f[i]) for i in range(int(f.valuation()),int(f.prec())) if f[i]}
        return ls(vals).add_bigoh(5*f.prec())
    eo=eta/z**10; zetao=frob(eo)*z**4
    for row in OO:
        for a in row:assert a.valuation()>=0
    assert (OO[0][0]*OO[1][1]-OO[0][1]*OO[1][0]-mui).add_bigoh(200)==0
    assert (OO[0][0]+(OO[0][1].derivative()-zetao*OO[1][1])*invseries(eo)).add_bigoh(180)==0
    assert (OO[1][0]+OO[1][1].derivative()*invseries(eo)).add_bigoh(180)==0
    polyencode=lambda p:[encode(a,25) for a in p]
    result=dict(status='PASS independent generalized corrected W2 frames',label=model['label'],
                producer_code_imported=False,model_sha256=hashlib.sha256(Path(args.model).read_bytes()).hexdigest(),
                local_comparison_sha256=hashlib.sha256(localpath.read_bytes()).hexdigest(),
                double_degree=int(ldeg),formal_chart=previous['formal_oper_chart'],
                exact_affine_determinant=True,exact_affine_covariant_derivative=True,
                exact_actual_corrected_Hodge_line=True,formal_check_exclusive_exponent=180,
                affine_reconstruction_check_exclusive_exponent=200,precision=N,
                affine_frames=[[[polyencode(a) for a in entry] for entry in row] for row in AA],
                source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                seconds=time.monotonic()-start,
                scope='Changed double and corrected W2 frames independently checked; full W4 transition covered by source audit and parent production replays')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('PASS independent formal W2 normalization through exponent180; seconds',result['seconds'],flush=True)


if __name__=='__main__':main()
