class PlayerJet
{
  PImage PlayerImg[] = new PImage[15];
  PImage PlayerBullet;
  
  int x=0;
  int x_added=50;
  int y=300;
  int y_added=50;
  int Damage;
  int Health = 1000;
  int Life;
  int ImgFrame=0;
  boolean isDead;
  
  float TimeTofire = 0;
  
  ArrayList<PlayerBullet> m_PlayerBullets = new ArrayList<PlayerBullet>();
  
  boolean Up=false,Down=false,Left=false,Right=false;
  
  void SetUpPlayerImage()
  {
    for(int i = 0 ; i < 15 ; i++)
    {
      String ImgName = "Jet"+(i+1)+".png";
      PlayerImg[i] = loadImage(ImgName);
    }
    PlayerBullet = loadImage("JetBullet.png");
  }
  
  void Update()
  {
    UpdateBullet();
    CheckBulletDead();
    ImgFrame = (ImgFrame+1)%15;
    image(PlayerImg[ImgFrame],x,y,x_added,y_added);
  }
  
  void UpdateBullet()
  {
    for(int i = m_PlayerBullets.size() ; i > 0 ; i--)
    {
      PlayerBullet pb = m_PlayerBullets.get(i-1);
      pb.MoveFoward();
      pb.DrawObj();
      pb.CheckBulletDead();
    }
  }
  
  void CheckBulletDead()
  {
    for(int i = m_PlayerBullets.size() ; i > 0 ; i--)
    {
      PlayerBullet eb = m_PlayerBullets.get(i-1);
      if(eb.isDead)
        m_PlayerBullets.remove(i-1);
    }
  }
  
  void FireWeapon()
  {
    if(millis() - TimeTofire > 75)
    {
      TimeTofire = millis();
      m_PlayerBullets.add(new PlayerBullet(x+x_added-30,y+y_added/2+9,PlayerBullet));
      m_PlayerBullets.add(new PlayerBullet(x+x_added-25,y+y_added/2-2,PlayerBullet));
      m_PlayerBullets.add(new PlayerBullet(x+x_added-30,y+y_added/2-11,PlayerBullet));
    }
  }
}