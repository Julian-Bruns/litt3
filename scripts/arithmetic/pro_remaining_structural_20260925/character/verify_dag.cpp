// Independent certificate checker: direct sparse polynomial identities.
// It does not run Buchberger, perform polynomial division, or trust pair criteria.
#include <array>
#include <algorithm>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>
#include <chrono>
using namespace std;using Key=uint64_t;using Poly=unordered_map<Key,uint8_t>;
int nv,nc;int A[25][25],M[25][25],N[25],I[25];
void need(bool b,const string&s){if(!b)throw runtime_error(s);}
int expK(Key k,int j){return (k>>(6+6*j))&63;}
int deg(Key k){int d=0;for(int j=0;j<nv;++j)d+=expK(k,j);return d;}
bool greaterK(Key a,Key b){int da=deg(a),db=deg(b);if(da!=db)return da>db;for(int j=nv-1;j>=0;--j)if(expK(a,j)!=expK(b,j))return expK(a,j)<expK(b,j);return (a&63)<(b&63);}
Key lead(const Poly&p){need(!p.empty(),"zero polynomial");Key best=p.begin()->first;for(auto&t:p)if(greaterK(t.first,best))best=t.first;return best;}
Key readmon(istream&in,bool component){int c=0,e;if(component)in>>c;need(c>=0&&c<nc,"bad component");Key k=c;for(int j=0;j<nv;++j){in>>e;need(e>=0&&e<64,"exponent overflow");k|=Key(e)<<(6+6*j);}return k;}
Poly readpoly(istream&in,int nt,bool tags){Poly p;p.reserve(nt*2+1);for(int j=0;j<nt;++j){string tag;if(tags){in>>tag;need(tag=="T","bad term tag");}Key k=readmon(in,true);int c;in>>c;need(c>0&&c<25&&!p.count(k),"bad term");p[k]=c;}return p;}
void subtract(Poly&a,const Poly&b,Key shift,int c){
 for(auto&t:b){for(int j=0;j<nv;++j)need(expK(t.first,j)+expK(shift,j)<64,"shift overflow");Key key=t.first+shift;auto it=a.find(key);int val=A[it==a.end()?0:it->second][N[M[c][t.second]]];if(val)a[key]=val;else if(it!=a.end())a.erase(it);}
}
int matrixrank(vector<vector<int>>a){int r=0;for(int j=0;j<nc&&r<(int)a.size();++j){int q=r;while(q<(int)a.size()&&!a[q][j])++q;if(q==(int)a.size())continue;swap(a[q],a[r]);int s=I[a[r][j]];for(auto&x:a[r])x=M[s][x];for(int i=r+1;i<(int)a.size();++i)if(a[i][j]){s=a[i][j];for(int k=j;k<nc;++k)a[i][k]=A[a[i][k]][N[M[s][a[r][k]]]];}++r;}return r;}
int main(int argc,char**argv){
 need(argc>=3,"Usage: verify_dag INPUT DAG [allow-incomplete]");
 for(int a=0;a<25;++a){N[a]=(-a%5+5)%5+5*((-(a/5)+5)%5);for(int b=0;b<25;++b){A[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);M[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
 for(int a=1;a<25;++a)for(int b=1;b<25;++b)if(M[a][b]==1)I[a]=b;
 ifstream input(argv[1]),dag(argv[2]);need(bool(input)&&bool(dag),"file missing");int ni;input>>nv>>nc>>ni;need(nv<=9&&nc<=64,"unsupported dimensions");vector<Poly>initial;
 for(int i=0;i<ni;++i){int nt;input>>nt;Poly p=readpoly(input,nt,false);int v=I[p.at(lead(p))];for(auto&t:p)t.second=M[v][t.second];initial.push_back(move(p));}
 string tag;int vn,cn,in;dag>>tag>>vn>>cn>>in;need(tag=="MODULE_DAG_V1"&&vn==nv&&cn==nc&&in==ni,"header mismatch");vector<Poly>g;auto start=chrono::steady_clock::now();double last=0;int claimed=-1;bool ended=false;
 while(dag>>tag){
  if(tag=="INIT"){int idx,nt;dag>>idx>>nt;need(idx==(int)g.size()&&idx<ni,"bad init");Poly p=readpoly(dag,nt,true);need(p==initial[idx],"initial polynomial mismatch");g.push_back(move(p));}
  else if(tag=="ADD"){
   int idx,i,j,sc,nt,nr;dag>>idx>>i>>j>>sc>>nt>>nr;need(idx==(int)g.size()&&i<idx&&j<idx&&i>=0&&j>=0&&sc>0&&sc<25,"bad ADD");Poly target=readpoly(dag,nt,true);Key li=lead(g[i]),lj=lead(g[j]);need((li&63)==(lj&63)&&g[i].at(li)==1&&g[j].at(lj)==1,"bad leading terms");Key si=0,sj=0;
   for(int v=0;v<nv;++v){int e=max(expK(li,v),expK(lj,v));si|=Key(e-expK(li,v))<<(6+6*v);sj|=Key(e-expK(lj,v))<<(6+6*v);}
   Poly actual;actual.reserve(target.size()*2+1024);subtract(actual,g[i],si,4);subtract(actual,g[j],sj,1);
   for(int r=0;r<nr;++r){int ri,c;dag>>tag>>ri;need(tag=="R"&&ri>=0&&ri<idx,"bad reducer");Key s=readmon(dag,false);dag>>c;need(c>0&&c<25,"bad reducer coefficient");subtract(actual,g[ri],s,c);}
   for(auto&t:actual)t.second=M[sc][t.second];need(actual==target,"polynomial identity failed at node "+to_string(idx));g.push_back(move(target));
  }else if(tag=="END"){dag>>claimed;ended=true;break;}else if(tag=="STOP")break;else throw runtime_error("unknown tag");
  double elapsed=chrono::duration<double>(chrono::steady_clock::now()-start).count();if(elapsed-last>5){cout<<"verified_nodes="<<g.size()<<" seconds="<<elapsed<<endl;last=elapsed;}
 }
 vector<vector<int>>constants;for(auto&p:g)if(deg(lead(p))==0){vector<int>r(nc);for(auto&t:p){need(deg(t.first)==0,"invalid constant member");r[t.first&63]=t.second;}constants.push_back(move(r));}int cr=matrixrank(constants);bool complete=ended&&claimed==nc&&cr==nc;
 cout<<"IDENTITIES_VERIFIED nodes="<<g.size()<<" constant_rank="<<cr<<" complete_exclusion="<<complete<<" seconds="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
 if(argc<4)need(complete,"No complete full-module certificate");return 0;
}
