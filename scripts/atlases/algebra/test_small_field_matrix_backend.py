#!/usr/bin/env python3
"""Reproduce small-field optimized-matrix disagreement; verify safe backend.

Run with sage -python. This tests arithmetic, not a geometric theorem.
"""
import json
from sage.all import GF,PolynomialRing,matrix,identity_matrix

P=PolynomialRing(GF(5),'z');z=P.gen();results=[]
for coefficients in ([2,0,1],[2,4,1],[3,4,1,4,1]):
    for implementation in ('givaro','pari_ffelt'):
        k=GF(5**(len(coefficients)-1),'t',modulus=P(coefficients),impl=implementation)
        t=k.gen();M=matrix(k,[[4*t+1,3*t+3],[3,3]],implementation='generic')
        N=matrix(k,2,2,[c**5 for c in M.list()],implementation='generic')
        manual=matrix(k,2,2,lambda i,j:sum(M[i,h]*N[h,j] for h in range(2)),implementation='generic')
        generic=matrix(k,M,implementation='generic')*matrix(k,N,implementation='generic')
        native_error=None
        try:native=matrix(k,M.list(),nrows=2)*matrix(k,N.list(),nrows=2)
        except AttributeError as exc:native=None;native_error=str(exc)
        assert generic==manual
        item=dict(modulus=coefficients,field_implementation=implementation,
            native_matches_manual=(native==manual),native_error=native_error,
            generic_matches_manual=True,native=str(native),manual=str(manual))
        results.append(item)
print(json.dumps(results,indent=2))
