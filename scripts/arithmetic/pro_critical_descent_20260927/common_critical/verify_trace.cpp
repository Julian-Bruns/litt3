// Replay only exact polynomial identities. No Buchberger decisions are trusted.
#define FINITE_ALGEBRA_NO_MAIN
#include "finite_algebra.cpp"
int main(int argc,char**argv){
 if(argc!=5){cerr<<"usage verify_trace field.bin original_input.txt proof.txt output_gb.txt\n";return 2;}
 initfield(argv[1]);auto inputs=readpolys(argv[2]);F.clear();G.clear();
 ifstream in(argv[3]);int nv,ni,n,nb;in>>nv>>ni>>n>>nb;if(nv!=NV||ni!=(int)inputs.size())abort();
 long long nsteps=0;
 for(int k=0;k<n;k++){
  int type,a,b,scale;long long steps;in>>type>>a>>b>>scale>>steps;Work w;
  if(type==0){if(a<0||a>=ni)abort();for(auto [m,c]:inputs[a].t)inc(w,m,c);}
  else{
   if(type!=1||a<0||b<0||a>=k||b>=k)abort();Mon m=lcm(F[a].lm(),F[b].lm());
   for(auto [mm,c]:F[a].t)inc(w,mprod(mm,m-F[a].lm()),c);
   for(auto [mm,c]:F[b].t)inc(w,mprod(mm,m-F[b].lm()),neg(c));
  }
  for(long long j=0;j<steps;j++){
   int r,c;in>>r>>c;Mon shift=0;for(int z=0;z<NV;z++){int e;in>>e;if(e<0||e>255)abort();shift|=Mon(e)<<(8*z);}
   if(r<0||r>=k||!c)abort();Mon m=mprod(F[r].lm(),shift);auto it=w.find(m);
   if(it==w.end()||it->second!=c){cerr<<"BAD_REDUCTION node="<<k<<" step="<<j<<endl;return 3;}
   for(auto [mm,cc]:F[r].t)inc(w,mprod(mm,shift),neg(mul(c,cc)));
  }
  if(w.empty()||!scale)abort();Poly f;for(auto [m,c]:w)f.t.emplace_back(m,mul(c,scale));if(f.t[0].second!=1)abort();F.push_back(move(f));nsteps+=steps;
 }
 for(int j=0;j<nb;j++){int r;in>>r;if(r<0||r>=n)abort();G.insert(r);}
 if((int)G.size()!=nb||!in)abort();writegb(argv[4]);
 cerr<<"PROVENANCE_VERIFIED nodes="<<n<<" exact_reductions="<<nsteps<<" output_generators="<<G.size()<<endl;
 return 0;
}
