import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

String[] phrases; //contains all of the phrases
int totalTrialNum = 2; //the total number of phrases to be tested - set this low for testing. Might be ~10 for the real bakeoff!
int currTrialNum = 0; // the current trial number (indexes into trials array above)
float startTime = 0; // time starts when the first letter is entered
float finishTime = 0; // records the time of when the final trial ends
float lastTime = 0; //the timestamp of when the last trial was completed
float lettersEnteredTotal = 0; //a running total of the number of letters the user has entered (need this for final WPM computation)
float lettersExpectedTotal = 0; //a running total of the number of letters expected (correct phrases)
float errorsTotal = 0; //a running total of the number of errors (when hitting next)
String currentPhrase = ""; //the current target phrase
String currentTyped = ""; //what the user has typed so far
final int DPIofYourDeviceScreen = 254; //you will need to look up the DPI or PPI of your device to make sure you get the right scale!! mine: 254
//http://en.wikipedia.org/wiki/List_of_displays_by_pixel_density
final float sizeOfInputArea = DPIofYourDeviceScreen*1; //aka, 1.0 inches square!
int clicks = 0; //0-3, indicates how many times you have clicked consecutively on the same key
int lastKeyClicked = -1; //0-9, keys labeled left to right, top to bottom
char pendingLetter = 'a'; //most recently entered letter, not yet saved to phrase
PImage watch;
PImage abc;
PImage def;
PImage ghi;
PImage jkl;
PImage mno;
PImage pqrs;
PImage tuv;
PImage wxyz;

//Variables for my silly implementation. You can delete this:
char currentLetter = 'a';

//You can modify anything in here. This is just a basic implementation.
void setup()
{
  watch = loadImage("watchhand3smaller.png");
  abc = loadImage("abc.png");
  def = loadImage("def.png");
  ghi = loadImage("ghi.png");
  jkl = loadImage("jkl.png");
  mno = loadImage("mno.png");
  pqrs = loadImage("pqrs.png");
  tuv = loadImage("tuv.png");
  wxyz = loadImage("wxyz.png");
  phrases = loadStrings("phrases2.txt"); //load the phrase set into memory
  Collections.shuffle(Arrays.asList(phrases), new Random()); //randomize the order of the phrases with no seed
  //Collections.shuffle(Arrays.asList(phrases), new Random(100)); //randomize the order of the phrases with seed 100; same order every time, useful for testing
 
  orientation(LANDSCAPE); //can also be PORTRAIT - sets orientation on android device
  size(800, 800); //Sets the size of the app. You should modify this to your device's native size. Many phones today are 1080 wide by 1920 tall.
  textFont(createFont("Arial", 24)); //set the font to arial 24. Creating fonts is expensive, so make difference sizes once in setup, not draw
  noStroke(); //my code doesn't use any strokes
}

//You can modify anything in here. This is just a basic implementation.
void draw()
{
  background(255); //clear background
  drawWatch(); //draw watch background
  fill(100);
  rect(width/2-sizeOfInputArea/2, height/2-sizeOfInputArea/2, sizeOfInputArea, sizeOfInputArea); //input area should be 1" by 1"
  drawButtons(); //draw keyboard buttons

  if (finishTime!=0)
  {
    fill(128);
    textAlign(CENTER);
    text("Finished", 280, 150);
    return;
  }

  if (startTime==0 & !mousePressed)
  {
    fill(128);
    textAlign(CENTER);
    text("Click to start time!", 280, 150); //display this messsage until the user clicks!
  }

  if (startTime==0 & mousePressed)
  {
    nextTrial(); //start the trials!
  }

  if (startTime!=0)
  {
    //feel free to change the size and position of the target/entered phrases and next button 
    textAlign(LEFT); //align the text left
    fill(128);
    text("Phrase " + (currTrialNum+1) + " of " + totalTrialNum, 70, 50); //draw the trial count
    fill(128);
    text("Target:   " + currentPhrase, 70, 100); //draw the target string
    text("Entered:  " + currentTyped +"|", 70, 140); //draw what the user has entered thus far 

    //draw very basic next button
    fill(255, 0, 0);
    rect(600, 600, 200, 200); //draw next button
    fill(255);
    text("NEXT > ", 650, 650); //draw next label

    /* my draw code
    fill(255, 0, 0); //red button
    rect(width/2-sizeOfInputArea/2, height/2-sizeOfInputArea/2+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2); //draw left red button
    fill(0, 255, 0); //green button
    rect(width/2-sizeOfInputArea/2+sizeOfInputArea/2, height/2-sizeOfInputArea/2+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2); //draw right green button
    */
    textAlign(CENTER);
    fill(200);
    text("" + currentLetter, width/2, height/2-sizeOfInputArea/4); //draw current letter
  }
}

//my terrible implementation you can entirely replace
boolean didMouseClick(float x, float y, float w, float h) //simple function to do hit testing
{
  return (mouseX > x && mouseX<x+w && mouseY>y && mouseY<y+h); //check to see if it is in button bounds
}

void mousePressed()
{
  //abc
  if (keyClicked() == 0) {
    if (lastKeyClicked != 0 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%3;
    clicks++;
    lastKeyClicked = 0;
    switch (clicks) {
      case 1:
        currentLetter = 'a';
        break;
      case 2:
        currentLetter = 'b';
        break;
      case 3:
        currentLetter = 'c';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //def
  if (keyClicked() == 1) {
    if (lastKeyClicked != 1 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%3;
    clicks++;
    lastKeyClicked = 1;
    switch (clicks) {
      case 1:
        currentLetter = 'd';
        break;
      case 2:
        currentLetter = 'e';
        break;
      case 3:
        currentLetter = 'f';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //ghi
  if (keyClicked() == 2) {
    if (lastKeyClicked != 2 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%3;
    clicks++;
    lastKeyClicked = 2;
    switch (clicks) {
      case 1:
        currentLetter = 'g';
        break;
      case 2:
        currentLetter = 'h';
        break;
      case 3:
        currentLetter = 'i';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //jkl
  if (keyClicked() == 3) {
    if (lastKeyClicked != 3 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%3;
    clicks++;
    lastKeyClicked = 3;
    switch (clicks) {
      case 1:
        currentLetter = 'j';
        break;
      case 2:
        currentLetter = 'k';
        break;
      case 3:
        currentLetter = 'l';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //mno
  if (keyClicked() == 4) {
    if (lastKeyClicked != 4 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%3;
    clicks++;
    lastKeyClicked = 4;
    switch (clicks) {
      case 1:
        currentLetter = 'm';
        break;
      case 2:
        currentLetter = 'n';
        break;
      case 3:
        currentLetter = 'o';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //pqrs
  if (keyClicked() == 5) {
    if (lastKeyClicked != 5 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%4;
    clicks++;
    lastKeyClicked = 5;
    switch (clicks) {
      case 1:
        currentLetter = 'p';
        break;
      case 2:
        currentLetter = 'q';
        break;
      case 3:
        currentLetter = 'r';
        break;
      case 4:
        currentLetter = 's';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //space
  if (keyClicked() == 6) {
    if (lastKeyClicked != 6 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks++;
    lastKeyClicked = 6;
    currentLetter = '_';
  }
  
  //tuv
  if (keyClicked() == 7) {
    if (lastKeyClicked != 7 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%3;
    clicks++;
    lastKeyClicked = 7;
    switch (clicks) {
      case 1:
        currentLetter = 't';
        break;
      case 2:
        currentLetter = 'u';
        break;
      case 3:
        currentLetter = 'v';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //wxyz
  if (keyClicked() == 8) {
    if (lastKeyClicked != 8 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks = clicks%4;
    clicks++;
    lastKeyClicked = 8;
    switch (clicks) {
      case 1:
        currentLetter = 'w';
        break;
      case 2:
        currentLetter = 'x';
        break;
      case 3:
        currentLetter = 'y';
        break;
      case 4:
        currentLetter = 'z';
        break;
      default:
        currentLetter = '?';
    }
  }
  
  //backspace
  if (keyClicked() == 9) {
    if (lastKeyClicked != 9 && lastKeyClicked != -1) {
      clicks = 0;
    }
    clicks++;
    lastKeyClicked = 9;
    currentLetter = '`';
  }
  
  /* if (didMouseClick(width/2-sizeOfInputArea/2, height/2-sizeOfInputArea/2+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2)) //check if click in left button
  {
    currentLetter --;
    if (currentLetter<'_') //wrap around to z
      currentLetter = 'z';
  }

  if (didMouseClick(width/2-sizeOfInputArea/2+sizeOfInputArea/2, height/2-sizeOfInputArea/2+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2)) //check if click in right button
  {
    currentLetter ++;
    if (currentLetter>'z') //wrap back to space (aka underscore)
      currentLetter = '_';
  } */

  if (didMouseClick(width/2-sizeOfInputArea/2, height/2-sizeOfInputArea/2, sizeOfInputArea, sizeOfInputArea/2-45)) //check if click occured in letter area
  {
    if (currentLetter=='_') //if underscore, consider that a space bar
      currentTyped+=" ";
    else if (currentLetter=='`' & currentTyped.length()>0) //if `, treat that as a delete command
      currentTyped = currentTyped.substring(0, currentTyped.length()-1);
    else if (currentLetter!='`') //if not any of the above cases, add the current letter to the typed string
      currentTyped+=currentLetter;
  }

  //You are allowed to have a next button outside the 1" area
  if (didMouseClick(600, 600, 200, 200)) //check if click is in next button
  {
    nextTrial(); //if so, advance to next trial
  }
}


void nextTrial()
{
  if (currTrialNum >= totalTrialNum) //check to see if experiment is done
    return; //if so, just return

  if (startTime!=0 && finishTime==0) //in the middle of trials
  {
    System.out.println("==================");
    System.out.println("Phrase " + (currTrialNum+1) + " of " + totalTrialNum); //output
    System.out.println("Target phrase: " + currentPhrase); //output
    System.out.println("Phrase length: " + currentPhrase.length()); //output
    System.out.println("User typed: " + currentTyped); //output
    System.out.println("User typed length: " + currentTyped.length()); //output
    System.out.println("Number of errors: " + computeLevenshteinDistance(currentTyped.trim(), currentPhrase.trim())); //trim whitespace and compute errors
    System.out.println("Time taken on this trial: " + (millis()-lastTime)); //output
    System.out.println("Time taken since beginning: " + (millis()-startTime)); //output
    System.out.println("==================");
    lettersExpectedTotal+=currentPhrase.trim().length();
    lettersEnteredTotal+=currentTyped.trim().length();
    errorsTotal+=computeLevenshteinDistance(currentTyped.trim(), currentPhrase.trim());
  }

  //probably shouldn't need to modify any of this output / penalty code.
  if (currTrialNum == totalTrialNum-1) //check to see if experiment just finished
  {
    finishTime = millis();
    System.out.println("==================");
    System.out.println("Trials complete!"); //output
    System.out.println("Total time taken: " + (finishTime - startTime)); //output
    System.out.println("Total letters entered: " + lettersEnteredTotal); //output
    System.out.println("Total letters expected: " + lettersExpectedTotal); //output
    System.out.println("Total errors entered: " + errorsTotal); //output

    float wpm = (lettersEnteredTotal/5.0f)/((finishTime - startTime)/60000f); //FYI - 60K is number of milliseconds in minute
    float freebieErrors = lettersExpectedTotal*.05; //no penalty if errors are under 5% of chars
    float penalty = max(errorsTotal-freebieErrors, 0) * .5f;
    
    System.out.println("Raw WPM: " + wpm); //output
    System.out.println("Freebie errors: " + freebieErrors); //output
    System.out.println("Penalty: " + penalty);
    System.out.println("WPM w/ penalty: " + (wpm-penalty)); //yes, minus, becuase higher WPM is better
    System.out.println("==================");

    currTrialNum++; //increment by one so this mesage only appears once when all trials are done
    return;
  }

  if (startTime==0) //first trial starting now
  {
    System.out.println("Trials beginning! Starting timer..."); //output we're done
    startTime = millis(); //start the timer!
  } 
  else
    currTrialNum++; //increment trial number

  lastTime = millis(); //record the time of when this trial ended
  currentTyped = ""; //clear what is currently typed preparing for next trial
  currentPhrase = phrases[currTrialNum]; // load the next phrase!
  //currentPhrase = "abc"; // uncomment this to override the test phrase (useful for debugging)
}

int keyClicked()
{
  float leftX = width/2-sizeOfInputArea/2+10;
  float midX = width/2-sizeOfInputArea/2+90;
  float rightX = width/2-sizeOfInputArea/2+170;
  float topY = height/2-sizeOfInputArea/2+85;
  float midY = height/2-sizeOfInputArea/2+135;
  float botY = height/2-sizeOfInputArea/2+185;
  float w = 75;
  float h = 45;
  if (didMouseClick(leftX, topY, w, h)) return 0; //abc
  if (didMouseClick(midX, topY, w, h)) return 1; //def
  if (didMouseClick(rightX, topY, w, h)) return 2; //ghi
  if (didMouseClick(leftX, midY, w, h)) return 3; //jkl
  if (didMouseClick(midX, midY, w, h)) return 4; //mno
  if (didMouseClick(rightX, midY, w, h)) return 5; //pqrs
  if (didMouseClick(width/2-sizeOfInputArea/2+8, botY, 40, 40)) return 6; //space
  if (didMouseClick(width/2-sizeOfInputArea/2+50, botY, 75, 45)) return 7; //tuv
  if (didMouseClick(width/2-sizeOfInputArea/2+130, botY, 75, 45)) return 8; //wxyz
  if (didMouseClick(width/2-sizeOfInputArea/2+210, botY, 40, 40)) return 9; //backspace
  return -1;
}

// draws keyboard buttons
void drawButtons()
{
  pushMatrix();
  translate(width/2, height/2);
  int leftX = -80;
  int rightX = 80;
  int topRowY = -20;
  int middleRowY = 30;
  int bottomRowY = 80;
  image(abc, leftX, topRowY);
  image(def, 0, topRowY);
  image(ghi, rightX, topRowY);
  image(jkl, leftX, middleRowY);
  image(mno, 0, middleRowY);
  image(pqrs, rightX, middleRowY);
  image(tuv, leftX/2, bottomRowY);
  image(wxyz, rightX/2, bottomRowY);
  fill(255, 255, 255);
  ellipse(-100, bottomRowY, 35, 35); //space bar button
  fill(0, 0, 0);
  ellipse(100, bottomRowY, 35, 35); //back button
  popMatrix();
}

void drawWatch()
{
  float watchscale = DPIofYourDeviceScreen/138.0;
  pushMatrix();
  translate(width/2, height/2);
  scale(watchscale);
  imageMode(CENTER);
  image(watch, 0, 0);
  popMatrix();
}





//=========SHOULD NOT NEED TO TOUCH THIS METHOD AT ALL!==============
int computeLevenshteinDistance(String phrase1, String phrase2) //this computers error between two strings
{
  int[][] distance = new int[phrase1.length() + 1][phrase2.length() + 1];

  for (int i = 0; i <= phrase1.length(); i++)
    distance[i][0] = i;
  for (int j = 1; j <= phrase2.length(); j++)
    distance[0][j] = j;

  for (int i = 1; i <= phrase1.length(); i++)
    for (int j = 1; j <= phrase2.length(); j++)
      distance[i][j] = min(min(distance[i - 1][j] + 1, distance[i][j - 1] + 1), distance[i - 1][j - 1] + ((phrase1.charAt(i - 1) == phrase2.charAt(j - 1)) ? 0 : 1));

  return distance[phrase1.length()][phrase2.length()];
}
