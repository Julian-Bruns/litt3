#!/usr/bin/env sage
"""NEW small necessary cubic-norm/original-Cartier model.

Use saved d=0 annihilator/GB only for exact polynomial normal forms.
No GB, resultant, adaptive elimination, sample, point replay or source
decision. Keep r=0 and every nontrivial Cartier torsion alternative.
"""
import argparse
import hashlib
import json
from pathlib import Path
import signal
import time

parser=argparse.ArgumentParser()
parser.add_argument('--annihilator',required=True)
parser.add_argument('--source',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
started=time.monotonic()
input_path=Path(args.annihilator)
source_path=Path(args.source)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
assert not (out/'norm_cartier_model.sobj').exists()
R,Rx,G,Hsaved,ann,Usaved,old_norm_remainders=load(str(input_path))
k=R.base_ring()
alpha=k.gen()
vs=dict(zip(R.variable_names(),R.gens()))
assert Usaved.is_monic() and Usaved.degree()==6
assert len(ann)==4 and len(G)>0
assert all(z==0 for z in old_norm_remainders)
S=PolynomialRing(R,'r')
r=S.gen()
T=PolynomialRing(S,'x')
x=T.gen()
A,B=k(1)-alpha,k(2)-alpha
H=A*x^5+B*x^4-1

def nr(p):
    p=S(p)
    return S([c.reduce(G) for c in p.list()])

def nx(p):
    p=T(p)
    return T([nr(c) for c in p.list()])

U=T(Usaved)
scale=R(1/k(3))*vs['inv_a2']^3
E=nx(T(ann[1][0])*scale)
O=nx(T(ann[1][1])*scale)
assert nr(E[7]-A*vs['inv_a2'])==0
summary={
    'scope':'NEW necessary actual d=0 norm/Cartier torsion model; not a source decision',
    'threads':1,'new_groebner_basis':False,'numeric_samples':False,
    'source_sha256':hashlib.sha256(source_path.read_bytes()).hexdigest(),
    'input_sha256':hashlib.sha256(input_path.read_bytes()).hexdigest(),
    'saved_basis_count':len(G),'r_zero_stratum_retained':True,
    'nontrivial_torsion_retained':True,'stages':[],
}
equations={}
identities={}

def checkpoint(stage):
    summary['stages'].append(stage)
    summary['elapsed_seconds']=time.monotonic()-started
    summary['equation_degrees_in_r']={name:int(p.degree()) for name,p in equations.items()}
    summary['equation_coefficient_term_counts']={name:sum(len(c.monomials()) for c in p.list()) for name,p in equations.items()}
    summary['equation_zero_flags']={name:bool(p==0) for name,p in equations.items()}
    summary['identity_zero_flags']={name:bool(p==0) for name,p in identities.items()}
    save((R,Rx,G,S,T,H,U,E,O,equations,identities),str(out/'norm_cartier_model.sobj'))
    (out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')

c2=nr((U[5]+A*r^2)/k(2))
c1=nr((U[4]+B*r^2-c2^2)/k(2))
c0=nr((U[3]-2*c2*c1)/k(2))
F=x^3+c2*x^2+c1*x+c0
norm_residual=nx(F^2-r^2*H-U)
assert norm_residual.degree()<=2
for i in range(3):equations['norm_x'+str(i)]=nr(norm_residual[i])
identities['norm_top_coefficients']=nx(sum(norm_residual[i]*x^i for i in range(3,7)))
checkpoint('three_normalized_norm_residuals_saved')

sigma1=nr(3*A*(r+vs['inv_a2']))
sigma0=nr(r*(2*A*c2+B)-sigma1*U[5]-2*E[6])
sigma=sigma0+sigma1*x
predicted_even=3*(r*(H*F.derivative()-2*B*x^3*F)-sigma*U)
even_residual=nx(E-predicted_even)
assert even_residual.degree()<=5
for i in range(6):equations['first_coordinate_even_x'+str(i)]=nr(even_residual[i])
identities['even_top_coefficients']=nx(sum(even_residual[i]*x^i for i in (6,7)))
predicted_odd=3*(F*F.derivative()-2*B*r^2*x^3)
# This checks the precise sign/scalar: odd residual is implied by norm.
identities['odd_identity_mod_norm_derivative']=nx(predicted_odd-O-4*norm_residual.derivative())
assert identities['odd_identity_mod_norm_derivative']==0
checkpoint('first_connection_coordinate_model_saved')

equations['cartier_sigma0']=nr(sigma0^5-3*B*sigma0)
equations['cartier_sigma1']=nr(sigma1^5-2*A*B*sigma0-B^2*sigma1)
checkpoint('two_exact_cartier_equations_saved')
save((R,Rx,G,S,T,H,U,E,O,F,c2,c1,c0,sigma0,sigma1,norm_residual,even_residual,equations,identities),str(out/'norm_cartier_model.sobj'))
(out/'equations.txt').write_text('\n'.join(name+' = '+str(p) for name,p in equations.items())+'\n')
summary['completed_all_model_equations']=True
summary['elapsed_seconds']=time.monotonic()-started
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
