import requests
import json

#Get list of URL in a category

url = "https://10.2.23.2/mgmt/tm/sys/url-db/url-category/Bypass"

payload={}
headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YXBpOkJpem9uMTIzIQ==',
  'Cookie': 'BIGIPAuthCookie=4relC7o3YjPMedF4E9LYfkEDLQpagnalYnapLQE5; BIGIPAuthUsernameCookie=api'
}

response = requests.request("GET", url, headers=headers, data=payload, verify=False)
#response is a Python object, which contains all data about server response. This object has its own methods and properties.

json_data = response.json()
#Now we have a Python dictionary from a server reply

#Print dict as is - a long string
print(json_data)

#Print dict in a comfortable JSON form
print(json.dumps(json_data, indent=4))

#Print a dict via items method - not very convenient
for k, v in json_data.items():
  print(k,":",v)

#List all keys of the dictionary
#print(json_data.keys())

#json_data is a dict, urls is a list inside it, 0 is the first element(dict) in list, name is a key in dict :)
#print(json_data['urls'][0]['name'])

#Print all all URLs from a list
for x in json_data['urls']:
  print(x['name'])

#Add new URL to a list inside dictionary
json_data['urls'].append({'name': 'http://www.abra.com/', 'type': 'exact-match'}) 

#Add URL to an category
#Create a JSON from a dictionary
payload=json.dumps(json_data)
response = requests.request("PATCH", url, headers=headers, data=payload, verify=False)


#Create a new virtual server----------------------------------------------------------------------------------------------------

url = "https://10.2.23.2/mgmt/tm/ltm/virtual"

payload = json.dumps({
  "name": "vs10",
  "destination": "192.168.184.230:80",
  "mask": "255.255.255.255"
})

headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YXBpOkJpem9uMTIzIQ==',
  'Cookie': 'BIGIPAuthCookie=0vjkLQI5edutTUobBGNOJ469AD0vszBC1mncZKUT; BIGIPAuthUsernameCookie=api'
}

#response = requests.request("POST", url, headers=headers, data=payload, verify=False)
#print(response.json())
