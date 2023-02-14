import sqlite3 as sql,urllib.request,re
list_sql=[]
count=1
url_sql=open('corpus-medical_snt/concord.html',encoding='utf-8').readlines()
for sample in url_sql:
	x=re.search(r'\d\"\>[a-zA-Z]+ [^\<]+', sample,re.I)
	if x:
		list_sql.append(x.group())

listo=[]
for i in list_sql:
		listo.append((count,i[3:len(i)+1]))
		count=count+1


connection=sql.connect('extraction.db')
cursr=connection.cursor()
cursr.execute(""" 
	CREATE TABLE IF NOT EXISTS extraction(
		id integer PRIMARY KEY,
		posologie text
	)
	""")
cursr.executemany("INSERT INTO extraction VALUES (?,?)",listo)

cursr.execute("SELECT * FROM extraction")
for i in cursr.fetchall():
	print(str(i[0])+'\t|\t'+str(i[1]))

print('La database est remplie')
connection.commit()
connection.close()