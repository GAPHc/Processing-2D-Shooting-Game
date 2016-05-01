class EnemyBasicInfo
{
  PImage EnemyJet;
  PImage EnemyBullet;
  
  int x;
  int x_added=50;
  int y;
  int y_added=50;
  int Speed = -3;
  
  int Health = 100;
  int BulletDamage;
  int BulletSpeed;
  int ExtraDelay;
  
  boolean isDead = false;
  boolean isDeadOutLine = false;
  
  float TimeToFire = 0;
  
  boolean AttackType_1 = false;
  boolean AttackType_2 = false;
  boolean AttackType_3 = false;
  
  ArrayList<EnemyBullet> m_EnemyBullets = new ArrayList<EnemyBullet>();
  
  void UpdateBullet()
  {
    for(int i = m_EnemyBullets.size() ; i > 0 ; i--)
    {
      EnemyBullet eb = m_EnemyBullets.get(i-1);
      eb.MoveFoward();
      eb.DrawObj();
      eb.CheckBulletDead();
    }
  }
  
  void CheckBulletDead()
  {
    for(int i = m_EnemyBullets.size() ; i > 0 ; i--)
    {
      EnemyBullet eb = m_EnemyBullets.get(i-1);
      if(eb.isDead)
        m_EnemyBullets.remove(i-1);
    }
  }
  
  void CleanBullets()
  {
    for(int i = m_EnemyBullets.size() ; i > 0 ; i--)
        m_EnemyBullets.remove(i-1);
  }
  
}

class Enemy_1 extends EnemyBasicInfo
{
  Enemy_1(float x_1, float y_1, PImage Img, 
  PImage Img_2, int Health_1, int Speed_1, int BulletDamage_1, int BulletSpeed_1, int ExtraDelay_1)
  {
    x=(int)x_1;
    y=(int)y_1;
    TimeToFire = random(1000,2000);
    EnemyJet = Img;
    EnemyBullet = Img_2;
    Health = Health_1;
    Speed = Speed_1;
    BulletDamage = BulletDamage_1;
    BulletSpeed = BulletSpeed_1;
    ExtraDelay = ExtraDelay_1;
  }
  
  void Move()
  {
    x += Speed;
  }
  
  void Draw()
  {
    image(EnemyJet,x,y,x_added,y_added);
  }
  
  void FireWeapon()
  {
    if(millis() - TimeToFire > (2000-ExtraDelay))
    {
      TimeToFire = millis();
      m_EnemyBullets.add(new EnemyBullet(x+10,y+y_added/2,EnemyBullet,BulletDamage,BulletSpeed));
    }
  }
  
  void CheckJetDead()
  {
    if(x+100 < 0 || Health <= 0)
      isDead = true;
    if(x+100 < 0)
      isDeadOutLine = true;
  }
}