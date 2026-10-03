// NEW exact zero-y11-coefficient boundary identities. No old exclusion replay.
#include "projective_core.hpp"
#include <chrono>
using namespace proj;
using Ep=std::array<std::array<int,2>,4>;
using Row=std::array<K,4>;
static constexpr int weights[2][4]={{13,3,9,2},{22,24,12,11}};
static constexpr int exponents[2]={5,17};
static const int p2[4]={1,2,4,3};
static int rank(std::array<std::array<int,6>,3>A,int n){int r=0;for(int j=0;j<n&&r<3;j++){int p=r;while(p<3&&!A[p][j])p++;if(p==3)continue;std::swap(A[p],A[r]);int inv=1;while(inv*A[r][j]%5!=1)inv++;for(int k=j;k<n;k++)A[r][k]=A[r][k]*inv%5;for(int i=r+1;i<3;i++){int c=A[i][j];for(int k=j;k<n;k++)A[i][k]=(A[i][k]+25-c*A[r][k])%5;}r++;}return r;}
static std::vector<Ep> patterns(int n){std::vector<std::array<int,2>>pairs;for(int j=0;j<n;j++)for(int k=j;k<n;k++)pairs.push_back({j,k});std::vector<Ep>out;
 for(auto a:pairs)for(auto b:pairs)for(auto c:pairs)for(auto d:pairs){Ep ep={a,b,c,d};bool can=true;for(int r=1;r<4;r++){Ep rot;for(int i=0;i<4;i++)rot[i]=ep[(i+r)%4];if(rot<ep)can=false;}if(!can)continue;
 int mask=0,common=(1<<n)-1;bool doubled=true;std::array<std::array<int,6>,3>Q{};
 for(int i=0;i<4;i++){int s=(1<<ep[i][0])|(1<<ep[i][1]);mask|=s;common&=s;doubled&=ep[i][0]==ep[i][1];for(int l=1;l<=3;l++)for(int j:ep[i])Q[l-1][j]=(Q[l-1][j]+p2[(l*i)%4])%5;}
 if(mask!=(1<<n)-1||common||doubled)continue;bool full=true;for(auto q:Q){bool nz=false;for(int j=0;j<n;j++)nz|=q[j]!=0;full&=nz;}if(full&&rank(Q,n)==2)out.push_back(ep);}
 if(out.size()!=std::array<int,7>{0,0,0,0,426,405,135}[n])throw std::runtime_error("template coverage mismatch");return out;}
static Row row(const Ep&ep,int kind){Row r;for(int i=0;i<4;i++){K v=add(roots[exponents[kind]*ep[i][0]%29],roots[exponents[kind]*ep[i][1]%29]);for(int l=0;l<4;l++)r[l]=add(r[l],mul(B(weights[kind][l]),scale5(v,p2[(l*i)%4])));}return r;}
static void endpoint_json(const Ep&ep){std::cout<<"[";for(int i=0;i<4;i++){if(i)std::cout<<",";std::cout<<"["<<ep[i][0]<<","<<ep[i][1]<<"]";}std::cout<<"]";}
int main(int argc,char**argv){try{if(argc!=3)throw std::runtime_error("usage: boundary_scan field.txt supports.txt");auto start=std::chrono::steady_clock::now();Input input=load(argv[1]);std::ifstream in(argv[2]);if(!in)throw std::runtime_error("supports missing");int n,ns;std::uint64_t total=0,zero1=0,zero2=0,both=0;bool comma=false;
 std::cout<<"{\"format\":\"WG-zero-coefficient-source-boundary-v1\",\"sectors\":[";
 while(in>>n>>ns){auto pats=patterns(n);std::uint64_t count=0,z1=0,z2=0,zb=0;if(comma)std::cout<<",";comma=true;std::cout<<"{\"support\":"<<n<<",\"samples\":[";bool sc=false;
 for(int si=0;si<ns;si++){std::array<int,6>S{};for(int j=0;j<n;j++)if(!(in>>S[j]))throw std::runtime_error("truncated support");for(auto temp:pats){Ep ep=temp;for(auto&p:ep)for(int&j:p)j=S[j];Row C=row(ep,0),U=row(ep,1);if(C[1].zero()||U[2].zero())throw std::runtime_error("required full source coordinate zero");
 K e1=sub(mul(C[1],U[3]),mul(C[2],U[2]));K e2=sub(mul(B(14),mul(C[0],U[2])),mul(C[1],U[1]));
 z1+=e1.zero();z2+=e2.zero();zb+=e1.zero()&&e2.zero();
 if(count%100000==0){if(sc)std::cout<<",";sc=true;std::cout<<"{\"sector_index\":"<<count<<",\"source\":";endpoint_json(ep);std::cout<<",\"first_residual_original_code\":"<<oldcode(e1,input)<<",\"second_residual_original_code\":"<<oldcode(e2,input)<<"}";}
 if(e1.zero()&&e2.zero()){std::cerr<<"boundary identity positive: ";for(auto p:ep)std::cerr<<p[0]<<","<<p[1]<<" ";std::cerr<<"\n";}
 count++;}}
 std::cout<<"],\"sources\":"<<count<<",\"first_identity_zero\":"<<z1<<",\"second_identity_zero\":"<<z2<<",\"both_identities_zero\":"<<zb<<"}";total+=count;zero1+=z1;zero2+=z2;both+=zb;}
 if(total!=602667)throw std::runtime_error("source total mismatch");double sec=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
 std::cout<<"],\"sources\":"<<total<<",\"first_identity_zero\":"<<zero1<<",\"second_identity_zero\":"<<zero2<<",\"both_identities_zero\":"<<both<<",\"seconds\":"<<sec<<",\"complete\":true,\"scope\":\"NEW all-zero WG y11-coefficient source boundary only; full open incidence unresolved\"}\n";
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
