"""Build the exact translated coefficients, without inverting y or P."""
from endpoints import *

def divz(f,k):
 out={}
 for j in range(3):
  a={m:c for m,c in f.items() if m[1]==j};ex=(j-k)//3;jr=(j-k)%3
  if ex<0:a=pdivide_univ(a,{i:c for (i,j),c in Ppowers[-ex].items()})[0]
  elif ex>0:a=pmul(a,lift4(Ppowers[ex]))
  a={(i,jr,h,q-ex):c for (i,j,h,q),c in a.items()};out=padd(out,a)
 return out

def main():
 G2,G3,G4,G5=load_hats();BB=lift4(B0)
 g2=divz(G2,2);g3=divz(psub(G3,pscale(pmul(BB,G2),3)),3)
 g4=divz(padd(psub(G4,pscale(pmul(BB,G3),2)),pscale(pmul(ppow(BB,2),G2),3)),4)
 g5=divz(psub(padd(psub(G5,pmul(BB,G4)),pmul(ppow(BB,2),G3)),pmul(ppow(BB,3),G2)),5)
 Qh=divz(lift4(psub(Q,ppow(B0,5))),5)
 polys=[pscale(g2,3),pscale(g3,2),g4,g5,Qh,pshift(lift4(t3),(0,0,0,3))]
 with open(ROOT/'data'/'model_input.txt','w') as out:
  out.write('11 '+' '.join(map(str,Prow))+'\n')
  tv=[t.get((i,0),0) for i in range(4)];out.write('4 '+' '.join(map(str,tv))+'\n')
  for name,p in zip(['a','b','c','d','Qhat','T'],polys):
   out.write(f'{name} {len(p)}\n')
   for (i,j,h,q),c in sorted(p.items()):out.write(f'{i} {j} {h} {q} 0 {c}\n')
 print('translated coefficient term counts',list(map(len,polys)))
 (ROOT/'data'/'translated_source.json').write_text(json.dumps({'variables':['x','z_c','H','q'],'names':['a','b','c','d','Qhat','T'],'coefficients':[dumps(g) for g in polys]},separators=(',',':'))+'\n')
if __name__=='__main__':main()
