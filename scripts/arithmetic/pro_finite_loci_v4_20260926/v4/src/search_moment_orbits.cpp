// Exhaustive necessary-moment search, modulo coefficient-Frobenius orbits.
// No assumption about branch-polynomial fields is made here.
#include "moment_orbit_field.hpp"
int main(int argc,char**argv){try{
 string nodes,out;uint64_t first=0,limit=TOTAL_ORBITS;
 for(int i=1;i<argc;i++){string x=argv[i];if(x=="--nodes"&&i+1<argc)nodes=argv[++i];else if(x=="--output"&&i+1<argc)out=argv[++i];else if(x=="--start"&&i+1<argc)first=stoull(argv[++i]);else if(x=="--limit"&&i+1<argc)limit=stoull(argv[++i]);else throw runtime_error("Usage --nodes 0:2,1:1 --output stem [--start N --limit N]");}
 if(nodes.empty()||out.empty()||first>TOTAL_ORBITS)throw runtime_error("missing/invalid arguments");
 auto started=chrono::steady_clock::now();initialize_labels();auto off=make_offsets(nodes);
 static E cp[116][116],ep[116][116];for(int i=0;i<116;i++)for(int j=i;j<116;j++){cp[i][j]=add(CLabel[i],CLabel[j]);ep[i][j]=add(ELabel[i],ELabel[j]);}
 vector<OrbitRec> streams[2];for(auto &s:streams)s.reserve(min<uint64_t>(limit,TOTAL_ORBITS));
 vector<uint32_t> zerovec[2],infinity[2];uint64_t zeronum[2]={},count=0,ordinal=0;
 struct Entry{E num,den;uint32_t code;int side;};vector<Entry> batch;batch.reserve(32768);
 auto flush=[&](){if(batch.empty())return;vector<E> pref(batch.size());E prod=one();
  for(size_t i=0;i<batch.size();i++){pref[i]=prod;prod=mul(prod,batch[i].den);}E inv=inverse(prod);
  for(size_t ii=batch.size();ii>0;ii--){size_t i=ii-1;auto&w=batch[i];E id=mul(pref[i],inv);inv=mul(inv,w.den);streams[w.side].push_back(canonical_record(mul(w.num,id),w.code));}
  if(!(inv==one()))throw runtime_error("inverse chain");
  batch.clear();};
 auto submit=[&](const E&num,const E&den,uint32_t code,int side){
  if(num.zero())zeronum[side]++;
  if(den.zero()){
   if(num.zero())zerovec[side].push_back(code);else infinity[side].push_back(code);
   E tag;tag.a[0]=num.zero()?Q+1:Q;streams[side].push_back({tag,code});
  }else {batch.push_back({num,den,code,side});if(batch.size()>=32768)flush();}};
 for(int i=0;i<116;i++)for(int j=i;j<116;j++)for(int k=j;k<116;k++)for(int l=k;l<116;l++){
  uint32_t code=quartet_code(i,j,k,l);if(canonical_code(code)!=code)continue;
  if(ordinal++<first)continue;
  if(count>=limit)goto done;
  E cs=add(cp[i][j],cp[k][l]),es=add(ep[i][j],ep[k][l]);
  submit(sub(es,off.eneg2),sub(cs,off.cpos6),code,0);
  submit(sub(cs,off.cneg6),sub(es,off.epos2),code,1);count++;
 }
 done:flush();
 const char* side_name[2]={"left","right"};
 for(int s=0;s<2;s++){
  sort(streams[s].begin(),streams[s].end(),[](const OrbitRec&a,const OrbitRec&b){return a.v.a<b.v.a||(a.v.a==b.v.a&&a.code<b.code);});
  ofstream f(out+"."+side_name[s]+".keys",ios::binary);if(!f)throw runtime_error("key output");
  for(auto &r:streams[s]){f.write((const char*)r.v.a.data(),28);f.write((const char*)&r.code,4);}if(!f)throw runtime_error("key write failed");
 }
 ofstream f(out+".json");if(!f)throw runtime_error("summary output");
 f<<"{\n\"nodes\":\""<<nodes<<"\",\n\"start\":"<<first<<",\n\"count\":"<<count<<",\n\"total_orbits\":"<<TOTAL_ORBITS<<",\n\"zero_numerator_counts\":["<<zeronum[0]<<","<<zeronum[1]<<"],\n";
 auto arr=[&](const char*name,vector<uint32_t>*a){f<<"\""<<name<<"\":[";for(int s=0;s<2;s++){if(s)f<<',';f<<'[';for(size_t i=0;i<a[s].size();i++){if(i)f<<',';f<<a[s][i];}f<<']';}f<<"],\n";};
 arr("zero_vectors",zerovec);arr("infinite_vectors",infinity);
 f<<"\"finite_counts\":["<<(streams[0].size()-zerovec[0].size()-infinity[0].size())<<","<<(streams[1].size()-zerovec[1].size()-infinity[1].size())<<"]\n}\n";
 cout<<"GENERATED nodes="<<nodes<<" start="<<first<<" count="<<count<<" zero_num="<<zeronum[0]<<","<<zeronum[1]<<" zero_vec="<<zerovec[0].size()<<","<<zerovec[1].size()<<" inf="<<infinity[0].size()<<","<<infinity[1].size()<<" seconds="<<chrono::duration<double>(chrono::steady_clock::now()-started).count()<<endl;
 return 0;
}catch(const exception&e){cerr<<"ERROR "<<e.what()<<endl;return 1;}}
