"""Full finite presentations of the auxiliary J=0 fibres; no point enumeration."""
from integral_chart import *
ends=json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints']
charts=json.loads((ROOT/'data'/'integral_charts.json').read_text())
mon=json.loads((ROOT/'data'/'monic_charts.json').read_text())
rows=[]
for e,ch,mo in zip(ends,charts,mon):
 f=monic(dense_component(pshift(loads(mo['T_norm_auxiliary_J']),(2,0)),0));F=loads(ch['F'])
 a=ur(dense_component(F,2),f);b=ur(dense_component(F,1),f)
 assert len(f)==7 and ug(f,derivative(f))==[1] and ug(f,a)==[1] and ug(f,b)==[1]
 assert not ur(dense_component(F,0),f)
 factors=factor_squarefree(f)
 row={'r':e['r'],'basis':['v^i*S^j for j=0,...,4 and i=0,...,5'],'dimension':30,'v_modulus':f,'S_relation_a':a,'S_relation_b':b,'v_factor_degrees':[len(g)-1 for g in factors],'v_factors':factors,'retained_curve':'S^5+a(v)S+b(v)=0, since S is required to be nonzero','delta_polynomial':dumps(pshift(loads(e['Delta']),(8,0))),'integral_chart':ch}
 rows.append(row)
 with open(ROOT/'data'/f"J_input_{e['r']}.txt",'w') as o:
  o.write(f"{e['r']} {e['P_r']}\n")
  for pp in [f,a,b]:o.write(str(len(pp))+' '+' '.join(map(str,pp))+'\n')
  ps=[('beta',ch['beta']),('delta',row['delta_polynomial']),('Hn',ch['H_numerator']),('Hd',ch['H_denominator'])]
  for br in ch['branches']:ps.extend([(br['name']+'_n',br['numerator']),(br['name']+'_d',br['denominator'])])
  for name,p in ps:
   o.write(f'{name} {len(p)}\n')
   for rr in p:o.write(' '.join(map(str,rr))+'\n')
 print('J fibre',e['r'],'dimension',30,'v_factor_degrees',row['v_factor_degrees'],flush=True)
(ROOT/'data'/'J_algebras.json').write_text(json.dumps(rows,separators=(',',':'))+'\n')
