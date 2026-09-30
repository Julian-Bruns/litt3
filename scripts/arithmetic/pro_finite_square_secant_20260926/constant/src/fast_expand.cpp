/* Full residual expansion. Exact Kronecker multiplication over K,
   using GMP solely for multiplication of nonnegative integers. */
#define times slow_times
#define main previous_main
#include "expand.cpp"
#undef main
#undef times
#include <gmp.h>
#include <memory>
#include <climits>
#include <zlib.h>
#include <cstdio>
static std::vector<std::array<uint8_t,8>> primitive;
static E lift[15][5];
static void init_primitive(){
 primitive.resize(ff::SIZE);
 int a[8][16]={};
 for(int j=0;j<8;j++){E c=ff::pow(25,j);for(int i=0;i<8;i++,c/=5)a[i][j]=c%5;}
 for(int i=0;i<8;i++)a[i][i+8]=1;
 for(int j=0;j<8;j++){int r=j;while(r<8&&!a[r][j])r++;if(r==8)throw std::runtime_error("nonprimitive alpha");for(int k=0;k<16;k++)std::swap(a[j][k],a[r][k]);int inv[]={0,1,3,2,4};int s=inv[a[j][j]];for(int k=0;k<16;k++)a[j][k]=a[j][k]*s%5;for(int i=0;i<8;i++)if(i!=j){int z=a[i][j];for(int k=0;k<16;k++)a[i][k]=(a[i][k]+25-z*a[j][k])%5;}}
 for(E c=0;c<ff::SIZE;c++){int ds[8];E v=c;for(int i=0;i<8;i++,v/=5)ds[i]=v%5;for(int j=0;j<8;j++){int z=0;for(int i=0;i<8;i++)z+=a[j][i+8]*ds[i];primitive[c][j]=z%5;}}
 for(int j=0;j<15;j++)for(int c=0;c<5;c++)lift[j][c]=ff::mul(ff::pow(25,j),c);
 for(E c=0;c<ff::SIZE;c++){E r=0;for(int j=0;j<8;j++)r=ff::add(r,lift[j][primitive[c][j]]);if(r!=c)throw std::runtime_error("primitive conversion failure");}
}
static_assert(sizeof(mp_limb_t)==8 && GMP_NAIL_BITS==0,
              "This exact packing requires 64-bit GMP limbs without nails.");
static_assert(sizeof(uint32_t)==4 && CHAR_BIT==8,
              "This checkpoint/packing format requires 8-bit bytes.");
static void check_platform(){
 const uint32_t one=1; unsigned char first=0;
 std::memcpy(&first,&one,1);
 if(first!=1)throw std::runtime_error("This format is implemented for little-endian hosts.");
}
static uint64_t fastcount=0;
Poly ktimes(const Poly&a,const Poly&b){
 uint64_t work=uint64_t(a.size())*b.size();
 if(work<3000000)return slow_times(a,b);
 if(16ull*8ull*std::min(a.size(),b.size()) >= (1ull<<32))throw std::runtime_error("Kronecker carry bound");
 auto start=std::chrono::steady_clock::now();Bounds A=bounds(a),B=bounds(b);
 int nx=A.x+B.x+1,nh=A.h+B.h+1,nm=A.m+B.m+1,nq=A.q1+B.q1-A.q0-B.q0+1;
 if(nx>1024||nh>64||nm>8)throw std::runtime_error("exponent overflow");
 size_t sh=nx,sm=sh*nh,sq=sm*nm,N=sq*nq;
 if(N*15>250000000ull)throw std::runtime_error("Kronecker output memory cap");
 std::cout<<"KRONECKER start "<<++fastcount<<" terms="<<a.size()<<","<<b.size()<<" box="<<nx<<","<<nh<<","<<nm<<","<<nq<<" words="<<15*N<<std::endl;
 mpz_t aa,bb,cc;mpz_inits(aa,bb,cc,nullptr);
 auto fill=[&](mpz_t z,const Poly&p,const Bounds&D){
   size_t last=(D.x+sh*D.h+sm*D.m+sq*(D.q1-D.q0))*15+8;
   size_t limbs=(last+1)/2;mp_limb_t* mem=mpz_limbs_write(z,limbs);std::memset(mem,0,limbs*sizeof(mp_limb_t));unsigned char* bytes=reinterpret_cast<unsigned char*>(mem);
   for(auto&t:p){size_t i=(X(t.m)+sh*H(t.m)+sm*M(t.m)+sq*(Qexp(t.m)-D.q0))*15;for(int j=0;j<8;j++){uint32_t digit=primitive[t.c][j];std::memcpy(bytes+4*(i+j),&digit,4);}}
   while(limbs&&mem[limbs-1]==0)limbs--;mpz_limbs_finish(z,limbs);
 };
 fill(aa,a,A);fill(bb,b,B);mpz_mul(cc,aa,bb);mpz_clears(aa,bb,nullptr);
 const unsigned char* bytes=reinterpret_cast<const unsigned char*>(mpz_limbs_read(cc));size_t nw=2*mpz_size(cc);
 Poly r;r.reserve(std::min(N,a.size()+b.size()));
 for(int q=0;q<nq;q++)for(int m=0;m<nm;m++)for(int h=0;h<nh;h++)for(int x=0;x<nx;x++){
  size_t i=(x+sh*h+sm*m+sq*q)*15;E c=0;for(int j=0;j<15&&i+j<nw;j++){uint32_t digit;std::memcpy(&digit,bytes+4*(i+j),4);auto v=digit%5;if(v)c=ff::add(c,lift[j][v]);}if(c)r.push_back({key(x,h,m,q+A.q0+B.q0),c});
 }
 mpz_clear(cc);products+=work;multiplications++;
 std::cout<<"KRONECKER done "<<fastcount<<" out="<<r.size()<<" seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;return r;
}
Poly kpow(Poly a,int n){Poly r=one();while(n){if(n&1)r=ktimes(r,a);n>>=1;if(n)a=ktimes(a,a);}return r;}
static uint64_t source_fingerprint(const Curve&a){
 uint64_t h=1469598103934665603ull;
 auto byte=[&](uint8_t v){h^=v;h*=1099511628211ull;};
 for(int j=0;j<3;j++){byte(j);for(auto&t:a[j]){uint64_t k=uint64_t(t.m);for(int b=0;b<8;b++)byte(k>>(8*b));for(int b=0;b<4;b++)byte(t.c>>(8*b));}}
 return h;
}
static void gzwrite_all(gzFile f,const void*p,unsigned n){if(gzwrite(f,p,n)!=int(n))throw std::runtime_error("compressed checkpoint write failed");}
static void gzread_all(gzFile f,void*p,unsigned n){if(gzread(f,p,n)!=int(n))throw std::runtime_error("truncated/corrupt compressed checkpoint");}
static void save_checkpoint(const std::string&file,const Poly&p,uint64_t fingerprint,uint32_t part){
 std::string tmp=file+".part";gzFile f=gzopen(tmp.c_str(),"wb6");if(!f)throw std::runtime_error("cannot open checkpoint");
 const char magic[8]={'N','O','R','M','1','4','0','1'};uint64_t n=p.size();
 gzwrite_all(f,magic,8);gzwrite_all(f,&fingerprint,8);gzwrite_all(f,&part,4);gzwrite_all(f,&n,8);
 std::vector<uint8_t> block(12*65536);size_t k=0;
 while(k<p.size()){size_t n=std::min(size_t(65536),p.size()-k);for(size_t i=0;i<n;i++){std::memcpy(block.data()+12*i,&p[k+i].m,8);std::memcpy(block.data()+12*i+8,&p[k+i].c,4);}gzwrite_all(f,block.data(),12*n);k+=n;}
 if(gzclose(f)!=Z_OK)throw std::runtime_error("compressed checkpoint close failed");
 if(std::rename(tmp.c_str(),file.c_str()))throw std::runtime_error("checkpoint atomic rename failed");
}
static Poly read_checkpoint(const std::string&file,uint64_t fingerprint,uint32_t part){
 gzFile f=gzopen(file.c_str(),"rb");if(!f)throw std::runtime_error("cannot open compressed checkpoint");
 char magic[8];uint64_t fp,n;uint32_t index;gzread_all(f,magic,8);gzread_all(f,&fp,8);gzread_all(f,&index,4);gzread_all(f,&n,8);
 if(std::memcmp(magic,"NORM1401",8)||fp!=fingerprint||index!=part||n>20000000)throw std::runtime_error("stale/invalid norm checkpoint");
 Poly p(n);std::vector<uint8_t>block(12*65536);size_t k=0;
 while(k<n){size_t count=std::min(size_t(65536),size_t(n-k));gzread_all(f,block.data(),12*count);for(size_t i=0;i<count;i++){std::memcpy(&p[k+i].m,block.data()+12*i,8);std::memcpy(&p[k+i].c,block.data()+12*i+8,4);}k+=count;}
 char c;if(gzread(f,&c,1)!=0||gzclose(f)!=Z_OK)throw std::runtime_error("bad checkpoint footer");
 for(size_t i=0;i<p.size();i++)if(!p[i].c||p[i].c>=ff::SIZE||(i&&p[i-1].m>=p[i].m))throw std::runtime_error("bad checkpoint monomial");return p;
}
Poly knorm(const Curve&a,const std::string&root){
 uint64_t fingerprint=source_fingerprint(a);Poly r;
 for(int j=0;j<3;j++){
  std::string file=root+"/build/normterm_"+std::to_string(j)+".bin.gz";Poly term;std::ifstream test(file);
  if(test.good()){test.close();term=read_checkpoint(file,fingerprint,j);std::cout<<"RESUME "<<file<<std::endl;}
  else{term=kpow(a[j],3);if(j)term=ktimes(term,kpow(Dpoly,j));save_checkpoint(file,term,fingerprint,j);}
  r=plus(r,term);
 }
 std::string file=root+"/build/normterm_3.bin.gz";Poly term;std::ifstream test(file);
 if(test.good()){test.close();term=read_checkpoint(file,fingerprint,3);std::cout<<"RESUME "<<file<<std::endl;}else{term=ktimes(ktimes(ktimes(a[0],a[1]),a[2]),Dpoly);save_checkpoint(file,term,fingerprint,3);}
 return minus(r,scale(term,3));
}
int main(int argc,char**argv){try{
 auto start=std::chrono::steady_clock::now();check_platform();ff::init();init_primitive();
 if(argc<2)throw std::runtime_error("usage: fast_expand ROOT [test]");std::string root=argv[1];
 if(argc>2&&std::string(argv[2])=="test"){
   uint64_t seed=343;for(int trial=0;trial<4;trial++){Poly a,b;for(int i=0;i<2300;i++){seed=seed*6364136223846793005ULL+1;E c=1+(seed>>32)%ff::ORDER;a.push_back({key(i%30,(i/30)%8,0,i/240-5),c});seed=seed*6364136223846793005ULL+1;c=1+(seed>>32)%ff::ORDER;b.push_back({key(i%30,(i/30)%8,trial%2,i/240-3),c});}Poly c=ktimes(a,b),d=slow_times(a,b);if(c.size()!=d.size())throw std::runtime_error("test length");for(size_t i=0;i<c.size();i++)if(c[i].m!=d[i].m||c[i].c!=d[i].c)throw std::runtime_error("test mismatch");}
   std::cout<<"PASS: four exact dense/sparse multiplication comparisons, all field conversion codes."<<std::endl;return 0;
 }
 Curve res;for(int j=0;j<3;j++)res[j]=readpoly(root+"/build/resbar_"+std::to_string(j)+".bin");
 E pc[]={11,22,18,5,19,20,15,16,9,22,1};for(int i=0;i<11;i++)if(pc[i])Ppoly.push_back({i,pc[i]});Dpoly=shift(Ppoly,-SQ);
 Poly N=knorm(res,root);stats("norm",N);/* Full norm is regenerable from the four compressed checkpoints. */
 std::ifstream input(root+"/evidence/normalized_sources.dat");std::array<Curve,6>src;for(auto&g:src){int n;input>>n;for(int i=0;i<n;i++){int h,q,y,x;E c;input>>h>>q>>y>>x>>c;g[y].push_back({key(x,h,0,q),c});}for(auto&p:g)std::sort(p.begin(),p.end(),[](auto&a,auto&b){return a.m<b.m;});}
 Poly td=powp(shift(src[5][0],-3*SQ),5);std::vector<E>dv(bounds(td).x+1,0);for(auto&t:td){if(H(t.m)||M(t.m)||Qexp(t.m))throw std::runtime_error("bad divisor");dv[X(t.m)]=t.c;}
 Poly R=shift(exact_div_x(N,dv),-15*SQ);stats("Rcal",R);save(root+"/build/Rcal.bin",R);
 std::ofstream o(root+"/evidence/full_expansion_summary.json");auto b=bounds(R);o<<"{\"terms\":"<<R.size()<<",\"degree_H\":"<<b.h<<",\"degree_mu\":"<<b.m<<",\"degree_x\":"<<b.x<<",\"q_min\":"<<b.q0<<",\"q_max\":"<<b.q1<<",\"gmp_version\":\""<<gmp_version<<"\"}\n";
 std::cout<<"PASS: full residual expansion with exact t^15 division; seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
}catch(const std::exception&e){std::cerr<<"ERROR: "<<e.what()<<std::endl;return 1;}return 0;}
