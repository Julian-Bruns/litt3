// Exact global compression; this program is NOT a square-locus decision.
#define main retained_global_generator_main
#include "../../continuation/src/global_residual.cpp"
#undef main
constexpr int CH=13,CQ=61,CX=47,CM=3,CJ=3,CB=CJ*CM*CH*CX;
static size_t ix(int j,int m,int h,int x,int q){return (((size_t(j)*CM+m)*CH+h)*CX+x)*CQ+q;}
static std::vector<F> coeff;
static std::array<BiPoly,3> at(F H,F q){std::array<BiPoly,3> E;for(int j=0;j<3;j++){E[j].resize(3);for(int m=0;m<3;m++){E[j][m].resize(CX);for(int x=0;x<CX;x++){F z=0;for(int h=CH-1;h>=0;h--){F a=0;for(int k=CQ-1;k>=0;k--)a=addf(mulf(a,q),coeff[ix(j,m,h,x,k)]);z=addf(mulf(z,H),a);}E[j][m][x]=z;}E[j][m].trim();}}return E;}
static BiPoly compact_norm(F H,F q){auto B=at(H,q);return badd(badd(bscale(bpow(B[0],3),FF::pow(q,2)),bscale(bxmul(bpow(B[1],3),P),q)),badd(bxmul(bpow(B[2],3),power(P,2)),bscale(bxmul(bmul(bmul(B[0],B[1]),B[2]),P),FF::mul(2,q))));}
int main(int argc,char**argv){try{if(argc!=2)throw std::runtime_error("Usage: compact_residual work-directory");std::string work=argv[1];std::filesystem::create_directories(work);init_curve();a625.resize(625*625);for(F a=0;a<625;a++)for(F b=0;b<625;b++)a625[a*625+b]=FF::add(a,b);auto chart=load_chart();std::vector<F>hn(CH),qn(CQ),wn(CQ);std::iota(hn.begin(),hn.end(),0);for(int i=0;i<CQ;i++){wn[i]=FF::pow(25,i);qn[i]=FF::pow(wn[i],3);}auto LH=lagrange(hn),LQ=lagrange(qn);std::vector<F> vals(size_t(CB)*CQ);Poly t5=power(t,5);Curve qb=cm(0,1)*Curve(exactdiv(Q-power(B0,5),power(P,2)));std::atomic<bool>bad=false;std::atomic<int>done=0;
#pragma omp parallel for schedule(dynamic)
for(int iq=0;iq<CQ;iq++){try{F w=wn[iq],q=qn[iq],iw=FF::inv(w);std::vector<F> v(CB);for(int ih=0;ih<CH;ih++){auto g=barred(evaluate(chart,FF::mul(hn[ih],iw),w));auto D=universal_resultant(scale(g[0],3),scale(g[1],2),g[2],g[3],qb,Curve(power(t,3)));for(int j=0;j<3;j++)for(int m=0;m<3;m++){Poly E=exactdiv(D[m][j],t5);if(E.deg()>46-3*j)throw std::runtime_error("pole degree at grid node");int powerw=m+j-2;F sc=FF::mul(FF::pow(q,16),powerw>=0?FF::pow(w,powerw):FF::pow(iw,-powerw));for(int x=0;x<CX;x++)v[((j*CM+m)*CH+ih)*CX+x]=FF::mul(sc,E.coef(x));}}
for(int j=0;j<3;j++)for(int m=0;m<3;m++)for(int h=0;h<CH;h++)for(int x=0;x<CX;x++){F s=0;for(int ih=0;ih<CH;ih++)s=addf(s,mulf(LH[h][ih],v[((j*CM+m)*CH+ih)*CX+x]));vals[ix(j,m,h,x,iq)]=s;}
for(int j=0;j<3;j++)for(int m=0;m<3;m++)for(int ih=0;ih<CH;ih++)for(int x=0;x<CX;x++){F z=0;for(int h=CH-1;h>=0;h--)z=addf(mulf(z,hn[ih]),vals[ix(j,m,h,x,iq)]);if(z!=v[((j*CM+m)*CH+ih)*CX+x])throw std::runtime_error("H roundtrip");}int z=++done;if(z%10==0||z==CQ){
#pragma omp critical
std::cout<<"q nodes "<<z<<"/"<<CQ<<"; every t^5 division and H roundtrip exact\n"<<std::flush;}}catch(const std::exception&e){bad=true;
#pragma omp critical
std::cerr<<"node "<<iq<<": "<<e.what()<<"\n";}}
if(bad)throw std::runtime_error("node stage failed");coeff.resize(vals.size());
#pragma omp parallel for schedule(dynamic,16)
for(int b=0;b<CB;b++)for(int q=0;q<CQ;q++){F s=0;for(int iq=0;iq<CQ;iq++)s=addf(s,mulf(LQ[q][iq],vals[size_t(b)*CQ+iq]));coeff[size_t(b)*CQ+q]=s;}
#pragma omp parallel for schedule(dynamic,16)
for(int b=0;b<CB;b++)for(int iq=0;iq<CQ;iq++){F s=0;for(int q=CQ-1;q>=0;q--)s=addf(mulf(s,qn[iq]),coeff[size_t(b)*CQ+q]);if(s!=vals[size_t(b)*CQ+iq])bad=true;}
if(bad)throw std::runtime_error("q roundtrip");std::cout<<"Full coefficient-grid roundtrip PASS\n";
long long terms=0;std::array<long long,3>termsj{};std::array<int,3> qdj{},hdj{},mdj{},xdj{};std::ofstream sparse(work+"/compact.jsonl");for(int j=0;j<3;j++)for(int m=0;m<3;m++)for(int h=0;h<CH;h++)for(int x=0;x<CX;x++)for(int q=0;q<CQ;q++){F c=coeff[ix(j,m,h,x,q)];if(!c)continue;terms++;termsj[j]++;qdj[j]=std::max(qdj[j],q);hdj[j]=std::max(hdj[j],h);mdj[j]=std::max(mdj[j],m);xdj[j]=std::max(xdj[j],x);int lower=h+(5*m+j)/3; // ceil((5*m+j-2)/3) = floor((5*m+j)/3)
int upper=60-3*h-(2-j+10*m+2)/3;if(h+m>12||q<lower||q>upper||x>46-3*j)throw std::runtime_error("support bound");sparse<<"["<<j<<","<<m<<","<<h<<","<<q<<","<<x<<","<<c<<"]\n";}
sparse.close();write_vec(work+"/compact.bin",coeff);std::cout<<"support bounds PASS; terms="<<terms<<"\n";
int checks=0;for(auto[H,w]:std::vector<std::pair<F,F>>{{0,2},{1,1},{31,2},{73,3},{105,5},{200,25},{1024,1024},{390123,28123},{33,196636},{37281,189244},{198227,209199},{87364,39857}}){F q=FF::pow(w,3);auto r=residual_all_scales(evaluate(chart,FF::div(H,w),w));auto W=compact_norm(H,q);for(int m=0;m<7;m++){if(W[m].deg()>140)throw std::runtime_error("compact norm x degree");auto expected=scale(r[m],FF::mul(FF::pow(q,48),FF::pow(w,m)));if(W[m]!=expected)throw std::runtime_error("original all-scale residual mismatch");}checks++;}
std::cout<<checks<<" extra all-scale, all-x residual comparisons PASS\n";
std::ofstream summary("elimination/evidence/compact_summary.json");summary<<"{\"status\":\"global exact compression, not a geometric decision\",\"formula\":\"W=q^2 E0^3+q P E1^3+P^2 E2^3-3 q P E0 E1 E2\",\"binary_dimensions\":[3,3,13,47,61],\"binary_order\":\"j,mu,H,x,q; little-endian uint32 K-codes\",\"sparse_order\":\"j,mu,H,q,x,K-code\",\"grid_source_count\":793,\"exact_component_divisions\":7137,\"all_grid_entries_checked\":335439,\"extra_all_scale_checks\":"<<checks<<",\"terms\":"<<terms<<",\"components\":[";for(int j=0;j<3;j++){if(j)summary<<",";summary<<"{\"j\":"<<j<<",\"terms\":"<<termsj[j]<<",\"H_degree\":"<<hdj[j]<<",\"q_degree\":"<<qdj[j]<<",\"mu_degree\":"<<mdj[j]<<",\"x_degree\":"<<xdj[j]<<"}";}summary<<"]}\n";std::cout<<"Full geometric square scheme remains UNRESOLVED\n";return 0;}catch(const std::exception&e){std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}}
