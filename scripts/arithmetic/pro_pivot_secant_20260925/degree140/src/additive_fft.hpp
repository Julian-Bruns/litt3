#pragma once
// Assumes fast_exact.cpp has been included. Exact F_5-additive multipoint
// evaluation and interpolation in the archive's fixed field encoding.
struct AddFFT {
 vector<int> p5; vector<Poly> lin; vector<vector<pair<int,int>>> sparse;
 vector<int> a4inv;
 AddFFT(){p5.resize(9);p5[0]=1;for(int s=1;s<=8;s++)p5[s]=5*p5[s-1];lin.resize(9);sparse.resize(9);a4inv.resize(9);lin[0]={0,1};
  for(int s=1;s<=8;s++){int e=p5[s-1],a=leval(s-1,e);if(!a)throw runtime_error("dependent additive field basis");int a4=ff::pow(a,4);a4inv[s]=ff::inv(a4);Poly next(p5[s]+1);for(int j=0;j<(int)lin[s-1].size();j++)if(lin[s-1][j]){next[5*j]=ff::add(next[5*j],ff::pow(lin[s-1][j],5));next[j]=ff::sub(next[j],ff::mul(a4,lin[s-1][j]));}lin[s]=move(next);}
  for(int s=0;s<=8;s++)for(int j=1;j<(int)lin[s].size();j++)if(lin[s][j])sparse[s].push_back({j,lin[s][j]});
  if(lin[8][1]!=4||lin[8].back()!=1||sparse[8].size()!=2)throw runtime_error("field subspace polynomial is not x^q-x");
 }
 int leval(int s,int h)const{int z=0;for(int e=1;e<(int)lin[s].size();e*=5)z=ff::add(z,ff::mul(lin[s][e],ff::pow(h,e)));return z;}
 Poly rem_linear(Poly f,int s,int c)const{int d=p5[s];if((int)f.size()<=d)return f;for(int i=f.size()-1;i>=d;i--){int v=f[i];if(!v)continue;f[i]=0;for(auto [e,k]:sparse[s])if(e<d)f[i-d+e]=ff::sub(f[i-d+e],ff::mul(v,k));if(c)f[i-d]=ff::add(f[i-d],ff::mul(v,c));}f.resize(d);trim(f);return f;}
 void eval_rec(const Poly&f,int s,int shift,vector<int>&out)const{if(!s){out[shift]=f.empty()?0:f[0];return;}int d=p5[s-1];for(int j=0;j<5;j++){int sh=shift+j*d,c=leval(s-1,sh);auto r=rem_linear(f,s-1,c);eval_rec(r,s-1,sh,out);}}
 vector<int> evaluate(const Poly&f,int s)const{if((int)f.size()>p5[s])throw runtime_error("additive evaluation degree too high");vector<int>out(p5[s]);eval_rec(f,s,0,out);return out;}
 Poly mul_linear(const Poly&f,int s)const{if(f.empty())return {};Poly out(f.size()+p5[s]);for(auto [e,c]:sparse[s])for(int i=0;i<(int)f.size();i++)if(f[i])out[i+e]=ff::add(out[i+e],ff::mul(f[i],c));trim(out);return out;}
 Poly interp_rec(const vector<int>&vals,int s,int shift)const{if(!s)return cn(vals[shift]);int d=p5[s-1];array<Poly,5>rs;for(int j=0;j<5;j++)rs[j]=interp_rec(vals,s-1,shift+j*d);array<Poly,5>qs;for(auto&q:qs)q.resize(d);
  for(int j=0;j<5;j++){int c=leval(s-1,shift+j*d);int fac[5];for(int t=0;t<5;t++)fac[t]=ff::neg(ff::mul(a4inv[s],ff::pow(c,4-t)));fac[0]=ff::add(fac[0],1);for(int t=0;t<5;t++)if(fac[t])for(int i=0;i<(int)rs[j].size();i++)qs[t][i]=ff::add(qs[t][i],ff::mul(rs[j][i],fac[t]));}
  for(auto&q:qs)trim(q);Poly f=move(qs[4]);for(int t=3;t>=0;t--)f=add(mul_linear(f,s-1),qs[t]);return f;}
 Poly interpolate(const vector<int>&vals,int s)const{if((int)vals.size()!=p5[s])throw runtime_error("additive interpolation length");return interp_rec(vals,s,0);}
};
