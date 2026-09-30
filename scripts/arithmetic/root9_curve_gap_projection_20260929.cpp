// Degree-certified norms of newly computed regular-square-root rows on
// the whole degree12 endpoint curve. Unknown scalar content is retained.
#define main critical_resultant_main
#include "root9_critical_resultants_20260929.cpp"
#undef main
#include "root9_large_fourier_20260929.hpp"
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
FP readpoly(const ptree&r){std::vector<F>a;for(auto&[k,v]:r)a.push_back(F(v.get_value<unsigned>()));return FP(a);}
void writepoly(std::ostream&o,const FP&p){o<<'[';for(int i=0;i<=p.deg();i++){if(i)o<<',';o<<p[i].v;}o<<']';}
int main(int argc,char**argv){try{
 F::init();FastK::init();large_dft_controls();
 if(argc==1)return 0;
 if(argc<5)throw std::runtime_error("usage J.json output-prefix gap1.json gap2.json [gap3.json]");
 auto start=std::chrono::steady_clock::now();ptree obj;boost::property_tree::read_json(argv[1],obj);
 std::vector<std::vector<FP>> rows(1);for(auto&[k,r]:obj.get_child("coefficients"))rows[0].push_back(readpoly(r));
 std::vector<FP>contents;std::vector<int>indices,bounds;int jdeg=0;for(auto&p:rows[0])jdeg=std::max(jdeg,p.deg());
 for(int k=3;k<argc;k++){
  boost::property_tree::read_json(argv[k],obj);rows.emplace_back();
  for(auto&[kk,r]:obj.get_child("coefficients"))rows.back().push_back(readpoly(r));
  contents.push_back(readpoly(obj.get_child("content")));indices.push_back(obj.get<int>("index"));
  int d=0;for(auto&p:rows.back())d=std::max(d,p.deg());
  bounds.push_back((rows[0].size()-1)*d+(rows.back().size()-1)*jdeg);
 }
 int bound=*std::max_element(bounds.begin(),bounds.end()),N=0;
 for(int i=bound+1;i<=(int)F::NN;i++)if(F::NN%i==0){N=i;break;}
 if(!N)throw std::runtime_error("projection degree exceeds field root grid");F root=F(25).pow(F::NN/N);
 std::cout<<"DEGREE_BOUNDS ";for(int b:bounds)std::cout<<b<<' ';std::cout<<"GRID "<<N<<std::endl;
 std::vector<std::pair<int,int>>cols;std::vector<std::vector<std::vector<F>>>ev(rows.size());
 for(int i=0;i<(int)rows.size();i++){ev[i].resize(rows[i].size());for(int j=0;j<(int)rows[i].size();j++)cols.push_back({i,j});}
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<(int)cols.size();k++){
  auto[i,j]=cols[k];auto c=rows[i][j].c;c.resize(N);ev[i][j]=large_dft(c,root);
  #pragma omp critical
  std::cout<<"COEFFICIENT_DFT "<<i<<' '<<j<<std::endl;
 }
 std::vector<std::vector<F>>val(rows.size()-1,std::vector<F>(N));
 #pragma omp parallel for schedule(dynamic,64)
 for(int k=0;k<N;k++){
  std::vector<FP>p(rows.size());for(int i=0;i<(int)rows.size();i++){for(auto&v:ev[i])p[i].c.push_back(v[k]);p[i].trim();}
  for(int i=1;i<(int)rows.size();i++)val[i-1][k]=fixed_resultant(p[0],p[i],rows[0].size()-1,rows[i].size()-1);
 }
 std::cout<<"ALL_SYLVESTER_VALUES_DONE"<<std::endl;ev.clear();
 std::vector<FP>norms;F ni=F(N%5).inverse();
 for(int i=0;i<(int)val.size();i++){
  auto c=large_dft(val[i],root.inverse());for(auto&z:c)z*=ni;
  for(int j=bounds[i]+1;j<N;j++)assert(!c[j]);FP poly(c);
  for(int k:{0,1,71,313,N/2,N-1})assert(poly.eval(root.pow(k))==val[i][k]);
  // Additional nodes outside any coordinate-table assumptions: original
  // polynomial evaluation and a literal Sylvester matrix agree.
  for(F z:{F(25)+F(1),F(25).pow(2)+F(2)}){
   FP a,b;for(auto&p:rows[0])a.c.push_back(p.eval(z));for(auto&p:rows[i+1])b.c.push_back(p.eval(z));a.trim();b.trim();
   assert(poly.eval(z)==sylvester(a,b,rows[0].size()-1,rows[i+1].size()-1));
  }
  std::ofstream out(std::string(argv[2])+"."+std::to_string(indices[i])+".json");
  out<<"{\"index\":"<<indices[i]<<",\"degree_bound\":"<<bounds[i]<<",\"grid\":"<<N<<",\"content\":";writepoly(out,contents[i]);out<<",\"norm_of_primitive_row\":";writepoly(out,poly);out<<"}\n";
  norms.push_back(std::move(poly));std::cout<<"NORM_DONE "<<indices[i]<<" degree "<<norms.back().deg()<<std::endl;
 }
 auto[g,u,v]=xgcd_half(norms[0],norms[1],true);
 std::ofstream out(std::string(argv[2])+".gcd.json");out<<"{\"gcd\":";writepoly(out,g);out<<",\"u\":";writepoly(out,u);out<<",\"v\":";writepoly(out,v);out<<"}\n";
 std::cout<<"LITERAL_BEZOUT_DONE gcd_degree "<<g.deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
