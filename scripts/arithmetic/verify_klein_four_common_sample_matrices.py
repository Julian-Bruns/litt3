#!/usr/bin/env python3
"""Compare all entries of2008 native matrices to the accepted exact builder.

This is an implementation cross-check on fixed samples, not a second
enumeration of the full63,526,008 endpoint pairs.
"""
import argparse
import csv
from pathlib import Path
from klein_four_general_fourth_traces import F, M


def main(prefix):
    with Path(str(prefix)+'.samples.tsv').open() as f:
        samples=list(csv.DictReader(f,delimiter='\t'))
    mats=[[int(v) for v in line.split()] for line in Path(str(prefix)+'.sample_matrices.tsv').read_text().splitlines()]
    assert len(samples)==len(mats)==2008
    for r,m in zip(samples,mats):
        q=[int(r['q'+str(i)]) for i in range(4)]
        h=[int(r['h'+str(i)]) for i in range(4)]
        *_,const,cols,system=M.data(q,h)
        expected=[[cols[j][i] for j in range(4)]+[F.neg(const[i])] for i in range(8)]
        assert m==[v for row in expected for v in row],(q,h)
        assert expected[1:]==system
    with Path(str(prefix)+'.candidates.tsv').open() as f:
        candidates=list(csv.DictReader(f,delimiter='\t'))
    first={tuple(int(r['q'+str(i)]) for i in range(4)) for r in candidates}
    actual={(tuple(int(r['q'+str(i)]) for i in range(4)),tuple(int(r['h'+str(i)]) for i in range(4))) for r in candidates}
    expected={(q,tuple(29*i+j for i in range(4))) for q in first for j in range(29)}
    assert len(first)==8 and len(candidates)==len(actual)==232 and actual==expected
    print('PASS: all80320 native matrix entries agree with the accepted elementary coefficient builder.')
    print('PASS: the232 retained pairs are exactly the29 balanced second endpoints for each of eight first endpoints.')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('prefix',type=Path)
    main(p.parse_args().prefix)
