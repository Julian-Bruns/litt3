// Complete six-label fourth-trace endpoint filter, with compact surviving data.
// The inherited field/signature/rank routines are retained and audited.
// This program makes NO curve-existence or two-endpoint compatibility claim.
#define main inherited_quintic_main
#include "pro_mixed_quintic_20260927/src/mixed_phase_check.cpp"
#undef main
#include <fstream>

void sextic_scalars(const array<int,6>& labels,bool reciprocal,Counts& counts,std::ofstream& out){
 int U[7]={},V[7]={};
 for(int label:labels)for(int j=0;j<7;++j){U[j]=add8(U[j],u_table[label][j]);V[j]=add8(V[j],v_table[label][j]);}
 int ui=0;while(ui<7&&U[ui]<25)++ui;
 // Prime-field independence and 6 != 4a+5b show U is never constant.
 assert(ui<7);
 int vi=0;while(vi<7&&V[vi]<25)++vi;
 bool reverse=reciprocal&&vi<7;int chosen=reverse?vi:ui;
 if(reciprocal&&!reverse)++counts.reciprocal_fallbacks;
 for(int a=0;a<25;++a)for(int b=0;b<25;++b){
  int epsilon,d=0;
  if(reverse){d=div8(sub8(a,U[chosen]),sub8(V[chosen],b));if(!d)continue;epsilon=div8(1,d);}
  else epsilon=div8(sub8(b,V[chosen]),sub8(U[chosen],a));
  if(!permitted[epsilon])continue;
  ++counts.candidates;bool ok=true;
  for(int j=0;j<7;++j){
   int value=reverse?add8(U[j],mul8(d,V[j])):add8(mul8(epsilon,U[j]),V[j]);
   if(!member_by_minors(value,reverse?d:epsilon)){ok=false;break;}
  }
  if(ok){++counts.accepted;for(int k=0;k<4;++k)out.put(char((epsilon>>(8*k))&255));for(int l:labels)out.put(char(l));}
 }
}

int main(int argc,char**argv){
 assert(argc>=2);bool reciprocal=argc>2&&std::string(argv[2])=="--reciprocal";
 std::ofstream out(argv[1],std::ios::binary);assert(out);
 initialize_fields();initialize_signatures();int nscalar=0;
 for(int a=1;a<FIELD_ORDER;++a){permitted[a]=logarithm8[a]%626!=0;nscalar+=permitted[a];}
 assert(nscalar==390000);std::cout<<"SEXTIC permitted_all_scalars_outside_F625 "<<nscalar<<" reciprocal "<<reciprocal<<std::endl;
 Counts counts;uint16_t empty[5][14]={},s1[5][14],s2[5][14],s3[5][14],s4[5][14],s5[5][14],s6[5][14];
 for(int phase_index=0;phase_index<29;++phase_index){
  int a=4*phase_index;add_label(s1,empty,a);
  for(int b=a;b<116;++b){add_label(s2,s1,b);
   for(int c=b;c<116;++c){add_label(s3,s2,c);
    for(int d=c;d<116;++d){add_label(s4,s3,d);
     for(int e=d;e<116;++e){add_label(s5,s4,e);
      for(int f=e;f<116;++f){add_label(s6,s5,f);
       int rank=reciprocal?column_rank(s6):row_rank(s6);++counts.rank[rank];
       if(rank>=4)continue;
       sextic_scalars({a,b,c,d,e,f},reciprocal,counts,out);
      }
     }
    }
   }
  }
  uint64_t total=0;for(auto c:counts.rank)total+=c;
  std::cout<<"PHASE "<<phase_index<<" total "<<total<<" candidates "<<counts.candidates<<" accepted "<<counts.accepted<<std::endl;
 }
 uint64_t total=0;for(auto c:counts.rank)total+=c;
 assert(total==1034820920ULL);
 std::cout<<"COMPLETE total "<<total;for(int i=0;i<5;++i)std::cout<<" rank"<<i<<' '<<counts.rank[i];
 std::cout<<" candidates "<<counts.candidates<<" accepted "<<counts.accepted<<" fallback "<<counts.reciprocal_fallbacks<<std::endl;
}
