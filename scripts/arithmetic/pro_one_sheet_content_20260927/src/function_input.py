from integral_chart import *
for e in json.loads((ROOT/'data'/'integral_charts.json').read_text()):
 with open(ROOT/'data'/f"function_input_{e['r']}.txt",'w') as f:
  f.write(str(e['r'])+'\n')
  for k in ['F','H_numerator','H_denominator']:
   f.write(k+' '+str(len(e[k]))+'\n')
   for row in e[k]:f.write(' '.join(map(str,row))+'\n')
  for b in e['branches']:
   for k in ['numerator','denominator']:
    f.write(b['name']+'_'+k+' '+str(len(b[k]))+'\n')
    for row in b[k]:f.write(' '.join(map(str,row))+'\n')
