#include "ff.hpp"
#include <algorithm>
extern "C" {
uint32_t init_field(){return ff::init();}
void dump_field(const char* dir){std::string d(dir); std::ofstream(d+"/add625.bin",std::ios::binary).write((char*)ff::a625,sizeof(ff::a625)); std::ofstream(d+"/neg.bin",std::ios::binary).write((char*)ff::negs,sizeof(ff::negs)); std::ofstream(d+"/log.bin",std::ios::binary).write((char*)ff::logs,sizeof(ff::logs)); std::ofstream(d+"/exp.bin",std::ios::binary).write((char*)ff::exps,sizeof(ff::exps));}
int rref(uint32_t* mat,int nr,int nc,int* piv){
using namespace ff; int r=0;for(int c=0;c<nc&&r<nr;c++){int j=r;for(;j<nr&&!mat[j*nc+c];j++);if(j==nr)continue;
for(int k=0;k<nc;k++)std::swap(mat[r*nc+k],mat[j*nc+k]);E sc=inv(mat[r*nc+c]);for(int k=c;k<nc;k++)mat[r*nc+k]=mul(mat[r*nc+k],sc);
for(int i=0;i<nr;i++)if(i!=r){E b=mat[i*nc+c];if(b)for(int k=c;k<nc;k++)mat[i*nc+k]=sub(mat[i*nc+k],mul(b,mat[r*nc+k]));}piv[r++]=c;}
return r;}
void polymul(uint32_t* a,int n,uint32_t* b,int m,uint32_t* out){using namespace ff;std::fill(out,out+n+m-1,0);for(int i=0;i<n;i++)if(a[i])for(int j=0;j<m;j++)if(b[j])out[i+j]=add(out[i+j],mul(a[i],b[j]));}
}
extern "C" uint32_t matrix_det(uint32_t* a,int n){
 using namespace ff;E det=1;
 for(int i=0;i<n;i++){int j=i;while(j<n&&!a[j*n+i])j++;if(j==n)return 0;if(j!=i){for(int k=0;k<n;k++)std::swap(a[i*n+k],a[j*n+k]);det=neg(det);}E p=a[i*n+i];det=mul(det,p);E ip=inv(p);for(j=i+1;j<n;j++){E f=mul(a[j*n+i],ip);if(f)for(int k=i+1;k<n;k++)a[j*n+k]=sub(a[j*n+k],mul(f,a[i*n+k]));}}
 return det;
}
