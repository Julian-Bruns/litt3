#!/usr/bin/env sage
"""Export exact field tables and compact module inputs for native arithmetic."""
from sage.all import *
import argparse,json,numpy as np
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);ap.add_argument('--uncleared-auxiliary',action='store_true');args=ap.parse_args();data=args.work/'data';s=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));top=load(str(data/f'twisted_d10m6_global_top_kernel_{args.root}.sobj'));K=s['K'];RR=s['RR'];eta,lam=RR.gens();prime=int(5);order=int(K.order());suffix='uncleared' if args.uncleared_auxiliary else 'incidence';dest=data/(f'native_uncleared_module_{args.root}' if args.uncleared_auxiliary else f'native_module_{args.root}');dest.mkdir(exist_ok=True)
basis=[s['beta']**i*s['alpha']**j for j in range(4) for i in range(2)];basis_matrix=matrix(GF(5),8,8,lambda i,j:int(basis[j].to_integer())//(prime**int(i))%prime);inverse=basis_matrix.inverse();inverse_array=np.array([[int(cc) for cc in row] for row in inverse.rows()],dtype=np.uint32)
values=np.arange(order,dtype=np.uint32);digits=np.array([(values//np.uint32(prime**j))%np.uint32(prime) for j in range(8)],dtype=np.uint32).transpose();converted=(digits@inverse_array.transpose())%np.uint32(prime);mapping=sum((converted[:,j]*np.uint32(prime**j) for j in range(8)),np.zeros(order,dtype=np.uint32));assert np.unique(mapping).size==order
reverse=np.zeros(order,dtype=np.uint32);reverse[mapping]=values;logs=np.fromfile(args.work/'cache/logs.bin',dtype=np.int32)[mapping];exps=reverse[np.fromfile(args.work/'cache/exps.bin',dtype=np.uint32)]
logs.astype('<i4').tofile(dest/'logs.bin');exps.astype('<u4').tofile(dest/'exps.bin');(args.work/'cache/addhalf.bin').read_bytes();(dest/'addhalf.bin').write_bytes((args.work/'cache/addhalf.bin').read_bytes())
encoded=np.load(str(data/f'twisted_d10m6_{suffix}_compact_{args.root}.npz'))['coefficients'];encoded.astype('<u4').tofile(dest/'matrix.bin')
B=top['global_kernel'];degree=int(max(f.degree(eta) for f in B.list()));bc=np.zeros((8,6,2,degree+1),dtype=np.uint32)
for i in range(8):
    for j in range(6):
        for (ep,lp),cc in B[i,j].dict().items():bc[i,j,int(lp),int(ep)]=int(cc.to_integer())
bc.astype('<u4').tofile(dest/'kernel.bin')
def ep_coeffs(f):
    result=[K.zero()]*(int(f.degree(eta))+1)
    for (ep,lp),cc in f.dict().items():assert not lp;result[int(ep)]=cc
    return [int(cc.to_integer()) for cc in result]
root=sum((s['beta']**(j%2)*s['alpha']**(j//2)*((int(args.root)//(prime**j))%prime) for j in range(8)),K.zero());leading=s['D'][3];a2=leading.lift()[0][2];apoint=sum((component(root) for component in leading.lift().list()),RR.zero());delta=[int(cc.to_integer()) for cc in s['auxiliary_delta'].list()]
unit_factors=[ep_coeffs(s['H']),delta,ep_coeffs(a2),ep_coeffs(apoint)]
if args.uncleared_auxiliary:unit_factors.pop(1)
(dest/'units.json').write_text(json.dumps(unit_factors,separators=(',',':'))+'\n');unit_values=[]
for f in unit_factors:unit_values.append(len(f));unit_values.extend(f)
np.array(unit_values,dtype='<u4').tofile(dest/'units.bin')
checks=[]
for aa,bb in [(int(1237*i)%order,int(7777*i+5)%order) for i in range(1,101)]:
    result=0 if not aa or not bb else int(exps[int(logs[aa])+int(logs[bb])]);assert K.from_integer(result)==K.from_integer(aa)*K.from_integer(bb);checks.append((aa,bb,result))
report={'root':int(args.root),'matrix_shape':list(map(int,encoded.shape)),'kernel_shape':list(map(int,bc.shape)),'field_order':order,'field_modulus':[int(c) for c in K.modulus().list()],'basis_matrix':[[int(c) for c in row] for row in basis_matrix.rows()],'inverse_basis_matrix':[[int(c) for c in row] for row in inverse.rows()],'field_multiplication_checks':checks,'little_endian_uint32':True,'units':'H, exactm6leadingcoefficient, nonzeroselectedcriticalleadingcoefficient'+('' if args.uncleared_auxiliary else ', auxiliarydelta'),'module_columns':int(171) if args.uncleared_auxiliary else int(126),'auxiliaries':int(15) if args.uncleared_auxiliary else int(0)}
P=PolynomialRing(K,'e');e=P.gen();fixtures=[]
for n,m in [(1,5),(17,31),(31,32),(32,33),(64,17),(99,128),(255,64),(511,99)]:
    f=P([K.from_integer(int(1237*i+29)%order) for i in range(n)]);g=P([K.from_integer(int(9871*i+77)%order) for i in range(m)])
    q,r=f.quo_rem(g);fixtures.append({'f':[int(c.to_integer()) for c in f.list()],'g':[int(c.to_integer()) for c in g.list()],'product':[int(c.to_integer()) for c in (f*g).list()],'quotient':[int(c.to_integer()) for c in q.list()],'remainder':[int(c.to_integer()) for c in r.list()],'gcd':[int(c.to_integer()) for c in f.gcd(g).monic().list()]})
(dest/'fixtures.json').write_text(json.dumps(fixtures,separators=(',',':'))+'\n')
fixture_values=[len(fixtures)]
for item in fixtures:
    for name in ['f','g','product','quotient','remainder','gcd']:fixture_values.append(len(item[name]));fixture_values.extend(item[name])
np.array(fixture_values,dtype='<u4').tofile(dest/'fixtures.bin')
(dest/'metadata.json').write_text(json.dumps(report,separators=(',',':'))+'\n');np.array([*encoded.shape,*bc.shape],dtype='<u4').tofile(dest/'header.bin');print('EXPORTED_NATIVE',dest,'SHAPE',encoded.shape,'KERNELDEG',degree,flush=True)
