// Exact division by q-r in K[u,q]/(g), g monic in q of degree nine.
#include "field.cpp"
extern "C" {
int div_q_linear(const int* input,int n,int count,const int* gs,int r,int* out){
 const int d=9; vector<KP> g(10,KP(3,0));
 for(int j=0;j<10;j++)for(int i=0;i<3;i++)g[j][i]=gs[j*3+i];
 for(auto& t:g)trim(t);
 KP gr;for(int j=9;j>=0;j--)gr=padd(pscale(gr,r),g[j]);
 if(gr.empty())return -2;
 std::fill(out,out+(size_t)n*count*d,0);
 for(int k=0;k<count;k++){
  vector<KP> f(9,KP(n));
  for(int i=0;i<n;i++)for(int j=0;j<9;j++)f[j][i]=input[((size_t)i*count+k)*9+j];
  for(auto& t:f)trim(t);
  KP fr;for(int j=8;j>=0;j--)fr=padd(pscale(fr,r),f[j]);
  auto qr=pdiv(fr,gr);if(!qr.second.empty())return k+1;
  KP h8=pscale(qr.first,4); vector<KP> h(9);h[8]=h8;
  for(int j=7;j>=0;j--)h[j]=padd(padd(f[j+1],pmul(h8,g[j+1])),pscale(h[j+1],r));
  if(psub(padd(f[0],pmul(h8,g[0])),pscale(h[0],neg(r))).size())return -3;
  for(int j=0;j<9;j++){
   if(h[j].size()>(size_t)n)return -4;
   for(int i=0;i<(int)h[j].size();i++)out[((size_t)i*count+k)*9+j]=h[j][i];
  }
 }
 return 0;
}
}
static vector<KP> ring_g;
static vector<KP> rqmul(const vector<KP>&f,int r){
 vector<KP> h(9);for(int j=0;j<9;j++){
 h[j]=psub(j?f[j-1]:KP(),pmul(f[8],ring_g[j]));
 h[j]=psub(h[j],pscale(f[j],r));
 }return h;
}
static vector<KP> rqdiv(const vector<KP>&f,int r){
 KP gr,fr;for(int j=9;j>=0;j--)gr=padd(pscale(gr,r),ring_g[j]);
 for(int j=8;j>=0;j--)fr=padd(pscale(fr,r),f[j]);
 auto qr=pdiv(fr,gr);if(qr.second.size())throw runtime_error("nonexact q-r division");
 KP z=pscale(qr.first,4);vector<KP>h(9);h[8]=z;
 for(int j=7;j>=0;j--)h[j]=padd(padd(f[j+1],pmul(z,ring_g[j+1])),pscale(h[j+1],r));
 if(padd(padd(f[0],pmul(z,ring_g[0])),pscale(h[0],r)).size())throw runtime_error("internal q-r division identity");
 return h;
}
extern "C" {
int normalize_jet(const int* input,int n,const int* gs,int dr,int dl,int pq,int pd,int pu,int* out,int nout){
 try{
 ring_g.assign(10,KP(3,0));for(int j=0;j<10;j++)for(int i=0;i<3;i++)ring_g[j][i]=gs[3*j+i];for(auto&t:ring_g)trim(t);
 vector<KP>f(9,KP(n));for(int i=0;i<n;i++)for(int j=0;j<9;j++)f[j][i]=input[i*9+j];for(auto&t:f)trim(t);
 for(int i=0;i<-pq;i++)f=rqdiv(f,0);
 for(int i=0;i<-pd;i++)f=rqdiv(f,dr);
 if(pu<0)for(auto&t:f){for(int i=0;i<min(-pu,(int)t.size());i++)if(t[i])throw runtime_error("nonexact u division");if(t.size()>(size_t)(-pu))t=KP(t.begin()-pu,t.end());else t.clear();}
 for(int i=0;i<pq;i++)f=rqmul(f,0);
 for(int i=0;i<pd;i++)f=rqmul(f,dr);
 if(pu>0)for(auto&t:f)if(t.size())t.insert(t.begin(),pu,0);
 int scalar=pw(dl,pd);for(auto&t:f)t=pscale(t,scalar);
 std::fill(out,out+(size_t)nout*9,0);int degree=-1;
 for(int j=0;j<9;j++){degree=max(degree,(int)f[j].size()-1);if(f[j].size()>(size_t)nout)return -3;for(int i=0;i<(int)f[j].size();i++)out[i*9+j]=f[j][i];}
 return degree+1;
 }catch(const std::exception&e){fprintf(stderr,"normalize jet: %s\n",e.what());return -1;}
}
}
extern "C" {
// Divide every labelled polynomial by Z using a separately certified inverse
// numerator I and denominator D. It returns success only if all nine ordinary
// K[u] divisions by D have zero remainder. No D is inverted in the output.
int div_ring_element(const int* input,int n,int count,const int* gs,
 const int* nums,int ni,const int* den,int nd,int* out){
 vector<KP>g(10,KP(3));for(int j=0;j<10;j++)for(int i=0;i<3;i++)g[j][i]=gs[3*j+i];for(auto&t:g)trim(t);
 vector<KP>z(9,KP(ni));for(int j=0;j<9;j++)for(int i=0;i<ni;i++)z[j][i]=nums[j*ni+i];for(auto&t:z)trim(t);
 KP dd(den,den+nd);std::fill(out,out+(size_t)n*count*9,0);
 for(int k=0;k<count;k++){
  vector<KP> f(9,KP(n));for(int j=0;j<9;j++)for(int i=0;i<n;i++)f[j][i]=input[((size_t)i*count+k)*9+j];for(auto&t:f)trim(t);
  vector<KP> h(17);for(int j=0;j<9;j++)for(int l=0;l<9;l++)h[j+l]=padd(h[j+l],pmul(f[j],z[l]));
  for(int j=16;j>=9;j--)if(h[j].size())for(int l=0;l<9;l++)h[j-9+l]=psub(h[j-9+l],pmul(h[j],g[l]));
  for(int j=0;j<9;j++){
   auto qr=pdiv(h[j],dd);if(qr.second.size())return 1+k;
   if(qr.first.size()>(size_t)n)return -1;
   for(int i=0;i<(int)qr.first.size();i++)out[((size_t)i*count+k)*9+j]=qr.first[i];
  }
 }
 return 0;
}
}
