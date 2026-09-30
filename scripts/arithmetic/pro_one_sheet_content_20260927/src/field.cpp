#include <cstdint>
#include <vector>
#include <cstdio>
#include <cassert>
#include <algorithm>
using U=uint32_t;
static constexpr U QQ=390625, ORD=QQ-1;
static U ad25[25][25],mu25[25][25];
static std::vector<U> tab,lg,ex,ng;
static U direct_add(U a,U b){U c=0,p=1;for(int i=0;i<4;i++){c+=p*ad25[a%25][b%25];a/=25;b/=25;p*=25;}return c;}
static U direct_mul(U a,U b){U aa[4],bb[4],cc[7]={0};for(int i=0;i<4;i++){aa[i]=a%25;a/=25;bb[i]=b%25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)cc[i+j]=ad25[cc[i+j]][mu25[aa[i]][bb[j]]];
 const U f[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)cc[i-4+j]=ad25[cc[i-4+j]][mu25[cc[i]][mu25[4][f[j]]]];
 U c=0,p=1;for(int i=0;i<4;i++){c+=p*cc[i];p*=25;}return c;}
static U dpow(U a,U b){U c=1;for(;b;b>>=1,a=direct_mul(a,a))if(b&1)c=direct_mul(c,a);return c;}
extern "C" {
U kadd(U a,U b){return tab[(a%625)*625+b%625]+625*tab[(a/625)*625+b/625];}
U kmul(U a,U b){return a&&b?ex[lg[a]+lg[b]]:0;}
U kneg(U a){return ng[a];}
U kinv(U a){assert(a);return ex[ORD-lg[a]];}
U kpow(U a,int64_t b){if(!b)return 1;if(!a){assert(b>0);return 0;}int64_t s=(int64_t)lg[a]*(b%(int64_t)ORD)%(int64_t)ORD;if(s<0)s+=ORD;return ex[s];}
U kdirect(U a,U b){return direct_mul(a,b);}
U initfield(const char *out){
 for(U a=0;a<25;a++)for(U b=0;b<25;b++){
  ad25[a][b]=((a%5+b%5)%5)+5*((a/5+b/5)%5);
  mu25[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
 }
 U g=25;while(!(dpow(g,ORD)==1&&dpow(g,ORD/2)!=1&&dpow(g,ORD/3)!=1&&dpow(g,ORD/13)!=1&&dpow(g,ORD/313)!=1))g++;
 tab.resize(625*625);for(U a=0;a<625;a++)for(U b=0;b<625;b++)tab[a*625+b]=direct_add(a,b);
 ng.resize(QQ);for(U a=0;a<QQ;a++){U b=a,c=0,p=1;for(int i=0;i<8;i++){c+=p*((5-b%5)%5);b/=5;p*=5;}ng[a]=c;}
 lg.assign(QQ,QQ);ex.resize(2*ORD+1);U c=1;for(U i=0;i<ORD;i++){assert(lg[c]==QQ);lg[c]=i;ex[i]=c;c=direct_mul(c,g);}assert(c==1);for(U i=ORD;i<=2*ORD;i++)ex[i]=ex[i-ORD];
 for(U a=1;a<QQ;a++){assert(kmul(a,kinv(a))==1);assert(kadd(a,ng[a])==0);}
 if(out){FILE*f=fopen(out,"wb");assert(f);fwrite(&g,4,1,f);fwrite(tab.data(),4,tab.size(),f);fwrite(lg.data(),4,lg.size(),f);fwrite(ex.data(),4,ex.size(),f);fwrite(ng.data(),4,ng.size(),f);fclose(f);}return g;}
int rref(U *m,int rows,int cols,int *piv){int rank=0;for(int c=0;c<cols-1&&rank<rows;c++){int r=rank;while(r<rows&&!m[r*cols+c])r++;if(r==rows)continue;for(int j=0;j<cols;j++)std::swap(m[r*cols+j],m[rank*cols+j]);U iv=kinv(m[rank*cols+c]);for(int j=c;j<cols;j++)m[rank*cols+j]=kmul(m[rank*cols+j],iv);for(int i=0;i<rows;i++)if(i!=rank&&m[i*cols+c]){U t=ng[m[i*cols+c]];m[i*cols+c]=0;for(int j=c+1;j<cols;j++)if(m[rank*cols+j])m[i*cols+j]=kadd(m[i*cols+j],kmul(t,m[rank*cols+j]));}piv[rank]=c;rank++;}return rank;}
}
#ifdef FIELD_MAIN
int main(int argc,char**argv){U g=initfield(argc>1?argv[1]:nullptr);printf("K cardinality=%u primitive_generator_code=%u full_cycle=PASS all_inverses=PASS\n",QQ,g);}
#endif
