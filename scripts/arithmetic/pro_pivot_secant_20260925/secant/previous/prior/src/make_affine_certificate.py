"""Regenerate the affine-label Bezout certificate without a CAS."""
import argparse
import json
from pathlib import Path
from algebra_checks import recompute_affine
from finite25 import egcd, pm, pa

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    root = Path(__file__).resolve().parents[1]
    endpoint = json.loads((root/'data/endpoint.json').read_text())
    H,R,pivot,G = recompute_affine(endpoint)
    g = G[0]
    B = [[1],[],[]]
    for k in range(1,3):
        g,s,t = egcd(g,G[k])
        B = [pm(s,b) for b in B]
        B[k] = pa(B[k],t)
    data = {'H':H,'pivot':pivot,'R':R,'G':G,'bezout':B,'gcd':g}
    args.output.write_text(json.dumps(data,indent=2)+'\n')
    print('Regenerated exact affine-label certificate:', args.output)
if __name__ == '__main__':
    main()
