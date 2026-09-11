#!/usr/bin/env python3
"""Bounded actual fixed-X Jacobian arithmetic diagnostic.

Tests Sage's documented Khuri--Makdisi models before attempting explicit
two-torsion/carrier construction. No finite-point or cover exclusion is made.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,FunctionField,ZZ
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('out',type=Path)
p.add_argument('--model',choices=['km_small','km_medium','km_large','hess'],default='km_small')
p.add_argument('--seconds',type=int,default=120)
p.add_argument('--scalar',type=int,default=100)
p.add_argument('--constant-degree',type=int,default=2,
               help='Even degree over F5;342 contains all fixed-X geometric two-torsion')
p.add_argument('--random-point',action='store_true')
p.add_argument('--skip-order-check',action='store_true')
args=p.parse_args();args.out.mkdir(exist_ok=False)
started=time.monotonic();events=[]
def report(stage,**kw):
    event=dict(stage=stage,seconds=time.monotonic()-started,**kw)
    events.append(event);print(json.dumps(event),flush=True)
    (args.out/'progress.json').write_text(json.dumps(events,indent=2)+'\n')

alarm(args.seconds)
try:
    assert args.constant_degree>=2 and args.constant_degree%2==0
    if args.constant_degree==2:
        k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));a=k.gen()
    else:
        k=GF(5**args.constant_degree,'b',modulus='random',impl='pari_ffelt')
        base_poly=PolynomialRing(k,'z')([2,4,1])
        a=base_poly.roots(multiplicities=False)[0]
        assert a*a+4*a+2==0
    report('constant_field_ready',constant_degree=args.constant_degree)
    K=FunctionField(k,'x');x=K.gen();KY=PolynomialRing(K,'Y');Y=KY.gen()
    f=x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6+4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+(2*a+1)
    F=K.extension(Y**3-f,'y');y=F.gen()
    assert F.genus()==9
    poles=F(x).divisor_of_poles();support=poles.support()
    assert len(support)==1 and support[0].degree()==1
    infinity=support[0];infinity_divisor=infinity.divisor()
    assert poles==3*infinity_divisor
    report('actual_function_field_ready',genus=9)
    degree=10 if args.model=='km_small' else 19
    J=F.jacobian(model=args.model,base_div=degree*infinity_divisor)
    group=J.group();zero=group.zero()
    report('jacobian_ready',model=args.model,base_divisor_degree=degree)
    if args.random_point or args.constant_degree>2:
        yy=PolynomialRing(k,'yy').gen();trials=0
        while True:
            trials+=1;value=k.random_element()
            image=k(f(value))
            roots=(yy**3-image).roots(multiplicities=False)
            if roots and image:
                place=F.maximal_order().ideal(x-value,y-roots[0]).place();break
        point_information=dict(random_trials=trials)
    else:
        places=F.places(1)
        place=next(P for P in places if P!=infinity)
        point_information=dict(rational_places=len(places))
    point=group.point(place.divisor()-infinity_divisor)
    report('actual_point_ready',point_zero=bool(point==zero),**point_information)
    test_started=time.monotonic();result=args.scalar*point
    assert result==point.multiple(args.scalar)
    assert point+(-point)==zero
    report('scalar_arithmetic_verified',scalar=args.scalar,
           arithmetic_seconds=time.monotonic()-test_started)
    # The established Frob25 polynomial gives this exact group order.
    coefficients=[3814697265625,-305175781250,-177001953125,13916015625,
        -1210937500,1451562500,48171875,-58884375,3536250,601875,
        141450,-94215,3083,3716,-124,57,-29,-2,1]
    if not args.skip_order_check:
        assert args.constant_degree==2,'Only the established F25 group order is used by this check'
        order=ZZ(sum(coefficients));test_started=time.monotonic()
        assert order*point==zero
        report('group_order_annihilation_verified',group_order=str(order),
               arithmetic_seconds=time.monotonic()-test_started)
    report('complete',scope='Actual fixed-X arithmetic benchmark only; no torsion or carrier enumeration')
except AlarmInterrupt:
    report('time_limit_no_verdict')
finally:
    cancel_alarm()
