#!/usr/bin/env python3
"""Independently reconstruct every exceptional minimum word by polynomial division.

The exhaustive C++ orbit counts provide coverage. This checker uses direct
coefficient matrices, not the complementary-root Hankel/cofactor formula.
"""
import argparse,collections,hashlib,json,re
from pathlib import Path
import check_klein_four_minimum_words as F


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('root',type=Path);a=ap.parse_args()
    hits=collections.defaultdict(list);totals={};paths=[]
    for name in ['minimum_word_missing_nodes_low.log','minimum_word_missing_nodes_high.log']:
        path=a.root/name;paths.append(path)
        for line in path.read_text().splitlines():
            vals=dict((k,int(v)) for k,v in re.findall(r'(\w+)=(\d+)',line))
            if line.startswith('HIT'):hits[(vals['d'],vals['mask'])].append(vals['node']);assert vals['Tzero']==0
            if line.startswith('TOTAL'):totals[vals['d']]=vals
    expected=[(30421755,167367,31),(13123110,85358,12),(3108105,24739,3),
              (376740,3872,2),(20475,299,0),(378,10,0)]
    for d,(n,r,h) in enumerate(expected):
        v=totals[d];assert(v['normalized'],v['representatives'],v['covered'],v['nodes'],v['hits'])==(n,r,n,r*(13-2*d),h)
    assert len(hits)==48 and all(len(v)==1 for v in hits.values())
    zs=[F.power((0,1,0,0,0,0,0),i) for i in range(29)];rows=[]
    for (d,mask),nodes in sorted(hits.items()):
        J=[i for i in range(29) if mask>>i&1];C=[F.O]
        for i in range(29):
            if i not in J:C=F.pmul(C,[F.neg(zs[i]),F.O])
        nq=6-d
        def coeff(i):return C[i] if 0<=i<len(C) else F.Z
        mat=[[coeff(j-k) for k in range(nq+1)] for j in range(16+d,22)]
        Q=F.kernel_one(mat,nq+1);G=F.pmul(C,Q)
        assert all(G[j]==F.Z for j in range(16+d,22))
        T=[F.scale(G[22+j],3) for j in range(d+1)]
        actual=[]
        for j in J:
            tv=F.polyval(T,zs[j]);gv=F.polyval(G,zs[j])
            if gv==F.mul(zs[22*j%29],tv):actual.append(j);assert tv!=F.Z
        assert actual==nodes
        rows.append({'d':d,'mask':mask,'unique_exceptional_node':nodes[0]})
    path=a.root/'zero_endpoint_individual_jets.log';paths.append(path)
    line=path.read_text().strip();vals=dict((k,int(v)) for k,v in re.findall(r'(\w+)=(\d+)',line))
    assert vals=={'character_tests':804837,'zero_B':345,'zero_B_nonzero_A':0,
                  'nonzero_B_zero_derivative':0,'zero_B_individual_jet_checks':345,'zero_B_nonzero_first_jet':0}
    data={'status':'PASS','scope':'Exact complete orbit counts plus independent reconstruction of all48 exceptional minimum words; separate complete zero-leading-value first-jet test.',
          'totals':totals,'exceptions':rows,'source_hashes':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}}
    (a.root/'missing_nodes_independent.json').write_text(json.dumps(data,indent=2)+'\n')
    print('PASS: all48 exceptions reconstructed, at most one missing-node match per minimum word; complete individual-jet zero check.')


if __name__=='__main__':main()
