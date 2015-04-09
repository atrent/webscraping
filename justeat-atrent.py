import bs4
import sys

if __name__=="__main__":
    path=sys.argv[1]

    with open(path, "r") as f:
        data=f.read()
        soup=bs4.BeautifulSoup(data)
        selector=".restaurantCuisines"
        for c in soup.select(selector):
			print [j.strip() for j in c.text.split(",")]
			print "-------------------"

