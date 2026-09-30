#include "module_arithmetic.hpp"
int main(int argc,char**argv){if(argc<3){cerr<<"usage module_gb input output-prefix [seconds]\n";return 1;}init();ifstream in(argv[1]);int ng;in>>NV>>NC>>ng;if(NV>6||NV<1||NC>255){cerr<<"unsupported dimensions\n";return 2;}MASK=(U(1)<<(8*NV))-1;reducers.assign(NC,{});string prefix=argv[2];ofstream hist(prefix+".history");hist<<NV<<" "<<NC<<"\n";
 auto start=chrono::steady_clock::now();int seconds=argc>3?stoi(argv[3]):600;
 auto add=[&](Poly f,int type,int a,int b,U l){vector<Reduction>pr;auto r=reduce(f,&pr);if(r.empty()){zeros++;return;}int s=INV[r[0].c];for(auto &t:r)t.c=MUL[s][t.c];int h=polys.size();polys.push_back(r);hist<<h<<" "<<type<<" "<<a<<" "<<b<<" "<<l<<" "<<s<<" "<<pr.size()<<"\n";for(auto u:pr)hist<<u.g<<" "<<u.c<<" "<<u.m<<"\n";writepoly(hist,r);update(h);};
 for(int i=0;i<ng;i++){auto f=readpoly(in);add(f,0,i,-1,0);}
 cerr<<"initial "<<active.size()<<" pairs "<<pairs.size()<<"\n";
 int iter=0;bool done=true;auto prev=start;
 while(!pairs.empty()){
  auto it=pairs.begin();auto p=*it;pairs.erase(it);maxdeg=max(maxdeg,degree(p.m));
  auto f=spoly(p.a,p.b,p.m);add(f,1,p.a,p.b,p.m);iter++;
  auto now=chrono::steady_clock::now();if(chrono::duration_cast<chrono::seconds>(now-prev).count()>=5){cerr<<"t "<<chrono::duration_cast<chrono::seconds>(now-start).count()<<" basis "<<active.size()<<" total "<<polys.size()<<" pairs "<<pairs.size()<<" degree "<<degree(p.m)<<" iter "<<iter<<" reductions "<<redsteps<<"\n";prev=now;hist.flush();}
  if(chrono::duration_cast<chrono::seconds>(now-start).count()>=seconds){done=false;break;}
 }
 ofstream out(prefix+".gb");out<<NV<<" "<<NC<<" "<<active.size()<<"\n";for(int g:active)writepoly(out,polys[g]);
 ofstream all(prefix+".all");all<<NV<<" "<<NC<<" "<<polys.size()<<"\n";for(auto &p:polys)writepoly(all,p);
 ofstream ids(prefix+".ids");for(int g:active)ids<<g<<"\n";
 cerr<<(done?"COMPLETE":"PARTIAL")<<" basis "<<active.size()<<" total "<<polys.size()<<" maxdegree "<<maxdeg<<" zeros "<<zeros<<" pairs "<<pairs.size()<<" elapsed "<<chrono::duration_cast<chrono::seconds>(chrono::steady_clock::now()-start).count()<<"\n";
 return done ? 0 : 2;
}
