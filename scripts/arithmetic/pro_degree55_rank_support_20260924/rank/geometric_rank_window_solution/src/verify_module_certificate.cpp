/* Exact certificate verifier. No Groebner-basis completeness is assumed.
 * Every retained module vector is replayed as a linear combination of earlier
 * vectors and original matrix rows. Only zero reductions are used afterwards.
 */
#include "module_arithmetic.hpp"
#include <stdexcept>
#include <filesystem>
namespace fs = std::filesystem;
void require(bool ok,const string &message){if(!ok)throw runtime_error(message);}
Poly read_checked(istream &in){
 long long n;require(bool(in>>n),"missing polynomial");require(n>=0&&n<10000000,"bad term count");Poly p;
 for(long long k=0;k<n;k++) {int c,j,e;require(bool(in>>c>>j),"truncated term");require(c>=0&&c<25&&j>=0&&j<NC,"invalid coefficient/component");U m=0;
  for(int i=0;i<NV;i++){require(bool(in>>e),"truncated monomial");require(e>=0&&e<128,"invalid exponent");m|=U(e)<<(8*i);}require(degree(m)<128,"degree outside encoding");if(c)p.push_back({m,c,j});
 }
 return norm(p);
}
using Sparse=map<U,int,greater<U>>;
void accum(Sparse &v,const Poly&p,int c=1,U shift=0){
 require(p.empty() || degree(p[0].m)+degree(shift)<128,"monomial encoding bound exceeded");
 for(auto t:p){U k=key(t.m+shift,t.p);int a=MUL[c][t.c];if(!a)continue;auto it=v.find(k);if(it==v.end())v.emplace(k,a);else{a=ADD[it->second][a];if(a)it->second=a;else v.erase(it);}}
}
Poly from_sparse(const Sparse&v,int c=1){Poly p;for(auto t:v)p.push_back({getm(t.first),MUL[c][t.second],getp(t.first)});return p;}
bool equalpoly(const Poly&a,const Poly&b){if(a.size()!=b.size())return false;for(size_t i=0;i<a.size();i++)if(a[i].m!=b[i].m||a[i].p!=b[i].p||a[i].c!=b[i].c)return false;return true;}
Poly linear_sum(const vector<Poly>&v,const vector<int>&cs){Sparse r;require(cs.size()<=v.size(),"coefficient row too long");for(size_t i=0;i<cs.size();i++)accum(r,v[i],cs[i]);return from_sparse(r);}
Poly diff_poly(const Poly&a,const Poly&b){Sparse r;accum(r,a);accum(r,b,4);return from_sparse(r);}
Poly product_reduce(const Poly&p,const Poly&q){Poly r;for(auto a:p)for(auto b:q)r.push_back({a.m+b.m,MUL[a.c][b.c],a.p});return reduce(r);}
Poly power_on_generator(const Poly&q,int n,int j){Poly w={{0,1,j}};while(n--)w=product_reduce(w,q);return w;}
vector<int> read_row(istream &in){int n;require(bool(in>>n)&&n>=0&&n<10000,"bad coefficient row");vector<int>v(n);for(int &c:v)require(bool(in>>c)&&c>=0&&c<25,"bad coefficient");return v;}
void zero_reduction(const Poly&p,const string &label){auto r=reduce(p);require(r.empty(),"nonzero reduction: "+label);}
int main(int argc,char**argv){
 try {
  require(argc==3,"usage: verify_module_certificate ARCHIVE_ROOT CHART_INDEX");fs::path root=argv[1];int ch=stoi(argv[2]);require(ch>=0&&ch<5,"chart outside 0..4");fs::path dir=root/"data"/"modules"/("chart"+to_string(ch));init();
  ifstream input(dir/"input.txt");int ng;require(bool(input>>NV>>NC>>ng),"missing input header");require(NV==5-ch&&NC==15&&ng==23,"unexpected module dimensions");MASK=(U(1)<<(8*NV))-1;
  vector<Poly>original;for(int i=0;i<ng;i++)original.push_back(read_checked(input));
  ifstream hist(dir/"history.txt");int nv,nc;require(bool(hist>>nv>>nc)&&nv==NV&&nc==NC,"history header mismatch");int h,type,a,b,scalar,nr;U l;long long combinations=0;
  auto start=chrono::steady_clock::now();
  while(hist>>h){require(bool(hist>>type>>a>>b>>l>>scalar>>nr),"truncated history record");require(h==(int)polys.size(),"history indices not consecutive");require(scalar>0&&scalar<25&&nr>=0,"bad history scalar/count");Sparse r;
   if(type==0){require(a>=0&&a<ng,"original-row index");accum(r,original[a]);}
   else {require(type==1&&a>=0&&b>=0&&a<h&&b<h,"invalid S-pair references");require(!polys[a].empty()&&!polys[b].empty(),"zero S-pair operand");require(polys[a][0].p==polys[b][0].p,"different leading components");require(l==lcmm(polys[a][0].m,polys[b][0].m),"wrong least common multiple");accum(r,polys[a],INV[polys[a][0].c],l-polys[a][0].m);accum(r,polys[b],NEG[INV[polys[b][0].c]],l-polys[b][0].m);}
   for(int j=0;j<nr;j++){int g,c;U m;require(bool(hist>>g>>c>>m),"truncated reduction history");require(g>=0&&g<h&&c>0&&c<25&&(m&~MASK)==0,"invalid reduction history");accum(r,polys[g],c,m);}
   Poly claimed=read_checked(hist);Poly computed=from_sparse(r,scalar);require(!claimed.empty()&&claimed[0].c==1,"nonmonic/zero retained row");require(equalpoly(computed,claimed),"history identity failed at row "+to_string(h));polys.push_back(move(claimed));combinations+=nr;
  }
  require(hist.eof(),"malformed history ending");require(!polys.empty(),"empty history");
  ifstream ids(dir/"basis_ids.txt");int id;while(ids>>id){require(id>=0&&id<(int)polys.size(),"invalid basis index");require(active.insert(id).second,"duplicate basis index");}require(!active.empty(),"empty retained reducer list");refresh();
  cout<<"PASS chart "<<ch<<": replayed "<<polys.size()<<" module-membership identities ("<<combinations<<" earlier-row multiples); retained "<<active.size()<<" reducers.\n";
  ifstream qfile(dir/"annihilators.txt");int nq;require(bool(qfile>>nv>>nc>>nq)&&nv==NV&&nc==1,"annihilator header");vector<Poly>qs;for(int i=0;i<nq;i++){Poly q=read_checked(qfile);for(auto t:q)require(t.p==0,"nonscalar annihilator");qs.push_back(q);}
  int obligations=0;
  if(ch==0){
   require(nq==3,"three scroll equations required");ifstream shape(root/"data"/"shape.txt");require(bool(shape>>nv)&&nv==5,"shape header");vector<int>p=read_row(shape);require(p.size()==45&&p.back()==1&&p[0]!=0,"invalid residual polynomial");vector<vector<int>>coords;
   for(int i=0;i<5;i++){coords.push_back(read_row(shape));require(read_checked(shape).empty(),"nonzero stored discovery remainder");}
   Poly w=power_on_generator(qs[0],3,0);vector<Poly>powers={w};for(int i=1;i<45;i++)powers.push_back(product_reduce(powers.back(),qs[0]));zero_reduction(linear_sum(powers,p),"p(q0)w");obligations++;
   for(int i=0;i<5;i++){Poly xi={{U(1)<<(8*i),1,0}};zero_reduction(diff_poly(product_reduce(w,xi),linear_sum(powers,coords[i])),"coordinate action "+to_string(i));obligations++;}
   ifstream cont(root/"data"/"chart0_containment.txt");require(bool(cont>>nv>>nc>>nq)&&nv==5&&nc==15&&nq==3,"containment header");set<pair<int,int>>seen;
   for(int k=0;k<45;k++){int qi,j,n;require(bool(cont>>qi>>j>>n)&&qi>=0&&qi<3&&j>=0&&j<15&&n==3,"invalid containment record");require(seen.insert({qi,j}).second,"duplicate containment record");vector<int>r=read_row(cont);zero_reduction(diff_poly(power_on_generator(qs[qi],3,j),linear_sum(powers,r)),"q_i^3 e_j finite-submodule containment");obligations++;}
  } else {
   for(int i=0;i<(int)qs.size();i++)for(int j=0;j<NC;j++){zero_reduction(power_on_generator(qs[i],1,j),"annihilator "+to_string(i)+" component "+to_string(j));obligations++;}
  }
  cout<<"PASS chart "<<ch<<": "<<obligations<<" support-certificate obligations; no standard-basis completeness assumption.\n";
  cout<<"Elapsed seconds: "<<chrono::duration_cast<chrono::seconds>(chrono::steady_clock::now()-start).count()<<"\n";
  return 0;
 }catch(const exception&e){cerr<<"FAIL: "<<e.what()<<"\n";return 1;}
}
