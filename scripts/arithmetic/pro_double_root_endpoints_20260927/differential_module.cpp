// Exact polynomial row reduction of the112x71 differential matrix.
// The complete coefficient algebra is retained; any nonunit pivot aborts.
// A reverse trace, rather than a full polynomial transformation matrix,
// constructs just the one required identity. Verification multiplies it
// against the ORIGINAL, untransformed matrix.
#include "field.cpp"
struct Row {
 vector<EP> a;
 int deg=-1,pos=-1;
 void lead(){deg=-1;pos=-1;for(int i=0;i<(int)a.size();i++)
   if(a[i].len() && a[i].len()-1>=deg){deg=a[i].len()-1;pos=i;}}
};
struct Event {int i,j,shift;E z;bool swap;};
static EP shift_scale(const EP&a,const E&z,int shift){
 EP b=epscale(a,z);if(b.len() && shift)b.a.insert(b.a.begin(),shift*ED,0);return b;
}
extern "C" {
// A input order[T][tau][coefficient-algebra basis], tau padded to nscale.
// c output order[differential row][tau][algebra basis], padded to nout.
// stats: reductions,rank,sum row degrees,max certificate degree.
int differential_left_certificate(const int*input,int nscale,int*out,int nout,int*stats){
 try {
 ff_init();const int nr=112,nc=71;vector<int>ms;
 for(int m=1;m<=140;m++)if(m%5)ms.push_back(m);
 vector<EP>A;for(int i=0;i<=140;i++)A.emplace_back(KP(input+(size_t)i*nscale*ED,input+(size_t)(i+1)*nscale*ED));
 vector<Row>rows(nr);for(int k=0;k<nr;k++){
  int m=ms[k];rows[k].a.resize(nc);
  for(int j=0;j<nc;j++)if(m-j>=0 && m-j<=140){int c=((3*j-m)%5+5)%5;
    E z(ED,0);z[0]=c;rows[k].a[j]=epscale(A[m-j],z);}
  rows[k].lead();
 }
 vector<int>owner(nc,-1);vector<Event>trace;long reductions=0;
 for(int i=0;i<nr;i++){
  while(rows[i].pos>=0){int p=rows[i].pos;int j=owner[p];
   if(j<0){owner[p]=i;break;}
   if(rows[i].deg<rows[j].deg){swap(rows[i],rows[j]);trace.push_back({i,j,0,{},true});}
   int shift=rows[i].deg-rows[j].deg;
   E z=emul(rows[i].a[p].coeff(rows[i].deg),einv(rows[j].a[p].coeff(rows[j].deg)));
   for(int col=0;col<nc;col++)if(rows[j].a[col].len())
    rows[i].a[col]=epsub(rows[i].a[col],shift_scale(rows[j].a[col],z,shift));
   rows[i].lead();trace.push_back({i,j,shift,z,false});reductions++;
   if(reductions%5000==0){fprintf(stderr,"MODULE reductions %ld row %d\n",reductions,i);fflush(stderr);}
  }
 }
 int rank=0,sumdeg=0;for(int j:owner)if(j>=0){rank++;sumdeg+=rows[j].deg;}
 stats[0]=reductions;stats[1]=rank;stats[2]=sumdeg;
 fprintf(stderr,"MODULE rank %d sumdegrees %d reductions %ld\n",rank,sumdeg,reductions);fflush(stderr);
 // A constant row with leading position0 is already a unit times e0.
 if(owner[0]<0 || rows[owner[0]].deg!=0)return 1;
 vector<EP>c(nr);c[owner[0]]=EP(einv(rows[owner[0]].a[0].coeff(0)));
 for(auto it=trace.rbegin();it!=trace.rend();++it){
  if(it->swap)swap(c[it->i],c[it->j]);
  else if(c[it->i].len())c[it->j]=epsub(c[it->j],shift_scale(c[it->i],it->z,it->shift));
 }
 int md=-1;for(const EP &p:c)md=max(md,p.len()-1);stats[3]=md;
 fprintf(stderr,"MODULE reverse-trace certificate degree %d\n",md);fflush(stderr);
 if(md>=nout)return -3;
 std::fill(out,out+(size_t)nr*nout*ED,0);
 for(int k=0;k<nr;k++)copy(c[k].a.begin(),c[k].a.end(),out+(size_t)k*nout*ED);
 // Check every one of the71 columns against the untransformed matrix.
 for(int j=0;j<nc;j++){
  EP check;
  for(int k=0;k<nr;k++){
   int m=ms[k];if(m-j<0 || m-j>140)continue;
   int cc=((3*j-m)%5+5)%5;if(!cc)continue;E zz(ED,0);zz[0]=cc;
   check=epadd(check,epmul(c[k],epscale(A[m-j],zz)));
  }
  EP wanted=j==0?EP(eone()):EP();
  if(epsub(check,wanted).len())return -4;
 }
 return 0;
 }catch(const std::exception&e){fprintf(stderr,"MODULE ABORT: %s\n",e.what());return -2;}
}
}
