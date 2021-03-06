float bx;
float by;
float bdx;
float bdy;
boolean bAlive;
int bDeath;
int[]bDir;
int[] bRevDir;
boolean binSpawn;
int bTargetX;
int bTargetY;
final int bspawnx = 464;
final int bspawny = 432+shiftDown;
final int bspawnx2 = 464;
final int bspawny2 = 464+shiftDown;

public class Blinky extends Ghost{
  public Blinky(float startx,float starty,float sdx, float sdy){
    bx = startx;
    by = starty;
    bdx = sdx;
    bdy = sdy;
    bAlive = true;
    bDir = new int[]{1};
    bTargetX = pacMan.xToCor(getX());
    bTargetY = pacMan.yToCor(getY());
    bRevDir = new int[]{3};
    binSpawn = false;
  } 
   public void display(){
     if (bAlive){
       if(pTimer>0){
         image(s,bx,by,32,32);
       }else{
         image(b,bx,by,32,32);
       } 
     } else {
      //code that displayes the image for a set of eyeballs
      image(e,bx,by,32,32);
    }
     
   }
  
   void Gmove(){
     if (bx > 352 && bx < 544 && by > 416 + shiftDown && by < 544 + shiftDown) {
       setAlive(true);
       setSpawn(true);
     }
     
     if(binSpawn){
       out(bDir[0]);
     }else{
       if (bAlive){
     if(pTimer>0){
       bDir[0] = changeDir();
     } else{
       if (!scatterMode) {
       bestMove();
       } else {
         scatter();
       }
     }
     } else {
       bestMove();
     }
     }
     if(bDir[0]==1){
      if(xToCor(bx)<=0){
         bx = 895;
       }
     }
     if(bDir[0]==3){
       if(xToCor(bx)>=27){
         bx = 1;
       }
     }
     if(bx%gridSize==16 && (by-shiftDown)%gridSize==16){
     if (bDir[0]==0){
       wGMove();
     }
     if (bDir[0]==1){
       aGMove();
     }
     if (bDir[0]==2){
       sGMove();
     }
     if (bDir[0]==3){
       dGMove();
     }
     }
     bx+=bdx;
     by+=bdy;
   }
   void wGMove(){
     int ycor = yToCor(by - bdy - (gridSize / 2)-1.5);//checks if cord + 16 is wall
     int xcor = xToCor(bx - bdx);

     //centers when turning
    if((bx%gridSize)!=gridSize/2){
       bx = (xToCor(bx)*gridSize+16);
     }
     
     if (!(board[ycor][xcor] == 1)){
       if (bAlive) {
       if (!(board[ycor][xcor] == 8)) {
       bRevDir[0] = 2;
       if(level<3 && bAlive){
          bdy = -((level+1)/2*2*gridSize) / 64;
          bdx = 0;
       }else{
          bdy = -(2*2*gridSize)/64;
          bdx = 0;
       }
       }
       } else {
      if (!(board[ycor][xcor] == 8)) {
       bRevDir[0] = 2;
       if(level<3 && bAlive){
          bdy = -((level+1)/2*2*gridSize) / 64;
          bdx = 0;
       }else{
          bdy = -(2*2*gridSize)/64;
          bdx = 0;
       }
       }
       }
       
       
     }
   }
   void aGMove(){
     int xcor = xToCor(bx - bdx - (gridSize / 2));
     int ycor = yToCor(by - bdy);
    if((by-shiftDown)%gridSize!=gridSize/2){
       bdy = yToCor(by)*gridSize+shiftDown+16;
     }
     //exits
     if (!(board[ycor][xcor] == 1)){
       if (bAlive) {
       if (!(board[ycor][xcor] == 8)) {
       bRevDir[0] = 3;
       if(level<3 && bAlive){
          bdy = 0;
          bdx = -((level+1)/2*2*gridSize) / 64;
       }else{
          bdy = 0;
          bdx = -(2*2*gridSize) / 64;
       }
     }
       } else {
         bRevDir[0] = 3;
       if(level<3 && bAlive){
          bdy = 0;
          bdx = -((level+1)/2*2*gridSize) / 64;
       }else{
          bdy = 0;
          bdx = -(2*2*gridSize) / 64;
       }
       }
     }
   }
   void sGMove(){
     int ycor = yToCor(by + bdy + (gridSize / 2));
     int xcor = xToCor(bx - bdx);
     
     if(bx%gridSize!=gridSize/2){
       bx = xToCor(bx)*gridSize+16;
     }
     
     if (!(board[ycor][xcor] == 1)){
       if (bAlive) {
         if (!(board[ycor][xcor] == 8)) {
       bRevDir[0] = 0;
       if(level<3 && bAlive){
          bdy = ((level+1)/2*2*gridSize) / 64;
          bdx = 0;
       }else{
          bdy = (2*2*gridSize)/64;
          bdx = 0;
       }
         }
       } else {
         bRevDir[0] = 0;
       if(level<3 && bAlive){
          bdy = ((level+1)/2*2*gridSize) / 64;
          bdx = 0;
       }else{
          bdy = (2*2*gridSize)/64;
          bdx = 0;
       }
       }
     }
   }
   void dGMove(){
     int xcor = xToCor(bx + bdx + (gridSize / 2));
     int ycor = yToCor(by - bdy);
     
     if((by-shiftDown)%gridSize!=gridSize/2){
       by = (yToCor(by)*gridSize+shiftDown+16);
     }
     //exits
     if (!(board[ycor][xcor] == 1)){
       if (bAlive) {
         if (!(board[ycor][xcor] == 8)) {
       bRevDir[0] = 1;
       if(level<3 && bAlive){
          bdy = 0;
          bdx = ((level+1)/2*2*gridSize) / 64;
       }else{
          bdy = 0;
          bdx = (2*2*gridSize)/64;
       }
         }
       } else {
         bRevDir[0] = 1;
       if(level<3 && bAlive){
          bdy = 0;
          bdx = ((level+1)/2*2*gridSize) / 64;
       }else{
          bdy = 0;
          bdx = (2*2*gridSize)/64;
       }
       }
     }
   }
    public int xToCor(float x){
     return (int)(x / gridSize);
   }
   public int yToCor(float y){
     return (int)((y-shiftDown) / gridSize);
   }
  int changeDir(){
     ArrayList<Integer>canGo = new ArrayList<Integer>();
     if (bDir[0] == 0){
       if((by-shiftDown)%32==16 && gCanGoThere(0)){
         canGo.add(0);
       }
       if((by-shiftDown)%32==16 && gCanGoThere(1)){
         canGo.add(1);
       }
       if((by-shiftDown)%32==16 && gCanGoThere(3)){
         canGo.add(3);
       }
     }
     if (bDir[0] == 1){
       if(bx%32==16 && gCanGoThere(0)){
         canGo.add(0);
       }
       if(bx%32==16 && gCanGoThere(1)){
         canGo.add(1);
       }
       if(bx%32==16 && gCanGoThere(2)){
         canGo.add(2);
       }
     }
     if (bDir[0] == 2){
       if((by-shiftDown)%32==16 && gCanGoThere(2)){
         canGo.add(2);
       }
       if((by-shiftDown)%32==16 && gCanGoThere(1)){
         canGo.add(1);
       }
       if((by-shiftDown)%32==16 && gCanGoThere(3)){
         canGo.add(3);
       }
     }
     if (bDir[0] == 3){
       if(bx%32==16 && gCanGoThere(0)){
         canGo.add(0);
       }
       if(bx%32==16 && gCanGoThere(2)){
         canGo.add(2);
       }
       if(bx%32==16 && gCanGoThere(3)){
         canGo.add(3);
       }
     }
     //choose randomly out of the possible directions
     if(canGo.size()>0){
       return canGo.get((int)(Math.random()*(canGo.size())));
     }else{
       return bDir[0];
     }
   }
   
   boolean gCanGoThere(int dir){
     if (bAlive) {
     if (dir == 0) {
       return (board[yToCor(by)-1][xToCor(bx)] != 1 && board[yToCor(by) - 1][xToCor(bx)] != 8);
     } else if (dir == 1 && xToCor(bx) - 1>-1) {
       return (board[yToCor(by)][xToCor(bx) - 1] != 1 && board[yToCor(by)][xToCor(bx)-1] != 8);
     } else if (dir == 2) {
       return (board[yToCor(by) + 1][xToCor(bx)] != 1 && board[yToCor(by) + 1][xToCor(bx)] != 8);
     } else if (dir == 3 && xToCor(bx)+1<28) {
       return (board[yToCor(by)][xToCor(bx) + 1] != 1 && board[yToCor(by)][xToCor(bx)+1] != 8);
     }     
   } else {
     if (dir == 0) {
       return (board[yToCor(by)-1][xToCor(bx)] != 1);
     } else if (dir == 1 && xToCor(bx) - 1>-1) {
       return (board[yToCor(by)][xToCor(bx) - 1] != 1);
     } else if (dir == 2) {
       return (board[yToCor(by) + 1][xToCor(bx)] != 1);
     } else if (dir == 3 && xToCor(bx)+1<28) {
       return (board[yToCor(by)][xToCor(bx) + 1] != 1);
     }     
   }
     return false;
   }
   boolean gCanGoThere2(int dir){
     if (dir == 0) {
       return (board[yToCor(by)-1][xToCor(bx)] != 1);
     } else if (dir == 1 && xToCor(bx) - 1>-1) {
       return (board[yToCor(by)][xToCor(bx) - 1] != 1);
     } else if (dir == 2) {
       return (board[yToCor(by) + 1][xToCor(bx)] != 1);
     } else if (dir == 3 && xToCor(bx)+1<28) {
       return (board[yToCor(by)][xToCor(bx) + 1] != 1);
     }     
     return false;
   }
   public float getX(){
     return bx;
   }
   public float getY(){
     return by;
   }
   public float getDx(){
     return bdx;
   }
   public float getDy(){
     return bdy;
   }
   public int getDir(){
     return bDir[0];
   }
   public void setDir(int d){
     bDir[0] = d;
   }
   public void setAlive(boolean a){
     bAlive = a;
   }
   public boolean isAlive(){
    return bAlive;
  }
   void setX(float x){
     bx = x;
   }
   void setY(float y){
     by = y;
   }
   void setDx(float speed){
     bdx = speed;
   }
   void setDy(float speed){
     bdy = speed;
   }
   void setDTimer(int s){
     bDeath = s;
   }
   public int getDTimer(){
     return bDeath;
   }
   public float getSpawnX(){
     return bspawnx2;
   }
   public float getSpawnY(){
     return bspawny2;
   }
   void setSpawn(boolean a){
     binSpawn = a;
   }
   public void bestMove() {
     float shortest = 10000; //placeholder, no distance can be greater than 10000 in the game
     int direction = bDir[0];
     int nextGridX = 0;
     int nextGridY = 0;
     float temp = 0;
     for (int i = 0; i < 4; i++) {
       if (i != bRevDir[0] && gCanGoThere(i)) {
         if(i == 0){
           nextGridX = 0;
           nextGridY = -gridSize;
         }
         if(i == 1){
           nextGridX = -gridSize;
           nextGridY = 0;
         }
         if(i == 2){
           nextGridX = 0;
           nextGridY = gridSize;
         }
         if(i == 3){
           nextGridX = gridSize;
           nextGridY = 0;
         }
         if (bAlive) {
         temp = dist(bx+nextGridX,(by-shiftDown)+nextGridY,pacMan.getX(),pacMan.getY());
         } else { 
           temp = dist(bx+nextGridX,(by-shiftDown)+nextGridY,getSpawnX(),getSpawnY());
         }
         if (temp < shortest) {
           shortest = temp;
           direction = i;
         }
       }
     }
     bDir[0] = direction;
   }
   public void out(int dir){
     float shortest = 10000; //placeholder, no distance can be greater than 10000 in the game
     int direction = dir;
     int nextGridX = 0;
     int nextGridY = 0;
     float temp = 0;
     if(by == 368+shiftDown && bx == 432){
       binSpawn = false;
     } 
     for (int i = 0; i < 4; i++) {
       if (i != bRevDir[0] && gCanGoThere2(i)) {
         if(i == 0){
           nextGridX = 0;
           nextGridY = -gridSize;
         }
         if(i == 1){
           nextGridX = -gridSize;
           nextGridY = 0;
         }
         if(i == 2){
           nextGridX = 0;
           nextGridY = gridSize;
         }
         if(i == 3){
           nextGridX = gridSize;
           nextGridY = 0;
         }
         temp = dist(bx+nextGridX,(by-shiftDown)+nextGridY,432,368+shiftDown);
         if (temp < shortest) {
           shortest = temp;
           direction = i;
         }
       }
     }
     bDir[0] = direction;
   }
   
   public int getRevDir() {
     return bRevDir[0];
   }
   
   
   public void setRevDir(int d) {
     bRevDir[0] = d;
   }
   
   public void scatter() {
     float shortest = 10000; //placeholder, no distance can be greater than 10000 in the game
     int direction = cDir[0];
     int nextGridX = 0;
     int nextGridY = 0;
     float temp = 0;
     for (int i = 0; i < 4; i++) {
       if (i != bRevDir[0] && gCanGoThere(i)) {
         if(i == 0){
           nextGridX = 0;
           nextGridY = -gridSize;
         }
         if(i == 1){
           nextGridX = -gridSize;
           nextGridY = 0;
         }
         if(i == 2){
           nextGridX = 0;
           nextGridY = gridSize;
         }
         if(i == 3){
           nextGridX = gridSize;
           nextGridY = 0;
         }
         
         temp = dist(bx+nextGridX,(by-shiftDown)+nextGridY,870,50);
         if (temp < shortest) {
           shortest = temp;
           direction = i;
         }
       }
     }
     bDir[0] = direction;
   }
}
