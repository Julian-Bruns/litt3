#!/usr/bin/env sage
"""Import an msolve basis, specialize the coefficient field, and certify length.

The input is generated locally by msolve -g 2 from fixed_x_dormant_opers.sage.
All costly intermediate bases are checkpointed. This does not yet enumerate roots.
"""
import sys, re
from pathlib import Path
args=list(sys.argv)
invariant='--invariant' in args
stem='invariant_oper' if invariant else 'full_oper'
if '--c4-zero' in args:
    stem='c4_zero_oper'
normalized='--normalized' in args
if normalized:
    assert not invariant and '--c4-zero' not in args
    stem='normalized_oper'
elif not invariant and '--c4-zero' not in args:
    raise SystemExit('Select --normalized, --invariant, or --c4-zero; the obsolete full search was retired.')
filename=Path('Research/computations')/(stem+'_msolve.gb')
raw=filename.read_text()
order=re.search(r'#variable order:\s*([^\n]+)',raw).group(1)
qnames=[v.strip() for v in order.split(',')]
Q=PolynomialRing(GF(5),names=qnames,order='degrevlex')
body='\n'.join(line for line in raw.splitlines() if not line.startswith('#')).strip()
assert body.startswith('[') and body.endswith(']:')
Gprime=[Q(s.strip()) for s in body[1:-2].split(',') if s.strip()]
print('prime_field_basis_size',len(Gprime),flush=True)
# Reload the independently generated F25 equations. The normalized search
# uses different coordinates and must not be interpreted as the original24.
if normalized:
    P,coefficients,As,Cs,Bs,lam=load('Research/computations/'+stem+'_quotient.sobj')
    k=P.base_ring()
    a=k.gen()
    names=list(P.variable_names())
else:
    source=Path('scripts/fixed_x_dormant_opers.sage').read_text()
    sys.argv=['fixed_x_dormant_opers.sage','--build-only']+(['--invariant'] if invariant else [])
    if '--c4-zero' in args:
        sys.argv.append('--c4-zero')
    exec(compile(source,'fixed_x_dormant_opers.sage','exec'))
assert qnames==names+['zeta']
specialize=Q.hom(list(P.gens())+[P(a)],P)
projected=list(dict.fromkeys(specialize(f) for f in Gprime if specialize(f)))
save((P,projected),'Research/computations/'+stem+'_projected_basis.sobj')
J=P.ideal(projected)
G=J.groebner_basis()
save((P,list(G)),'Research/computations/'+stem+'_groebner.sobj')
assert all(J.reduce(f)==0 for f in coefficients)
assert J.dimension()==0
length=J.vector_space_dimension()
expected=55 if invariant else 29375
if '--c4-zero' in args:
    expected=330
if normalized:
    expected=9645
assert length==expected,(length,expected)
# I is contained in J; both finite quotients have the known same length.
# Therefore I=J. This is also an exact independent check on field conversion.
print('CERTIFIED F25 basis; size',len(G),'length',length,flush=True)
if '--radical' in args:
    radical=J.radical()
    RG=radical.groebner_basis()
    save((P,list(RG)),'Research/computations/'+stem+'_radical.sobj')
    print('radical_length',radical.vector_space_dimension(),flush=True)
    if '--c4-zero' in args:
        assert radical.vector_space_dimension()==55
        assert all(radical.reduce(t)==0 for t in P.gens()[8:])
        print('All c4-zero geometric solutions have A=C=0',flush=True)
