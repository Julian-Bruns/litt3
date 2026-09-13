#!/usr/bin/env sage-python
"""Independent algebraic audit of the actual corrected Hodge frames.

Rebuild affine anti-invariant polynomials over W2 from their stored
expansions, then check their connection normalization exactly in the
actual double algebra. No producer arithmetic module is imported.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time

from sage.all import GF, Integers, LaurentSeriesRing, PolynomialRing


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--archive',required=True)
    ap.add_argument('--run',default='runs/base')
    ap.add_argument('--precision',type=int,default=600)
    ap.add_argument('--output',default='Research/computations/neutral5_corrected_frames_independent_audit.json')
    args=ap.parse_args(); start=time.monotonic()
    root=Path(args.archive)
    model=json.loads((root/'Research/computations/neutral5_hyperelliptic_model.json').read_text())
    local_path=root/args.run/'genus6_local_comparison.json'
    local=json.loads(local_path.read_text())
    first=json.loads((root/args.run/'genus6_first_stage.json').read_text())
    previous=json.loads(Path('Research/computations/returned_neutral5_w4_local_audit.json').read_text())
    assert first['xi_coefficients']==[[0,2,2,2],[4,4,0,2],[4,4,3,2],[1,1,2,3],
        [2,1,2,3],[3,1,1,3],[4,3,1,2],[3,3,2,4],[3,4,4,1],[1,1,2,2],[1,4,3,2]]
    fp=PolynomialRing(GF(5),'t'); k=GF(625,'t',modulus=fp(model['field_modulus'])); t=k.gen()
    pol=PolynomialRing(k,'s'); s=pol.gen()
    fpoly=lambda key:pol([k(a) for a in model[key]])
    G=fpoly('hyperelliptic_polynomial'); n5=fpoly('numerator').leading_coefficient()
    # Integral coefficient rings are rebuilt independently.
    def unram(n):
        b=PolynomialRing(Integers(n),'T')
        return b.quotient(b(model['field_modulus']),'T')
    O3=unram(125); T3=O3.gen()
    O=unram(25); T=O.gen()
    encode=lambda a,n:[int(a.lift()[i])%n for i in range(4)]
    c3=lambda a:sum(O3(int(x))*T3**i for i,x in enumerate(a))
    c=lambda a:sum(O(int(x))*T**i for i,x in enumerate(a))
    lf3=lambda a:c3([int(a.polynomial()[i]) for i in range(4)])
    lf=lambda a:c([int(a.polynomial()[i]) for i in range(4)])
    sig=T3**5
    for _ in range(4):
        sig-=(sig**4+4*sig**3+sig**2+4*sig+3)/(4*sig**3+12*sig**2+2*sig+4)
    sigcoeff=lambda a:sum(O3(int(a.polynomial()[i]))*sig**i for i in range(4))
    mp3=PolynomialRing(O3,'s'); sm3=mp3.gen()
    mp=PolynomialRing(O,'s'); sm=mp.gen()
    G3=mp3([lf3(a) for a in G]); GS=mp3([sigcoeff(a) for a in G])
    GG=mp([lf(a) for a in G])
    fu=sm3**5; bv=G3**2
    inv=(G.derivative()**5).inverse_mod(G**3)
    for power in [5,25]:
        err=GS(fu)-G3*bv*bv
        ee=[]
        for a in err:
            ac=encode(a,125); assert all(x%power==0 for x in ac)
            ee.append(k([x//power%5 for x in ac]))
        E=pol(ee); a=(-E*inv).mod(G**3)
        b,rem=(E+G.derivative()**5*a).quo_rem(2*G**3); assert rem==0
        fu+=power*mp3([lf3(x) for x in a]); bv+=power*mp3([lf3(x) for x in b])
    assert GS(fu)-G3*bv*bv==0
    num=[]
    for a in fu.derivative():
        aa=encode(a,125); assert all(x%5==0 for x in aa)
        num.append(c([x//5%25 for x in aa]))
    num=mp(num); den=mp([c(encode(a,25)) for a in bv])
    num0=pol([k(encode(a,5)) for a in num]); den0=pol([k(encode(a,5)) for a in den])
    zeta0,rem=num0.quo_rem(den0); assert rem==0
    zetau=mp([lf(a) for a in zeta0])
    rr=num-zetau*den; rr1=[]
    for a in rr:
        aa=encode(a,25); assert all(x%5==0 for x in aa)
        rr1.append(k([x//5 for x in aa]))
    zeta1,rem=pol(rr1).quo_rem(den0); assert rem==0
    zetau+=5*mp([lf(a) for a in zeta1])
    assert num-zetau*den==0
    print('Independent affine Frobenius connection rebuilt',flush=True)

    # Reference double, not an unrelated split line.
    branch=c(previous['hensel_lifted_double_branch'])
    RR=sm-branch
    SC,rem=GG.quo_rem(RR); assert rem==0
    mu=c(first['mu']); mui=~mu
    N=args.precision
    ls=LaurentSeriesRing(O,'z',default_prec=N+200); z=ls.gen()
    def invseries(f):
        valuation=int(f.valuation()); lead=f[valuation]
        unit=f*z**(-valuation)*(~lead)
        assert unit[0]==1
        # Sage's generic is_unit for quotient rings over Z/25 is not
        # implemented for arbitrary coefficients; normalization to1
        # avoids that backend limitation without changing arithmetic.
        return (~lead)*unit**(-1)*z**(-valuation)
    rev=mp(list(reversed(GG.list())))
    x=GG.leading_coefficient()*z*z
    for _ in range(12):
        x=(x-(x-z*z*rev(x))/(1-z*z*rev.derivative()(x))).add_bigoh(N+150)
    u=invseries(x); Y=u**6/z
    ee=-z*x**4*x.derivative()
    ww2=(1-branch*x)*invseries(x/z**2)
    wc=lf(1/n5)
    for _ in range(3):wc=(wc+ww2[0]/wc)/2
    assert wc*wc==ww2[0]
    unit=ww2*(~(wc*wc))
    ws=ls(1)
    for _ in range(11):ws=((ws+unit/ws)/2).add_bigoh(N+100)
    ww=wc*ws/z; yy=Y*invseries(ww)
    print('Independent mixed-characteristic reference series rebuilt',flush=True)
    def load(a):
        lo=a['low']; precision=min(a['precision'],N)
        cc=[c(v) for v in a['coefficients'][:max(0,precision-lo)]]
        return (ls(cc,prec=precision-lo)*z**lo).add_bigoh(precision)
    UU=[[load(a) for a in row] for row in local['I2U']]
    OO=[[load(a) for a in row] for row in local['I2O']]
    upowers=[ls(1)]
    for i in range(110):upowers.append(upowers[-1]*u)
    def af_reduce(a,anti):
        f=a; p=mp(0); q=mp(0)
        first=int(f.valuation())
        for j in range(first,1):
            cc=f[j]
            if not cc:continue
            if anti:
                if j<=-1 and j%2:kind=0; degree=(-j-1)//2; base=ww*upowers[degree]
                elif j<=-12 and not j%2:kind=1; degree=(-j-12)//2; base=yy*upowers[degree]
                else:raise AssertionError(('non-affine anti pole',j,cc))
            else:
                if j<=-13 and j%2:kind=1; degree=(-j-13)//2; base=Y*upowers[degree]
                elif not j%2:kind=0; degree=-j//2; base=upowers[degree]
                else:raise AssertionError(('non-affine ordinary pole',j,cc))
            coefficient=cc/base[j]
            if kind==0:p+=coefficient*sm**degree
            else:q+=coefficient*sm**degree
            f-=coefficient*base
        assert f.add_bigoh(200)==0,('affine reconstruction',anti,f.valuation())
        return (p,q)
    AA=[[af_reduce(a,True) for a in row] for row in UU]
    normal=af_reduce(load(local['first_hodge_normal_U']),False)
    def add(a,b):return (a[0]+b[0],a[1]+b[1])
    def neg(a):return (-a[0],-a[1])
    def sub(a,b):return add(a,neg(b))
    def scale(a,f):return (a[0]*f,a[1]*f)
    def deriv(a):return (SC*a[1].derivative()+SC.derivative()*a[1]/2,
                         RR*a[0].derivative()+a[0]/2)
    def aprod(a,b):return (RR*a[0]*b[0]+SC*a[1]*b[1],a[0]*b[1]+a[1]*b[0])
    def eprod(a,b):return (a[0]*b[0]+GG*a[1]*b[1],a[0]*b[1]+a[1]*b[0])
    def epanti(a,b):return (a[0]*b[0]+SC*a[1]*b[1],a[0]*b[1]+RR*a[1]*b[0])
    det=sub(aprod(AA[0][0],AA[1][1]),aprod(AA[0][1],AA[1][0]))
    assert det==(mp(mui),mp(0))
    assert AA[0][0]==add(neg(deriv(AA[0][1])),scale(AA[1][1],zetau))
    assert AA[1][0]==neg(deriv(AA[1][1]))

    # Verify the actual corrected line relative to the independently
    # reconstructed first affine comparison, not only its determinant.
    pp=mp([c(a) for a in previous['first_bezout_p']])
    pq=mp([c(a) for a in previous['first_bezout_q']])
    qU=(mp(0),mp([c(a) for a in previous['first_affine_comparison_polynomial']]))
    b2=pol([k(a) for a in previous['double_b2']])
    DK=fpoly('denominator_square_root')*b2*(fpoly('numerator')-(4*t+3)*fpoly('denominator'))
    BC=(s-t**5)*DK.derivative()+DK/2
    kp=mp([lf(a) for a in DK]); bp=mp([lf(a) for a in BC])
    avec=(kp,mp(0)); bvec=(mp(0),bp)
    cvec=(mp(0),-bp*pq); dvec=(kp*pp,mp(0))
    h=[AA[0][1],AA[1][1]]
    mh=[sub(h[0],epanti(qU,h[1])),h[1]]
    sh0=add(aprod(avec,mh[0]),scale(aprod(cvec,mh[1]),mu))
    sh1=add(aprod(bvec,mh[0]),scale(aprod(dvec,mh[1]),mu))
    assert sub(sh0,scale(eprod(normal,sh1),5))==(mp(0),mp(0))

    # Independent formal-chart normalization. Its local spin differential
    # is omega/z^10, and its actual local inverse-Cartier connection is
    # d-F_O(omega/z^10)*z^4 E12.
    sig2=c(encode(sig,25))
    def cfrob(a):
        return sum(O(int(a.lift()[i]))*sig2**i for i in range(4))
    def frob(f):
        vals={5*i:cfrob(f[i]) for i in range(int(f.valuation()),int(f.prec())) if f[i]}
        return ls(vals).add_bigoh(5*f.prec())
    eo=ee/z**10
    zetao=frob(eo)*z**4
    for row in OO:
        for a in row:assert a.valuation()>=0
    assert (OO[0][0]*OO[1][1]-OO[0][1]*OO[1][0]-mui).add_bigoh(200)==0
    assert (OO[0][0]+(OO[0][1].derivative()-zetao*OO[1][1])*invseries(eo)).add_bigoh(180)==0
    assert (OO[1][0]+OO[1][1].derivative()*invseries(eo)).add_bigoh(180)==0

    def polyencode(p):return [encode(a,25) for a in p]
    result=dict(status='PASS_INDEPENDENT_CORRECTED_FRAMES',
        source_sha256=hashlib.sha256(local_path.read_bytes()).hexdigest(),
        precision=N,affine_reconstruction_checked_through=200,
        formal_covariant_normalization_checked_through=180,
        exact_affine_determinant=True,exact_affine_covariant_normalization=True,
        exact_actual_corrected_Hodge_line=True,
        affine_connection_coefficient=polyencode(zetau),
        affine_frames=[[[polyencode(a) for a in entry] for entry in row] for row in AA],
        affine_normal_repair=[polyencode(a) for a in normal],
        seconds=time.monotonic()-start,
        scope='Independent actual W2 corrected Hodge frames and regularity. Central G3 normal cocycle is covered by parent full producer replay and source audit, not recomputed here.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('PASS independently reconstructed all four affine anti-invariant W2 frame entries')
    print('PASS EXACT affine determinant, covariant derivative normalization, and corrected Hodge line')
    print('PASS independent formal-chart W2 normalization through exponent180')
    print('Receipt:',args.output,'seconds',result['seconds'])


if __name__=='__main__':main()
