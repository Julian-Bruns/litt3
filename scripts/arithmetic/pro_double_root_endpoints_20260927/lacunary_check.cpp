// Independent literal-certificate verifier: multiply in K[u][q], then reduce
// by the monic relation. This does not replay polynomial row operations.
#include "field.cpp"
static void qreduce(vector<KP>& p,const vector<KP>& g){
 for(int n=(int)p.size()-1;n>=9;n--)if(!p[n].empty()){
  KP v=p[n];p[n].clear();for(int j=0;j<9;j++)p[n-9+j]=psub(p[n-9+j],pmul(v,g[j]));
 }p.resize(9);
}
extern "C" int lacunary_check(const int*raw,int n,const int*gs,
 const int*xs,const int*js,const int*co,int nr,int stride,
 int d0,int d1,int dp,int*stats){
 try{ff_init();vector<KP> g(10,KP(3));for(int j=0;j<10;j++){for(int i=0;i<3;i++)g[j][i]=gs[3*j+i];trim(g[j]);}
 if(g[9]!=KP{1})return -10;
 vector<vector<KP>> answer(7,vector<KP>(17));int terms=0,md=-1;
 for(int k=0;k<nr;k++){
  if(xs[k]<16||xs[k]>124||js[k]<0||js[k]>8)return -11;
  KP c(co+(size_t)k*stride,co+(size_t)(k+1)*stride);trim(c);md=max(md,(int)c.size()-1);
  for(int s=0;s<7;s++)for(int j=0;j<9;j++){
   KP a(n);for(int i=0;i<n;i++)a[i]=raw[(((size_t)i*7+s)*141+xs[k])*9+j];trim(a);
   if(a.empty()||c.empty())continue;terms++;answer[s][j+js[k]]=padd(answer[s][j+js[k]],pmul(a,c));
  }
 }
 for(auto &a:answer)qreduce(a,g);
 KP dq{1};for(int i=0;i<dp;i++)dq=pmul(dq,KP{d0,d1});
 vector<KP> target(max(9,(int)dq.size()));for(int j=0;j<(int)dq.size();j++)if(dq[j])target[j]={dq[j]};qreduce(target,g);
 int nz=0;for(int s=0;s<7;s++)for(int j=0;j<9;j++){
  KP rem=psub(answer[s][j],s?KP():target[j]);if(!rem.empty())nz++;
 }
 stats[0]=terms;stats[1]=md;stats[2]=nz;return nz?1:0;
 }catch(const exception &e){fprintf(stderr,"independent lacunary verifier: %s\n",e.what());return -2;}
}

extern "C" int late_linear_check(const int*raw,int n,const int*gs,
 const int*xs,const int*js,const int*co,int nr,int stride,
 int d0,int d1,int dp,int*stats){
 try{ff_init();vector<KP> g(10,KP(3));for(int j=0;j<10;j++){for(int i=0;i<3;i++)g[j][i]=gs[3*j+i];trim(g[j]);}
 if(g[9]!=KP{1})return -10;
 vector<vector<KP>> answer(7,vector<KP>(17));int terms=0,md=-1;
 for(int k=0;k<nr;k++){
  if(xs[k]<16||xs[k]>124||js[k]<0||js[k]>8)return -11;
  KP c(co+(size_t)k*stride,co+(size_t)(k+1)*stride);trim(c);md=max(md,(int)c.size()-1);
  for(int s=0;s<7;s++)for(int j=0;j<9;j++){
   KP a(n);for(int i=0;i<n;i++)a[i]=raw[(((size_t)i*7+s)*141+xs[k])*9+j];trim(a);
   if(a.empty()||c.empty())continue;terms++;answer[s][j+js[k]]=padd(answer[s][j+js[k]],pmul(a,c));
  }
 }
 for(auto &a:answer)qreduce(a,g);
 vector<KP> target(9);target[0]={1};vector<KP> leading(9,KP(n));
 for(int j=0;j<9;j++){for(int i=0;i<n;i++)leading[j][i]=raw[(((size_t)i*7)*141+140)*9+j];trim(leading[j]);}
 for(int e=0;e<dp;e++){vector<KP> p(17);for(int i=0;i<9;i++)for(int j=0;j<9;j++)p[i+j]=padd(p[i+j],pmul(target[i],leading[j]));qreduce(p,g);target=move(p);}
 int nz=0;for(int s=0;s<7;s++)for(int j=0;j<9;j++){
  KP rem=psub(answer[s][j],s?KP():target[j]);if(!rem.empty())nz++;
 }
 stats[0]=terms;stats[1]=md;stats[2]=nz;return nz?1:0;
 }catch(const exception &e){fprintf(stderr,"independent lacunary verifier: %s\n",e.what());return -2;}
}
