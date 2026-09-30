#!/usr/bin/env python3
"""Full deterministic verification entry point. No network access is used.
Runs all finite-field checks, all genus-one tuples, all three certificates,
symbolic formula audits, and independent reference-arithmetic spot checks.
Compiles C++ in a temporary directory and does not alter the archive.
"""
from pathlib import Path
import argparse,hashlib,json,os,platform,subprocess,sys,tempfile
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
from ff25 import *
from genus2_boundary import certify,A,P,MOD,kpow,kmul,as4
from genus1_boundary import locdata,setup_evaluator,case_polynomials,testpoly
from certificate_tools import genus1_records,orbit_representatives
from make_cpp_input import input_arrays,header_text
from reference_field import ReferenceField
from reference_boundary import genus0_values
import numpy as np
import sympy

def require(condition,message):
 if not condition:raise AssertionError(message)

def check_fields():
 problem=json.loads((ROOT/'data/problem.json').read_text())
 require(problem['P']==P and problem['A']==A,'portable problem polynomial rows')
 require(problem['coefficient_field']['minimal_polynomial_ascending']==[2,4,1],'portable coefficient field relation')
 require(problem['model']['genera']==[0,1,2],'all three input genera')
 for x in range(25):
  require(power(x,25)==x,'F25 Frobenius')
  if x:require(mul(x,inv(x))==1,'F25 inverse')
  for y in range(25):
   for z in range(25):
    require(mul(mul(x,y),z)==mul(x,mul(y,z)),'F25 associativity')
    require(mul(x,add(y,z))==add(mul(x,y),mul(x,z)),'F25 distributivity')
 require(pgcd(A,pder(A))==[1],'A squarefree')
 require(pgcd(P,pder(P))==[1],'P squarefree')
 require(pgcd(P,A)==[1],'P and A coprime')
 x=[0,1]
 require(ppowmod(x,25**4,MOD)==x,'A Frobenius degree four')
 require(pgcd(MOD,psub(ppowmod(x,25**2,MOD),x))==[1],'A irreducible')
 d=locdata();H=d['H'];C=d['C']
 require(kpow(d['h'],29)==pscale(H,C),'29th-root polynomial')
 require(pow(29,-1,25**4-1)==67349,'29th-root exponent')
 for i in range(4):
  for j in range(i):
   require(d['roots'][i]!=d['roots'][j],'four distinct A roots')
   require(kpow(H,25**i)!=kpow(H,25**j),'injective H on A roots')
 factors=json.loads((ROOT/'data/cyclotomic29_factors.json').read_text())
 product=[1]
 for f in factors:
  require(len(f)==8 and f[-1]==1,'cyclotomic factor degree')
  require(ppowmod(x,25**7,f)==x,'cyclotomic Frobenius')
  require(pgcd(f,psub(ppowmod(x,25,f),x))==[1],'degree-seven irreducibility')
  product=pmul(product,f)
 require(product==[1]*29,'factorization of Phi_29')
 arrays=input_arrays()
 require(arrays==json.loads((ROOT/'data/boundary_input.json').read_text()),'portable boundary input')
 require(header_text(arrays)==(ROOT/'src/boundary_input.hpp').read_text(),'C++ header reconstruction')
 lm=arrays['LM']
 require(ppowmod(x,29,lm)==[1] and x!=[1],'zeta has order 29')
 require(pow(25,4,29)==24,'Frobenius orbit multiplier')
 require(len(orbit_representatives())==3485,'all root-of-unity orbits')
 print('PASS: F25 field axioms, irreducible degree-four and degree-seven fields, input squarefreeness/coprimality, H injectivity, root normalization, C++ input')
 return arrays

def check_genus1_full_grid():
 d=locdata();lm,zp,ta,tm,grid=setup_evaluator();total=0
 stored=json.loads((ROOT/'data/genus1_boundary_results.json').read_text())
 cases={tuple(c['indices']):c for c in stored['cases']}
 for j in range(4):
  for k in range(4):
   for l in range(4):
    polys=case_polynomials(d,0,j,k,l)
    portable=[[[list(e),as4(c)] for e,c in sorted(E.items())] for E in polys]
    require(portable==cases[(0,j,k,l)]['polynomials'],'genus-one polynomial reconstruction')
    mask=np.ones(len(grid),dtype=bool)
    if j==0:mask&=grid[:,0]!=0
    if k==l:mask&=grid[:,1]!=0
    ids=np.flatnonzero(mask);total+=len(ids)
    for E in polys:ids,_=testpoly(E,ids,zp,ta,tm,grid)
    require(len(ids)==0,f'genus-one full-grid survivors {(j,k,l)}')
 require(total==1534100,'genus-one full-grid count')
 print('PASS: all 1534100 genus-one boundary tuples tested directly (no orbit reduction)')


def check_reference(arrays):
 F=ReferenceField(arrays['KM'],arrays['LM'])
 vectors=json.loads((ROOT/'data/arithmetic_vectors.json').read_text());binary=bytearray()
 for v in vectors:
  require(F.mul(v['a'],v['b'])==v['product'],'independent arithmetic vector')
  binary.extend(bytes(v['a']+v['b']+v['product']))
 require(bytes(binary)==(ROOT/'certificates/arithmetic_vectors.bin').read_bytes(),'arithmetic-vector binary')
 raw=(ROOT/'certificates/genus0_boundary.bin').read_bytes()
 require(len(raw)==90*219188,'genus-zero certificate length')
 m=np.frombuffer(raw,dtype=np.uint8).reshape(-1,90)
 require(bool(np.all(m[:,6:]<25)),'F25 certificate code range')
 for start in (6,34,62):require(bool(np.all(np.any(m[:,start:start+28]!=0,axis=1))),'recorded field units')
 n=len(raw)//90
 sample=sorted(set([0,1,3247,3248,n-1]+[int((n-1)*j/31) for j in range(32)]))
 for r in sample:
  record=raw[90*r:90*(r+1)];values=genus0_values(arrays,list(record[:6]))
  require(b''.join(bytes(x) for x in values)==record[6:],f'independent genus-zero record {r}')
 g1=(ROOT/'certificates/genus1_boundary.bin').read_bytes()
 require(len(g1)==10*219188,'genus-one certificate length')
 g1m=np.frombuffer(g1,dtype=np.uint8).reshape(-1,10)
 require(bool(np.array_equal(m[:,:6],g1m[:,:6])),'identical exhaustive orbit indexing')
 d=locdata()
 for r in sample:
  j,k,l,u,t,v,pn,ki,lj,value=map(int,g1m[r])
  poly=case_polynomials(d,0,j,k,l)[pn];out=F.zero()
  for ex,c in poly.items():
   power=(u*ex[0]+t*ex[1]+v*ex[2])%29
   out=F.add(out,F.outer(as4(c),arrays['ZP'][power]))
  require(value!=0 and out[4*lj+ki]==value,f'independent genus-one witness {r}')
 print(f'PASS: 64 independently computed field products; {len(sample)} independent genus-zero determinant records and genus-one witness records')


def main():
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--all',action='store_true',help='run the complete verification (required)');parser.add_argument('--compiler',default=os.environ.get('CXX','g++'))
 args=parser.parse_args()
 if not args.all:parser.error('specify --all to run the complete verification')
 print('Verification started',flush=True)
 print('Python',sys.version.replace('\n',' '));print('NumPy',np.__version__,'SymPy',sympy.__version__);print('Platform',platform.platform())
 arrays=check_fields()
 import audit_formulas
 audit_formulas.run()
 require(certify()==json.loads((ROOT/'data/genus2_boundary_certificate.json').read_text()),'complete genus-two rank certificate')
 print('PASS: genus-two certificate: 144 matrices; rank 4 in 120 cases, rank 3 in 24 cases; all excluded')
 check_genus1_full_grid()
 records,summary=genus1_records(verbose=False)
 require(records==(ROOT/'certificates/genus1_boundary.bin').read_bytes(),'genus-one orbit certificate')
 require(summary==json.loads((ROOT/'data/genus1_certificate_summary.json').read_text()),'genus-one case summary')
 print('PASS: all 219188 genus-one orbit witness records reproduced')
 check_reference(arrays)
 sys.stdout.flush()
 with tempfile.TemporaryDirectory(prefix='degree6_verify_') as temp:
  binary=Path(temp)/'genus0_boundary'
  ver=subprocess.run([args.compiler,'--version'],check=True,capture_output=True,text=True)
  print('Compiler:',ver.stdout.splitlines()[0],flush=True)
  subprocess.run([args.compiler,'-std=c++17','-O3',str(ROOT/'src/genus0_boundary.cpp'),'-o',str(binary)],check=True)
  subprocess.run([str(binary),'--check-arithmetic',str(ROOT/'certificates/arithmetic_vectors.bin')],check=True)
  subprocess.run([str(binary),'--verify',str(ROOT/'certificates/genus0_boundary.bin')],check=True)
 print('ALL CHECKS PASSED. Complete geometric model exclusion for genera 0, 1, 2; see REPORT.md for the proof and supplied-input dependency.',flush=True)

if __name__=='__main__':
 try:main()
 except Exception as error:
  print('VERIFICATION FAILED:',repr(error),file=sys.stderr,flush=True)
  raise
