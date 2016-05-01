class MainGame
{
  PImage EnemyBulletImg;
  PImage PlayerBulletImg;
  PImage EnemyImg;
  PImage[] JetImages = new PImage[3];
  float Score = 0;
  int EnemyMakeDelay = 0;
  
  PlayerJet m_PlayerJet = new PlayerJet();
  int stars = 100;
  ArrayList starSpeed = new ArrayList();
  
  float TimeToMakeStar = 0;
  
  ArrayList<Enemy_1> m_Enemy1 = new ArrayList<Enemy_1>();
  
  ArrayList<Star> m_Stars = new ArrayList<Star>();
 
  boolean GameOver = false;
  
  void SetUp()
  {
    EnemyBulletImg = loadImage("EnemyBullet.png");
    EnemyImg = loadImage("EnemyJet.png");
  }
 
  void update()
  {
    MakeStar();
    MakeStar();
    Background();
    m_PlayerJet.Update();
    MakeEnemy();
    UpdateEnemy();
    CheckCollision();
    UpdateUI();
    CheckGameOver();
  }
  
  void UpdateUI()
  {
    fill(255,255,255,255);
    textSize(20);
    text("Jet Health ",50,height-75);
    
    noStroke();
    fill(255,255,255,255);
    rect(50,height-50,200,20);
    if(m_PlayerJet.Health > 800)
      fill(0,216,255,255);
    else if(m_PlayerJet.Health <= 800 && m_PlayerJet.Health > 400)
      fill(29,219,22,255);
    else if(m_PlayerJet.Health <= 400 && m_PlayerJet.Health > 200)
      fill(255,228,0,255);
    else
      fill(255,0,0,255);
    rect(50,height-50,m_PlayerJet.Health/5,20);
    stroke(255);
    
    textSize(30);
    fill(29,219,22,255);
    text("Score : "+ Score,50,50);
  }
 
  void MakeEnemy()
  {
    int rnd = (int)random(0,1000);
    if(rnd > (965-EnemyMakeDelay))
    {
      if(Score < 500)
        m_Enemy1.add(new Enemy_1(width+20,random(0,height-100),EnemyImg,EnemyBulletImg,100,-3,50,-10,0));
      else if(Score >= 500 && Score < 1000)
        m_Enemy1.add(new Enemy_1(width+20,random(0,height-100),EnemyImg,EnemyBulletImg,200,-5,50,-10,250));
      else if(Score >= 1000 && Score < 2000)
        m_Enemy1.add(new Enemy_1(width+20,random(0,height-100),EnemyImg,EnemyBulletImg,300,-8,75,-15,500));
      else if(Score >= 2000 && Score < 3000)
        m_Enemy1.add(new Enemy_1(width+20,random(0,height-100),EnemyImg,EnemyBulletImg,400,-8,75,-15,750));
      else if(Score >= 3000 && Score < 4500)
        m_Enemy1.add(new Enemy_1(width+20,random(0,height-100),EnemyImg,EnemyBulletImg,500,-10,100,-20,1000));
      else
        m_Enemy1.add(new Enemy_1(width+20,random(0,height-100),EnemyImg,EnemyBulletImg,800,-10,100,-25,1250));
    }
    
    if(Score > 1500)
    {
      if(Score > 3000)
        EnemyMakeDelay = 40;
      else
        EnemyMakeDelay = 15;
    }
    else
      EnemyMakeDelay = 0;
  }
  
  void UpdateEnemy()
  {
    for(int i = m_Enemy1.size() ; i > 0 ; i--)
    {
      Enemy_1 e1 = m_Enemy1.get(i-1);
      e1.Draw();
      e1.Move();
      e1.FireWeapon();
      e1.UpdateBullet();
      e1.CheckBulletDead();
      e1.CheckJetDead();
      
      if(e1.isDead)
      {
        e1.CleanBullets();
        m_Enemy1.remove(i-1);
        if(!e1.isDeadOutLine)
          Score += 50;
      }
    }
  }
  
  void CheckCollision()
  {
    for(int i = m_Enemy1.size(); i > 0 ; i--)
    {
      Enemy_1 e1 = m_Enemy1.get(i-1);
      for(int j = m_PlayerJet.m_PlayerBullets.size(); j > 0 ; j--)
      {
        PlayerBullet pb = m_PlayerJet.m_PlayerBullets.get(j-1);
        if(pb.x > e1.x && pb.x < e1.x+ e1.x_added &&
        pb.y > e1.y && pb.y < e1.y +  e1.y_added)
        {
          pb.isDead = true;
          e1.Health -= pb.Damage;
        }
      }
    }
    
    for(int i = m_Enemy1.size() ; i > 0 ; i--)
    {
      Enemy_1 e1 = m_Enemy1.get(i-1);
      for(int j = e1.m_EnemyBullets.size() ; j > 0 ; j--)
      {
        EnemyBullet eb = e1.m_EnemyBullets.get(j-1);
        if(eb.x > m_PlayerJet.x && eb.x < m_PlayerJet.x + m_PlayerJet.x_added
        && eb.y > m_PlayerJet.y && eb.y < m_PlayerJet.y + m_PlayerJet.y_added)
        {
          eb.isDead = true;
          m_PlayerJet.Health -= eb.Damage;
        }
      }
    }
  }
  
  void Background()
  {
    for(int i = m_Stars.size(); i > 0 ; i--)
    {
      Star st = m_Stars.get(i-1);
      st.Move();
      st.DrawObj();
      st.CheckDead();
      st.CheckSize();
      
      if(st.isDead)
        m_Stars.remove(i-1);
    }
  }
  
  void MakeStar()
  {
     int rnd = (int)random(0,1000);
     if(rnd > 400)
       m_Stars.add(new Star(width+20,random(0,height)));
  }
  
  void CheckGameOver()
  {
    if(m_PlayerJet.Health <= 0)
      GameOver = true;
  }
  
  void Clean()
  {
    m_PlayerJet.Health = 1000;
    Score = 0;
    
    for(int i = m_PlayerJet.m_PlayerBullets.size() ; i > 0 ; i--)
      m_PlayerJet.m_PlayerBullets.remove(i-1);
      
    for(int i = m_Enemy1.size() ; i > 0 ; i--)
    {
      Enemy_1 e1 = m_Enemy1.get(i-1);
      e1.CleanBullets();
      m_Enemy1.remove(i-1);
    }
    
    for(int i = m_Stars.size() ; i > 0 ; i--)
    {
      m_Stars.remove(i-1);
    }
  }
}