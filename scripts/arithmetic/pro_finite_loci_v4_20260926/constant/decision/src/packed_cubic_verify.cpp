// Independent extension-polynomial identity verifier: no generator field code.
#define main packed_base_main
#include "packed_verify.cpp"
#undef main
using CE=std::array<U,3>;using CP=std::vector<CE>;
U kneg(U a){U c=0,p=1;for(int i=0;i<4;i++){c+=p*n25(a%25);a/=25;p*=25;}return c;}
U ksub(U a,U b){return add(a,kneg(b));}
U kmul(U a,U b){U aa[4],bb[4],c[7]{};for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=a25(c[i+j],m25(aa[i],bb[j]));const U mod[]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=a25(c[i-4+j],n25(m25(c[i],mod[j])));return c[0]+25*c[1]+625*c[2]+15625*c[3];}
void trim(Poly&a){while(!a.empty()&&!a.back())a.pop_back();}
Poly plus(const Poly&a,const Poly&b){Poly c(std::max(a.size(),b.size()));for(size_t i=0;i<c.size();i++)c[i]=add(i<a.size()?a[i]:0,i<b.size()?b[i]:0);trim(c);return c;}
Poly minus(const Poly&a,const Poly&b){Poly c(std::max(a.size(),b.size()));for(size_t i=0;i<c.size();i++)c[i]=ksub(i<a.size()?a[i]:0,i<b.size()?b[i]:0);trim(c);return c;}
Poly times(Poly a,U b){for(auto&c:a)c=kmul(c,b);trim(a);return a;}
bool nonzero(const CE&a){return a[0]||a[1]||a[2];}
void ctrim(CP&a){while(!a.empty()&&!nonzero(a.back()))a.pop_back();}
CP cprod(const CP&a,const CP&b,const CE&mod){if(a.empty()||b.empty())return {};std::array<Poly,3>A,B;for(int j=0;j<3;j++){A[j].resize(a.size());B[j].resize(b.size());for(size_t i=0;i<a.size();i++)A[j][i]=a[i][j];for(size_t i=0;i<b.size();i++)B[j][i]=b[i][j];trim(A[j]);trim(B[j]);}Poly p0=prod(A[0],B[0]),p1=prod(A[1],B[1]),p2=prod(A[2],B[2]);Poly p01=minus(minus(prod(plus(A[0],A[1]),plus(B[0],B[1])),p0),p1);Poly p02=minus(minus(prod(plus(A[0],A[2]),plus(B[0],B[2])),p0),p2);Poly p12=minus(minus(prod(plus(A[1],A[2]),plus(B[1],B[2])),p1),p2);std::array<Poly,5>C{p0,p01,plus(p02,p1),p12,p2};for(int i=4;i>=3;i--)for(int j=0;j<3;j++)C[i-3+j]=minus(C[i-3+j],times(C[i],mod[j]));CP c(a.size()+b.size()-1);for(size_t i=0;i<c.size();i++)for(int j=0;j<3;j++)c[i][j]=i<C[j].size()?C[j][i]:0;ctrim(c);return c;}
CP cread(std::istream&f){size_t n;f>>n;CP a(n);for(auto&c:a)for(auto&v:c){f>>v;if(v>=390625)throw std::runtime_error("extension coefficient code out of range");}if(!f)throw std::runtime_error("invalid extension certificate");return a;}
int main(int argc,char**argv){try{if(argc!=2)throw std::runtime_error("usage: packed_cubic_verify certificate.txt");std::ifstream f(argv[1]);int idx;f>>idx;const std::array<CE,2>mods{{{{219733,262411,63559}},{{288706,229183,188479}}}};if(idx<0||idx>1)throw std::runtime_error("factor index");CP a=cread(f),b=cread(f),u=cread(f),v=cread(f),g=cread(f);if(g!=CP{CE{1,0,0}})throw std::runtime_error("not a unit certificate");auto p=cprod(a,u,mods[idx]),q=cprod(b,v,mods[idx]);p.resize(std::max(p.size(),q.size()));for(size_t i=0;i<q.size();i++)for(int j=0;j<3;j++)p[i][j]=add(p[i][j],q[i][j]);ctrim(p);if(p!=g)throw std::runtime_error("full extension Bezout identity fails");size_t n=std::max(a.size()+u.size(),b.size()+v.size())-1;std::cout<<"Independent cubic-extension packed-integer verification: "<<n<<" extension coefficients ("<<3*n<<" K coefficients) checked; unit Bezout identity PASS; factor="<<idx<<"; GMP "<<gmp_version<<"\n";return 0;}catch(const std::exception&e){std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}}
