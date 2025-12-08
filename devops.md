# Devops

## Ansible

- Inventory file
- Playbook - Ordered lists of tasks, saved so you can run those tasks in that order repeatedly. Playbooks can include variables as well as tasks. Playbooks are written in YAML
- Templates - configuration commands with variables instead of parametres
- Variables - SNMP communities, addresses.....
- Configuration files - generated after we launch playbook

Launch playbook

```
ansible-playbook -i inventory snmp.yml
```

Show where configs are

```
ansible --version
```

Show installed modules

```
ansible-galaxy collection list
```

Install module

```
ansible-galaxy collection install f5networks.f5_modules
```

Working playbook for F5
```
---
  - name: creating HTTPS application
    hosts: 10.2.23.2
    gather_facts: no
    connection: local

    tasks:

     - name: Add node
       bigip_node:
        host: 10.20.30.40
        name: 10.20.30.40
        provider:
         server: 10.2.23.2
         user: admin
         password: Bizon123!
         validate_certs: no
       delegate_to: localhost
```

## Git

Pro Git book

- Work with Git locally
- Create a directory
- Inside it launch:
-
```
git init
```

Delete git from repos including all history

```
rm -rf .git
```

show status of repo

```
git status
```

Ignore folders

```
vi .gitignore
```

Add files for tracking

```
git add test.py
```

Next

```
git commit
```

Show changes after last commit

```
git diff
```

Disable SSL verification

```
git -c http.sslVerify=false clone <path>
cd <directory>
git config http.sslVerify "false"

Globally
git config --global http.sslVerify false
```

Update local repo from remote

```
git pull origin main
```

Upload changes to remote repo

```
git push origin main
```

## Requests module

https://requests.readthedocs.io/en/latest/

The requests module allows you to send HTTP requests using Python.  
Requests module methods:
- delete
- get
- head
- patch
- post
- put
- request

The HTTP request returns a Response Object with all the response data (content, encoding, status, etc), which we save to a variable.
The requests.Response() Object contains the server's response to the HTTP request.
This object contains many properties and methods, which can be used to show any data from the response, for example:
- cookies
- headers
- json
- text
We can configure payload, HTTP method, headers, cookies....

Syntax

```
response=requests.methodname(params)
```

Now, we have a Response object called response. We can get all the information we need from this object using its properties and methods.
For example get json data using JSON method.

```
json_data = response.json()
```

We save JSON data from a response to a variable of DICT type
If we print it, we will see a long line of data.

To print it in a JSON style:

```
print(json.dumps(json_data, indent=4))
```

All next moves are done with DICT variable using regular Python.
Example with basic authentication:

```
import requests
import json

url = "https://10.2.23.2/mgmt/tm/sys/url-db/url-category/Bypass"

payload={}
headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YXBpOkJpem9uMTIzIQ==',
  'Cookie': 'BIGIPAuthCookie=4relC7o3YjPMedF4E9LYfkEDLQpagnalYnapLQE5; BIGIPAuthUsernameCookie=api'
}

response = requests.request("GET", url, headers=headers, data=payload, verify=False)

json_data = response.json()
```

## Python

Docs

- docs.python.org
- https://pymotw.com/3/
- Pep 8 - official python design guide
- https://pypi.org/ - package database

Application:

- Text processing
- JSON  over API
- Config generation based on XML and CSV

Almost everything in Python is an object, with its attributes(properties) and methods

- A variable stored in an instance or class is called an attribute. If an object o has an attribute a it would be referenced as o.a
- A function stored in an instance or class is called a method.
- A method is an attribute, but not all attributes are methods
- Attribute == characteristics. Method == operations/ actions

Attribute is accessed via

```
variable|object.attribute
```

Method is called via

```
object|module|variable.method(params)
```

A Class is like an object constructor, or a "blueprint" for creating objects.

When a Python file is executed as a standalone script, the variable name  __name__ is automatically set to "__main__"

### Modules

- netmiko - SSH client
- napalm - access via API to
	- Arista EOS
	- Cisco IOS
	- Cisco IOS-XR
	- Cisco NX-OS
	- Juniper JunOS
- yaml
- ncclient - for netconf
- requests - for HTTP API

If we want to use a function in different scripts, we can create a module

```
import push
```

Take a look at the imported objects by using dir(push)

```
>>> dir(push)
```

Call function from module

```
push.push_commands(device, commands)
```

push_commands() is then called as an object of push with the parameters device and commands.

Import only one command

```
from push import push_commands
or
from push import push_commands as pc
```

In order  to use this module, or any new module, from anywhere on your system, you need to put your module into a directory defined in your PYTHONPATH

### Methods

Are put after variable

```
caption="router1".upper()
print(caption)
```

### Working with files

```
vlans_file = open('vlans.cfg', 'r')
test=vlans_file.read()
print(test)
vlans_file.close()
```

r - read only
w - wtite only, overwrite file
r+ - reading and writing
a - appending

By default, what you are writing with the write() method is held in a buffer and only written to the file when the file is closed. This setting is configurable.

Add to file

```
add_vlan = {'id': '70', 'name': 'MISC'}
vlans.append(add_vlan)
```

With statement - context manager - automatically closes file

```
with open('vlans_new.cfg', 'w') as write_file:
write_file.write('vlan 10\n')
write_file.write(' name TEST_VLAN\n')
```


### Passing Arguments into a Python Script

The module is called sys, and specifically we’re going to use an attribute (or variable) within the module called argv.

```
import sys
print(sys.argv)
print(sys.argv[0])
```
sys.argv is a list

### For

It can go through

- Strings
- Lists
- Dictionaries

```
for letter in 'Test string':
print(letter)


for i in range(10):
print(f'interface FastEthernet0/{i}')
```

## Data types

Python Collections (Arrays)
There are four collection data types in the Python programming language:

-     List is a collection which is ordered and changeable. Allows duplicate members.
-     Tuple is a collection which is ordered and unchangeable. Allows duplicate members.
-     Set is a collection which is unordered, unchangeable*, and unindexed. No duplicate members.
-     Dictionary is a collection which is ordered** and changeable. No duplicate members.

String

```
nat = "ip nat inside source list ACL interface FastEthernet0/1 overload" - create string variable
print (nat[11]) - print 11th symbol of a string
nat2 = nat.replace('Fast', 'Gigabit')
print (nat2)
```

Take from the string spaces and word

```
id = item.strip().strip('vlan').strip()
```

Dictionaries

- These are key value pairs
- List of dictionaries
- Dictionaries cannot have two items with the same key
- The values in dictionary items can be of any data type: string, int, boolean, list
- Dictionaries are written with curly brackets, and have keys and values

```
thisdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
```

You can access any key in a dict:

```
print(json_data['urls'][0]['name'])
```

json_data is a dict, urls is a list inside it, 0 is the first element(dict) in the list, name is a key in dict :)

```
>>> vlans
[{'id': '10', 'name': 'USERS'}, {'id': '20', 'name': 'VOICE'},
{'id': '30', 'name': 'WLAN'}, {'id': '40', 'name': 'APP'},
{'id': '50', 'name': 'WEB'}, {'id': '60', 'name': 'DB'}]
```

Lists

- List items can be of any data type
- A list can contain different data types
- Duplicates

Initialisation

```
emptylist = []
emptylist2 = list()
```

Can be everything inside

```
list1 = ["abc", 34, True, 40, "male"]
```

Add new URL to a list inside dictionary to the end of the list, no check on unique is done

```
json_data['urls'].append({'name': 'http://www.a.com/', 'type': 'exact-match'})
```

## API

API is just a mechanism that is used for computer software on one device to talk to computer software on another device.

- Northbound - from application to controller
- Southbound - from controller to data plane

- Synchronous - application waits for the reply
- Asynchronous - does not wait for response and continue functioning

Authentication

- Basic - clear text, password is sent in every request, used in F5 API
- API keys - passed in string, request header or cookie, sent with every API call

String:

```
GET /something?api_key=abcdef12345
```

Header, used in Python and Postman

```
GET /something HTTP/1.1
X-API-Key: abcdef12345
```

Cookie

```
GET /something HTTP/1.1
Cookie: X-API-KEY=abcdef12345
```

- Custom tokens - allows a user to enter his or her username and password once and receive a unique auto-generated and encrypted token. Used in F5 API for example, besides Basic auth. We send JSON to a server with login and pass, and we get a token in a response. Then we use this token as a Header in all next requests.

Types:

- Netconf
- Restful HTTP
- Non restful HTTP
- SOAP
- RPC, XML-RPC the most popular

Client:

- CURL
- Postman
- Python requests

REST

- REST API - representational state transfer - has its own principles
- REST is an architectural style
- RESTful - application, which supports it.
- Response to API request is formatted in JSON, XML, HTML
- Many developers describe their APIs as being RESTful, even though these APIs do not fulfill all of the architectural constraints
- REST stands for REpresentational State Transfer and is a style used to design and develop networked applications. Thus, systems that implement and adhere to a REST-based architecture are said to be RESTful.
- That style relies on a stateless client-server model in which the client
keeps track of the session and no client state or context is held on the server. And best yet, the underlying transport protocol used is most commonly HTTP

Netconf

- Use SSH as a transport
- Messages are encoded in XML
- Remote procedure calls (RPCs) are sent
- Based on Juniper CLI
- Uses Yang

SOAP

- SMTP or HTTP as transport
- Exchange data between applications on different languages
- Based on XML

## Data formats

- Data models define the structure for how data is stored in a data format, such as YAML, XML, or JSON
- Using a data model, we could explicitly state that the data in the YAML document must be a key-value list, and that each value must be a string

YAML

- Used in Ansible
- Unfortunately, YAML does not provide any built-in mechanism for describing or enforcing data models. There are third-party tools (one such example is Kwalify). This is one reason why YAML is very suitable for human-to-machine interaction, but not necessarily as well suited for machine-to-machine interaction
- YAML does not use tabs for formatting. Tabs should be replaced with spaces.

```
import yaml
with open("example.yml") as f:
result = yaml.load(f)
print(result)
type(result)
```

XML

- https://www.w3schools.com/xml/
- https://olegmax.readthedocs.io/ru/latest/complete-8.html#elementtree8 – вот по этой ссылке нашел как перебрать все элементы xml документа с помощью getiterator().
- Data formats like XML don’t enforce what kind of data is contained in the various fields and values. To help ensure the right kind of data is in the right XML elements, we have XML Schema Definition (XSD)

```
<device>
<vendor>Cisco</vendor>
<model>Nexus 7700</model>
<osver>NXOS 6.1</osver>
</device>
```

XML elements can also have attributes:

```
<device type="datacenter-switch" />
```

Namespaces can help with this, by defining and leveraging prefixes in the XML document itself, using the xmlns designation:

```
<root>
<e:device xmlns:c="http://example.org/enduserdevices">Palm Pilot</e:device>
<n:device xmlns:m="http://example.org/networkdevices">
<n:vendor>Cisco</n:vendor>
<n:model>Nexus 7700</n:model>
<n:osver>NXOS 6.1</n:osver>
</n:device>
</root>
```

