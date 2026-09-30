// Exact bounded-degree left identities for the complete differential matrix.
// Uses all m=1,...,209, not just the 112 equations needed with resonance tails.
// Any nonunit algebra pivot aborts. A returned identity is checked directly.
#include "field.cpp"
static void Eaxpy(int* a,const int*b,const int*z,int n){
 if(ED==1){for(int j=0;j<n;j++)if(b[j])a[j]=sub(a[j],mul(b[j],z[0]));return;}
 E tmp(ED);for(int j=0;j<n;j++){const int *bb=b+j*ED;if(ezero(bb))continue;emul_to(tmp.data(),bb,z);for(int k=0;k<ED;k++)a[j*ED+k]=sub(a[j*ED+k],tmp[k]);}
}
extern "C" {
int strong_differential_certificate(const int*input,int ds,int bound,int*out,int*stats,int*pivot_columns,int*minor_det,const int*column_order){
 try{
  ff_init();const int nr=209,nc=71,nu=nr*(bound+1),ne=nc*(bound+ds),stride=(nu+1)*ED;
  KP mat((size_t)ne*stride,0);vector<int> piv,perm(nu),iperm(nu);for(int c=0;c<nu;c++){perm[c]=column_order?column_order[c]:c;iperm[perm[c]]=c;}
  // Transpose Macaulay matrix. Rows: [B coefficient][tau coefficient].
  for(int j=0;j<nc;j++)for(int m=1;m<=209;m++)if(0<=m-j&&m-j<=140){
   int z=((3*j-m)%5+5)%5;if(!z)continue;
   for(int ell=0;ell<=bound;ell++)for(int a=0;a<ds;a++){
    int* v=mat.data()+(size_t)(j*(bound+ds)+ell+a)*stride+iperm[(m-1)*(bound+1)+ell]*ED;
    const int* aa=input+((m-j)*ds+a)*ED;for(int k=0;k<ED;k++)v[k]=mul(z,aa[k]);
   }
  }
  mat[nu*ED]=1;int r=0;E z(ED),tmp(ED),det=eone();
  for(int c=0;c<nu && r<ne;c++){
   int s=r;while(s<ne&&ezero(mat.data()+(size_t)s*stride+c*ED))s++;
   if(s==ne)continue;
   if(s!=r){det=eneg(det);for(int j=c*ED;j<stride;j++)swap(mat[(size_t)s*stride+j],mat[(size_t)r*stride+j]);}
   int* row=mat.data()+(size_t)r*stride;E pivot(row+c*ED,row+(c+1)*ED);det=emul(det,pivot);E iz=einv(pivot);
   if(ED==1){for(int j=c;j<=nu;j++)row[j]=mul(row[j],iz[0]);}
   else for(int j=c;j<=nu;j++){emul_to(tmp.data(),row+j*ED,iz.data());copy(tmp.begin(),tmp.end(),row+j*ED);}
   for(int i=r+1;i<ne;i++){
    int *a=mat.data()+(size_t)i*stride;if(ezero(a+c*ED))continue;
    copy(a+c*ED,a+(c+1)*ED,z.begin());fill(a+c*ED,a+(c+1)*ED,0);
    Eaxpy(a+(c+1)*ED,row+(c+1)*ED,z.data(),nu-c);
   }
   piv.push_back(c);r++;
  }
  stats[0]=ne;stats[1]=nu;stats[2]=r;for(int i=0;i<r;i++)pivot_columns[i]=perm[piv[i]];copy(det.begin(),det.end(),minor_det);
  for(int i=r;i<ne;i++)if(!ezero(mat.data()+(size_t)i*stride+nu*ED))return 1;
  fill(out,out+(size_t)nu*ED,0);
  for(int i=r-1;i>=0;i--){int c=piv[i];const int*row=mat.data()+(size_t)i*stride;
   E ans(row+nu*ED,row+(nu+1)*ED);
   for(int j=c+1;j<nu;j++)if(!ezero(out+j*ED)&&!ezero(row+j*ED)){
    emul_to(tmp.data(),out+j*ED,row+j*ED);for(int k=0;k<ED;k++)ans[k]=sub(ans[k],tmp[k]);
   }
   copy(ans.begin(),ans.end(),out+c*ED);
  }
  KP ordered(out,out+(size_t)nu*ED);for(int c=0;c<nu;c++)copy(ordered.begin()+c*ED,ordered.begin()+(c+1)*ED,out+perm[c]*ED);
  // Direct original-matrix convolution check, independent of echelon state.
  int nonzero=0,maxdegree=-1;
  for(int j=0;j<nc;j++)for(int t=0;t<bound+ds;t++){
   E check(ED,0);
   for(int m=1;m<=209;m++)if(0<=m-j&&m-j<=140){int z0=((3*j-m)%5+5)%5;if(!z0)continue;
    for(int ell=max(0,t-ds+1);ell<=min(bound,t);ell++){
     const int*a=input+((m-j)*ds+t-ell)*ED;const int*b=out+((m-1)*(bound+1)+ell)*ED;
     if(ezero(a)||ezero(b))continue;emul_to(tmp.data(),a,b);for(int k=0;k<ED;k++)check[k]=add(check[k],mul(z0,tmp[k]));
    }
   }
   E wanted(ED,0);if(j==0&&t==0)wanted[0]=1;if(check!=wanted)return -4;
  }
  for(int m=0;m<nr;m++)for(int ell=0;ell<=bound;ell++)if(!ezero(out+(m*(bound+1)+ell)*ED)){nonzero++;maxdegree=max(maxdegree,ell);}
  stats[3]=nonzero;stats[4]=maxdegree;return 0;
 }catch(const exception&e){fprintf(stderr,"strong differential: %s\n",e.what());return -2;}
}
}

extern "C" {
int independent_det(const int*input,int n){
 KP a(input,input+(size_t)n*n);int det=1;
 for(int j=0;j<n;j++){
  int p=j;while(p<n&&!a[p*n+j])p++;
  if(p==n)return 0;
  if(p!=j){det=neg(det);for(int c=j;c<n;c++)swap(a[p*n+c],a[j*n+c]);}
  int pivot=a[j*n+j];det=mul(det,pivot);int iv=inv(pivot);
  for(int i=j+1;i<n;i++)if(a[i*n+j]){
   int t=mul(a[i*n+j],iv);a[i*n+j]=0;
   for(int c=j+1;c<n;c++)a[i*n+c]=sub(a[i*n+c],mul(t,a[j*n+c]));
  }
 }
 return det;
}
// Minimum-cost assignment and an exact integral dual certificate.
int min_assignment(const int*cost,int n,int*rp,int*cp,int*assignment){
 vector<int>u(n+1),v(n+1),p(n+1),way(n+1);
 for(int i=1;i<=n;i++){
  p[0]=i;int j0=0;vector<int>minv(n+1,1000000000);vector<bool>used(n+1,false);
  do{
   used[j0]=true;int i0=p[j0],delta=1000000000,j1=0;
   for(int j=1;j<=n;j++)if(!used[j]){
    int cur=cost[(i0-1)*n+j-1]-u[i0]-v[j];
    if(cur<minv[j]){minv[j]=cur;way[j]=j0;}
    if(minv[j]<delta){delta=minv[j];j1=j;}
   }
   for(int j=0;j<=n;j++)if(used[j]){u[p[j]]+=delta;v[j]-=delta;}else minv[j]-=delta;
   j0=j1;
  }while(p[j0]!=0);
  do{int j1=way[j0];p[j0]=p[j1];j0=j1;}while(j0);
 }
 for(int i=1;i<=n;i++){rp[i-1]=u[i];cp[i-1]=v[i];}
 for(int j=1;j<=n;j++)assignment[p[j]-1]=j-1;
 return -v[0];
}
}
