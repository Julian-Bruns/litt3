#!/usr/bin/env python3
"""Necessary cyclotomic contact targets for c=15,d=0 Hermite pencils.

Reads the complete Moore-label test. Does not claim a geometric solution
or exclusion until the separate subset equations have been checked.
"""
import argparse
import json
import re
from pathlib import Path
import klein_four_constant_character_jet as J
import check_klein_four_constant_character_jet as N

F=J.F
ZERO=(0,)*7;ONE=(1,)+(0,)*6


def add(a,b):return tuple(F.f.add(x,y) for x,y in zip(a,b))
def neg(a):return tuple(F.f.neg(x) for x in a)
def sub(a,b):return add(a,neg(b))
def mul(a,b):
    v=F.f.rem(F.f.pm(list(a),list(b)),F.D7)
    return tuple(v+[0]*(7-len(v)))
def inv(a):
    assert a!=ZERO
    g,s,_=F.f.egcd(list(a),F.D7)
    assert g==[1]
    s=F.f.rem(s,F.D7)
    return tuple(s+[0]*(7-len(s)))
def coord(a,i):return tuple(v[i] for v in a)


def solve(bb,ab,num):
    bb=[coord(bb,i) for i in range(4)]
    ab=[coord(ab,i) for i in range(4)]
    num=[coord(num,i) for i in range(4)]
    i=next(i for i in range(4) if bb[i]!=ZERO)
    for j in range(4):
        den=sub(mul(ab[j],bb[i]),mul(ab[i],bb[j]))
        if den!=ZERO:
            slope=mul(sub(mul(num[j],bb[i]),mul(num[i],bb[j])),inv(den))
            intercept=mul(sub(num[i],mul(slope,ab[i])),inv(bb[i]))
            assert all(add(mul(slope,ab[k]),mul(intercept,bb[k]))==num[k] for k in range(4))
            return {'kind':'nonrational','slope':slope,'intercept':intercept}
    r=mul(ab[i],inv(bb[i]));s=mul(num[i],inv(bb[i]))
    assert all(mul(s,bb[k])==num[k] for k in range(4))
    return {'kind':'rational','r':r,'s':s}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('label_log',type=Path)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    old=F.construct_data();roots=list(map(tuple,old['alpha_roots']));bases=list(map(tuple,old['B_base']))
    om=(F.ZERO,F.ONE)+(F.ZERO,)*5
    powers=[N.power(om,i) for i in range(29)]
    constants=[]
    for a in roots:
        av=F.ev(F.f.der(F.f.A),a);cv=F.es(F.ei(av),13)
        lv=F.em(cv,F.ea(F.em(F.ev(F.f.der(F.f.P),a),F.ei(F.ev(F.f.P,a))),F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),a),F.ei(av)))))
        constants.append((cv,lv))
    targets=[];zero_alpha=0
    rx=re.compile(r'LABEL roots=([0-3,]+) exponents=([0-9,]+) mask3=(\d+) mask4=(\d+)')
    for line in args.label_log.read_text().splitlines():
        m=rx.fullmatch(line)
        if not m:continue
        tags=list(map(int,m[1].strip(',').split(',')))
        exps=list(map(int,m[2].split(',')));mask=int(m[3])
        eligible=[]
        for i,signs in enumerate(J.SIGNS):
            if not mask&(1<<i):continue
            av=F.ZERO
            for tag,sign in zip(tags,signs):av=F.ea(av,F.es(roots[tag],sign))
            if av==F.ZERO:zero_alpha+=1
            else:eligible.append(i)
        if not eligible:continue
        labels=[]
        for j,e in zip(tags,exps):
            b=N.times(N.lift(bases[j]),powers[e]);cv,lv=constants[j]
            labels.append((N.lift(roots[j]),b,N.times(N.lift(cv),N.power(b,4)),N.times(N.lift(lv),N.power(b,5))))
        for i,signs in enumerate(J.SIGNS):
            if i not in eligible:continue
            vals=[]
            for k in range(4):
                v=N.Z
                for sign,label in zip(signs,labels):v=N.plus(v,N.scalar(label[k],sign))
                vals.append(v)
            a,b,da,db=vals
            assert a!=N.Z
            assert b!=N.Z
            bb=N.times(b,b);ab=N.times(a,b);num=N.minus(N.times(da,b),N.times(a,db))
            target=solve(bb,ab,num)
            if target['kind']=='nonrational':
                try:
                    mp=solve(bb,ab,N.times(a,a))
                    assert mp['kind']=='nonrational'
                    target['minimal_trace']=mp['slope'];target['minimal_constant']=mp['intercept']
                except AssertionError:
                    target['degree_over_M']=4
            target.update(roots=tags,exponents=exps,character=i)
            targets.append(target)
    unique={}
    for t in targets:
        core={k:v for k,v in t.items() if k in ('kind','slope','intercept','r','s','minimal_trace','minimal_constant','degree_over_M')}
        key=json.dumps(core,sort_keys=True)
        unique.setdefault(key,dict(core,examples=[]))['examples'].append({k:v for k,v in t.items() if k not in core})
    out={'scope':'Necessary c=15,d=0 endpoint targets, common B phase normalized by the mu29 parameter symmetry.',
         'status':'targets_only','rational_targets':[x for x in unique.values() if x['kind']=='rational'],
         'nonrational_targets':[x for x in unique.values() if x['kind']=='nonrational'],
         'retained_label_characters':len(targets),'zero_alpha_characters_skipped':zero_alpha}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    with args.output.with_suffix('.dat').open('w') as f:
        print(len(out['nonrational_targets']),file=f)
        for t in out['nonrational_targets']:print(*t['slope'],*t['intercept'],file=f)
        print(len(out['rational_targets']),file=f)
        for t in out['rational_targets']:print(*t['r'],*t['s'],file=f)
    print('Targets:',len(out['nonrational_targets']),'nonrational,',len(out['rational_targets']),'rational; label characters',len(targets),flush=True)


if __name__=='__main__':main()
