
PVector[] poly;
int n = 7;
Grid grid;

void setup() {
  size(640, 360); 
  noStroke();
  //rectMode(CENTER);
  
  
  
  poly = new PVector[n];
  
  makeNGon(poly, new PVector(320, 180), 160);
  
  grid = new Grid(20, 30, 16);
  
}

void draw() {
  /*
  for(int i = 0; i < n; i++)
  {
   for(int j = 0; j < n; j++)
   {
     if ( i == j )
       continue;
       
     arrow(poly[i], PVector.sub(poly[j], poly[i]), 5, 0);
   }
  }
  */
  background(150);
  
  grid.wind(new PVector(5, 5));
  grid.draw();
  
}

void makeNGon(PVector[] buf, PVector c, float r)
{
  float theta = 0;
  float delta = (1f / n) * 2 * PI;
  for(int i = 0; i < n; i++)
  {
    buf[i] = PVector.add(PVector.mult(new PVector(cos(theta), sin(theta)), r), c);
    theta += delta;
  }
}

void arrow(PVector pos, PVector dir, int stroke, float clamp)
{
  float headangle = radians(25f);
  float headscale = 4;
  
  //body
  stroke(0);
  strokeWeight(stroke);
  if (clamp > 0 && dist(dir.x, dir.y, pos.x, pos.y) > clamp){
    dir = PVector.mult(dir, clamp / dir.mag());
  }
  PVector head = PVector.add(dir, pos);
  line(pos.x, pos.y, head.x, head.y);
  
  
  //head
  
  float angle = atan2(dir.y, dir.x);
  float ang1 = angle + PI - headangle;
  float ang2 = angle + PI + headangle;
  
  line(head.x, head.y, head.x + (dir.mag() / headscale * cos(ang1)), head.y + (dir.mag() / headscale * sin(ang1)));
  line(head.x, head.y, head.x + (dir.mag() / headscale * cos(ang2)), head.y + (dir.mag() / headscale * sin(ang2)));
}

class CellFlow{
  
  //
  //Positive == outward flow
  //
  
  int t, b, l, r;
  public CellFlow(){};
  public CellFlow(int t, int b, int l, int r)
  {
     this.t = t; this.b = b; this.l = l; 
  }
}

class Grid
{
  float cellSize;
  int sizeX; int sizeY;
  
  PVector[] centers;
  PVector[] vel;
  CellFlow[] flow;
  
  public Grid(float cellSize, int sizeX, int sizeY)
  {
    this.cellSize = cellSize; this.sizeX = sizeX; this.sizeY = sizeY;
    
    centers = new PVector[sizeX * sizeY];
    vel = new PVector[sizeX * sizeY];
    flow = new CellFlow[sizeX * sizeY];
    
    for(int i = 0; i < centers.length; i++)
    {
      flow[i] = new CellFlow();
      centers[i] = new PVector((cellSize * (i % sizeX)) + (cellSize/2), cellSize * floor(i / sizeX) + (cellSize / 2));
      
      vel[i] = PVector.mult(new PVector(cos(random(0,2*PI)), sin(random(0,2*PI))), cellSize * 0.8f);
    }
    
  }
  
  Addsource(PVector pos, PVector direction){
    s
  }
  
  public void wind(PVector direction)
  {
    direction.normalize();
    float heading = direction.heading();
    float delta;
    
    for(int i = 0; i < centers.length; i++)
    {
      delta = random(-PI/4, PI/4);
      vel[i] = PVector.mult(PVector.fromAngle(heading + delta), cellSize);
      
    }
  }
  
  public void draw()
  {
    for(int i = 0; i < centers.length; i++)
    {
      arrow(centers[i], vel[i], 1, 0);
    }
  }
}
