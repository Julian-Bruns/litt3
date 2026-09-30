#!/usr/bin/env python3
"""Transport the cubic base to its original double and three AS charts.

This builds actual integral etale coordinates with their fixed residue
marking. It does not compute the rank125 fourth or fifth comparison.
The rank125 formal algebra is the tensor product of the three degree5
constant etale algebras constructed here.
"""
import argparse
import hashlib
import json
import math
import time
from pathlib import Path

from reconstruct_base_reference import reconstruct, poly_const, field_code, poly_data, series_data
from witt_cubic import *


class Etale5:
    """Five Laurent coefficients modulo S^5=a*S, with a a Teichmuller unit."""
    def __init__(self,parts,a):
        self.parts=tuple(Ser(x) for x in parts)
        assert len(self.parts)==5
        self.a=a

    @classmethod
    def scalar(cls,value,a):
        return cls([Ser(value)]+[Ser(0)]*4,a)

    def coerce(self,value):
        if isinstance(value,Etale5):
            assert self.a==value.a
            return value
        return Etale5.scalar(value,self.a)

    def __add__(self,other):
        other=self.coerce(other)
        return Etale5([x+y for x,y in zip(self.parts,other.parts)],self.a)
    __radd__=__add__

    def __neg__(self):
        return Etale5([-x for x in self.parts],self.a)

    def __sub__(self,other):
        return self+-self.coerce(other)

    def __rsub__(self,other):
        return self.coerce(other)+-self

    def __mul__(self,other):
        other=self.coerce(other);out=[Ser(0) for _ in range(5)]
        for i,x in enumerate(self.parts):
            if x.iszero():
                continue
            for j,y in enumerate(other.parts):
                if y.iszero():
                    continue
                d=i+j;factor=1
                if d>=5:
                    d-=4;factor=self.a
                out[d]=out[d]+factor*x*y
        return Etale5(out,self.a)
    __rmul__=__mul__

    def __pow__(self,n):
        assert n>=0
        out=self.coerce(1);x=self
        while n:
            if n&1:
                out=out*x
            n//=2
            if n:
                x=x*x
        return out

    def mod(self,m):
        return Etale5([x.mod(m) for x in self.parts],self.a)

    def deriv(self):
        return Etale5([x.deriv() for x in self.parts],self.a)

    def frob(self):
        return Etale5([pow(self.a,i,MOD)*x.frob() for i,x in enumerate(self.parts)],self.a)

    @property
    def precision(self):
        return min(x.prec for x in self.parts)


def check_zero(value,modulus,bound,label):
    parts=value.parts if isinstance(value,Etale5) else [value]
    for i,part in enumerate(parts):
        reduced=part.mod(modulus).cut(bound)
        assert reduced.prec>=bound and reduced.iszero(),(label,i,reduced,reduced.prec)


def run(variant=0,branch=1,bound=40):
    started=time.time()
    base=reconstruct(variant);o=base.pop('_objects')
    def log(*xs):
        print(*xs,'seconds',round(time.time()-started,2),flush=True)
    u,v,g=(o[k] for k in ('u','v','g'))
    P,F=o['P'],o['F'];U=o['U'];level=round(math.log(MOD,5))
    assert 5**level==MOD and level>=2
    kappa=branch*u*(1-3/u).sqrt1()
    y=v/kappa
    Q=poly_const(1)
    for root in [ca(1),ca(2),T]:
        Q=pm(Q,np.array([-root,ca(1)]).T)
    def D(x):
        return x.deriv()/g
    check_zero(kappa*kappa-u*(u-3),MOD,bound,'normalized double kappa')
    check_zero(y*y-peval(Q,u),MOD,bound,'normalized double y')
    check_zero(D(kappa)-(2*u-3)*y*Ser(ci(2)),MOD,bound,'regular D(kappa)')
    check_zero(D(y)-kappa*peval(pd(Q),u)*Ser(ci(2)),MOD,bound,'regular D(y)')

    # Original scaled characters, with all coefficient lifts explicit.
    chi_data=[[(1,31)],[(1,24),(2,118)],[(1,112),(2,43)]]
    characters=[];affine_polynomials=[]
    for i,terms in enumerate(chi_data):
        factor=y if i==0 else v
        squared=ppow(Q if i==0 else F,2)%5
        c=(3,1,2)[i]
        chi=sum((Ser(ca([n%5,(n//5)%5,n//25]))*factor/u**h for h,n in terms),Ser(0))
        poly=poly_const(0)
        for h,n in terms:
            coefficient=cm(ca(c),cp(ca([n%5,(n//5)%5,n//25]),5))%5
            tail=squared[:,5*h:]
            if tail.shape[1]:
                poly=padd(poly,pscale(tail,coefficient))%5
        characters.append(chi.mod(5));affine_polynomials.append(poly)
    assert poly_data(affine_polynomials[0])==[[0,[2,0,0]],[1,[0,2,1]]]
    log('original normalized double and scaled character polynomials')

    # The canonical overlap acts on constant formal AS coordinates trivially.
    source_codes=[[118,113,119],[31,119,44],[2,0,123],[77,86,64]]
    source=[]
    for row in source_codes:
        source.append(sum((Ser(ca([n%5,(n//5)%5,n//25]))*Z**e
                           for n,e in zip(row,(-3,-1,1))),Ser(0)))
    ell=source[0]-5*source[1]-25*source[2]-125*source[3]
    weights=[None,5,Ser(cm(ca(25),ci(2))),Ser(cm(ca(125),ci(6))),
             Ser(cm(ca(625),ci(24))),Ser(cm(ca(625),ci(24)))]
    valuations=[None,1,2,3,4,4]
    def tau(value):
        out=value;term=value
        for j in range(1,6):
            m=MOD//5**valuations[j]
            if m<=1:
                continue
            term=(term.mod(m).deriv()*g.inv().mod(m)*ell.mod(m)).mod(m)
            out=out+term*weights[j]
        return out.mod(MOD)

    displacement=o['fuz']-Z**5
    def affine_frobenius(value):
        out=value.frob();term=value;delta_power=Ser(1)
        for j in range(1,level):
            term=term.deriv()
            delta_power=(delta_power*displacement).mod(MOD)
            piece=term.mod(MOD//5**j).frob()
            out=out+piece*(delta_power*Ser(ci(math.factorial(j))))
        return out.mod(MOD)

    records=[];objects=[]
    for i,chi in enumerate(characters):
        c=(3,1,2)[i]
        a0=pow(c,-1,5);a=pow(a0,5**(level-1),MOD)
        assert pow(a,4,MOD)==1 and a%5==a0
        factor=y if i==0 else v
        FU=factor*peval(affine_polynomials[i],u)
        FO=(FU-c*chi.frob()+chi).mod(5)
        assert FO.valuation>=1,('infinity AS regularity',i,FO.valuation)
        RO=Ser(0)
        for _ in range(2+math.ceil(math.log(MAX,5))):
            RO=(c*RO.frob()-FO).mod(5)
        check_zero(c*RO.frob()-RO-FO,5,bound,'whole residue formal root')
        rU=(chi+RO).mod(5)
        S=Etale5([Ser(0),Ser(1),Ser(0),Ser(0),Ser(0)],a)
        W=S+rU
        bU=a*FU
        check_zero(W**5-a*W-bU,5,bound,'original residue affine AS chart')
        reached=1
        while reached<level:
            # The derivative is -a times(1-5W^4/a), so its inverse is
            # a finite nilpotent geometric sum. No Laurent-unit guess.
            error=(W**5-a*W-bU).mod(MOD)
            e=(W**4)*(5*Ser(ci(a)))
            inv=W.coerce(1);power=W.coerce(1)
            for _ in range(1,level):
                power=(power*e).mod(MOD);inv=inv+power
            inv=inv*(-Ser(ci(a)))
            W=(W-error*inv).mod(MOD)
            reached=min(2*reached,level)
            check_zero(W**5-a*W-bU,5**reached,bound,'integral affine AS Hensel root')
        check_zero((5*(W**4)-a)*(W.deriv()*g.inv())-D(bU),MOD,bound,
                   'full lifted AS derivation')
        phiW=affine_frobenius(W)
        phib=affine_frobenius(W.coerce(bU))
        check_zero(phiW**5-a*phiW-phib,MOD,bound,'regular affine AS Frobenius')
        check_zero(phiW-W**5,5,bound,'AS Frobenius residue')
        tauW=tau(W);taub=tau(W.coerce(bU))
        check_zero(tauW**5-a*tauW-taub,MOD,bound,'canonical source transport of AS relation')
        # Retain the finite coefficient windows only as diagnostics; the
        # whole coordinates are the uniquely specified Hensel roots.
        records.append({'generator':i+1,'c_mod5':c,'constant_a':a,
            'affine_FU_polynomial':poly_data(affine_polynomials[i]),
            'affine_FU_factor':'y' if i==0 else 'v',
            'FO_residue_valuation':FO.valuation,'RO_residue_valuation':RO.valuation,
            'root_precision':W.precision,'frobenius_precision':phiW.precision,
            'source_transport_precision':tauW.precision,
            'affine_root_parts_through_30':[series_data(x,30) for x in W.parts],
            'checks_modulus':MOD,'checks_exclusive_precision':bound,
            'checks':['affine equation','derivation','affine Frobenius','Frobenius residue','canonical source transport']})
        objects.append({'W':W,'S':S,'FU':FU,'FO':FO,'RO':RO,'phiW':phiW,'tauW':tauW})
        log('integral original AS generator PASS',i+1,'precision',W.precision)

    return {'status':'Executed actual integral etale reference coordinates; geometric audit pending; no Hodge obstruction value',
        'modulus':MOD,'series_workspace':MAX,'frobenius_variant':variant,'infinity_branch':branch,
        'base_reference_id':'cubic_ordinary_base_reference',
        'constant_formal_algebra':'tensor_i R_m[S_i]/(S_i^5-a_i*S_i); derivative S_i=0, formal Frobenius S_i=a_i*S_i',
        'original_marking':'W_U,i mod5=S_i+chi_i+RO_i; W_O,i mod5=S_i+RO_i, with original scaled characters',
        'whole_root_definition':'c_i*RO_i^5-RO_i=FO_i, RO_i in z*k0[[z]]; W_U,i is unique Hensel root W^5-a_i W=a_i FU_i reducing to S_i+chi_i+RO_i',
        'checks':['normalized genus-three affine curve','regular lifted derivation','all three actual etale chart maps'],
        'generators':records,'seconds':time.time()-started,
        '_objects':{'base':o,'kappa':kappa,'y':y,'generators':objects,'tau':tau,'affine_frobenius':affine_frobenius}}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--frobenius-variant',type=int,choices=(0,1),default=0)
    ap.add_argument('--infinity-branch',type=int,choices=(-1,1),default=1)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    result=run(args.frobenius_variant,args.infinity_branch)
    result.pop('_objects')
    result['source_sha256']={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
        for p in [Path(__file__),Path(__file__).with_name('reconstruct_base_reference.py'),Path(__file__).with_name('witt_cubic.py')]}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: original integral etale reference charts; no rank125 obstruction value')


if __name__=='__main__':
    main()
