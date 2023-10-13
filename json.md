# JSON

- JavaScript Object Notation
- Appeared in early 2000
- To substitute XML, which is too bloated
- Based on a collection of name/value pairs(an object) and an ordered list of values(an array)
- A value can be a string in double quotes, or a number, or true or false or null, or an object or an array. These structures can be nested.
- An object begins with {left brace and ends with }right brace. Each name is followed by :colon and the name/value pairs are separated by ,comma.
- An array is an ordered collection of values. An array begins with [left bracket and ends with ]right bracket. Values are separated by ,comma.    
- Data is in name/value pairs
- Data is separated by commas
- Curly braces hold objects
- Square brackets hold arrays
- JSON names require double quotes.
---
Example:
```
{
"hostname": "CORESW01",
"vendor": "Cisco",
"isAlive": true,
"uptime": 123456,
"users": {
"admin": 15,
"storage": 10,
},
"vlans": [
{
"vlan_name": "VLAN30",
"vlan_id": 30
},
{
"vlan_name": "VLAN20",
"vlan_id": 20
}
]
}
```

---

## json.loads
- If you have a JSON string, you can parse it by using the json.loads() method.
- The result will be a Python dictionary.

---

## json.dumps
We use it to convert Python object into a strict JSON format and then send it to a server as a payload.
```
payload = json.dumps({
  "name": "vs10",
  "destination": "192.168.184.230:80",
  "mask": "255.255.255.255"
})
```
You can convert Python objects of the following types, into JSON strings:
- dict
- list
- tuple
- string
- int
- float
- True
- False
- None

The json.dumps() method has parameters to make it easier to read the result:

```
print(json.dumps(json_data, indent=4))
```

---

## Example

```
import json

with open("json-example.json") as f:
data = f.read()

# json_dict is a dictionary, and json.loads takes care of
# placing our JSON data into it.
json_dict = json.loads(data)

print("Now printing each item in this document and the type it contains")
for k, v in json_dict.items():
print("-- The key {0} contains a {1} value.".format(str(k), str(type(v)))
)
```
