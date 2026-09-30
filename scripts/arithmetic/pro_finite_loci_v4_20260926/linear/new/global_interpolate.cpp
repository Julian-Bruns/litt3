// Exact global interpolation over K. No restriction on geometric parameters:
// the resulting polynomial is identified by proved degree bounds, not by a search.
#include "../src/residual.hpp"
#include <thread>
#include <atomic>
#include <filesystem>
namespace fs=std::filesystem;
using Rows=std::vector<std::vector<F>>;
constexpr int NH=78,NQ=208,NC=7*141;
Rows dft(const Rows& in,F root){
 const int n=in.size(), cols=in[0].size(); Rows out(n,std::vector<F>(cols));
 if(n==1)return in;
 int a=2;while(n%a)a++;int b=n/a;
 if(b==1){
  F rk(1);for(int k=0;k<n;k++){F fac(1);for(int j=0;j<n;j++){if(fac==F(1)){for(int c=0;c<cols;c++)out[k][c]+=in[j][c];}else for(int c=0;c<cols;c++)out[k][c]+=in[j][c]*fac;fac*=rk;}rk*=root;}return out;
 }
 for(int r=0;r<a;r++){
  Rows sub(b);for(int j=0;j<b;j++)sub[j]=in[a*j+r];Rows val=dft(sub,root.pow(a));
  F fac(1),step=root.pow(r);for(int k=0;k<n;k++){if(fac==F(1)){for(int c=0;c<cols;c++)out[k][c]+=val[k%b][c];}else for(int c=0;c<cols;c++)out[k][c]+=val[k%b][c]*fac;fac*=step;}
 }
 return out;
}
void write32(std::ostream& f,int a){uint32_t n=a;char b[4];for(int i=0;i<4;i++)b[i]=char(n>>(8*i));f.write(b,4);}
int read32(std::istream& f){unsigned char b[4];f.read((char*)b,4);if(!f)throw std::runtime_error("truncated binary");return int(b[0])+(int(b[1])<<8)+(int(b[2])<<16)+(int(b[3])<<24);}
Rows read_rows(const fs::path& p,int nr,int nc){std::ifstream f(p,std::ios::binary);if(read32(f)!=nr||read32(f)!=nc)throw std::runtime_error("bad dimensions");Rows r(nr,std::vector<F>(nc));for(auto& row:r)for(auto& a:row)a=F::code(read32(f));if(f.peek()!=EOF)throw std::runtime_error("trailing bytes");return r;}
void write_rows(const fs::path& p,const Rows& rows){fs::path tmp=p.string()+".tmp";std::ofstream f(tmp,std::ios::binary);write32(f,rows.size());write32(f,rows[0].size());for(auto& row:rows)for(F a:row)write32(f,a.v);f.close();if(!f)throw std::runtime_error("write failed");fs::rename(tmp,p);}
int main(int argc,char** argv){try{
 if(argc<3)throw std::runtime_error("usage: global_interpolate ROOT_CODE OUTPUT_DIR [THREADS]");
 int rr=std::stoi(argv[1]),threads=argc>3?std::stoi(argv[3]):4;fs::path out=argv[2];fs::create_directories(out);
 input::init();if(std::find(input::roots.begin(),input::roots.end(),rr)==input::roots.end())throw std::runtime_error("bad root");
 auto c=cramer(reconstruct(F::code(rr)));F pr=F::code(kfield::primitive),zh=pr.pow(kfield::N/NH),zw=pr.pow(kfield::N/(3*NQ)),zq=zw.pow(3);
 if(zh.pow(NH)!=F(1)||zh.pow(NH/2)==F(1)||zh.pow(NH/3)==F(1)||zh.pow(NH/13)==F(1))throw std::runtime_error("H root order");
 if(zq.pow(NQ)!=F(1)||zq.pow(NQ/2)==F(1)||zq.pow(NQ/13)==F(1)||c.pivot.pow(NQ)==F(1))throw std::runtime_error("q grid collision/order");
 for(auto& p:c.num)for(auto [e,a]:p.c)if(e.first>2||e.first<0||e.second< -4||e.second>11)throw std::runtime_error("source degree bound");
 auto co=coordinates();for(int k=0;k<156;k++)for(auto [e,a]:c.num[k].c)if((e.second+co[k].j+(co[k].n==0?2:0)-1)%3)throw std::runtime_error("weight failure");
 const auto start=std::chrono::steady_clock::now();std::atomic<int> next(0),done(0);std::atomic<bool> failed(false);std::mutex mu;std::string err;
 auto worker=[&]{try{for(;;){int iq=next++;if(iq>=NQ||failed)break;fs::path path=out/("grid_"+std::to_string(iq)+".bin");if(fs::exists(path)){read_rows(path,NH,NC);done++;continue;}
  F w=zw.pow(iq),q=w.pow(3),d=q-c.pivot;F factor=q.pow(48)*d.pow(36);Rows values(NH,std::vector<F>(NC));F H(1);
  for(int ih=0;ih<NH;ih++){
   auto s=evaluate_source(c,H,w);auto R=residual(s,F::code(rr));if(R.c.size()>7)throw std::runtime_error("scale bound");
   F fac=factor;for(int l=0;l<7;l++){if(l<(int)R.c.size()&&R.c[l].deg()>140)throw std::runtime_error("x degree bound");for(int i=0;i<=140;i++)values[ih][l*141+i]=(l<(int)R.c.size()?R.c[l][i]:F())*fac;fac*=w;}H*=zh;
  }
  auto coeff=dft(values,zh.inv());F inv=F(NH).inv();for(auto& row:coeff)for(auto& a:row)a*=inv;
  for(int h=73;h<NH;h++)for(F a:coeff[h])if(a)throw std::runtime_error("H tail failed");
  write_rows(path,coeff);int n=++done;if(n%16==0){std::lock_guard<std::mutex> lock(mu);std::cout<<"r="<<rr<<" q nodes "<<n<<"/"<<NQ<<" completed\n"<<std::flush;}
 }}catch(std::exception& e){failed=true;std::lock_guard<std::mutex> lock(mu);err=e.what();}};
 std::vector<std::thread> workers;for(int j=0;j<threads;j++)workers.emplace_back(worker);for(auto& t:workers)t.join();if(failed)throw std::runtime_error(err);
 std::cout<<"r="<<rr<<" full grid evaluated, starting exact q transform\n"<<std::flush;
 Rows all(NQ,std::vector<F>(73*NC));for(int iq=0;iq<NQ;iq++){auto row=read_rows(out/("grid_"+std::to_string(iq)+".bin"),NH,NC);for(int h=0;h<73;h++)std::copy(row[h].begin(),row[h].end(),all[iq].begin()+h*NC);}
 all=dft(all,zq.inv());F inv=F(NQ).inv();for(auto& row:all)for(auto& a:row)a*=inv;
 for(int iq=181;iq<NQ;iq++)for(F a:all[iq])if(a)throw std::runtime_error("q tail failed");
 long long terms=0;int dh=-1,dq=-1,dm=-1,dx=-1;
 for(int h=0;h<73;h++){Rows block(181,std::vector<F>(NC));for(int q=0;q<=180;q++)for(int l=0;l<7;l++)for(int x=0;x<=140;x++){F a=all[q][h*NC+l*141+x];block[q][l*141+x]=a;if(a){terms++;dh=std::max(dh,h);dq=std::max(dq,q);dm=std::max(dm,l);dx=std::max(dx,x);}}
  write_rows(out/("N_H_"+std::to_string(h)+".bin"),block);
 }
 std::ofstream meta(out/"summary.json");meta<<"{\"r\":"<<rr<<",\"pivot\":"<<c.pivot<<",\"H_nodes\":78,\"q_nodes\":208,\"H_generator\":"<<zh<<",\"w_generator\":"<<zw<<",\"q_generator\":"<<zq<<",\"nonzero_terms\":"<<terms<<",\"degrees_H_q_mu_x\":["<<dh<<","<<dq<<","<<dm<<","<<dx<<"],\"source_bound_check\":true,\"source_weight_check\":true,\"all_grid_x_divisions_exact\":true,\"H_and_q_tails_zero\":true,\"square_decision\":\"not_performed\"}\n";
 std::cout<<"r="<<rr<<" global polynomial completed: terms="<<terms<<" degrees="<<dh<<","<<dq<<","<<dm<<","<<dx<<" wall="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"\n"<<std::flush;
 return 0;
 }catch(std::exception& e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
