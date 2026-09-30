#!/usr/bin/env python3
"""Execute the canonical ordinary BASE tower through W5.

Uses genuine source overlaps, full inverse-Cartier matrices, whole regular
Hodge repairs and actual local frame lifts. Geometric scope and audit:
Proofs/deformations/cubic_ordinary_base_reference.md. This computes
base-reference data, not a rank125 slope.
Run with LITT3_REFERENCE_MODULUS=3125 and adequate Laurent precision.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

from reconstruct_base_reference import reconstruct, field_code, poly_data, series_data
from witt_cubic import *


def run(variant=0):
    assert MOD==3125, 'Base W5 reconstruction needs source precision3125'
    started=time.time()
    first=reconstruct(variant)
    o=first.pop('_objects')
    def log(*xs):
        print(*xs,'seconds',round(time.time()-started,2),flush=True)
    def zero(value,modulus,bound,label):
        reduced=value.mod(modulus).cut(bound)
        assert reduced.prec>=bound and reduced.iszero(),(label,reduced,reduced.prec)
    def mm(a,b):
        return [[sum((a[i][k]*b[k][j] for k in range(2)),Ser(0)) for j in range(2)] for i in range(2)]
    def mi(a,modulus=MOD):
        a=mmod(a,modulus)
        det=(a[0][0]*a[1][1]-a[0][1]*a[1][0]).mod(modulus)
        return [[a[1][1]/det,-a[0][1]/det],[-a[1][0]/det,a[0][0]/det]]
    def mmod(a,m):
        return [[x.mod(m) for x in row] for row in a]
    def madd(a,b):
        return [[a[i][j]+b[i][j] for j in range(2)] for i in range(2)]
    def scalar_matrix(c,a):
        return [[c*x for x in row] for row in a]
    u,v,g,Dz,xi,mu=(o[k] for k in ('u','v','g','Dz','xi','mu'))
    fuz,R,zeta=(o[k] for k in ('fuz','R','zeta'))
    reduce_h1=o['reduce_h1']
    def D(x):
        return x.deriv()/g
    def affine_lift(records,sign=1):
        return sum((Ser(ca(row['coefficient'])*sign)*v**row['v']*u**row['u'] for row in records),Ser(0))
    def split_normal(value):
        normal,affine,remainder,records=reduce_h1(value,n=2)
        canonical=sum((Ser(c)*Z**e for c,e in zip(normal,(-3,-1,1))),Ser(0))
        formal=((remainder-canonical)/Z**2).mod(5)
        assert formal.valuation>=0, ('whole normal primitive regularity',formal)
        zero(value-affine-canonical-Z**2*formal,5,30,'whole normal split')
        return normal,affine_lift(records),formal,records

    # I_0 must be lifted as actual affine functions, not as Laurent digits.
    MU=[[Ser(1),affine_lift(o['affine'])],[Ser(0),Ser(1)]]
    MO=[[Ser(1),o['qO']],[Ser(0),Ser(1)]]
    IU=mm(MU,mi(o['SU']));IO=mm(MO,mi(o['SO']))
    A=peval(o['AP'],u).mod(5)
    columns=[split_normal(A*Z**(5*e))[0] for e in (-3,-1,1)]
    primary=np.stack(columns,axis=1)
    _,piv=linear_solve(primary,np.zeros((3,DEG),dtype=np.int64))
    assert len(piv)==3
    log('ordinary base primary',[[field_code(c) for c in row] for row in primary])
    digits={3:Ser(0),4:Ser(0),5:Ser(0)}

    def overlap():
        ell=xi-5*digits[3]-25*digits[4]-125*digits[5]
        weights=[None,Ser(5),Ser(cm(ca(25),ci(2))),Ser(cm(ca(125),ci(6))),
                 Ser(cm(ca(625),ci(24))),Ser(cm(ca(625),ci(24)))]
        gi=g.inv()
        valuations=[None,1,2,3,4,4]
        def ED(value,modulus):
            return (ell.mod(modulus)*value.mod(modulus).deriv()*gi.mod(modulus)).mod(modulus)
        def tau(value,outmod=MOD):
            out=value.mod(outmod);term=value
            for j in range(1,6):
                modulus=outmod//5**valuations[j]
                if modulus==0 or modulus==1:
                    continue
                term=ED(term,modulus)
                out=out+weights[j]*term
            return out.mod(outmod)
        Az=Ser(1);term=ell
        for j in range(1,6):
            modulus=MOD//5**valuations[j]
            Az=Az+weights[j]*(term.mod(modulus).deriv()*gi.mod(modulus)).mod(modulus)
            term=ED(term,modulus)
        excess=Az-1
        qz=Z*(1+Ser(ci(2))*excess-Ser(ci(8))*excess**2
              +Ser(ci(16))*excess**3)
        tz=tau(Z)
        zero(Az-tau(g)*tz.deriv()/g,MOD,20,'actual source eta overlap')
        delta=(tau(fuz)-tz.frob()).divint(5)
        j11=qz.inv().frob();j22=qz.frob();j21=(-5*D(qz)/Az).frob()
        J=[[qz.inv(),Ser(0)],[-D(qz)/Az,qz]]
        return {'tau':tau,'delta':delta,'jet':[[j11,Ser(0)],[j21,j22]],'J':J}

    def transition(data,potential,flat_modulus):
        # The complete weighted Taylor recurrence, including order five.
        Au=[[Ser(0),-g],[-25*potential*g,Ser(0)]]
        K=[[Ser(1),Ser(0)],[Ser(0),Ser(1)]]
        total=[[Ser(1),Ser(0)],[Ser(0),Ser(1)]]
        factorials=(1,1,2,6,24,120)
        for j in range(1,6):
            K=madd(scalar_matrix(Ser(5),[[x.deriv() for x in row] for row in K]),mm(Au,K))
            if j==5:
                divided=[[x.divint(5)*Ser(ci(24)) for x in row] for row in K]
            else:
                divided=scalar_matrix(Ser(ci(factorials[j])),K)
            term=[[data['tau'](x).frob()*data['delta']**j for x in row] for row in divided]
            total=madd(total,term)
        return mmod(mm(data['jet'],total),flat_modulus)

    def comparison(data,GU,GO,potential,flat_modulus,division):
        G=transition(data,potential,flat_modulus)
        result=mm(mm(mi(GO,flat_modulus),G),[[data['tau'](x,flat_modulus) for x in row] for row in GU])
        numerator=(Z*result[0][1]).mod(flat_modulus)
        normal=numerator.divint(division).mod(5)
        return normal,G

    def covariant(vec,di,B):
        return [(vec[i].deriv()+sum((B[i][j]*vec[j] for j in range(2)),Ser(0)))*di for i in range(2)]
    def corrected(I,hodge,di,B,weight,outmod):
        I=mmod(I,outmod);B=mmod(B,outmod);di=di.mod(outmod)
        h=[I[i][1]+weight*hodge*I[i][0] for i in range(2)]
        h=[x.mod(outmod) for x in h]
        firstcol=[-x for x in covariant(h,di,B)]
        wr=firstcol[0]*h[1]-firstcol[1]*h[0]
        excess=(Ser(mu)*wr-1).mod(outmod)
        zero(excess,5,30,'Wronskian residue')
        factor=1-Ser(ci(2))*excess+Ser(cm(ca(3),ci(8)))*excess**2
        # Higher terms are zero modulo625: the cubic coefficient itself
        # contains5. Do not let formally computed zero terms poison the
        # Laurent precision bound through unused nilpotent polar tails.
        assert outmod<=625
        h=[(factor*x).mod(outmod) for x in h]
        firstcol=[(-x).mod(outmod) for x in covariant(h,di,B)]
        zero(Ser(mu)*(firstcol[0]*h[1]-firstcol[1]*h[0])-1,outmod,30,'normalized determinant')
        return [[firstcol[0],h[0]],[firstcol[1],h[1]]]
    def potential(I,di,B):
        I=mmod(I,25);B=mmod(B,25);di=di.mod(25)
        c=[I[i][0] for i in range(2)];h=[I[i][1] for i in range(2)]
        cc=covariant(c,di,B)
        pnew=(-Ser(mu)*(c[0]*cc[1]-c[1]*cc[0])).mod(25)
        hh=covariant(h,di,B)
        for i in range(2):
            zero(hh[i]+c[i],25,30,'actual oper upper entry')
            zero(cc[i]+pnew*h[i],25,30,'actual oper potential')
        return pnew
    def affine_frob25(value):
        return (value.frob()+(fuz-Z**5)*value.deriv().frob()).mod(25)

    zetaO=Z**4*(g/Z**2).frob()
    B2U=[[Ser(0),-zeta],[Ser(0),Ser(0)]]
    B2O=[[Ser(0),-zetaO],[Ser(0),Ser(0)]]
    records=[]
    GU,GO=IU,IO
    Pprev=Ser(0)
    BU,BO=B2U,B2O
    for stage,flat_modulus,division in [(3,25,5),(4,125,25),(5,625,125)]:
        data=overlap()
        rho,G=comparison(data,GU,GO,Pprev,flat_modulus,division)
        normal,_,_,_=split_normal(rho)
        unrepaired_normal=normal.copy()
        solution,piv=linear_solve(primary,normal)
        coefficients=np.array([cp(c,25)%5 for c in solution])
        digits[stage]=sum((Ser(c)*Z**e for c,e in zip(coefficients,(-3,-1,1))),Ser(0))
        log('canonical base digit',stage,[field_code(c) for c in coefficients])
        data=overlap()
        rho,G=comparison(data,GU,GO,Pprev,flat_modulus,division)
        normal,affine,formal,affine_records=split_normal(rho)
        assert not np.any(normal), ('base digit direct normal failure',stage,normal)
        if stage==4:
            # These are the ACTUAL preceding filtered-object potentials.
            P2U=potential(GU,g.inv(),B2U)
            P2O=potential(GO,Z**2/g,B2O)
            zero(P2U-R,5,40,'preceding potential special fibre')
            zero(P2O-(Z**4*R-Z**3*D(Dz)),5,40,
                 'preceding infinity potential transformation')
            BU=[[Ser(0),-zeta],[-25*affine_frob25(P2U)*zeta,Ser(0)]]
            BO=[[Ser(0),-zetaO],[-25*P2O.frob()*zetaO,Ser(0)]]
        # A separate connection check on the raw inverse-Cartier matrix,
        # before the Hodge graph normalization. This sees all four rows
        # of the full transition, not only its obstruction coordinate.
        tauBU=[[data['tau'](x,flat_modulus) for x in row] for row in BU]
        tzprime=data['tau'](Z,flat_modulus).deriv()
        horizontal=madd(madd(mm(BO,G),scalar_matrix(-tzprime,mm(G,tauBU))),
                        [[x.deriv() for x in row] for row in G])
        for i in range(2):
            for j in range(2):
                zero(horizontal[i][j],flat_modulus,20,'full IC horizontality')
        GU=corrected(GU,-affine,g.inv(),BU,division,625)
        GO=corrected(GO,formal,Z**2/g,BO,division,625)
        whole=mm(mm(mi(GO,flat_modulus),G),[[data['tau'](x,flat_modulus) for x in row] for row in GU])
        for i in range(2):
            for j in range(2):
                zero(whole[i][j]-data['J'][i][j],flat_modulus,20,'full corrected jet')
        records.append({'stage':stage,'source_coefficients_field_codes':[field_code(c) for c in coefficients],
            'unrepaired_normal_field_codes':[field_code(c) for c in unrepaired_normal],
            'repaired_normal_zero':True,'normal_precision':rho.prec,
            'hodge_affine_records':affine_records,'hodge_affine_sign':-1,
            'hodge_formal_valuation':formal.valuation,'hodge_formal_through_30':series_data(formal,30),
            'full_corrected_jet_modulus':flat_modulus,'full_corrected_jet_precision':20,
            'full_IC_horizontality_modulus':flat_modulus,'full_IC_horizontality_precision':20})
        if stage==3:
            Pprev=R
        elif stage==4:
            Pprev=P2U
        log('whole source, Hodge and full graded jet PASS',stage)

    return {'status':'Executed canonical BASE W5 reference and preceding flow through W4; NOT rank125 slope',
        'first_reference':first,'base_primary_field_codes':[[field_code(c) for c in row] for row in primary],
        'source_overlap':'exp((5*xi-25*n3-125*n4-625*n5)*D) modulo3125',
        'higher_reference_digits':records,
        'preceding_oper_mod25_through_30':{'U':series_data(P2U,30),'O':series_data(P2O,30)},
        'precision':MAX,'modulus':MOD,'frobenius_variant':variant,
        'seconds':time.time()-started}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--frobenius-variant',type=int,choices=(0,1),default=0)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    result=run(args.frobenius_variant)
    result['source_sha256']={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
        for p in [Path(__file__),Path(__file__).with_name('reconstruct_base_reference.py'),Path(__file__).with_name('witt_cubic.py')]}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: full canonical BASE W5 reference; no rank125 fifth scalar')


if __name__=='__main__':
    main()
