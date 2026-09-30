# Experimental source15625 extension; the original base reconstruction is preserved.
#!/usr/bin/env python3
"""Reconstruct the cubic ordinary base's first marked reference.

Actual-chart calculation, adapted from the executed rank25 base_setup.py.
Geometric scope: Proofs/deformations/cubic_ordinary_base_reference.md.
This is not a rank125 fifth numerator. The base is
Y: v^2=u(u-1)(u-2)(u-3)(u-T), T^3+T+1=0, with active A=(T+1)^2 P.
The square-trivial flat line is retained through w^2=u-T; w is a local
frame for that line and is NOT asserted to be a global function on Y.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

from witt_cubic import *


def poly_const(c):
    return ca(c).reshape(DEG, 1)


def field_code(c):
    c = np.asarray(c) % 5
    return int(c[0] + 5*c[1] + 25*c[2])


def poly_data(p):
    return [[i, [int(x) for x in c]] for i, c in enumerate(p.T) if np.any(c)]


def series_data(s, bound=30):
    return [[e, [int(x) for x in s.coef(e)]]
            for e in range(s.valuation, min(bound, s.prec)) if np.any(s.coef(e))]


def reconstruct(variant=0):
    started = time.time()
    def log(*xs):
        print(*xs, 'seconds', round(time.time()-started, 2), flush=True)
    def zero(x, modulus, bound, label):
        z0=x.mod(modulus).cut(bound)
        assert z0.prec>=bound and z0.iszero(), (label, z0, z0.prec)

    U=np.array([ca(0),ca(1)]).T
    P=poly_const(1)
    for root in [ca(0),ca(1),ca(2),ca(3)]:
        P=pm(P,np.array([-root,ca(1)]).T)
    RT=np.array([-T,ca(1)]).T
    F=pm(P,RT)
    scale=(T+ONE)%MOD
    AP=pscale(P,cp(scale,2))
    BP=pscale(pm(RT,ppow(pd(P),2)),cm(cp(scale,2),ci(4)))
    gcd,pc,qc=pxgcd(AP,BP)
    assert np.array_equal(gcd,poly_const(1))
    determinant=padd(pm(AP,pc),pm(BP,qc))
    error=padd(determinant,-poly_const(1))
    assert not np.any(error%5)
    # An ACTUAL affine Bezout identity, not a coefficientwise lift of one.
    inv_det=poly_const(1)
    power=poly_const(1)
    for _ in range(1,6):
        power=pm(power,-error)
        inv_det=padd(inv_det,power)
    pc=pm(pc,inv_det);qc=pm(qc,inv_det)
    assert np.array_equal(padd(pm(AP,pc),pm(BP,qc)),poly_const(1))

    reverse=F[:,::-1]
    s=Z**2
    for _ in range(max(10,MAX.bit_length()+1)):
        s=s-(s-Z**2*peval(reverse,s))/(1-Z**2*peval(pd(reverse),s))
    u=s.inv();v=u**2/Z
    g=-Z*s.deriv();Dz=g.inv()
    w=(((1-Ser(T)*s)/(s/Z**2)).sqrt1())/Z
    flat_y=v/w
    aa=Ser(scale)*flat_y
    bb=Ser(scale)*w*peval(pd(P),u)*Ser(ci(2))
    cc=-bb*peval(qc,u);dd=aa*peval(pc,u)
    Rpoly=padd(pscale(pd(P),ci(4)),pscale(pm(RT,pd(pd(P))),ci(2)))
    R=peval(Rpoly,u)
    zero(aa.deriv()/g-bb,MOD,60,'D a=b')
    zero(bb.deriv()/g-R*aa,MOD,60,'D b=R a')
    zero(aa*dd-bb*cc-1,MOD,60,'actual affine determinant')
    expected_R=[(0,21),(1,19),(2,20),(3,2)]
    # Check the polynomial against 1+4t, 4+3t, 4t, 2.
    assert [(i,field_code(c)) for i,c in enumerate(Rpoly.T)]==expected_R
    aO=Z**4*aa
    bO=(Z**5*(Z*bb-Dz*aa)).mod(5)
    assert aO.valuation==0 and np.any(aO.coef(0)%5)
    assert bO.valuation>=0, ('infinity first-column regularity', bO)
    # The infinity complement is (0,1/aO): aO is a unit here.
    # Therefore z^5*(S_O^-1 J S_U)_12=c/a.
    f_target=cc/aa
    log('actual base oper and flat-line frames')

    # Regular affine Frobenius on the PRODUCT coefficient lift.
    Fsig=SIGMAT@F%MOD
    Fder5=ppow(pd(F)%5,5)%5
    F3=ppow(F,3)%5
    _,Finv,_=pxgcd(Fder5,F3)
    fu=ppow(U,5);bv=ppow(F,2)
    corrections=[]
    for weight in (5,25,125,625,3125):
        if weight>=MOD:
            break
        err=padd(peval(Fsig,fu),-pm(F,ppow(bv,2)))
        assert not np.any(err%weight), ('Frobenius defect division',weight)
        e=(err//weight)%5
        ac=pdiv(-pm(e,Finv)%5,F3,True)[1]
        if weight==5 and variant:
            ac=padd(ac,F3)%5
        numer=padd(e,pm(Fder5,ac))%5
        bc,rem=pdiv(numer,pscale(F3,ca(2))%5,True)
        assert not np.any(rem)
        fu=padd(fu,weight*ac);bv=padd(bv,weight*bc)
        corrections.append({'weight':weight,'u':poly_data(ac),'v_multiplier':poly_data(bc)})
    assert not np.any(padd(peval(Fsig,fu),-pm(F,ppow(bv,2))))
    Fu=peval(fu,u);FBv=peval(bv,u)
    fuz=Fu**2/(v*FBv)
    zero(fuz-Z**5,5,80,'F(z) residue')
    delta_ref=(fuz-Z**5).divint(5)
    f_ref=-(g.frob()*delta_ref).mod(5)
    log('actual affine Frobenius', 'normal precision', f_ref.prec)

    u5=u.mod(5);v5=v.mod(5)
    def reduce_h1(value,n=10):
        value=value.mod(5);part=Ser(0);records=[]
        for e in range(value.valuation,1):
            coeff=value.coef(e)%5
            if not np.any(coeff):
                continue
            if e<=-5 and e%2:
                power=(-e-5)//2;is_v=1;basis=v5*u5**power
            elif e<=0 and e%2==0:
                power=-e//2;is_v=0;basis=u5**power
            else:
                continue
            coeff=cdiv(coeff,basis.coef(e))%5
            term=Ser(coeff)*basis
            value=(value-term).mod(5);part=(part+term).mod(5)
            records.append({'v':is_v,'u':power,'coefficient':[int(x) for x in coeff]})
        exponents=[-3,-1]+list(range(1,n))
        vec=np.array([value.coef(e)%5 for e in exponents])
        return vec,part,value,records

    columns=[reduce_h1(f_target)[0]]+[-reduce_h1(Z**j)[0]%5 for j in (-15,-5,5)]
    matrix=np.stack(columns,axis=1)
    rhs=reduce_h1(f_ref)[0]
    solution,pivots=linear_solve(matrix,rhs)
    assert len(pivots)==4
    mu=solution[0]
    assert np.any(mu)
    xi_coefficients=np.array([cp(c,25)%5 for c in solution[1:]])
    xi=sum((Ser(c)*Z**e for c,e in zip(xi_coefficients,(-3,-1,1))),Ser(0))
    f_actual=(f_ref+xi**5).mod(5)
    difference=(Ser(mu)*f_target-f_actual).mod(5)
    normal,qU,remainder,affine=reduce_h1(difference)
    assert not np.any(normal)
    qO=-(remainder/Z**10).mod(5)
    assert qO.valuation>=0
    beta=dd*cc.deriv()-cc*dd.deriv()+(-dd*dd+R*cc*cc)*g
    zeta=Fu.deriv().divint(5)/(v*FBv)
    zero(Ser(mu)*beta-qU.deriv()+zeta,5,60,'connection compatibility')
    # Check the initial connection as an EXACT polynomial identity too,
    # clearing the regular affine Frobenius denominator. This is
    # independent of the displayed finite Laurent window.
    pp,qq=pc%5,qc%5
    abv=pscale(pm(F,pd(P)),cm(cp(scale,2),ci(2)))%5
    betap=padd(-pm(pm(pm(Rpoly,AP),pp),qq),
               -pm(pm(abv,pp),pd(qq)))
    betap=padd(betap,pm(pm(BP,pp),qq))
    betap=padd(betap,pm(pm(abv,qq),pd(pp)))
    betap=padd(betap,-pm(AP,ppow(pp,2)))
    betap=padd(betap,pm(pm(Rpoly,BP),ppow(qq,2)))%5
    h=[poly_const(0),poly_const(0)]
    for row in affine:
        h[row['v']]=padd(h[row['v']],pscale(ppow(U,row['u']),row['coefficient']))%5
    dq=padd(pscale(pm(pd(F),h[1]),ci(2)),pm(F,pd(h[1])))%5
    assert not np.any(pd(h[0])%5)
    dfu=pd(fu)
    assert not np.any(dfu%5)
    exact_connection=padd(pm(padd(pscale(betap,mu),-dq),bv%5),dfu//5)%5
    assert not np.any(exact_connection), 'exact affine connection polynomial'
    log('first marked source', [field_code(c) for c in xi_coefficients],
        'extension scalar', field_code(mu))

    # Independently assemble the FULL mod-five gluing matrix in these
    # frames; this checks both diagonals and the lower row as well.
    def mm(left,right):
        return [[sum((left[i][k]*right[k][j] for k in range(2)),Ser(0))
                 for j in range(2)] for i in range(2)]
    def mi(a):
        det=a[0][0]*a[1][1]-a[0][1]*a[1][0]
        return [[a[1][1]/det,-a[0][1]/det],[-a[1][0]/det,a[0][0]/det]]
    SU=[[aa,Ser(mu)*cc],[bb,Ser(mu)*dd]]
    SO=[[aO,Ser(0)],[bO,Ser(mu)/aO]]
    MU=[[Ser(1),qU],[Ser(0),Ser(1)]]
    MO=[[Ser(1),qO],[Ser(0),Ser(1)]]
    IU=mm(MU,mi(SU));IO=mm(MO,mi(SO))
    G=[[Z**-5,Z**-5*f_actual],[Ser(0),Z**5]]
    J=[[1/Z,Ser(0)],[-Dz,Z]]
    gj=mm(mm(mi(IO),G),IU)
    for i in range(2):
        for j in range(2):
            zero(gj[i][j]-J[i][j],5,40,'full first marked gluing')

    return {'status':'Executed actual first base reference; scope in cubic_ordinary_base_reference; no rank125 fifth value',
        'field':'F5[t]/(t^3+t+1)','coefficient_modulus':MOD,'series_workspace':MAX,
        'frobenius_variant':variant,'witt_sigma_T':[int(x) for x in SIGT],
        'reference_equation':'PRODUCT u(u-1)(u-2)(u-3)(u-T); T^3+T+1=0',
        'flat_line':'O_Y(W_t-O), represented locally by w^2=u-T; not globally trivialized',
        'theta':'O_Y(O); z=u^2/v','A':'(t+1)^2 P',
        'D_potential_mod5':[[i,field_code(c)] for i,c in enumerate(Rpoly.T)],
        'affine_bezout':{'p':poly_data(pc),'q':poly_data(qc)},
        'frobenius_corrections':corrections,
        'dictionary_normal_exponents':[-3,-1]+list(range(1,10)),
        'dictionary_matrix_field_codes':[[field_code(c) for c in row] for row in matrix],
        'dictionary_rhs_field_codes':[field_code(c) for c in rhs],
        'dictionary_pivots':pivots,
        'extension_scalar_field_code':field_code(mu),
        'source_basis':'(z^-3,z^-1,z)*D; canonical overlap exp(5*xi*D) modulo25',
        'source_xi_field_codes':[field_code(c) for c in xi_coefficients],
        'source_xi_frobenius_field_codes':[field_code(c) for c in solution[1:]],
        'first_affine_homotopy':affine,
        'formal_homotopy_expression':'qO=-(mu*f_target-f_ref-xi^5-qU)/z^10 modulo5; f_target=c/a',
        'formal_homotopy_valuation':qO.valuation,
        'formal_homotopy_through_30':series_data(qO,30),
        'checks':{'affine_bezout_modulus':MOD,'oper_horizontality_through':60,
                  'affine_Frobenius_equation':'exact polynomial identity at coefficient modulus',
                  'initial_connection_exact_polynomial_mod5':True,
                  'dictionary_full_normal_zero':True,'connection_through':60,
                  'full_marked_gluing_through':40},
        'seconds':time.time()-started,
        '_objects':locals()}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--frobenius-variant',type=int,choices=(0,1),default=0)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    result=reconstruct(args.frobenius_variant)
    result.pop('_objects')
    result['source_sha256']={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
        for p in [Path(__file__),Path(__file__).with_name('witt_cubic.py')]}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: actual base first-reference arithmetic, full gluing and exact connection')


if __name__=='__main__':
    main()
