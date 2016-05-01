class BulletBaseInfo
{
  PImage BulletImg;
  
  int x=0;
  int x_added=20;
  int y=0;
  int y_added=5;
  int Damage = 50;
  int Speed = 20;
  boolean isGuided;
  boolean isDead = false;
}

class EnemyBullet extends BulletBaseInfo
{
  EnemyBullet(int x1, int y1, PImage img, int Damage_1, int Speed_1)
  {
    x = x1;
    y = y1;
    BulletImg = img;
    Damage = Damage_1;
    Speed = Speed_1;
  }
  
  void MoveFoward()
  {
    x+= Speed;
  }
  
  void CheckBulletDead()
  {
    if(x+100 < 0)
      isDead = true;
  }
  
  void DrawObj()
  {
    image(BulletImg,x,y,x_added,y_added);
  }
}

class PlayerBullet extends BulletBaseInfo
{
  PlayerBullet(int x1, int y1, PImage img)
  {
    x = x1;
    y = y1;
    BulletImg = img;
  }
  
  void MoveFoward()
  {
    x+= Speed;
  }
  
  void CheckBulletDead()
  {
    if(x > width+100)
      isDead = true;
  }
  
  void DrawObj()
  {
    image(BulletImg,x,y,x_added,y_added);
  }
}