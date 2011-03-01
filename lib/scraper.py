#!/usr/bin/env python
#Moses Nakamura
import re
import urllib


#all of the js files that have the information we need
links=["http://www.columbia.edu/acis/facilities/printers/ninja/acis/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/barnard/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/cait/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/lso/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/meche/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/old_pcd/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/soa/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/ssw/js/printers.js"]

searcher = re.compile(r"\[([^\]]*)\];")
lst=[]

#scrapes the files, puts the information into lists in lists
for link in links:
    filep = urllib.urlopen(link)
    for line in filep:
        matched = searcher.search(line)
        if matched:
            #note: the strings are surrounded by the character ", 
            #which is actually pretty useful.  Don't need to change this.
            lst.append(matched.group(1).split(","))



#organizes the information nicely
towrite = ["printers:\n"]

for line in lst:
    towrite.append("  - name: "+line[0]+"\n")
    towrite.append("    address: "+line[1]+"\n")
    towrite.append("    driver: "+line[2]+"\n")
    towrite.append("    place: "+line[3]+"\n")
    towrite.append("\n")

#writes it into the correct format in newprinter.yaml file
filep = open("newprinter.yaml","w")
filep.writelines(towrite)



