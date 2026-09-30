// Independent, division-free verification of the fixed (3,4) resultant.
// Complete rank-nine coefficient algebras, including nonreduced ones, are used.
#include "field.cpp"
static E determinant7(const vector<vector<E>>&a){
 vector<E>dp(128,E(ED,0));dp[0]=eone();
 for(int mask=0;mask<127;mask++){
  int row=__builtin_popcount((unsigned)mask);
  for(int j=0;j<7;j++)if(!(mask&(1<<j))){
   E z=emul(dp[mask],a[row][j]);int inversions=row-__builtin_popcount((unsigned)(mask&((1<<j)-1)));
   if(inversions&1)z=eneg(z);dp[mask|(1<<j)]=eadd(dp[mask|(1<<j)],z);
  }
 }
 return dp[127];
}
extern "C" int endpoint_resultant_checks(const int*raw,int rows,const int*gq,int pa,int count,int*out){
 try{
  ff_init();ED=9;
  for(int u=0;u<count;u++){
   EM.assign(10,0);for(int i=0;i<10;i++)EM[i]=add(gq[3*i],mul(u,add(gq[3*i+1],mul(u,gq[3*i+2]))));
   if(EM[9]!=1)return -1;
   vector<E>coeff(11,E(9,0));
   for(int k=0;k<11;k++)for(int j=0;j<9;j++){
    int z=0;for(int i=rows-1;i>=0;i--)z=add(mul(z,u),raw[((size_t)i*11+k)*9+j]);coeff[k][j]=z;
   }
   vector<vector<E>>mat(7,vector<E>(7,E(9,0)));
   for(int r=0;r<4;r++)for(int j=0;j<4;j++)mat[r][r+j]=coeff[3-j];
   for(int r=0;r<3;r++)for(int j=0;j<5;j++)mat[r+4][r+j]=coeff[8-j];
   E lhs=determinant7(mat),q8(9,0);q8[8]=mul(3,mul(pa,pa));
   E rhs=emul(q8,emul(coeff[9],emul(coeff[10],coeff[10])));
   if(lhs!=rhs){fprintf(stderr,"endpoint fixed resultant mismatch u=%d\n",u);return u+1;}
   copy(lhs.begin(),lhs.end(),out+9*u);
  }
  return 0;
 }catch(const exception&ex){fprintf(stderr,"endpoint global identity: %s\n",ex.what());return -2;}
}
