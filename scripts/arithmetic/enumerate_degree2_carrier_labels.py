#!/usr/bin/env python3
"""Build exact Frobenius/A4 label orbits for the backup Prym-factor sieve.

No curve equations or Jacobian factors are computed. Integer bitsets
replace repeated extension-field object construction in this finite step.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path

p=argparse.ArgumentParser(description=__doc__);p.add_argument('output',type=Path)
args=p.parse_args();start=time.monotonic()
exponents=[0,2,3,6,7,9,11,12,15,16,18];mod=sum(1<<i for i in exponents)
size=1<<18
def step(x):
    x<<=1
    return x^mod if x&size else x
def mul(x,y):
    answer=0
    while y:
        if y&1:answer^=x
        x=step(x);y>>=1
    return answer
rho=1
for _ in range(57):rho=step(rho)
assert mul(rho,rho)^rho==1 and rho!=1
seen=bytearray(size);seeds=[];line_seeds=[]
for x in range(1,size):
    if seen[x]:continue
    orbit=[];z=x
    for j in range(171):
        assert not seen[z];seen[z]=1;orbit.append(z);z=step(z)
    assert z==x
    seeds.append(x)
    lines=[min(orbit[j],orbit[j+57],orbit[j+114]) for j in range(57)]
    assert len(set(lines))==57
    line_seeds.append(min(lines))
assert sum(seen)==size-1 and len(seeds)==1533 and seeds==line_seeds

# Independent slow binary-polynomial multiplication verifies each full
# orbit and its F4-line grouping without the recurrence's reduction rule.
def slow_mul(a,b):
    prod=0
    for j in range(b.bit_length()):
        if (b>>j)&1:prod^=a<<j
    while prod.bit_length()>18:prod^=mod<<(prod.bit_length()-19)
    return prod
independent_seen=set()
for x in seeds:
    y=x
    for j in range(57):
        triple=(y,slow_mul(y,rho),slow_mul(y,slow_mul(rho,rho)))
        assert not independent_seen.intersection(triple)
        independent_seen.update(triple);y=slow_mul(y,2)
    assert y==slow_mul(x,rho)
assert len(independent_seen)==size-1
certificate=dict(schema=1,mod2_exponents=exponents,
    frobenius_multiplier=2,rho_multiplier=rho,seeds=seeds,
    carrier_labels=87381,carrier_orbit_length=57,carrier_orbits=1533,
    covered_nonzero_double_labels=262143,independent_partition_replay='PASS',
    seconds=time.monotonic()-start,
    scope='Necessary carrier-label partition only; no genus8 model or factor test')
with args.output.open('x') as f:json.dump(certificate,f,indent=2);f.write('\n')
print(json.dumps({k:v for k,v in certificate.items() if k!='seeds'}|{
    'certificate_sha256':hashlib.sha256(args.output.read_bytes()).hexdigest()},indent=2))
