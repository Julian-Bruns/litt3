"""Exhaustive optimization of NECESSARY integer-profile bounds, not curves.

Every tuple (s1,s2,s3,s4,j1,j2) with sum <= 29 is visited. The moment
conditions and nonlinear endpoint equations are NOT imposed. Consequently
this gives upper bounds, not realizability or actual maximal genera.
"""
import csv
import math
from pathlib import Path

FIELDS = ['n','genus_outer_bound','cubic_branch_lower_bound',
          's1','s2','s3','s4','j1','j2','e','j','b_cap','odd_correction']

def enumerate_bounds():
    best = {}
    visited = 0
    def process(counts):
        nonlocal visited
        visited += 1
        s1,s2,s3,s4,j1,j2 = counts
        n = 12+s1+2*s2+3*s3+4*s4+3*j1+6*j2
        if not 14 <= n <= 182:
            return
        s = s1+s2+s3+s4
        j = j1+j2
        e = s+j
        b = min(10,3+(e+1)//2)
        delta = 2*int(e <= 13 and e%2 == 1)
        old_intersection = 3*n-30-s2-3*s3-6*s4-2*j1-10*j2
        new_character = 3*b+2*j-3-delta
        genus = min(85,n+1,old_intersection,new_character)
        if genus < max(0,j-3):
            return
        row = [n,genus,8*n-3*genus+3,*counts,e,j,b,delta]
        if n not in best or genus > best[n][1]:
            best[n] = row
    def visit(prefix, remaining):
        if len(prefix) == 5:
            for c in range(remaining+1):
                process(prefix+(c,))
        else:
            for c in range(remaining+1):
                visit(prefix+(c,),remaining-c)
    visit((),29)
    assert visited == math.comb(35,6) == 1623160
    assert sorted(best) == list(range(14,183))
    rows = [best[n] for n in sorted(best)]
    assert all(row[1] <= row[0]+1 for row in rows)
    assert all(row[1] <= row[0] for row in rows if row[0]%2)
    assert all(row[0] in range(26,55,2) for row in rows if row[1]==row[0]+1)
    assert min(row[2] for row in rows) == 88
    return rows,visited

def write_bounds(path: Path):
    rows,visited = enumerate_bounds()
    with path.open('w',newline='') as f:
        w = csv.writer(f,lineterminator='\n');w.writerow(FIELDS);w.writerows(rows)
    return visited

def verify_bounds(path: Path):
    rows,visited = enumerate_bounds()
    with path.open(newline='') as f:
        reader = csv.reader(f)
        assert next(reader) == FIELDS
        actual = [[int(x) for x in row] for row in reader]
    assert actual == rows
    print(f'PASS relaxed integer-profile enumeration: {visited} tuples; all 169 degrees retained.')
    print('     This is NOT a geometric search. The recorded minimum cubic branch bound is 88.')
    print('     Updated small-degree genus upper bounds: '+', '.join(f'n={row[0]}: {row[1]}' for row in rows[:4]))

if __name__ == '__main__':
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument('--output',type=Path,required=True)
    args = ap.parse_args()
    print('Wrote relaxed profile bounds; tuples checked:',write_bounds(args.output))
