"""Normalize two scalar elimination certificates and their Bezout pair.
The operation only rescales by nonzero K constants; no localization changes.
"""
from algebra import *
import argparse

def row_read(line):
    a=list(map(int,line.split()));assert a[0]==len(a)-1;return a[1:]
def row_write(a):return str(len(a))+' '+ ' '.join(map(str,a))+'\n'
def main():
    p=argparse.ArgumentParser();p.add_argument('certificate71');p.add_argument('certificate72');p.add_argument('unit');p.add_argument('output_prefix');args=p.parse_args()
    lc=[]
    for n,path in zip([71,72],[args.certificate71,args.certificate72]):
        rows=[row_read(line) for line in Path(path).read_text().splitlines()]
        assert len(rows)==8 and rows[1]==[1];c=rows[0][-1];lc.append(c)
        for j in [0,2,3,4,5,6,7]:rows[j]=[mul(v,inv(c)) for v in rows[j]]
        Path(args.output_prefix+f'_C{n}_certificate.txt').write_text(''.join(row_write(a) for a in rows))
        Path(args.output_prefix+f'_C{n}_norm.txt').write_text(row_write(rows[0]))
    rows=[row_read(line) for line in Path(args.unit).read_text().splitlines()];assert len(rows)==3 and rows[0]==[1]
    rows[1]=[mul(c,lc[0]) for c in rows[1]];rows[2]=[mul(c,lc[1]) for c in rows[2]]
    Path(args.output_prefix+'_unit.txt').write_text(''.join(row_write(a) for a in rows))
    print('PASS: monic elimination scalars; certificate and Bezout cofactors rescaled exactly.')
if __name__=='__main__':main()
