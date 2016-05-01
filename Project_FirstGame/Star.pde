class Star
{
  int x;
  int y;
  
  float SizeX = 10;
  float SizeY = 4;
  float TimeToChange = 0;
  boolean SizeUp = false;
  boolean isDead = false;
  
  Star(float x1, float y1)
  {
    x = (int)x1;
    y = (int)y1;
    TimeToChange = random(0,500);
  }
  
  void Move()
  {
    x-= 20;
  }
  
  void CheckDead()
  {
    if(x+20 < 0)
      isDead = true;
  }
  
  void DrawObj()
  {
     noStroke();
     fill(255,255,255,100);
     rect(x,y,SizeX,SizeY);
     stroke(255);
  }
 
  void CheckSize()
  {
     if(SizeUp == true)
       SizeX++;
     else
       SizeX--;
       
     if(millis() - TimeToChange > 500)
     {
       TimeToChange = millis();
       if(SizeUp)
         SizeUp = false;
       else
         SizeUp = true;
     }
  }
}