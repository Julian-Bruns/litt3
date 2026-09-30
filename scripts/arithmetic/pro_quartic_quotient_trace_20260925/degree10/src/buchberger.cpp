// Exact polynomial-ideal membership generator over F_25.
// The certificate verifier does not rely on the correctness or completeness
// of Buchberger's pair criteria: it checks the final polynomial identity.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <map>
#include <set>
#include <stdexcept>
#include <tuple>
#include <vector>
using namespace std;
using U=uint64_t; using Poly=map<U,int,greater<U>>;
int n; array<int,8> weights; int ad[25][25],mu[25][25],ne[25],iv[25];
const U MASK=(U(1)<<48)-1;
U raw(U k){return MASK^(k&MASK);} int degree(U k){return k>>48;}
U key(U e){int d=0;for(int i=0;i<n;i++)d+=weights[i]*int((e>>(6*i))&63);return (U(d)<<48)|(MASK^e);}
U one(){return MASK;}
U multiply(U a,U b){U e=raw(a)+raw(b);for(int i=0;i<n;i++)if(((raw(a)>>(6*i))&63)+((raw(b)>>(6*i))&63)>63)throw runtime_error("exponent overflow");return (U(degree(a)+degree(b))<<48)|(MASK^e);}
bool mondivides(U a,U b){a=raw(a);b=raw(b);for(int i=0;i<n;i++)if(((a>>(6*i))&63)>((b>>(6*i))&63))return false;return true;}
U quotient(U b,U a){return (U(degree(b)-degree(a))<<48)|(MASK^(raw(b)-raw(a)));}
U lcmkey(U a,U b){a=raw(a);b=raw(b);U e=0;for(int i=0;i<n;i++)e|=U(max((a>>(6*i))&63,(b>>(6*i))&63))<<(6*i);return key(e);}
struct Edge{int id,c;U m;};
struct Node{Poly p;vector<Edge> edges;int input=-1;};vector<Node> nodes;
void term(Poly &p,U m,int c){if(!c)return;auto t=p.find(m);if(t==p.end())p.emplace(m,c);else{int v=ad[t->second][c];if(v)t->second=v;else p.erase(t);}}
void addmul(Poly &p,const Poly &q,U m,int c){for(auto [a,b]:q)term(p,multiply(a,m),mu[b][c]);}
void compact(vector<Edge>& es){map<pair<int,U>,int> d;for(auto e:es){auto k=make_pair(e.id,e.m);int c=ad[d[k]][e.c];if(c)d[k]=c;else d.erase(k);}es.clear();for(auto [k,c]:d)es.push_back({k.first,c,k.second});}
int reduce_node(Poly p,vector<Edge> es,vector<int> g){
 sort(g.begin(),g.end(),[](int a,int b){return nodes[a].p.begin()->first<nodes[b].p.begin()->first;});
 Poly rem;
 while(!p.empty()){
  auto [lm,lc]=*p.begin(); bool found=false;
  for(int id:g){auto [m,c]=*nodes[id].p.begin();if(mondivides(m,lm)){
    U t=quotient(lm,m);int scale=ne[mu[lc][iv[c]]];addmul(p,nodes[id].p,t,scale);es.push_back({id,scale,t});found=true;break;
  }}
  if(!found){rem.emplace(lm,lc);p.erase(p.begin());}
 }
 if(rem.empty())return -1;
 int inv=iv[rem.begin()->second];for(auto &t:rem)t.second=mu[t.second][inv];for(auto &e:es)e.c=mu[e.c][inv];compact(es);
 nodes.push_back({move(rem),move(es),-1});return int(nodes.size())-1;
}
struct Pair{U m;int a,b;bool operator<(const Pair&o)const{return tie(m,a,b)<tie(o.m,o.a,o.b);}};
vector<int> G;set<Pair> pairs;
void update(int h){
 U mh=nodes[h].p.begin()->first;vector<int>D;
 for(size_t i=0;i<G.size();i++){
  int g=G[i];U mg=nodes[g].p.begin()->first;U m=lcmkey(mh,mg);bool keep=(multiply(mh,mg)==m);
  if(!keep){keep=true;for(size_t j=i+1;j<G.size();j++)if(mondivides(lcmkey(mh,nodes[G[j]].p.begin()->first),m)){keep=false;break;}
   if(keep)for(int q:D)if(mondivides(lcmkey(mh,nodes[q].p.begin()->first),m)){keep=false;break;}}
  if(keep)D.push_back(g);
 }
 for(auto it=pairs.begin();it!=pairs.end();){
  if(mondivides(mh,it->m) && lcmkey(nodes[it->a].p.begin()->first,mh)!=it->m && lcmkey(nodes[it->b].p.begin()->first,mh)!=it->m)it=pairs.erase(it);else ++it;
 }
 for(int g:D){U mg=nodes[g].p.begin()->first,m=lcmkey(mh,mg);if(multiply(mh,mg)!=m)pairs.insert({m,h,g});}
 vector<int> ng;for(int g:G)if(!mondivides(mh,nodes[g].p.begin()->first))ng.push_back(g);ng.push_back(h);G=move(ng);
}
void exps(ostream&o,U m){U e=raw(m);for(int i=0;i<n;i++)o<<' '<<((e>>(6*i))&63);}
void save_certificate(int root,string path,int ni){
 set<int> used;vector<int> todo={root};while(!todo.empty()){int i=todo.back();todo.pop_back();if(!used.insert(i).second)continue;for(auto e:nodes[i].edges)todo.push_back(e.id);}
 ofstream f(path);f<<"IDEAL_DAG_V1 "<<n<<' '<<ni<<' '<<used.size()<<' '<<root<<'\n';size_t et=0;
 for(int i:used){auto &nd=nodes[i];f<<"NODE "<<i<<' '<<nd.input<<' '<<nd.p.size()<<' '<<nd.edges.size()<<'\n';for(auto e:nd.edges){f<<e.id<<' '<<e.c;exps(f,e.m);f<<'\n';et++;}}
 cerr<<"CERTIFICATE nodes="<<used.size()<<" edges="<<et<<" path="<<path<<"\n";
}
int main(int argc,char**argv){try{
 if(argc<3){cerr<<"usage: buchberger input.txt certificate.dag [seconds=180] [weighted=0]\n";return 2;}
 int limit=argc>3?stoi(argv[3]):180;bool weighted=argc>4?stoi(argv[4]):false;
 for(int a=0;a<25;a++){ne[a]=((5-a%5)%5)+5*((5-a/5)%5);for(int b=0;b<25;b++){ad[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);mu[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
 for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mu[a][b]==1)iv[a]=b;
 ifstream in(argv[1]);int ni;in>>n>>ni;if(n<1||n>8)throw runtime_error("variables must be 1..8");weights.fill(1);if(weighted&&n==8)weights={10,7,4,1,6,3,6,3};
 for(int i=0;i<ni;i++){int sz;in>>sz;Poly p;for(int j=0;j<sz;j++){int c;in>>c;U e=0;for(int k=0;k<n;k++){int a;in>>a;e|=U(a)<<(6*k);}term(p,key(e),c);}nodes.push_back({move(p),{},i});}
 auto start=chrono::steady_clock::now(),last=start;long total=0,zero=0;
 vector<int> inputs;for(int i=0;i<ni;i++)inputs.push_back(i);sort(inputs.begin(),inputs.end(),[](int a,int b){return nodes[a].p.begin()->first<nodes[b].p.begin()->first;});
 for(int i:inputs){int h=reduce_node(nodes[i].p,{{i,1,one()}},G);if(h>=0){if(nodes[h].p.begin()->first==one()){save_certificate(h,argv[2],ni);cout<<"UNIT_IDEAL\n";return 0;}update(h);}}
 while(!pairs.empty()){
  auto pr=*pairs.begin();pairs.erase(pairs.begin());U a=quotient(pr.m,nodes[pr.a].p.begin()->first),b=quotient(pr.m,nodes[pr.b].p.begin()->first);
  Poly p;addmul(p,nodes[pr.a].p,a,1);addmul(p,nodes[pr.b].p,b,ne[1]);int h=reduce_node(move(p),{{pr.a,1,a},{pr.b,ne[1],b}},G);total++;
  if(h>=0){if(nodes[h].p.begin()->first==one()){save_certificate(h,argv[2],ni);cout<<"UNIT_IDEAL reductions="<<total<<" total_nodes="<<nodes.size()<<"\n";return 0;}update(h);}else zero++;
  auto now=chrono::steady_clock::now();double elapsed=chrono::duration<double>(now-start).count();
  if(chrono::duration<double>(now-last).count()>5){size_t terms=0;for(int g:G)terms+=nodes[g].p.size();cerr<<"elapsed="<<elapsed<<" reductions="<<total<<" zero="<<zero<<" nodes="<<nodes.size()<<" active="<<G.size()<<" pairs="<<pairs.size()<<" terms="<<terms<<" current_pair_degree="<<degree(pr.m)<<"\n";last=now;}
  if(elapsed>limit){cerr<<"TIME_LIMIT: no conclusion\n";return 3;}
 }
 cout<<"PROPER_GROEBNER_BASIS (generator output only; not independently checked) size="<<G.size()<<"\n";return 4;
 }catch(const exception&e){cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
