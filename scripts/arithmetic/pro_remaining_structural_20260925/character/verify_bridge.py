"""Verify the continuation input is exactly a selection of parent DAG members.
Membership of the parent members is checked separately by verify_dag.cpp.
"""
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]
def main():
    name='matched_chart0_minimal'
    meta=json.loads((ROOT/f'data/{name}_provenance.json').read_text())
    chosen=meta['selected_node_ids'];wanted=set(chosen);polys={}
    with open(ROOT/meta['parent_dag']) as f:
        h=f.readline().split();assert h[0]=='MODULE_DAG_V1';nv,nc,ns=map(int,h[1:])
        for line in f:
            h=line.split()
            if h[0] in ['STOP','END']:break
            if h[0]=='INIT':idx,nt=map(int,h[1:]);nr=0
            elif h[0]=='ADD':idx,i,j,sc,nt,nr=map(int,h[1:])
            else:raise AssertionError('Unexpected parent record')
            terms=[]
            for _ in range(nt):
                row=f.readline().split();assert row[0]=='T'
                if idx in wanted:terms.append(tuple(map(int,row[1:])))
            for _ in range(nr):assert f.readline().startswith('R ')
            if idx in wanted:polys[idx]=terms
    assert set(polys)==wanted and len(chosen)==len(wanted)
    with open(ROOT/f'data/{name}.txt') as f:
        assert tuple(map(int,f.readline().split()))==(nv,nc,len(chosen))
        for idx in chosen:
            nt=int(f.readline());assert nt==len(polys[idx])
            for expected in polys[idx]:assert tuple(map(int,f.readline().split()))==expected
        assert not f.read().strip()
    print('PASS: continuation input consists exactly of the selected parent DAG members; no completeness or minimality assertion')
if __name__=='__main__':main()
