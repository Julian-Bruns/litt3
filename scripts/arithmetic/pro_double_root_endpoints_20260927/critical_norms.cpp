// Determinants of multiplication in the complete monic rank-nine algebra.
// No irreducibility, reducedness, or parameter-dependent inversion is assumed.
#include "field.cpp"
extern "C" int norm9(const int* modulus,const int* element){
 if(!ready)ff_init();
 int Mx[81]={0},v[9];copy(element,element+9,v);
 for(int j=0;j<9;j++){
  for(int i=0;i<9;i++)Mx[i*9+j]=v[i];
  int top=v[8];for(int i=8;i>=0;i--)v[i]=sub(i?v[i-1]:0,mul(top,modulus[i]));
 }
 int det=1;
 for(int j=0;j<9;j++){
  int k=j;while(k<9&&!Mx[k*9+j])k++;if(k==9)return 0;
  if(k!=j){for(int t=0;t<9;t++)swap(Mx[j*9+t],Mx[k*9+t]);det=neg(det);}
  int z=Mx[j*9+j];det=mul(det,z);int zi=inv(z);
  for(int k=j+1;k<9;k++)if(Mx[k*9+j]){
   int c=mul(Mx[k*9+j],zi);
   for(int t=j+1;t<9;t++)Mx[k*9+t]=sub(Mx[k*9+t],mul(c,Mx[j*9+t]));
   Mx[k*9+j]=0;
  }
 }
 return det;
}
static int determinant_small(std::vector<int> M,int n){
 int z=1;
 for(int j=0;j<n;j++){
  int k=j;while(k<n&&!M[k*n+j])k++;if(k==n)return 0;
  if(k!=j){for(int l=j;l<n;l++)std::swap(M[j*n+l],M[k*n+l]);z=neg(z);}
  int v=M[j*n+j];z=mul(z,v);v=inv(v);
  for(int k=j+1;k<n;k++)if(M[k*n+j]){
   int a=mul(M[k*n+j],v);
   for(int l=j+1;l<n;l++)M[k*n+l]=sub(M[k*n+l],mul(a,M[j*n+l]));
  }
 }
 return z;
}
extern "C" void adjugate9(const int*modulus,const int*element,int*out){
 if(!ready)ff_init();
 int M[81]={0},v[9];copy(element,element+9,v);
 for(int j=0;j<9;j++){
  for(int i=0;i<9;i++)M[i*9+j]=v[i];
  int top=v[8];for(int i=8;i>=0;i--)v[i]=sub(i?v[i-1]:0,mul(top,modulus[i]));
 }
 // adj(M) e_0: component i is cofactor (0,i), including singular matrices.
 for(int i=0;i<9;i++){
  std::vector<int>N;for(int r=1;r<9;r++)for(int c=0;c<9;c++)if(c!=i)N.push_back(M[r*9+c]);
  int z=determinant_small(N,8);out[i]=i%2?neg(z):z;
 }
}
