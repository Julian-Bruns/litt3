#include "algebra.hpp"
#include "rational.hpp"
#include "polynomial_tools.hpp"
#include "fft.hpp"
#include "jets.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <openssl/evp.h>
#include <omp.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <malloc.h>
#include <bit>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <sstream>
using namespace comp;using boost::property_tree::ptree;
static_assert(sizeof(F)==4&&std::endian::native==std::endian::little);
constexpr uint64_t MAGIC_VALUES=0x31534c4156435043ULL,MAGIC_NODES=0x315345444e435043ULL;
constexpr int COLUMN_COUNT=328,BLOCK=4096;
using JF=Jet<F>;using J2=Jet<F2>;
ptree read(const std::string&path){ptree z;boost::property_tree::read_json(path,z);return z;}
FP poly(const ptree&z){std::vector<F>v;for(auto&[k,x]:z)v.emplace_back(x.get_value<unsigned>());return FP(v);}
std::vector<int>ints(const ptree&z){std::vector<int>v;for(auto&[k,x]:z)v.push_back(x.get_value<int>());return v;}
std::vector<ptree>array(const ptree&z){std::vector<ptree>v;for(auto&[k,x]:z)v.push_back(x);return v;}
ptree js_poly(const FP&p){ptree z;for(F v:p.c){ptree x;x.put("",v.v);z.push_back({"",x});}return z;}
ptree js_ints(const std::vector<long long>&p){ptree z;for(auto v:p){ptree x;x.put("",v);z.push_back({"",x});}return z;}
void printpoly(std::ostream&o,const FP&p){o<<'[';for(size_t j=0;j<p.c.size();j++){if(j)o<<',';o<<p.c[j].v;}o<<']';}
struct Hash {
 EVP_MD_CTX*ctx=EVP_MD_CTX_new();Hash(){if(!ctx||EVP_DigestInit_ex(ctx,EVP_sha256(),nullptr)!=1)throw std::runtime_error("SHA256 init failed");}~Hash(){EVP_MD_CTX_free(ctx);}
 void add(const void*p,size_t n){if(EVP_DigestUpdate(ctx,p,n)!=1)throw std::runtime_error("SHA256 update failed");}
 std::string finish(){unsigned char b[32];unsigned n;if(EVP_DigestFinal_ex(ctx,b,&n)!=1||n!=32)throw std::runtime_error("SHA256 final failed");std::ostringstream s;for(auto c:b)s<<std::hex<<std::setw(2)<<std::setfill('0')<<int(c);return s.str();}
};
std::string sha_file(const std::string&path){std::ifstream f(path,std::ios::binary);if(!f)throw std::runtime_error("hash input missing");Hash h;std::vector<char>b(1<<20);while(f){f.read(b.data(),b.size());h.add(b.data(),f.gcount());}return h.finish();}
struct Mapping {
 int fd=-1;size_t bytes=0;void*base=MAP_FAILED;F*values=nullptr;
 Mapping(const std::string&name,size_t count,bool create){bytes=64+count*4;fd=open(name.c_str(),create?(O_RDWR|O_CREAT|O_TRUNC):O_RDONLY,0644);if(fd<0)throw std::runtime_error("cannot open mapped coefficient table");if(create){if(ftruncate(fd,bytes))throw std::runtime_error("cannot size coefficient table");}else{struct stat s;if(fstat(fd,&s)||uint64_t(s.st_size)!=bytes)throw std::runtime_error("mapped coefficient table has wrong length");}base=mmap(nullptr,bytes,create?(PROT_READ|PROT_WRITE):PROT_READ,MAP_SHARED,fd,0);if(base==MAP_FAILED)throw std::runtime_error("mmap failed");values=reinterpret_cast<F*>(reinterpret_cast<char*>(base)+64);}
 ~Mapping(){if(base!=MAP_FAILED)munmap(base,bytes);if(fd>=0)close(fd);}uint64_t*header(){return reinterpret_cast<uint64_t*>(base);}
 void sync(){if(msync(base,bytes,MS_SYNC))throw std::runtime_error("mapped table sync failed");}
};
int binomial(uint64_t n,int k){static int b[5][5]={{1,0,0,0,0},{1,1,0,0,0},{1,2,1,0,0},{1,3,3,1,0},{1,4,1,4,1}};int z=1;while(k){z=z*b[n%5][k%5]%5;if(!z)return 0;n/=5;k/=5;}return z;}
Rat rational(const ptree&z){Rat r;r.a=poly(z.get_child("a"));r.b=poly(z.get_child("b"));auto d=ints(z.get_child("den"));assert(d.size()==5);std::copy(d.begin(),d.end(),r.den.begin());return r;}
std::string block_hash(const F*table,int N,int L,int start,int count){Hash h;uint64_t header[]={uint64_t(N),uint64_t(L),uint64_t(start),uint64_t(count),COLUMN_COUNT};h.add(header,sizeof(header));for(int c=0;c<COLUMN_COUNT*L;c++)h.add(table+uint64_t(c)*N+start,size_t(count)*sizeof(F));return h.finish();}
JF evaluate(const FP&p,JF q){JF z;for(int i=p.deg();i>=0;i--)z=z*q+JF(p.c[i]);return z;}
void prepare(const std::string&root,const std::string&tailpath,const std::string&boundpath,const std::string&prefix,int threads){
 auto start=std::chrono::steady_clock::now();omp_set_num_threads(threads);auto input=read(root+"/data/inputs.json"),td=read(tailpath),bounds=read(boundpath);FP C=poly(input.get_child("C"));std::array<FP,5>poles;int kk=0;for(auto&[s,z]:td.get_child("poles"))poles[kk++]=poly(z);assert(kk==5);Rat::setup(C,poles);FastK::init();
 std::array<std::vector<Rat>,3>r;std::array<std::array<int,5>,3>den{};for(int n=0;n<3;n++)for(auto&[s,z]:td.get_child("C"+std::to_string(n+71))){auto a=rational(z);for(int k=0;k<5;k++)den[n][k]=std::max(den[n][k],a.den[k]);r[n].push_back(std::move(a));}assert(r[0].size()==54&&r[1].size()==55&&r[2].size()==55);td.clear();malloc_trim(0);
 auto bd=ints(bounds.get_child("projected_degree_bounds"));assert(bd.size()==2);auto expected_den=array(bounds.get_child("common_denominators"));for(int n=0;n<3;n++)for(int k=0;k<5;k++)assert(den[n][k]==ints(expected_den[n])[k]);
 FP bad=C;for(auto&p:poles)bad*=p;bad=exact_fast(bad,gcd_fast(bad,derivative(bad)));FP x(std::vector<F>{0,1});int N=F::NN;FP E0=gcd_fast(bad,power_mod(x,cpp_int(N),bad)-FP(1));std::vector<int>erased;
 for(auto&p:factor_squarefree(E0)){assert(p.deg()==1);F q=-p[0]/p[1];assert(q);erased.push_back(F::logs[q.v]);}std::sort(erased.begin(),erased.end());assert((int)erased.size()==E0.deg());int L=(std::max(bd[0],bd[1])+1+(N-E0.deg())-1)/(N-E0.deg());assert(L>=1&&L<=16);jet_order=L;
 std::vector<FP>polys;for(auto&row:r)for(auto&a:row){std::array<int,5>diff{};int n=&row-&r[0];for(int k=0;k<5;k++)diff[k]=den[n][k]-a.den[k];a.multiply_factors(diff);polys.push_back(std::move(a.a));polys.push_back(std::move(a.b));}assert(polys.size()==COLUMN_COUNT);r={};malloc_trim(0);
 ptree meta;meta.put("format","companion140-hermite-v1");meta.put("N",N);meta.put("L",L);meta.put("columns",COLUMN_COUNT);meta.put("node_block_size",BLOCK);meta.put("tail_sha256",sha_file(tailpath));meta.put("bounds_sha256",sha_file(boundpath));meta.add_child("degree_bounds",bounds.get_child("projected_degree_bounds"));meta.add_child("C",js_poly(C));meta.add_child("erasure_polynomial",js_poly(E0));std::vector<long long>er(erased.begin(),erased.end());meta.add_child("erased_indices",js_ints(er));
 ptree factors;for(auto&[s,z]:bounds.get_child("places")){int k=z.get<int>("pole_index");auto vb=ints(z.get_child("norm_resultant_valuation_bounds"));std::vector<long long>e;for(int j=0;j<2;j++)e.push_back(-vb[j]-2LL*(54*den[0][k]+53*den[j+1][k]));ptree p;p.add_child("polynomial",z.get_child("modulus"));p.add_child("exponents",js_ints(e));factors.push_back({"",p});}meta.add_child("normalizing_factors",factors);
 std::cout<<"{\"hermite_grid\":{\"nodes\":"<<N<<",\"order\":"<<L<<",\"erased_nodes\":"<<erased.size()<<"},\"input_clearing\":\"PASS\"}"<<std::endl;
 Mapping file(prefix+".values.bin",uint64_t(N)*L*COLUMN_COUNT,true);uint64_t header[]={MAGIC_VALUES,uint64_t(N),uint64_t(L),COLUMN_COUNT,0,0,0,0};std::copy(header,header+8,file.header());DFT transform(N,F(25));std::atomic<int>done=0;
 #pragma omp parallel for schedule(dynamic,1)
 for(int col=0;col<COLUMN_COUNT*L;col++){
  int p=col/L,l=col%L;std::vector<F>a(N);for(int i=0;i<=polys[p].deg();i++){int b=binomial(i,l);if(b)a[i%N]+=polys[p][i]*F(b);}auto v=transform.apply(a);std::copy(v.begin(),v.end(),file.values+uint64_t(col)*N);
  // Exact local diagnostics against direct polynomial evaluation at four nodes.
  for(int j:{0,1,N/3,N-1}){F q(F::exps[j]),z=0;for(int i=polys[p].deg();i>=0;i--)z=z*q+polys[p][i]*F(binomial(i,l));assert(v[j]==z);}
  int n=++done;if(n%64==0){
   #pragma omp critical
   std::cout<<"{\"Fourier_columns_completed\":"<<n<<",\"total\":"<<COLUMN_COUNT*L<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
  }
 }
 // The original Python sample is independent of the global Fourier table.
 auto sample=read(root+"/data/sample_residual.json"),expected=read(root+"/data/sample_tails.json");F q0(sample.get<unsigned>("q")),xi0(sample.get<unsigned>("xi"));int node=F::logs[q0.v],offset=0;
 for(int n=0;n<3;n++){FP ex=poly(expected.get_child("C"+std::to_string(71+n)));F D=1;for(int k=0;k<5;k++)D*=poles[k].eval(q0).pow(den[n][k]);for(int j=0;j<(n==0?54:55);j++){F A=file.values[uint64_t((2*(offset+j))*L)*N+node],B=file.values[uint64_t((2*(offset+j)+1)*L)*N+node];assert((A+B*xi0)/D==ex[j]);}offset+=n==0?54:55;}
 std::vector<std::string>hashes((N+BLOCK-1)/BLOCK);
 #pragma omp parallel for schedule(dynamic,1)
 for(int i=0;i<(int)hashes.size();i++)hashes[i]=block_hash(file.values,N,L,i*BLOCK,std::min(BLOCK,N-i*BLOCK));
 ptree hh;for(auto&h:hashes){ptree p;p.put("",h);hh.push_back({"",p});}meta.add_child("value_block_sha256",hh);file.sync();boost::property_tree::write_json(prefix+".meta.json.tmp",meta);std::filesystem::rename(prefix+".meta.json.tmp",prefix+".meta.json");
 std::cout<<"{\"global_Hermite_value_table\":\"PASS\",\"sample_tail_comparison\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}
std::array<JF,2> point_values(const F*table,int N,int L,int node,const FP&C,const FP&E0,const std::vector<FP>&factors,const std::vector<std::array<long long,2>>&exponents){
 F q0(F::exps[node]);JF q(q0);if(L>1)q.c[1]=q0;JF cv=evaluate(C,q);assert(cv.unit());JF eta(1);F ci=cv.c[0].inverse();for(int k=1;k<L;k++){F v=cv.c[k]*ci;for(int j=1;j<k;j++)v-=eta.c[j]*eta.c[k-j];eta.c[k]=v*F(3);}
 std::array<JF,2>out;bool split=F::logs[cv.c[0].v]%2==0;int offset=0;
 if(split){F root(F::exps[F::logs[cv.c[0].v]/2]);JF xi=eta*JF(root);std::array<Poly<JF>,3>plus,minus;
  for(int n=0;n<3;n++){for(int j=0;j<(n==0?54:55);j++){JF a,b;for(int l=0;l<L;l++){a.c[l]=table[uint64_t((2*(offset+j))*L+l)*N+node];b.c[l]=table[uint64_t((2*(offset+j)+1)*L+l)*N+node];}b*=xi;plus[n].c.push_back(a+b);minus[n].c.push_back(a-b);}plus[n].trim();minus[n].trim();offset+=n==0?54:55;}
  for(int j=0;j<2;j++)out[j]=resultant_jet(plus[0],plus[j+1],53,54)*resultant_jet(minus[0],minus[j+1],53,54);
 }else{F2::parameter=cv.c[0];std::array<Poly<J2>,3>rows;
  for(int n=0;n<3;n++){for(int j=0;j<(n==0?54:55);j++){JF a,b;for(int l=0;l<L;l++){a.c[l]=table[uint64_t((2*(offset+j))*L+l)*N+node];b.c[l]=table[uint64_t((2*(offset+j)+1)*L+l)*N+node];}b*=eta;J2 c;for(int l=0;l<L;l++)c.c[l]=F2(a.c[l],b.c[l]);rows[n].c.push_back(c);}rows[n].trim();offset+=n==0?54:55;}
  for(int j=0;j<2;j++){J2 r=resultant_jet(rows[0],rows[j+1],53,54);JF a,b;for(int l=0;l<L;l++){a.c[l]=r.c[l].a;b.c[l]=r.c[l].b;}out[j]=a*a-JF(cv.c[0])*b*b;}
 }
 for(int k=0;k<(int)factors.size();k++){JF v=evaluate(factors[k],q);assert(v.unit());for(int j=0;j<2;j++){long long e=exponents[k][j];out[j]*=(e<0?v.inverse().pow(-e):v.pow(e));}}
 JF erase=evaluate(E0,q).pow(L);for(auto&v:out)v*=erase;return out;
}
void nodes(const std::string&prefix,int start,int count,int threads){
 auto meta=read(prefix+".meta.json");int N=meta.get<int>("N"),L=meta.get<int>("L");assert(N==int(F::NN)&&meta.get<int>("columns")==COLUMN_COUNT&&start>=0&&count>0&&start+count<=N);jet_order=L;omp_set_num_threads(threads);FP C=poly(meta.get_child("C")),E0=poly(meta.get_child("erasure_polynomial"));auto erased=ints(meta.get_child("erased_indices"));std::vector<FP>factors;std::vector<std::array<long long,2>>exponents;for(auto&[s,z]:meta.get_child("normalizing_factors")){factors.push_back(poly(z.get_child("polynomial")));auto e=ints(z.get_child("exponents"));exponents.push_back({e[0],e[1]});}
 Mapping file(prefix+".values.bin",uint64_t(N)*L*COLUMN_COUNT,false);assert(file.header()[0]==MAGIC_VALUES&&file.header()[1]==uint64_t(N)&&file.header()[2]==uint64_t(L)&&file.header()[3]==COLUMN_COUNT);auto hashes=array(meta.get_child("value_block_sha256"));for(int b=start/BLOCK;b<=(start+count-1)/BLOCK;b++)assert(block_hash(file.values,N,L,b*BLOCK,std::min(BLOCK,N-b*BLOCK))==hashes[b].get_value<std::string>());
 std::vector<F>out(uint64_t(2)*L*count);uint64_t fallbacks=0,skipped=0;auto ts=std::chrono::steady_clock::now();
 #pragma omp parallel reduction(+:fallbacks,skipped)
 {
  jet_fallbacks=0;
  #pragma omp for schedule(dynamic,8)
  for(int i=0;i<count;i++){int j=start+i;if(std::binary_search(erased.begin(),erased.end(),j)){skipped++;continue;}auto z=point_values(file.values,N,L,j,C,E0,factors,exponents);for(int p=0;p<2;p++)for(int l=0;l<L;l++)out[uint64_t(p*L+l)*count+i]=z[p].c[l];}
  fallbacks+=jet_fallbacks;
 }
 std::string name=prefix+".nodes."+std::to_string(start)+".bin";std::ofstream f(name+".tmp",std::ios::binary);uint64_t header[]={MAGIC_NODES,uint64_t(N),uint64_t(L),COLUMN_COUNT,uint64_t(start),uint64_t(count),0,0};f.write(reinterpret_cast<char*>(header),64);f.write(reinterpret_cast<const char*>(out.data()),out.size()*sizeof(F));f.close();std::filesystem::rename(name+".tmp",name);
 ptree checked;checked.put("start",start);checked.put("count",count);checked.put("N",N);checked.put("L",L);checked.put("source_meta_sha256",sha_file(prefix+".meta.json"));checked.put("output_sha256",sha_file(name));checked.put("unit_pivot_fallbacks",fallbacks);checked.put("erased_nodes",skipped);boost::property_tree::write_json(name+".json",checked);
 std::cout<<"{\"Hermite_node_chunk\":["<<start<<','<<count<<"],\"order\":"<<L<<",\"fallbacks\":"<<fallbacks<<",\"erased_nodes\":"<<skipped<<",\"status\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-ts).count()<<"}"<<std::endl;
}
std::vector<std::vector<F>> inverse_matrix(std::vector<std::vector<F>>a){int n=a.size();std::vector<std::vector<F>>b(n,std::vector<F>(n));for(int i=0;i<n;i++)b[i][i]=1;for(int k=0;k<n;k++){int p=k;while(p<n&&!a[p][k])p++;assert(p<n);std::swap(a[p],a[k]);std::swap(b[p],b[k]);F v=a[k][k].inverse();for(int j=0;j<n;j++){a[k][j]*=v;b[k][j]*=v;}for(int i=0;i<n;i++)if(i!=k){F z=a[i][k];for(int j=0;j<n;j++){a[i][j]-=z*a[k][j];b[i][j]-=z*b[k][j];}}}return b;}
void recover(const std::string&prefix,const std::string&samplefile,const std::string&output){
 auto meta=read(prefix+".meta.json");int N=meta.get<int>("N"),L=meta.get<int>("L");auto bd=ints(meta.get_child("degree_bounds"));FP E0=poly(meta.get_child("erasure_polynomial")),erase=E0.pow(L);Mapping samples(samplefile,uint64_t(2)*L*N,false);assert(samples.header()[0]==MAGIC_NODES&&samples.header()[1]==uint64_t(N)&&samples.header()[2]==uint64_t(L)&&samples.header()[4]==0&&samples.header()[5]==uint64_t(N));
 int period=1;while(period<L)period*=5;std::vector<std::vector<std::vector<F>>>inverses;for(int r=0;r<period;r++){std::vector<std::vector<F>>a(L,std::vector<F>(L));for(int l=0;l<L;l++)for(int j=0;j<L;j++)a[l][j]=F(binomial(r+uint64_t(j)*N,l));inverses.push_back(inverse_matrix(a));}
 DFT transform(N,F(25)),inverse(N,F(25).inverse());F invN=F(N%5).inverse();std::array<FP,2>pp;auto start=std::chrono::steady_clock::now();
 for(int pair=0;pair<2;pair++){
  std::vector<std::vector<F>>bc(L);for(int l=0;l<L;l++){const F*p=samples.values+uint64_t(pair*L+l)*N;std::vector<F>v(p,p+N);bc[l]=inverse.apply(v);for(auto&z:bc[l])z*=invN;}
  std::vector<F>q(uint64_t(L)*N);for(int r=0;r<N;r++){auto&iv=inverses[r%period];for(int j=0;j<L;j++)for(int l=0;l<L;l++)q[r+uint64_t(j)*N]+=iv[j][l]*bc[l][r];}
  FP Q(q);assert(Q.deg()<=bd[pair]+erase.deg());
  // Verify every input jet after reconstruction, not a selected subset.
  for(int l=0;l<L;l++){std::vector<F>a(N);for(int i=0;i<=Q.deg();i++)a[i%N]+=Q[i]*F(binomial(i,l));auto v=transform.apply(a);for(int j=0;j<N;j++)assert(v[j]==samples.values[uint64_t(pair*L+l)*N+j]);}
  pp[pair]=exact_fast(Q,erase);assert(pp[pair].deg()<=bd[pair]);std::cout<<"{\"projected_pair\":[71,"<<72+pair<<"],\"actual_degree\":"<<pp[pair].deg()<<",\"degree_bound\":"<<bd[pair]<<",\"all_Hermite_jets_rechecked\":\"PASS\"}"<<std::endl;
 }
 std::ofstream o(output);o<<"{\"meta_sha256\":\""<<sha_file(prefix+".meta.json")<<"\",\"samples_sha256\":\""<<sha_file(samplefile)<<"\",\"P12\":";printpoly(o,pp[0]);o<<",\"P13\":";printpoly(o,pp[1]);o<<"}\n";
 std::cout<<"{\"projected_polynomials\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}
int main(int argc,char**argv){try{assert(argc>=2);F::init();std::string task=argv[1];if(task=="prepare"){assert(argc==7);prepare(argv[2],argv[3],argv[4],argv[5],std::stoi(argv[6]));}else if(task=="nodes"){assert(argc==6);nodes(argv[2],std::stoi(argv[3]),std::stoi(argv[4]),std::stoi(argv[5]));}else if(task=="recover"){assert(argc==5);recover(argv[2],argv[3],argv[4]);}else throw std::runtime_error("unknown projector task");return 0;}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}}
