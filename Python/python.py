import netmiko

### String
print ("hello world") #quotes are mandatory
nat = "ip nat inside source list ACL interface FastEthernet0/1 overload" #create string variable
print (nat[11]) #print 11th symbol from string

#Show type of the variable
print(type(nat))
# Outputs:
# The variable, name is of type:  <class 'str'>
# The variable, score is of type: <class 'float'>  
# The variable, lessons is of type:  <class 'list'>
# The variable, person is of type:  <class 'dict'> 
# The variable, langs is of type:  <class 'tuple'> 
# The variable, basics is of type:  <class 'set'>  

nat2 = nat.replace('Fast', 'Gigabit') #Replace in nat string
print (nat2)

###List
config = "switchport trunk allowed vlan 1,3,10,20,30,100"
commands = config.split(" ") #split based on space and creates a list
print (commands)
print (commands[-1]) #print penultimate member of a list
vlans = commands[-1].split(",") #split based on comma
print (vlans)

vlans = [10, 20, 30, 50] #create a list
list1 = list('router') #create a list
print (list1)
print (list1[1])

###Dictionaries
london = {'name': 'London1', 'location': 'London Str', 'vendor': 'Cisco'}
london = {
    'id': 1,
    'name': 'London',
    'it_vlan': 320,
    'user_vlan': 1010,
    'mngmt_vlan': 99,
    'to_name': None,
    'to_id': None,
    'port': 'G1/0/11'
}
print (london['name'])
london['vendor'] = 'Cisco'
print (london)

#Work with arguments
from sys import argv
print (argv[1])
#0 argument is the name of script itself

#Request data from user
protocol = input('Твой любимый протокол маршрутизации? ')

#Work with print
#Print 3 new lines and 30 -
print('\n''\n''\n' + '-' * 30)

###Methods
#Show all available methods for a variable or object
print("Methods for london:")
print(dir(london))


#Upper method
caption="router1".upper()
print(caption)

#Working wih files
vlans_file = open('vlans.cfg', 'r')
test=vlans_file.read()
print(test)
vlans_file.close()

print(__name__)

import sys
print(sys.argv)
print(sys.argv[0])
