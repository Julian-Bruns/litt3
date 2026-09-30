// Exact all-record audit and all-chunk projective-orbit comparison.
// Audits use multiplication only, not the producer's division procedure.
#include "moment_orbit_field.hpp"
#include <queue>
#include <memory>
struct Reader {
 ifstream file;OrbitRec now{},previous{};bool have=false,first=true;uint64_t count=0;int id;
 explicit Reader(const string&path,int i):file(path,ios::binary),id(i){if(!file)throw runtime_error("cannot open "+path);advance();}
 void advance(){
  file.read((char*)now.v.a.data(),28);auto got=file.gcount();if(got==0&&file.eof()){have=false;return;}
  if(got!=28)throw runtime_error("partial key");
  file.read((char*)&now.code,4);if(file.gcount()!=4)throw runtime_error("partial code");
  if(!first&&(now.v.a<previous.v.a||(now.v.a==previous.v.a&&now.code<previous.code)))throw runtime_error("unsorted chunk");
  first=false;previous=now;have=true;count++;
 }
};
struct Item{E key;int id;};
struct Greater{bool operator()(const Item&a,const Item&b)const{return a.key.a>b.key.a;}};
struct Stream {
 vector<unique_ptr<Reader>> readers;priority_queue<Item,vector<Item>,Greater> heap;
 vector<uint64_t> seen;uint64_t count=0,nonzero_records=0,zero_num=0,infinity=0,zero_vectors=0;
 int side;Offsets off;
 Stream(const string&prefix,int chunks,int side_,Offsets offsets):seen((uint64_t(1)<<28)/64),side(side_),off(offsets){
  for(int i=0;i<chunks;i++){
   ostringstream name;name<<prefix<<'.';if(i<10)name<<'0';name<<i<<(side?".right.keys":".left.keys");
   readers.emplace_back(new Reader(name.str(),i));if(readers.back()->have)heap.push({readers.back()->now.v,i});
  }
 }
 bool empty()const{return heap.empty();}
 E top()const{return heap.top().key;}
 void audit(const OrbitRec&r){
  if(r.code>>30)throw runtime_error("bad record high bits");
  uint32_t c=r.code&((1u<<28)-1);int shift=(r.code>>28)&3;
  auto ids=decode_quartet(c);if(ids[3]>=116||!is_sorted(ids.begin(),ids.end())||canonical_code(c)!=c)throw runtime_error("noncanonical quartet");
  uint64_t flag=uint64_t(1)<<(c%64);if(seen[c/64]&flag)throw runtime_error("duplicate quartet");seen[c/64]|=flag;
  auto [cs,es]=label_sums(c);E num=side?sub(cs,off.cneg6):sub(es,off.eneg2),den=side?sub(es,off.epos2):sub(cs,off.cpos6);
  if(num.zero())zero_num++;
  if(r.v.a[0]>=Q){
   for(int i=1;i<7;i++)if(r.v.a[i])throw runtime_error("invalid special vector");
   if(shift||!den.zero())throw runtime_error("invalid infinite denominator or shift");
   if(r.v.a[0]==Q){if(num.zero())throw runtime_error("zero instead of infinite");infinity++;}
   else if(r.v.a[0]==Q+1){if(!num.zero())throw runtime_error("nonzero instead of zero vector");zero_vectors++;}
   else throw runtime_error("invalid special tag");
  }else{
   for(auto x:r.v.a)if(x>=Q)throw runtime_error("invalid field coordinate");
   if(den.zero()||!(mul(r.v,sigma(den,shift))==sigma(num,shift)))throw runtime_error("ratio cross-multiplication mismatch");
   E v=r.v;for(int j=1;j<4;j++){v=sigma(v);if(v.a<r.v.a)throw runtime_error("field key not orbit-minimal");}
   nonzero_records++;
  }
  count++;
 }
 uint64_t consume_group(E key,vector<uint32_t>*examples=nullptr){
  uint64_t n=0;
  while(!heap.empty()&&heap.top().key==key){int id=heap.top().id;heap.pop();auto&r=*readers[id];
   audit(r.now);if(examples&&examples->size()<4)examples->push_back(r.now.code);n++;r.advance();if(r.have)heap.push({r.now.v,id});
  }return n;
 }
 void finish(){while(!empty())consume_group(top());if(count!=TOTAL_ORBITS)throw runtime_error("incomplete endpoint-orbit coverage");}
};
int main(int argc,char**argv){try{
 string prefix,nodes,out;int chunks=8;
 for(int i=1;i<argc;i++){string x=argv[i];if(x=="--prefix"&&i+1<argc)prefix=argv[++i];else if(x=="--nodes"&&i+1<argc)nodes=argv[++i];else if(x=="--output"&&i+1<argc)out=argv[++i];else if(x=="--chunks"&&i+1<argc)chunks=stoi(argv[++i]);else throw runtime_error("Usage --prefix P --nodes e:w,... --output file.json [--chunks N]");}
 if(prefix.empty()||nodes.empty()||out.empty()||chunks<1)throw runtime_error("missing arguments");
 auto started=chrono::steady_clock::now();initialize_labels();auto off=make_offsets(nodes);Stream left(prefix,chunks,0,off),right(prefix,chunks,1,off);
 uint64_t hits=0,keyhits=0;vector<pair<uint32_t,uint32_t>> examples;
 while(!left.empty()&&!right.empty()){
  if(left.top().a<right.top().a){left.consume_group(left.top());continue;}
  if(right.top().a<left.top().a){right.consume_group(right.top());continue;}
  E key=left.top();vector<uint32_t> l,r;auto a=left.consume_group(key,&l),b=right.consume_group(key,&r);hits+=a*b;keyhits++;
  for(auto x:l)for(auto y:r)if(examples.size()<20)examples.emplace_back(x,y);
 }
 left.finish();right.finish();
 ofstream f(out);if(!f)throw runtime_error("cannot create result");
 f<<"{\n\"nodes\":\""<<nodes<<"\",\n\"orbit_count_each_side\":"<<TOTAL_ORBITS<<",\n\"full_quartet_count_each_side\":"<<TOTAL_QUARTETS<<",\n\"matching_orbit_pairs\":"<<hits<<",\n\"matching_field_orbit_keys\":"<<keyhits<<",\n\"complete_valid_unique_coverage\":true,\n\"all_record_identities_passed\":true,\n\"records_audited\":"<<left.count+right.count<<",\n\"field_cross_multiplications\":"<<left.nonzero_records+right.nonzero_records<<",\n\"zero_numerator_counts\":["<<left.zero_num<<','<<right.zero_num<<"],\n\"infinite_vector_counts\":["<<left.infinity<<','<<right.infinity<<"],\n\"zero_vector_counts\":["<<left.zero_vectors<<','<<right.zero_vectors<<"],\n\"moment_locus_empty\":"<<(hits==0?"true":"false")<<",\n\"first_matching_record_codes\":[";
 for(size_t i=0;i<examples.size();i++){if(i)f<<',';f<<'['<<examples[i].first<<','<<examples[i].second<<']';}f<<"]\n}\n";
 cout<<"AUDIT nodes="<<nodes<<" records="<<left.count+right.count<<" hits="<<hits<<" all_coverage=true seconds="<<chrono::duration<double>(chrono::steady_clock::now()-started).count()<<endl;
 return 0;
}catch(const exception&e){cerr<<"ERROR "<<e.what()<<endl;return 1;}}
