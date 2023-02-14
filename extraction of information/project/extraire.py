import urllib.request,re,sys
given_interval=sys.argv[1]
match=re.match(r"[a-zA-Z]-[a-zA-Z]",given_interval)
port_http=sys.argv[2]
if match:
	lower_bound=given_interval[0].upper()
	upper_bound=given_interval[2].upper()
	if ord(lower_bound)>ord(upper_bound):
		lower_bound=given_interval[2].upper()
		upper_bound=given_interval[0].upper()
	alphabet=[]
	for x in [chr(i) for i in range(ord(lower_bound),ord(upper_bound)+1)]:
		alphabet.append(x)

	print(alphabet)	
	substance=open("subst.dic",'w+',encoding='utf-16')
	nbr_med_by_let=0
	nbr_total=0
	infos=open("infos.txt",'w+',encoding='utf-8')
	vidal_url=urllib.request.urlopen('http://127.0.0.1:'+port_http+'/vidal/')
	vidal_url_decoded_file=vidal_url.read().decode('utf-8')
	vidal_url_files_name=[]
	for x in [chr(i) for i in range(ord(lower_bound),ord(upper_bound)+1)]:
		vidal_url_files_name=vidal_url_files_name+re.findall(r'vidal-Sommaires-Substances-'+x+'\.htm',vidal_url_decoded_file)	

	files_name_list=sorted(list(set(vidal_url_files_name))) 
	print('La liste des noms:',end=" ")
	print(files_name_list)
	files_name_url_list={}
	i=0
	for x in files_name_list :
		files_name_url_list['http://127.0.0.1/vidal/'+str(x)]=alphabet[i]
		i=i+1

	print('La liste des noms final :',end=" ")
	print(files_name_url_list)
	for x in files_name_url_list :
		letter_page_url = urllib.request.urlopen(x)
		letter_page_url_coded = letter_page_url.read().decode("utf-8")
		match_med=re.findall(r'Substance/([a-z]+[_a-z0-9]+|[a-z]+)-[0-9]+',str(letter_page_url_coded))
		match_med2=re.findall(r'([a-z]+[_a-z0-9]+|[a-z]+)',str(match_med))
		print(match_med2)
		for sub in match_med2:
			if((sub!="ubstance")) :
				substance.write(sub+',.N+subst\n')
				nbr_med_by_let=nbr_med_by_let+1

		infos.write('Le nombre de '+files_name_url_list[x]+' est : '+str(nbr_med_by_let)+'\n')	
		nbr_total=nbr_total+nbr_med_by_let
		nbr_med_by_let=0
	infos.write('Le nombre total des substances actives est : '+str(nbr_total))

else:
	print('la forme d\'intervalle invalide')

