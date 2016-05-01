PImage Img_Title;
PImage Img_Title2;
PImage Img_Title3;
PImage Img_Title4;

PImage Img_End;
PImage Img_End2;

MainGame mg = new MainGame();

boolean[] keys = new boolean[255];
boolean isTitle = true;
boolean isInGame = false;
boolean isGameOver = false;

float Score = 0;

void setup()
{
  Img_Title= loadImage("Title.png");
  Img_Title2= loadImage("Title2.png");
  Img_Title3= loadImage("Title3.png");
  Img_Title4= loadImage("Title4.png");
  Img_End = loadImage("End.png");
  Img_End2 = loadImage("End2.png");
  size(1200,600);
  background(255);
  mg.SetUp();
  mg.m_PlayerJet.SetUpPlayerImage();
}

void draw()
{
  background(0);
  
  if(isTitle)
  {
    imageMode(CENTER);
    image(Img_Title,width/2,height/2-100,500,500);
    image(Img_Title2,width/2,height/2+150,400,40);
    image(Img_Title3,width/2,height/2+30,400,40);
    image(Img_Title4,width/2,height/2+80,400,40);
    imageMode(CORNER);
    
    textAlign(CENTER);
    textSize(20);
    fill(255,255,255,255);
    text("20162627_Minseok Hong" ,width/2,height/2+210);
    textAlign(LEFT);
  }
  
  if(isInGame)
  {
    mg.update();
    updatePlayer();
    if(mg.GameOver == true)
    {
      Score = mg.Score;
      isInGame = false;
      isGameOver = true;
      mg.GameOver = false;
      mg.Clean();
    }
  }
  
  if(isGameOver)
  {
    imageMode(CENTER);
    image(Img_End,width/2,height/2-50,500,200);
    image(Img_End2,width/2,height/2+100,400,40);
    imageMode(CORNER);
    
    textAlign(CENTER);
    textSize(30);
    fill(255,255,255,255);
    text("Your Score : "+ Score ,width/2,height/2+55);
    textAlign(LEFT);
  }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void updatePlayer()
{
  if(keys[UP]){if(mg.m_PlayerJet.y > 0) mg.m_PlayerJet.y -= 10;}
  if(keys[DOWN]){if(mg.m_PlayerJet.y < height-50)mg.m_PlayerJet.y += 10;}
  if(keys[LEFT]){if(mg.m_PlayerJet.x > 50)mg.m_PlayerJet.x -= 10;}
  if(keys[RIGHT]){if(mg.m_PlayerJet.x < width-50)mg.m_PlayerJet.x += 10;}
  if(keys[CONTROL]){mg.m_PlayerJet.FireWeapon();}
}

void mouseClicked()
{
  if(isTitle)
  {
    isTitle = false;
    isInGame = true;
  }
  
  if(isGameOver)
  {
    isGameOver = false;
    isTitle = true;
  }
}