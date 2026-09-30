#include <array>
#include <vector>
#include <algorithm>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <chrono>
#include <string>
#include <functional>
#include <cassert>
#include <cstdint>
#include <cstring>
#include <random>
using namespace std;
static uint8_t ADD[25][25], SUB[25][25], MUL[25][25], NEG[25];
static constexpr int MOD[7]={4,21,6,5,9,8,20};
struct K {
 array<uint8_t,7> v{};
 K()=default; K(int a){v[0]=a;}
 bool zero()const {for(auto x:v)if(x)return false;return true;}
 bool operator==(const K&b)const{return v==b.v;}
 bool operator!=(const K&b)const{return v!=b.v;}
 K operator+(const K&b)const {K c;for(int i=0;i<7;i++)c.v[i]=ADD[v[i]][b.v[i]];return c;}
 K operator-(const K&b)const {K c;for(int i=0;i<7;i++)c.v[i]=SUB[v[i]][b.v[i]];return c;}
 K operator-()const {K c;for(int i=0;i<7;i++)c.v[i]=NEG[v[i]];return c;}
 K operator*(const K&b)const {
  uint8_t c[13]={};
  for(int i=0;i<7;i++)if(v[i])for(int j=0;j<7;j++)if(b.v[j])c[i+j]=ADD[c[i+j]][MUL[v[i]][b.v[j]]];
  for(int i=12;i>=7;i--)if(c[i])for(int j=0;j<7;j++)c[i-7+j]=SUB[c[i-7+j]][MUL[c[i]][MOD[j]]];
  K a;for(int i=0;i<7;i++)a.v[i]=c[i];return a;
 }
 K scale(int b)const{K c;for(int i=0;i<7;i++)c.v[i]=MUL[v[i]][b];return c;}
 K pow(uint64_t e)const {K a=*this,b(1);while(e){if(e&1)b=b*a;e>>=1;if(e)a=a*a;}return b;}
 K inv()const{if(zero())throw runtime_error("inverse of zero");return pow(6103515623ULL);}
 uint64_t code()const{uint64_t x=0;for(int i=6;i>=0;i--)x=25*x+v[i];return x;}
};
static array<K,29> ROOT;
static constexpr int MUC[8]={1,2,3,4,7,14,16,23};
using Poly=vector<K>;using Mat=vector<vector<K>>;
void init(){
 for(int a=0;a<25;a++){
  NEG[a]=((5-a%5)%5)+5*((5-a/5)%5);
  for(int b=0;b<25;b++){
   ADD[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   SUB[a][b]=(a%5+5-b%5)%5+5*((a/5+5-b/5)%5);
   MUL[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
  }
 }
 K q;q.v[1]=1;ROOT[0]=K(1);for(int i=1;i<29;i++)ROOT[i]=ROOT[i-1]*q;
 if(ROOT[28]*q!=K(1))throw runtime_error("bad root");
 if(q.pow(6103515625ULL)!=q)throw runtime_error("bad field order");
 for(int x:MUC)if(K(x).pow(8)!=K(1))throw runtime_error("bad mu8");
}
Poly pmul(const Poly&A,const Poly&B){Poly C(A.size()+B.size()-1);for(size_t i=0;i<A.size();i++)for(size_t j=0;j<B.size();j++)C[i+j]=C[i+j]+A[i]*B[j];return C;}
Poly der(const Poly&A){Poly D;if(A.size()<2)return {K()};for(size_t i=1;i<A.size();i++)D.push_back(A[i].scale(i%5));return D;}
K eval(const Poly&A,K q){K b;for(auto i=A.rbegin();i!=A.rend();++i)b=b*q+*i;return b;}
Mat kernel(Mat A,int cols){
 int rows=A.size(),r=0;vector<int> ps;
 for(int j=0;j<cols&&r<rows;j++){
  int i=r;while(i<rows&&A[i][j].zero())i++;if(i==rows)continue;
  swap(A[i],A[r]);K z=A[r][j].inv();for(int l=j;l<cols;l++)A[r][l]=A[r][l]*z;
  for(i=0;i<rows;i++)if(i!=r&&!A[i][j].zero()){
   z=A[i][j];A[i][j]=K();for(int l=j+1;l<cols;l++)A[i][l]=A[i][l]-z*A[r][l];
  }
  ps.push_back(j);r++;
 }
 Mat B;
 for(int j=0;j<cols;j++)if(find(ps.begin(),ps.end(),j)==ps.end()){
  vector<K>b(cols);b[j]=K(1);for(int i=0;i<r;i++)b[ps[i]]=-A[i][j];B.push_back(b);
 }
 return B;
}
struct Spaces {Poly D;Mat W1,W2;};
Spaces spaces(const vector<int>&I){
 int d=I.size();Spaces S;S.D={K(1)};for(int i:I)S.D=pmul(S.D,{-ROOT[i],K(1)});
 Poly dp=der(S.D),ddp=der(dp);Mat M1,M2;
 for(int i:I){K q=ROOT[i],u=eval(dp,q),v=eval(ddp,q);vector<K> row1,row2;K powq(1),prev;
  for(int j=0;j<d+2;j++){
   row1.push_back((j?u.scale(2*j%5)*prev:K())-v*powq);
   row2.push_back((u.scale((2*j+1)%5)-q*v)*powq);
   prev=powq;powq=powq*q;
  }
  M1.push_back(row1);M2.push_back(row2);
 }
 S.W1=kernel(M1,d+2);S.W2=kernel(M2,d+2);return S;
}
K det3(const array<array<K,3>,3>&M){return M[0][0]*(M[1][1]*M[2][2]-M[1][2]*M[2][1])-M[0][1]*(M[1][0]*M[2][2]-M[1][2]*M[2][0])+M[0][2]*(M[1][0]*M[2][1]-M[1][1]*M[2][0]);}
array<K,4> cof(const array<array<K,4>,3>&M){array<K,4> v;for(int j=0;j<4;j++){array<array<K,3>,3>A;for(int i=0;i<3;i++){int l=0;for(int k=0;k<4;k++)if(k!=j)A[i][l++]=M[i][k];}v[j]=det3(A);if(j%2)v[j]=-v[j];}return v;}
static uint64_t layouts=0,cases=0,rankbad=0,dimbad=0,surv=0,zeroopen=0,exactbad=0;
static ofstream exceptions;
static K product_obstructions(1);
void scan(const vector<int>&I){
 layouts++;auto S=spaces(I);int d=I.size();uint32_t mask=0;for(int i:I)mask|=1u<<i;
 if(S.W1.size()!=2||S.W2.size()!=2){dimbad++;exceptions<<"DIM "<<mask<<" "<<S.W1.size()<<" "<<S.W2.size()<<"\n";return;}
 vector<array<K,2>> v1,v2;vector<array<K,4>> R;
 for(int i:I){array<K,2>a={eval(S.W1[0],ROOT[i]),eval(S.W1[1],ROOT[i])},b={eval(S.W2[0],ROOT[i]),eval(S.W2[1],ROOT[i])};v1.push_back(a);v2.push_back(b);K q4=ROOT[4*i%29];R.push_back({-q4*a[0],-q4*a[1],b[0],b[1]});}
 for(int b=0;b<8;b++)for(int c=0;c<8;c++){
  cases++;array<array<K,4>,3>M={R[0],R[1],R[2]};for(int j=0;j<2;j++){M[1][j]=M[1][j].scale(MUC[b]);M[2][j]=M[2][j].scale(MUC[c]);}auto v=cof(M);
  if(v[0].zero()&&v[1].zero()&&v[2].zero()&&v[3].zero()){
   rankbad++;exceptions<<"RANK "<<mask<<" "<<b<<" "<<c<<"\n";continue;
  }
  bool good=true;
  for(int j=0;j<d;j++){
   K x=v1[j][0]*v[0]+v1[j][1]*v[1],y=v2[j][0]*v[2]+v2[j][1]*v[3];
   if(x.zero()||y.zero()){zeroopen++;good=false;break;}
   if(j>=3){K obs=y.pow(8)-ROOT[3*I[j]%29]*x.pow(8);if(!obs.zero()){product_obstructions=product_obstructions*obs;good=false;break;}}
  }
  if(good){
   K lc1=S.W1[0].back()*v[0]+S.W1[1].back()*v[1],lc2=S.W2[0].back()*v[2]+S.W2[1].back()*v[3],b10=S.W1[0][0]*v[0]+S.W1[1][0]*v[1],b20=S.W2[0][0]*v[2]+S.W2[1][0]*v[3];
   if(lc1.zero()||lc2.zero()||b10.zero()||b20.zero()){exactbad++;continue;}
   surv++;exceptions<<"SURV "<<mask<<" "<<b<<" "<<c;for(auto x:v)exceptions<<" "<<x.code();exceptions<<"\n";
  }
 }
}
static constexpr uint32_t FULL=(1u<<29)-1;
uint32_t minrot(uint32_t x){uint32_t z=x;for(int j=1;j<29;j++){x=((x<<1)&FULL)|(x>>28);if(x<z)z=x;}return z;}
static uint32_t PERM[14][5][64];
void initperm(){int h=1;for(int t=0;t<14;t++){for(int b=0;b<5;b++)for(int x=0;x<64;x++){uint32_t v=0;for(int j=0;j<6;j++)if((x&(1<<j))&&6*b+j<29)v|=1u<<((h*(6*b+j))%29);PERM[t][b][x]=v;}h=h*5%29;}}
bool canonical(uint32_t mask){for(int t=1;t<14;t++){uint32_t y=0;for(int b=0;b<5;b++)y|=PERM[t][b][(mask>>(6*b))&63];if(minrot(y)<mask)return false;}return true;}
void necklaces(int d,function<void(uint32_t)> callback){
 int a[30]={};
 function<void(int,int,int)> rec=[&](int t,int p,int w){
  if(w>d||w+(30-t)<d)return;
  if(t>29){if(29%p==0&&w==d){uint32_t mask=0;for(int i=1;i<=29;i++)mask=(mask<<1)|a[i];if(canonical(mask))callback(mask);}return;}
  a[t]=a[t-p];rec(t+1,p,w+a[t]);if(a[t-p]==0){a[t]=1;rec(t+1,t,w+1);}
 };
 rec(1,1,0);
}
int main(int argc,char**argv){
 try {
 init();initperm();int d=argc>1?stoi(argv[1]):4;int mode=argc>2?stoi(argv[2]):0;string out=argc>3?argv[3]:"exceptions.txt";exceptions.open(out);auto start=chrono::steady_clock::now();
 if(mode==1){mt19937 rng(1234);for(int rep=0;rep<100;rep++){vector<int>I(29);for(int j=0;j<29;j++)I[j]=j;shuffle(I.begin(),I.end(),rng);I.resize(d);sort(I.begin(),I.end());scan(I);}}
 else necklaces(d,[&](uint32_t mask){vector<int>I;for(int j=0;j<29;j++)if(mask>>j&1)I.push_back(j);if(mode!=2)scan(I);else layouts++;if(layouts%1000==0){double sec=chrono::duration<double>(chrono::steady_clock::now()-start).count();cerr<<"progress d="<<d<<" layouts="<<layouts<<" sec="<<sec<<" bad="<<dimbad<<","<<rankbad<<","<<surv<<"\n";}});
 double sec=chrono::duration<double>(chrono::steady_clock::now()-start).count();cout<<"{\"d\":"<<d<<",\"layouts\":"<<layouts<<",\"cases\":"<<cases<<",\"dimension_exceptions\":"<<dimbad<<",\"rank_exceptions\":"<<rankbad<<",\"survivors\":"<<surv<<",\"open_zero\":"<<zeroopen<<",\"degree_or_zero_exclusions\":"<<exactbad<<",\"obstruction_product\":"<<product_obstructions.code()<<",\"seconds\":"<<setprecision(10)<<sec<<"}"<<endl;
 }catch(exception&e){cerr<<"ERROR "<<e.what()<<endl;return 1;}
}
