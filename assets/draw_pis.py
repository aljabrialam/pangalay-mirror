from PIL import Image, ImageDraw
GOLD=(242,194,48); EDGE=(120,84,10)
BANDS=[(106,31,176),(122,15,46),(47,168,79),(242,106,27),(26,167,201),(122,15,46)]
ACC={'o':(242,106,27),'t':(26,167,201),'p':(106,31,176),'g':(47,168,79),'r':(200,40,50)}
PX,PY,BH=32,24,24
SP=["#########","#.......#","#.#####.#","#.#...#.#","#.#.###.#","#.#.....#","#.#######","#........","#........"]
def rot(m):return [''.join(m[len(m)-1-r][c] for r in range(len(m))) for c in range(len(m[0]))]
SPR=[SP,rot(SP),rot(rot(SP)),rot(rot(rot(SP)))]
def diamond(dx,dy,k):
    ax,ay=abs(dx),abs(dy); d=ax+ay
    if d>13: return None
    if d==13: return 'G' if ax%2==0 else None
    if d in(10,11): return 'G'
    if d==8: return ('t' if k%2 else 'g') if ax%2==0 else None
    if d==6: return 'G'
    if d<=4:
        if d==0: return 'o'
        if ax==0 or ay==0: return 't' if d==2 else 'G'
        if ax==ay: return 'G'
        return 'p' if k%2 else 'r'
    return None
def curl(dx,dy):
    if abs(dx)+abs(dy)<=1: return 'o' if (dx,dy)==(0,0) else 'G'
    for q,(ox,oy) in enumerate(((-10,-10),(2,-10),(2,2),(-10,2))):
        x,y=dx-ox,dy-oy
        if 0<=x<9 and 0<=y<9 and SPR[q][y][x]=='#': return 'G'
    return None
def floret(dx,dy,k):
    d=abs(dx)+abs(dy)
    if d==0: return 't' if k%2 else 'o'
    if d==2 and (dx==0 or dy==0): return 'G'
    if d==1: return 'G'
    return None
def cell(x,y):
    i=round(x/PX); j=round(y/PY); dx=x-i*PX; dy=y-j*PY
    v=diamond(dx,dy,i+j) if (i+j)%2==0 else curl(dx,dy)
    if v: return v
    fi=(x-PX//2)//PX; fj=(y-PY//2)//PY          # small florets in the gaps
    return floret(x-(fi*PX+PX//2)-PX//2+PX//2- (PX//2 if False else 0), y-(fj*PY+PY//2)-0, fi+fj) if False else floret((x+PX//2)%PX-PX//2*0-PX//2 if False else ((x-PX//2+PX//2)%PX)-PX//2, 0,0) if False else _fl(x,y)
def _fl(x,y):
    fx=(x-PX//2)%PX; fy=(y-PY//2)%PY
    dx=fx if fx<=PX//2 else fx-PX; dy=fy if fy<=PY//2 else fy-PY
    return floret(dx,dy,(x-PX//2)//PX+(y-PY//2)//PY)
def render(cols,rows,s,x0=0,y0=0):
    im=Image.new('RGB',(cols*s,rows*s)); d=ImageDraw.Draw(im)
    for r in range(rows):
        d.rectangle([0,r*s,cols*s,r*s+s],fill=BANDS[((r+y0)//BH)%len(BANDS)])
    for r in range(rows):
        for c in range(cols):
            v=cell(c+x0,r+y0)
            if v:
                d.rectangle([c*s,r*s,c*s+s-1,r*s+s-1],fill=EDGE if v=='G' else (20,12,10))
                d.rectangle([c*s+1,r*s+1,c*s+s-2,r*s+s-2],fill=GOLD if v=='G' else ACC[v])
    return im
if __name__=='__main__':
    bg=render(214,120,6,x0=5,y0=0).crop((0,0,1280,720)); bg.save('pis-art.png',optimize=True)
    sw=render(60,60,6,x0=34,y0=18); sw.save('pis-sw.png',optimize=True)
    p=Image.new('RGB',(1280+360,720)); p.paste(bg,(0,0)); p.paste(sw,(1280,0)); p.resize((1094,480)).save('me/prev2.png')
