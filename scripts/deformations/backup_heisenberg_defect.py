#!/usr/bin/env sage-python
"""Actual Heisenberg125 torsors and a measured Hodge-column pilot.

Uses finite Laurent-polynomial arithmetic on the actual biquadratic bad
double. UT3 Lang gluing constructs both affine charts, including infinity.
The source/target Frobenius twist is handled by the actual semilinear
formula A*f^5. A pilot is not a complete defect computation.
"""
import argparse
import itertools
import json
from math import comb
from pathlib import Path
import time

from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt
from sage.all import GF, LaurentPolynomialRing, PolynomialRing, matrix, vector


class CurveAlgebra:
    def __init__(self, field, alpha, Rcoeff, Acoeff):
        self.k=field
        self.L=LaurentPolynomialRing(field,'u')
        self.u=self.L.gen()
        u=self.u
        decode=lambda cs: sum((field(c)*alpha**i for i,c in enumerate(cs)),field(0))
        self.R=sum((decode(c)*u**i for i,c in enumerate(Rcoeff)),self.L(0))
        self.A=sum((decode(c)*u**i for i,c in enumerate(Acoeff)),self.L(0))
        self.F=u*(u-1)*(u-2)*(u-3)*(u-alpha)
        poly=PolynomialRing(field,'v')
        S,rem=poly(self.F).quo_rem(poly(self.R))
        assert not rem
        self.S=self.L(S)
        self.poles=(0,int(poly(self.R).degree()),int(S.degree()),5)
        self.factors=(self.L(1),self.R,self.S,self.F)
        self.zero=(self.L(0),)*4
        self.one=self.mono(0,0)
        self.basis=((3,-1),(3,-2),(3,-3),(2,-1),(1,-1),(2,-2))
        self.obasis=((3,-1),(3,-2),(2,-1))

    def mono(self,component,power=0,coefficient=1):
        out=[self.L(0)]*4
        out[component]=self.k(coefficient)*self.u**power
        return tuple(out)

    def add(self,a,b):return tuple(x+y for x,y in zip(a,b))
    def neg(self,a):return tuple(-x for x in a)
    def scale(self,a,c):return tuple(c*x for x in a)
    def nonzero(self,a):return any(a)

    def mul(self,a,b):
        out=[self.L(0)]*4
        for i in range(4):
            if a[i]:
                for j in range(4):
                    if b[j]:out[i^j]+=a[i]*b[j]*self.factors[i&j]
        return tuple(out)

    def frob(self,a):
        return tuple(a[i]**5*self.factors[i]**2 for i in range(4))

    def split(self,a,tangent=True):
        basis=self.basis if tangent else self.obasis
        bounds=(-1,-2,-3,-4) if tangent else (0,-1,-2,-3)
        cohom=[a[i][j] for i,j in basis]
        affine=[]
        infinite=[]
        for i in range(4):
            affine.append(sum((c*self.u**int(j) for j,c in a[i].dict().items()
                               if int(j)>=0),self.L(0)))
            infinite.append(sum((c*self.u**int(j) for j,c in a[i].dict().items()
                                 if int(j)<0 and int(j)<=bounds[i]),self.L(0)))
        rebuilt=self.add(tuple(affine),tuple(infinite))
        for (i,j),c in zip(basis,cohom):rebuilt=self.add(rebuilt,self.mono(i,j,c))
        assert rebuilt==a
        return cohom,tuple(affine),tuple(infinite)

    def from_h1o(self,coeffs):
        out=self.zero
        for (i,j),c in zip(self.obasis,coeffs):out=self.add(out,self.mono(i,j,c))
        return out

    def encode(self,a,encode_field):
        return [{str(int(i)):encode_field(c) for i,c in lp.dict().items()} for lp in a]


class TorsorAlgebra:
    def __init__(self,base,f1,f2,f3,chi1,chi2,kappa):
        self.base=base
        self.coefficient_zero=base.zero
        self.f1,self.f2,self.f3=f1,f2,f3
        self.one={(0,0,0):base.one}
        self.w=[{tuple(int(i==j) for i in range(3)):base.one} for j in range(3)]
        self.reduction_cache={}
        self.indices=sorted(itertools.product(range(5),repeat=3),key=lambda v:(v[0]+v[1]+2*v[2],v))
        self.position={v:i for i,v in enumerate(self.indices)}
        self.glue_cache={}
        self.frob_cache={}
        self.gluing=[self.add(self.w[0],self.constant(base.neg(chi1))),
                     self.add(self.w[1],self.constant(base.neg(chi2))),
                     self.add(self.add(self.w[2],self.scaled(self.w[1],base.neg(chi1))),
                              self.constant(kappa))]
        self.frobenius=[self.add(self.w[0],self.constant(f1)),
                       self.add(self.w[1],self.constant(f2)),
                       self.add(self.add(self.w[2],self.scaled(self.w[1],f1)),self.constant(f3))]
        self.glue_powers=[self.powers(w) for w in self.gluing]
        self.frob_powers=[self.powers(w) for w in self.frobenius]

    def constant(self,a):return {(0,0,0):a} if self.base.nonzero(a) else {}

    def add(self,a,b):
        out=dict(a)
        for key,c in b.items():
            value=self.base.add(out.get(key,self.coefficient_zero),c)
            if self.base.nonzero(value):out[key]=value
            else:out.pop(key,None)
        return out

    def scaled(self,a,c):
        return {key:value for key,co in a.items()
                if self.base.nonzero(value:=self.base.mul(co,c))}

    def reduce_monomial(self,exponent):
        if exponent in self.reduction_cache:return self.reduction_cache[exponent]
        if all(i<5 for i in exponent):return {exponent:self.base.one}
        a=list(exponent)
        j=next(i for i in (2,1,0) if a[i]>=5)
        a[j]-=5
        ans={}
        for term,coef in self.frobenius[j].items():
            sub=self.reduce_monomial(tuple(a[i]+term[i] for i in range(3)))
            ans=self.add(ans,self.scaled(sub,coef))
        self.reduction_cache[exponent]=ans
        return ans

    def mul(self,a,b):
        ans={}
        for key,c in a.items():
            for other,d in b.items():
                exponent=tuple(x+y for x,y in zip(key,other))
                product=self.base.mul(c,d)
                ans=self.add(ans,self.scaled(self.reduce_monomial(exponent),product))
        return ans

    def powers(self,a):
        result=[self.one]
        for i in range(4):result.append(self.mul(result[-1],a))
        return result

    def monomial_image(self,key,powers,cache):
        if key not in cache:
            cache[key]=self.mul(self.mul(powers[0][key[0]],powers[1][key[1]]),powers[2][key[2]])
        return cache[key]

    def reduce_cohomology(self,value):
        remaining=dict(value)
        answer={}
        for key in reversed(self.indices):
            coefficient=remaining.pop(key,self.coefficient_zero)
            if not self.base.nonzero(coefficient):continue
            cohom,affine,tail=self.base.split(coefficient)
            pos=self.position[key]*6
            for j,c in enumerate(cohom):
                if c:answer[pos+j]=c
            if self.base.nonzero(tail):
                transition=self.monomial_image(key,self.glue_powers,self.glue_cache)
                assert transition[key]==self.base.one
                for sub,co in transition.items():
                    if sub==key:continue
                    assert self.position[sub]<self.position[key],(key,sub)
                    repaired=self.base.add(remaining.get(sub,self.coefficient_zero),
                        self.base.neg(self.base.mul(co,tail)))
                    if self.base.nonzero(repaired):remaining[sub]=repaired
                    else:remaining.pop(sub,None)
        assert not remaining
        return answer


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--case',type=int,default=0)
    ap.add_argument('--plane',type=int,default=0)
    ap.add_argument('--central',type=int,choices=range(5),default=0)
    ap.add_argument('--field-degree',type=int,choices=[12,60],default=60,
                    help='Use degree12 only when the exact Lang equation is soluble there')
    ap.add_argument('--columns',type=int,default=12)
    ap.add_argument('--deck-generator-columns',action='store_true',
                    help='Measure the nontrivial deck generator, not Hodge columns')
    ap.add_argument('--start-column',type=int,default=0)
    ap.add_argument('--seconds',type=int,default=120)
    ap.add_argument('--report-every',type=int,default=1)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    started=time.monotonic()
    root=Path(__file__).resolve().parents[2]
    data=root/'Research/computations'
    source=json.loads((data/'backup_bad_double_cyclic_directions.json').read_text())
    case=source['cases'][args.case]
    raw=json.loads((data/('backup_bad_double_jet_%d.json'%args.case)).read_text())
    prime=GF(5)
    pol=PolynomialRing(prime,'z')
    small=GF(5**12,name='b',modulus=pol(source['coefficient_field_modulus']))
    b=small.gen()
    if args.field_degree==60:
        field,embed=small.extension(5,'c',map=True)
    else:
        field=small
        embed=small.hom([small.gen()],small)
    c=field.gen()
    degree=int(field.degree())
    assert degree==args.field_degree
    decode=lambda co: embed(sum((small(v)*b**i for i,v in enumerate(co)),small(0)))
    encode=lambda value:[int(field(value).polynomial()[i]) for i in range(degree)]
    alpha=decode(source['alpha_embedding'])
    assert alpha**3+alpha+1==0
    base=CurveAlgebra(field,alpha,raw['R'],raw['A'])
    fixed=[vector(field,[decode(co) for co in row]) for row in case['as_basis']]
    plane=case['planes'][args.plane]
    coefficient_basis=[vector(prime,v) for v in plane['coefficient_basis']]
    complement=next(vector(prime,[int(i==j) for i in range(3)]) for j in range(3)
                    if matrix(prime,coefficient_basis+[
                        vector(prime,[int(i==j) for i in range(3)])]).rank()==3)
    as_class=lambda v:sum((field(a)*w for a,w in zip(v,fixed)),vector(field,[0,0,0]))
    chi1,chi2=[base.from_h1o(as_class(v)) for v in coefficient_basis]
    chi3=base.from_h1o(as_class(complement))
    affine=[]
    infinity=[]
    for chi in [chi1,chi2]:
        cocycle=base.add(base.frob(chi),base.neg(chi))
        co,uu,oo=base.split(cocycle,tangent=False)
        assert not any(co)
        affine.append(uu)
        infinity.append(base.neg(oo))
    f1,f2=affine
    g1,g2=infinity
    cross=base.add(base.neg(base.mul(base.frob(chi1),f2)),base.mul(g1,chi2))
    rhs=vector(field,[-a for a in base.split(cross,tangent=False)[0]])
    matrix_frob=matrix(field,3,3,lambda i,j:
        base.split(base.frob(base.mono(*base.obasis[j])),tangent=False)[0][i],
        implementation='generic')
    flatten=lambda v:vector(prime,[a for x in v for a in encode(x)])
    unflatten=lambda v:vector(field,[sum((field(v[degree*j+i])*c**i for i in range(degree)),field(0))
                                   for j in range(3)])
    columns=[]
    for j in range(3):
        for i in range(degree):
            v=vector(field,[0,0,0]);v[j]=c**i
            columns.append(flatten(matrix_frob*vector(field,[a**5 for a in v])-v))
    lang=matrix(prime,columns).transpose()
    assert lang.right_kernel().dimension()==3
    primitive=unflatten(lang.solve_right(flatten(rhs)))
    assert matrix_frob*vector(field,[a**5 for a in primitive])-primitive==rhs
    kappa=base.add(base.from_h1o(primitive),base.scale(chi3,field(args.central)))
    error=base.add(cross,base.add(base.frob(kappa),base.neg(kappa)))
    co,uu,oo=base.split(error,tangent=False)
    assert not any(co)
    f3=base.neg(uu);g3=oo
    assert base.add(base.add(f3,cross),base.add(base.frob(kappa),base.neg(kappa)))==g3
    torsor=TorsorAlgebra(base,f1,f2,f3,chi1,chi2,kappa)
    # Exact defining-equation compatibility of BOTH charts.
    assert base.add(f1,base.neg(base.add(base.frob(chi1),base.neg(chi1))))==g1
    assert base.add(f2,base.neg(base.add(base.frob(chi2),base.neg(chi2))))==g2
    for f in [f1,f2,f3]:assert all(int(e)>=0 for lp in f for e in lp.dict())
    for g in [g1,g2,g3]:
        assert all(2*int(e)+base.poles[i]<=0
                   for i,lp in enumerate(g) for e in lp.dict())
    setup=time.monotonic()-started
    result=dict(status='pilot',case=args.case,plane=args.plane,central=args.central,
        plane_rank=plane['rank'],base_plane=plane['pulled_back_from_B'],
        field_modulus=[int(v) for v in field.modulus()],alpha=encode(alpha),
        as_plane_coefficients=[list(map(int,v)) for v in coefficient_basis],
        central_complement=list(map(int,complement)),
        gluing={name:base.encode(value,encode) for name,value in
                [('chi1',chi1),('chi2',chi2),('kappa',kappa)]},
        affine_rhs=[base.encode(v,encode) for v in [f1,f2,f3]],
        infinity_rhs=[base.encode(v,encode) for v in [g1,g2,g3]],
        setup_seconds=setup,columns=[],column_times=[],
        column_kind='deck_h' if args.deck_generator_columns else 'Hodge',
        scope='Actual smooth etale Heisenberg torsor; partial Hodge columns until all750 and rank verified.')
    print(json.dumps(dict(stage='actual_torsor_setup',case=args.case,plane=args.plane,
                         plane_rank=plane['rank'],seconds=setup)),flush=True)
    def save():
        result['seconds']=time.monotonic()-started
        Path(args.output).write_text(json.dumps(result,separators=(',',':'))+'\n')
    save()
    if args.deck_generator_columns:
        deck_images=[torsor.w[0],torsor.add(torsor.w[1],torsor.one),
                     torsor.add(torsor.w[2],torsor.w[0])]
        deck_powers=[torsor.powers(w) for w in deck_images]
        deck_cache={}
    alarm(args.seconds)
    try:
        for column in range(args.start_column,min(750,args.start_column+args.columns)):
            tick=time.monotonic()
            monomial=torsor.indices[column//6]
            component,power=base.basis[column%6]
            if args.deck_generator_columns:
                leading=base.mono(component,power)
                image=torsor.monomial_image(monomial,deck_powers,deck_cache)
            else:
                leading=base.scale(base.frob(base.mono(component,power)),base.A)
                image=torsor.monomial_image(monomial,torsor.frob_powers,torsor.frob_cache)
            reduced=torsor.reduce_cohomology(torsor.scaled(image,leading))
            elapsed=time.monotonic()-tick
            result['columns'].append(dict(column=column,monomial=list(monomial),
                                          entries={str(i):encode(v) for i,v in reduced.items()}))
            result['column_times'].append(elapsed)
            if len(result['columns'])%max(1,args.report_every)==0:
                save()
                print(json.dumps(dict(stage=result['column_kind']+'_column',column=column,
                    weight=monomial[0]+monomial[1]+2*monomial[2],seconds=elapsed,
                    total_seconds=time.monotonic()-started,nonzero=len(reduced))),flush=True)
        result['status']='columns_complete' if len(result['columns'])==750 else 'pilot_complete'
    except AlarmInterrupt:
        result['status']='time_limit_saved_completed_columns'
    finally:
        cancel_alarm();save()
    print(json.dumps({key:result[key] for key in ['status','seconds','setup_seconds']}
                     | dict(completed_columns=len(result['columns']),
                            column_seconds=sum(result['column_times']))),flush=True)


if __name__=='__main__':main()
