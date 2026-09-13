// Enumerate transitive labelled degree-48 (2,3,8) permutation pairs.
// The three columns are a, b, b^{-1}; labels are 0,...,47.
// C++17, standard library only.  No finite-group database is used.
//
// Completeness does not depend on trusting the pruning implementation:
// verify48.py separately checks inequivalence and compares the sum of
// reciprocal centralizer orders with an independent character-formula mass.
//
#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <vector>
using namespace std;
static const int MAXN=48;
static constexpr int bound=48, period=8;
static const int inv[3]={0,2,1};
struct Table { int n=1; int8_t t[MAXN][3]; uint64_t bigger=0; Table(){ for(auto &row:t) fill(begin(row),end(row),-1); } };
static uint64_t nodes=0, leaves=0;
static vector<vector<int>> rels, forbidden;
static chrono::steady_clock::time_point start;
static ofstream out;
bool assign(Table &s,int x,int g,int y,bool &changed){
 if((s.t[x][g]>=0&&s.t[x][g]!=y)||(s.t[y][inv[g]]>=0&&s.t[y][inv[g]]!=x))return false;
 if(x==y) return false;
 if(s.t[x][g]<0){s.t[x][g]=y;s.t[y][inv[g]]=x;changed=true;}
 return true;
}
bool propagate(Table &s){
 bool changed;
 do {
  changed=false;
  for(int x=0;x<s.n;x++){
   for(const auto &w:rels){
    int l=0,r=(int)w.size()-1, p=x,q=x;
    while(l<=r && s.t[p][w[l]]>=0){p=s.t[p][w[l++]];}
    if(l>r){if(p!=q)return false;continue;}
    while(r>=l && s.t[q][inv[w[r]]]>=0){q=s.t[q][inv[w[r--]]];}
    if(l>r){if(p!=q)return false;}
    else if(l==r){if(!assign(s,p,w[l],q,changed))return false;}
   }
   for(const auto&w:forbidden){
    int p=x; bool full=true;
    for(int g:w){if(s.t[p][g]<0){full=false;break;}p=s.t[p][g];}
    if(full&&p==x)return false;
   }
  }
 }while(changed);
 return true;
}
bool canonical(Table &s){
 for(int root=1;root<s.n;root++){
  if((s.bigger>>root)&1)continue;
  int nu[MAXN],mu[MAXN]; fill(nu,nu+s.n,-1); fill(mu,mu+s.n,-1);
  mu[0]=root;nu[root]=0;int last=0;bool stop=false;
  for(int x=0;x<s.n&&!stop;x++){
   assert(mu[x]>=0);
   for(int g=0;g<3;g++){
    int gamma=s.t[x][g], delta=s.t[mu[x]][g];
    if(gamma<0||delta<0){stop=true;break;}
    if(nu[delta]<0){nu[delta]=++last;mu[last]=delta;}
    if(nu[delta]<gamma)return false;
    if(nu[delta]>gamma){s.bigger|=(uint64_t(1)<<root);stop=true;break;}
   }
  }
 }
 return true;
}
void visit(Table s){
 ++nodes;
 if(nodes%1000000==0){ auto secs=chrono::duration<double>(chrono::steady_clock::now()-start).count();cerr<<"nodes="<<nodes<<" leaves="<<leaves<<" seconds="<<secs<<"\n"; }
 if(!propagate(s)||!canonical(s))return;
 int x=-1,g=-1;
 for(int i=0;i<s.n&&x<0;i++)for(int j=0;j<3;j++)if(s.t[i][j]<0){x=i;g=j;break;}
 if(x<0){
  ++leaves;out<<"[";for(int i=0;i<s.n;i++){if(i)out<<",";out<<"["<<int(s.t[i][0])<<","<<int(s.t[i][1])<<","<<int(s.t[i][2])<<"]";}out<<"]\n";out.flush();return;
 }
 for(int y=0;y<s.n;y++)if(y!=x&&s.t[y][inv[g]]<0){Table d=s;bool ch=false;if(assign(d,x,g,y,ch))visit(d);}
 if(s.n<bound){Table d=s;int y=d.n++;bool ch=false;if(assign(d,x,g,y,ch))visit(d);}
}
int main(int argc,char**argv){
 const char *filename = argc > 1 ? argv[1] : "tables48.jsonl";
 // b and its inverse have order three.  The a-column is its own inverse.
 rels.push_back({1,1,1});rels.push_back({2,2,2});
 // Both cyclic starting positions, and both orientations, of (ab)^8.
 for(int b:{1,2})for(int shift:{0,1}){
  vector<int>w;for(int i=0;i<2*period;i++)w.push_back((i+shift)%2?b:0);
  rels.push_back(w);
  // Excluding (ab)^4 excludes cycles of lengths 1, 2 and 4.
  w.resize(period);forbidden.push_back(w);
 }
 out.open(filename);
 if(!out){cerr<<"Cannot open output file: "<<filename<<"\n";return 1;}
 start=chrono::steady_clock::now();Table s;visit(s);
 cout<<"enumeration_nodes = "<<nodes<<"\n";
 cout<<"enumerated_classes = "<<leaves<<"\n";
 cout<<"enumeration_seconds = "
     <<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<"\n";
 return 0;
}
