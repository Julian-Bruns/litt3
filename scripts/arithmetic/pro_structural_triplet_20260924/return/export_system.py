"""Generate one exact Singular return system. No Groebner basis is computed here.
All 6*16 choices of chart and stability-open cover the stable geometric locus.
Source coordinates eta=v^25 remain separate. The ground field is F25, but
variables range over its algebraic closure, not just F25.
"""
from core import *
import argparse,json

def cf(x):
 a,b=int(x)%5,int(x)//5
 if not b:return str(a)
 z='beta' if b==1 else f'{b}*beta'
 return z if not a else f'({a}+{z})'

def term(co,*factors):
 if not co:return None
 fs=[x for x in factors if x!='1']
 if int(co)!=1:fs.insert(0,cf(co))
 return '*'.join(fs) or '1'

def sm(terms):return '+'.join(x for x in terms if x) or '0'
def row(a,vars):return sm(term(x,v) for x,v in zip(a,vars))

def system(chart,op):
 sch=json.loads((ROOT/'data'/'stability_charts.json').read_text())['charts'][chart]
 rel=sch['generators'][op]
 v=[f'v{i}' if i!=chart else '1' for i in range(6)]
 eta=[f'eta{i}' if i!=chart else '1' for i in range(6)]
 cv=[f'c{i}' for i in range(15)];sv=[f's{i}' for i in range(9)]
 variables=[z for z in v+eta if z!='1']+cv+sv+['z']
 lines=['// GENERATED, NOT SOLVED in this archive.',
 '// Exact geometric strict-return system; no v_i^25=v_i restriction.',
 f'// Projective chart v{chart}=1, stability open number {op}.',
 'ring R=(5,beta),('+','.join(variables)+'),dp;',
 'minpoly=beta^2-beta-3;']
 eqs=[]
 for r in range(23):
  p=sm(term(EQ['T'][j,r,l],eta[j],cv[l]) for j in range(6) for l in range(15))
  name=f'E{len(eqs)}';lines.append(f'poly {name}={p};');eqs.append(name)
 for r in range(14):
  ts=[term(EQ['C'][i,j,r,l],v[i],eta[j],cv[l]) for i in range(6) for j in range(6) for l in range(15)]
  ts +=[term(EQ['Q'][j,r,l],eta[j],sv[l]) for j in range(6) for l in range(9)]
  name=f'E{len(eqs)}';lines.append(f'poly {name}={sm(ts)};');eqs.append(name)
 I=EQ['c_indices'];J=EQ['s_indices']
 lines.append('poly h00='+sm([term(D['top_first_s'][l],sv[k]) for k,l in enumerate(J)]+[term(D['top_first_c'][i,l],v[i],cv[k]) for i in range(6) for k,l in enumerate(I)])+';')
 for r in range(2):lines.append(f'poly h{r+1}0='+row(D['first_at_point'][r,I],cv)+';')
 for index,(r,k) in enumerate([(2,1),(1,1),(2,2),(1,2)]):
  lines.append(f'poly h{r}{k}='+sm(term(D['lower_at_point'][j,index,l],eta[j],cv[t]) for j in range(6) for t,l in enumerate(I))+';')
 for k in range(2):
  ts=[term(D['top_other_s'][j,k,l],eta[j],sv[t]) for j in range(6) for t,l in enumerate(J)]
  ts +=[term(D['top_other_c'][i,j,k,l],v[i],eta[j],cv[t]) for i in range(6) for j in range(6) for t,l in enumerate(I)]
  lines.append(f'poly h0{k+1}='+sm(ts)+';')
 lines.append('poly detH=h00*(h11*h22-h12*h21)-h01*(h10*h22-h12*h20)+h02*(h10*h21-h11*h20);')
 vs=[v[i] for i in sch['retained_coordinates']]
 st=[]
 for mon,co in rel:
  st.append(term(co,*[x if p==1 else f'{x}^{p}' for x,p in zip(vs,mon) if p]))
 lines.append('poly stabilityOpen='+sm(st)+';')
 links=[eta[i]+'-'+v[i]+'^25' for i in range(6) if i!=chart]
 lines.append('ideal I='+','.join(links+eqs+['detH-1','z*stabilityOpen-1'])+';')
 lines +=['// The following computation is UNEXECUTED in the supplied archive.',
           'option(redSB);','ideal G=std(I);',
           'if (reduce(1,G)==0) { "UNIT_IDEAL: this open has no stable return"; }',
           'else { "PROPER_IDEAL: extract an exact point and reconstruct its matrix"; }',
           'G;','quit;']
 return '\n'.join(lines)+'\n'

if __name__=='__main__':
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--chart',type=int,choices=range(6),required=True);p.add_argument('--stability-open',type=int,choices=range(16),required=True);p.add_argument('--output',type=Path,required=True)
 a=p.parse_args();a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(system(a.chart,a.stability_open))
 print('Generated exact system; NOT SOLVED:',a.output)

