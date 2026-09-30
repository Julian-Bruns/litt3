from pathlib import Path
import struct,json,collections
root=Path(__file__).resolve().parents[1]
b=(root/'build/Rcal.bin').read_bytes();N=struct.unpack_from('<Q',b)[0];stats=collections.defaultdict(lambda:[0,999,-999,999,-999,999,-999]);byx=collections.defaultdict(lambda:[0,999,-999,999,-999,999,-999]);tot=0
for key,c in struct.iter_unpack('<qI',b[8:]):
 x=key&1023;h=(key>>10)&63;mu=(key>>16)&7;q=key>>19
 s=stats[mu];s[0]+=1;s[1]=min(s[1],x);s[2]=max(s[2],x);s[3]=min(s[3],h);s[4]=max(s[4],h);s[5]=min(s[5],q);s[6]=max(s[6],q)
 s=byx[x];s[0]+=1;s[1]=min(s[1],mu);s[2]=max(s[2],mu);s[3]=min(s[3],h);s[4]=max(s[4],h);s[5]=min(s[5],q);s[6]=max(s[6],q)
print('mu: count,xmin,xmax,hmin,hmax,qmin,qmax');print(dict(sorted(stats.items())))
print('x: count,mumin,mumax,hmin,hmax,qmin,qmax');print(dict((i,byx[i]) for i in range(140,119,-1)))
(root/'evidence/full_support_summary.json').write_text(json.dumps({'mu_slices':dict(sorted(stats.items())),'x_slices':dict(sorted(byx.items()))},indent=2)+'\n')
