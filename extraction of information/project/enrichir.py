import urllib.request,re,sys,os
corpus_med=open(sys.argv[1],'r',encoding='utf-8').readlines()
substance_enrichi=open("subst_enri.dic",'w+',encoding='utf-16')
substance=open("subst.dic",'r',encoding='utf-16').readlines()
info2=open("info2.txt",'w+',encoding='utf-16')
info3=open("info3.txt",'w+',encoding='utf-16')
count=1
list_corpus=[]
for exp in corpus_med:
	x=re.search(r'^(-|Ø| |\*|) ?(\w{4,}) ((\d+( \w+)?)? ?:|(LP|lp))? ?(\d+.?\d*|\d-) ?((\d-)+\d|- |½ cp|UI|µg/heures|sachet|sachets|mmol|flacon|\d+/j|\d+ par jour|\d+ sachet/jour|mg|g|ml|µg|µ)', exp,re.I)
	if x :
		if x.group(2).lower() != "intraveineuse" and x.group(2).lower() != "dossier" and x.group(2).lower() != "puis" and x.group(2).lower() != "depuis":
			substance_enrichi.write(x.group(2).lower()+',.N+subst\n') 
			list_corpus.append(x.group(2).lower()+',.N+subst\n')
			print(str(count)+' '+x.group(2).lower())
			count=count+1			
		
list_corpus=sorted(list(set(list_corpus)))
count_total=0
for x in [chr(i) for i in range(ord('a'),ord('z')+1)]:
	count=0
	for elt in list_corpus:
		if (elt[0]==x):
			info2.write(elt)
			count=count+1

	info2.write('---------------------------------------------------------\n')	
	info2.write('Total de '+str(x)+ ' : '+str(count)+'\n')
	info2.write('---------------------------------------------------------\n')
	count_total=count_total+count

info2.write('Le nombre total est : '+str(count_total)+'\n')	
info2.close()
substance_enrichi.close()
list_vidal=[]
for x in substance:
	list_vidal.append(x)
find=0
list_info3=[]
for eltc in list_corpus:
	for eltv in list_vidal:
		if(eltc==eltv):
			find=1
	if (find==0):
		list_info3.append(eltc)	
	find=0	
count_total=0
for x in [chr(i) for i in range(ord('a'),ord('z')+1)]:
	count=0
	for elt in list_info3:
		if (elt[0]==x):
			info3.write(elt)
			count=count+1

	info3.write('---------------------------------------------------------\n')	
	info3.write('Total de '+str(x)+ ' : '+str(count)+'\n')
	info3.write('---------------------------------------------------------\n')
	count_total=count_total+count
info3.write('Le nombre total est : '+str(count_total)+'\n')
info3.close()
list_enri=sorted(list(set(list_vidal+list_corpus)))
substance=open("subst.dic",'w+',encoding='utf-16')
substance_enrichi=open("subst_enri.dic",'r',encoding='utf-16')
for x in [chr(i) for i in range(ord('a'),ord('z')+1)]:
	for elt in list_enri:
		if (elt[0]==x):
			substance.write(elt)
	
substance.close()
substance_enrichi.close()
