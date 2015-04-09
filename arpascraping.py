import bs4
import sys
import numpy as np
if __name__=="__main__":
    path=sys.argv[1]

    with open(path, "r") as f:
        data=f.read()
        soup=bs4.BeautifulSoup(data)
        selector=".tableDati tr"
        res=[]
        intestazione=soup.select("td.tdIntestazioneInqunati")
        intestazione=[x.text.strip() for x in intestazione]
        for c in soup.select(selector)[10::2]:

                name=c.a.text.strip()
                vals=[str(list(val)[0].strip()) for val in c.find_all("p")]

                res.append( {"name":name,"vals":dict(zip(intestazione,vals))})


    print res

