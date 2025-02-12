// Step 0: add your images and gifs
import gifAnimation.*;

Gif catGif; //type Gif then your Gif <name>;
Gif catDancing;

PImage cskDuck; // for images, type PImage <name>;

//----------------------------------------------------------------------

// Step 1: Give a hex color for the front page
color frontPageColor = #ffffff; //look up hex codes for pink, white, and red... or anything!

// Step 2: Give a hex color for the "Open Card" and "Back" buttons
color buttonColor = #000000;

// Step 3: Give a hex color for the "inside" page of the card
color backPageColor = #FFFFFFFF;

// Step 4: Give a hex color for the "Yes" and "No" buttons
color yesButtonColor = #000000;

//leave these here!
boolean buttonClicked = false;
boolean yesButtonClicked = false;
boolean noButtonClicked = false;
ArrayList<ConfettiParticle> confettiParticles = new ArrayList<ConfettiParticle>();

//----------------------------------------------------------------------
//this is your front of card and the function you will call to close the card
void setup() {
  size(600, 400); // (width, height)
  background(frontPageColor);
  
  // Load the gifs (replace "catImage.gif" with your actual file name)
  catGif = new Gif(this, "catGif.gif");  // Load the GIF
  catGif.play();  // Start playing
  
  catDancing = new Gif(this, "catDancing.gif");  // Load the GIF
  catDancing.play();  // Start playing
  
  cskDuck = loadImage("cskDuck.png"); //load the image

  
  // Draw message on the front of the card
  fill(123);  // color for text
  textSize(24);
  textAlign(CENTER, CENTER);
  textFont(createFont("Arial", 25)); //Try some of these fonts! Comis Sans MS, Times New Roman, American Typewriter, Arial Black
  text("here is my valentines day card!", 300, 200); //write text, you can duplicate and change y value to stack


  // Draw red rectangle button on front page
  fill(buttonColor);
  rect(250, 260, 100, 40);
  
  // Add text to the button
  fill(255);  // White color for text
  textSize(12);
  textAlign(CENTER, CENTER);

// Step 8: Write the message you would like on the button to open the card
  text("open card!", 300, 280);
  
// draw your image(s)
  image(cskDuck, 250, 50, 125, 100); 
}

void draw() {
  if (buttonClicked) {
    background(backPageColor);

    // Draw back button
    fill(buttonColor);
    rect(25, 25, 50, 25);
    
    // Add text to the back button
    fill(255);  // White color for text
    textSize(10);
    textAlign(CENTER, CENTER);
// Step 9: Write the message you would like on the button to close the card
    text("close :(", 50, 37.5);


    // Add "valentine?" message
    fill(#FF8DA1);  // color
    textSize(24);
    textAlign(CENTER, CENTER);
    text("be my valentine?", width / 2, 180);
    
    // Draw Yes and No buttons
    drawYesNoButtons();
    
    // If "Yes" button is clicked, trigger confetti effect
    if (yesButtonClicked) {
      image(catDancing, 150, 50, 300, 300); 
      //confettiPop();
      //yesButtonClicked = false;
    }
    
    if (noButtonClicked) {
      image(catGif, 150, 50, 300, 300); 
    }
        
    // Display and update confetti particles
    for (int i = confettiParticles.size() - 1; i >= 0; i--) {
      ConfettiParticle particle = confettiParticles.get(i);
      particle.update();
      particle.display();
      if (particle.isOffscreen()) {
        confettiParticles.remove(i);
      }
    }
  }
}

void mousePressed() {
  if (buttonClicked) {
    // Check if the mouse is clicked inside the back button
    if (mouseX > 25 && mouseX < 75 && mouseY > 25 && mouseY < 50) {
      buttonClicked = false;
      noButtonClicked = false;
      yesButtonClicked = false;
      confettiParticles.clear();
      setup(); 
      
    }
  } else {
    // Check if the mouse is clicked inside the open card button
if (mouseX > 250 && mouseX < 350 && mouseY > 260 && mouseY < 300) {
      buttonClicked = true;
    }
  }

  int buttonWidth = 80;
  int buttonHeight = 40;
  int spacing = 20;
  int centerX = width / 2;
  int yesX = centerX - buttonWidth - spacing / 2;
  int noX = centerX + spacing / 2;
  int buttonY = (height / 2) + 75; // Adjusted to match drawn buttons

  // Check if the mouse is clicked inside the Yes button
  if (buttonClicked && mouseX > yesX && mouseX < yesX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    yesButtonClicked = true;
    confettiPop();  // Trigger confetti
  } 
  
  // "No" button clicked
  if (buttonClicked && mouseX > noX && mouseX < noX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    noButtonClicked = true;
  }
}


// Step 12: The "yes" or "no" buttons made sense for the example card. You may get rid of the buttons, or may implement a different type of button usage!
void drawYesNoButtons() {
    int buttonWidth = 80;
    int buttonHeight = 40;
    int spacing = 20;
    
    // Calculate button positions
    int centerX = width / 2;
    int yesX = centerX - buttonWidth - spacing / 2;
    int noX = centerX + spacing / 2;

    // Draw Yes button
    fill(yesButtonColor);
    rect(yesX, (height / 2) + 75, buttonWidth, buttonHeight);

    fill(#ffffff);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("Yes", yesX + buttonWidth / 2, (height / 2) + 75 + buttonHeight / 2);

    // Draw No button
    fill(yesButtonColor);
    rect(noX, (height / 2) + 75, buttonWidth, buttonHeight);

    fill(#ffffff);
    text("No", noX + buttonWidth / 2, (height / 2) + 75 + buttonHeight / 2);
}

void confettiPop() {
  // Add confetti pop effect
  for (int i = 0; i < 50; i++) {
    float angle = random(TWO_PI);
    float radius = random(50, 200);
    float confettiX = width / 2 + cos(angle) * radius;
    float confettiY = height / 2 + sin(angle) * radius;
    float confettiSpeedX = random(-2, 2);
    float confettiSpeedY = random(-5, -1);
    float confettiSize = random(5, 15);
    int confettiColor = color(random(255), random(255), random(255));
    
    ConfettiParticle confetti = new ConfettiParticle(confettiX, confettiY, confettiSpeedX, confettiSpeedY, confettiSize, confettiColor);
    confettiParticles.add(confetti);
  }
}

class ConfettiParticle {
  float x, y, speedX, speedY, size;
  color particleColor;
  
  ConfettiParticle(float x, float y, float speedX, float speedY, float size, color particleColor) {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
    this.size = size;
    this.particleColor = particleColor;
  }
  
  void update() {
    x += speedX;
    y += speedY;
    speedY += 0.1;  // Gravity effect
    
    // Bounce off the edges
    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y > height) {
      y = height;
      speedY *= -0.6;  // Add some damping to simulate bouncing on the ground
    }
  }

// Step 13 (OPTIONAL): Change the shape of the confetti (maybe try heart shapes <3)???
  void display() {
    fill(particleColor);
    rect(x, y, size, size/2);
  }
  
  boolean isOffscreen() {
    return (y > height);
  }
}
