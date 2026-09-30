#!/usr/bin/env python3
"""Direct polynomial checks of constant and linear mixed-node pencils.

Independent of the exhaustive group-ring endpoint formulas. Complete
coverage remains in the C++ enumerators, whose final counts are checked.
"""
import argparse,hashlib,json,random,re
from pathlib import Path
import check_klein_four_constant_pencils as P
T=P.T;Z=P.Z;O=P.O


def ev(poly,x):
    out=Z
    for c in reversed(poly):out=T.add(T.mul(out,x),c)
    return out


def build(C,Ts,z):
    quotient,_=P.divide([Z]*22+Ts,C)
    az=T.sub(T.mul(T.mul(P.power(z,22),ev(Ts,z)),T.inv(ev(C,z))),P.scale(ev(quotient,z),2))
    quotient=[P.scale(v,2) for v in quotient];quotient[0]=T.add(quotient[0],az)
    F=P.pm(C,quotient)
    assert ev(F,z)==T.mul(P.power(z,22),ev(Ts,z))
    return F


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('root',type=Path);a=ap.parse_args()
    zs=[P.power((0,1,0,0,0,0,0),i) for i in range(29)];rng=random.Random(26092643);records=[]
    for d in [0,1]:
        for rep in range(24):
            J=sorted(rng.sample(range(29),15-2*d));node=rng.choice(J);z=zs[node]
            C=[O];alpha=Z
            for i in range(29):
                if i not in J:C=P.pm(C,[T.neg(zs[i]),O])
                else:alpha=T.add(alpha,zs[-i%29])
            if d==0:
                # Build the unique word with first value0, and compare its
                # first derivative to the independent old-pencil formula.
                qp,_=P.divide([Z]*22+[O],P.pm(C,[T.neg(z),O]))
                cp=P.pm(C,[T.neg(z),O]);old=P.scale(T.mul(cp[0],qp[1]),2)
                jp=[O]
                for i in J:
                    if i!=node:jp=P.pm(jp,[T.neg(zs[i]),O])
                intercept=T.add(old,T.mul(T.mul(cp[0],P.power(z,21)),ev(jp,z)))
                q,_=P.divide([Z]*22+[O],C);av=T.neg(P.scale(q[0],2))
                bv=T.mul(T.sub(T.sub(T.mul(P.power(z,22),T.inv(ev(C,z))),P.scale(ev(q,z),2)),av),T.inv(z))
                q=[P.scale(v,2) for v in q];q[0]=T.add(q[0],av);q[1]=T.add(q[1],bv)
                word=P.pm(C,q)
                assert word[0]==Z and word[1]==intercept and ev(word,z)==P.power(z,22)
            else:
                word0,word1=build(C,[O],z),build(C,[Z,O],z)
                B0,B1,D0,D1=word0[0],word1[0],word0[1],word1[1]
                expected=(B1,P.scale(O,4),T.add(D1,B0),T.sub(T.mul(D0,B1),T.mul(D1,B0)))
                hs=[O]
                for i in J:hs=P.pm(hs,[O,T.neg(zs[i])])
                a0=Z
                for j in range(13):a0=T.add(a0,P.scale(T.mul(hs[j],zs[((6-j)*node)%29]),(j+(2 if j>=7 else 0))%5))
                b0=T.mul(C[0],T.add(P.scale(hs[6],2),a0));delta=T.mul(T.mul(C[0],z),a0)
                d0=T.add(T.mul(alpha,b0),P.scale(T.mul(C[0],hs[5]),2))
                d1=T.add(T.mul(alpha,delta),P.scale(T.mul(C[0],hs[6]),2))
                actual=(delta,P.scale(O,4),T.add(d1,b0),T.sub(T.mul(d0,delta),T.mul(d1,b0)))
                assert actual==expected
            records.append({'d':d,'J':J,'unused_node':node,'direct_polynomial_identity':True})
    # All31 degenerate linear pencils have a nonzero fixed first ratio
    # whose29th power is not even in F25, hence cannot be a forced label.
    degenerate=[]
    for mask,node in re.findall(r'^HIT d=0 mask=(\d+) node=(\d+)',(a.root/'minimum_word_missing_nodes_low.log').read_text(),re.M):
        mask,node=int(mask),int(node);C=[O]
        for j in range(29):
            if not mask>>j&1:C=P.pm(C,[T.neg(zs[j]),O])
        q,_=P.divide([Z]*22+[O],C)
        fixed=P.scale(T.mul(C[0],q[0]),2);norm=P.power(fixed,29)
        assert fixed!=Z and any(norm[1:])
        degenerate.append({'mask':mask,'node':node,'fixed_ratio':fixed,'norm29':norm})
    assert len(degenerate)==31
    cl=(a.root/'mixed_constant_rational.log').read_text()
    assert 'normalized_subsets=37442160 representatives=191280 covered=37442160 nodes=2869200 matching_labels=0' in cl
    nr=json.loads((a.root/'mixed_constant_nonrational.json').read_text());assert nr['count']==675 and nr['matches']==[]
    ll=(a.root/'mixed_linear_pencil.log').read_text()
    total=re.search(r'^TOTAL (.*)$',ll,re.M);assert total,'linear enumeration incomplete'
    counts=dict((k,int(v)) for k,v in re.findall(r'(\w+)=(\d+)',total[1]))
    assert counts['normalized']==counts['covered']==30421755 and counts['representatives']==167367
    assert counts['nodes']==2175771 and counts['degenerate']==31
    assert counts['nonrational_hits']==counts['quartic_hits']==0
    rl=(a.root/'mixed_linear_rational.log').read_text()
    rtotal=re.search(r'^TOTAL (.*)$',rl,re.M);assert rtotal
    rcounts=dict((k,int(v)) for k,v in re.findall(r'(\w+)=(\d+)',rtotal[1]))
    assert rcounts['normalized']==rcounts['covered']==30421755 and rcounts['representatives']==167367
    assert rcounts['nodes']==2175771 and rcounts['degenerate']==31 and rcounts['rational_hits']==0
    assert 'MODE rational_only' in rl
    paths=[a.root/n for n in ['mixed_constant_rational.log','mixed_constant_nonrational.json','mixed_linear_pencil.log','mixed_linear_rational.log']]
    out={'status':'PASS','scope':'48 independent direct polynomial reconstructions and exact full-log counts. The675 nonrational constant tests reuse the complete prior additive incidence list.',
         'linear_counts':counts,'rational_linear_counts':rcounts,'direct_checks':records,'degenerate_linear_exclusions':degenerate,'sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}}
    (a.root/'mixed_pencils_independent.json').write_text(json.dumps(out,indent=2)+'\n')
    print('PASS:48 direct polynomial checks and all complete mixed-pencil coverage counts.')


if __name__=='__main__':main()
