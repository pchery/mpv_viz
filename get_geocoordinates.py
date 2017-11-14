import requests
import numpy as np
import pandas
import json
#data = np.genfromtxt('/Users/paulchery/Documents/MPV.tsv',delimiter='\t', skip_header=1)
data = pandas.read_table('/Users/paulchery/Documents/new_data1.tsv', sep='\t').values
print(data.shape)
#print(np.array_str(data[0]).replace(' ', '+'))
coord = np.zeros([data.shape[0],2])
#coord = np.zeros([2,2])
for i in range(0,data.shape[0]):
#for i in range(0,2):
#print(data)
    address ='Powers+Drive+and+West+Colonial+Drive+Orlando+FL'
# address = np.array_str(data[i]).replace(' ', '+')
    payload = {'address': address, 'key':'AIzaSyAodpHF-GzGs5yh64kkcKSiVgCgsRbBmmU'}
    r = requests.get('https://maps.googleapis.com/maps/api/geocode/json', params=payload)
    print(r.url)
    jayson = json.loads(r.text)
    if (jayson['results']):
        coord[i][0] = jayson['results'][0]['geometry']['location']['lat']
        coord[i][1] = jayson['results'][0]['geometry']['location']['lng']
        print(coord[i][0])
        print(coord[i][1])
final_data = np.hstack((data,coord))
df = pandas.DataFrame(data = final_data)
df.to_csv('data2.tsv', sep='\t')
#np.savetxt('data.tsv', final_data,fmt=('%s, %s, %s, %s, %.7f, %.7f'), delimiter='\t')
