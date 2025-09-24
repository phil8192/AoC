NB. file pre-prepared by replacing blanks with _1 and adding _1 to end: 
NB. cat input.txt |sed 's/^$/_1/;' |tr '\n' ' ' |sed 's/$/_1/' >x.txt

NB. run: ./jconsole.sh, then loadd'sol.ijs'

readfile=:1!:1        NB. read file function: https://www.jsoftware.com/help/primer/files.htm
x=.".readfile<'x.txt' NB. read file in as ints

NB. solution:
s=.+/;._2 x           NB. group then sum groups: https://www.jsoftware.com/help/primer/cut.htm
{.|./:~s              NB. answer 1: sort s, reverse, head -1
+/3{.|./:~s           NB. answer 2: same as 1, except sum head -3

NB. see https://www.jsoftware.com/help/dictionary/d010.htm (box <;)
NB.   0 1{ <;._2 x
NB. ┌──────────┬──────────────────────────────────────────────────────┐
NB. │17998 7761│5628 1490 4416 2606 2828 4615 3206 7218 4793 5199 2129│
NB. └──────────┴──────────────────────────────────────────────────────┘

NB. 30 chars!
