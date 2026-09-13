#!/usr/bin/env sage
"""Bounded norm-membership diagnostic using all twelve incidence rows.

A nonzero remainder is not an atlas solution. A saved membership candidate
is not an exclusion until explicit multipliers replay against all originals.
"""
import argparse,json,time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def run(tensor,chart,seconds,max_power):
    started=time.monotonic();data=json.loads(Path(tensor).read_text())
    prime=PolynomialRing(GF(5),'x')
    k=GF(5**data['field_degree'],name='c',modulus=prime(data['field_modulus']))
    decode=lambda cs:k(prime(cs))
    names=['p'+str(i) for i in range(4)]+['b'+str(j) for j in range(chart+1,4)]
    R=PolynomialRing(k,names=names,order='degrevlex');pp=list(R.gens()[:4])
    bb=[R.zero()]*chart+[R.one()]+list(R.gens()[4:])
    original=[sum(decode(data['I'][h][j])*bb[j] for j in range(4))+
        sum(decode(data['tensor'][i][j][h])*pp[i]*bb[j]**5 for i in range(4) for j in range(4)) for h in range(12)]
    norm=sum(decode(data['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4))
    try:
        alarm(max(1,seconds-(time.monotonic()-started)))
        gb=list(R.ideal(original).groebner_basis(algorithm='libsingular:std'))
        print('incidence basis seconds',time.monotonic()-started,'length',len(gb),flush=True)
        if gb==[R.one()]:print('INCIDENCE UNIT CANDIDATE; no lift yet',flush=True);return
        rem=R.one()
        for exponent in range(1,max_power+1):
            rem=(rem*norm).reduce(gb)
            print('norm power',exponent,'remainder terms',len(rem.dict()),'seconds',time.monotonic()-started,flush=True)
            if not rem:
                print('NORM MEMBERSHIP CANDIDATE; no lift yet',flush=True);break
    except (AlarmInterrupt,KeyboardInterrupt):print('bounded incidence diagnostic incomplete',time.monotonic()-started,flush=True)
    finally:cancel_alarm()


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor',required=True);parser.add_argument('--chart',type=int,default=0)
    parser.add_argument('--seconds',type=int,default=15);parser.add_argument('--max-power',type=int,default=4)
    args=parser.parse_args();run(args.tensor,args.chart,args.seconds,args.max_power)
