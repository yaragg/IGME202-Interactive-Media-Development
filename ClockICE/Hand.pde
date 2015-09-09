//Hand class
//Draws a representation of a clock hand to the window
//A PShape in the shape of an arrow has pre-calculated vertices to create the arrow outline
//This program has 2 Hands:  a bigger hand that rotates to follow the mouse, 
//  and a smaller hand that continuously rotates around the clock center.
//The followMouse() method is used for any Hand which should follow the mouse
//The spin() method is used for any Hand which should constantly rotate

class Hand{
    PShape arrow;
    float angle; //Angle the arrow is pointing at
    Hand(){
        //This arrow uses 0, 0 as the upper-left-corner anchor point. 
        //It is 150 pixels wide and 50 pixels tall.  
        //It is drawn to the right (pointing toward 0 degrees)
        arrow = createShape();  
        arrow.beginShape();
            arrow.vertex(0, 15);
            arrow.vertex(110, 15);
            arrow.vertex(110, 0);
            arrow.vertex(150, 25);
            arrow.vertex(110, 50);
            arrow.vertex(110, 35);
            arrow.vertex(0, 35);
        arrow.endShape(CLOSE);
        arrow.setFill(color(160, 130, 85));
    }
    
    //WRITE THE CODE SO THAT THIS ARROW IS ALWAYS POINTING TOWARD THE MOUSE
    //THE ARROW SHOULD BE CENTERED ON THE SCREEN
    //HINT:  USE ATAN2
    void followMouse(){

    }
    
    
    //WRITE THE CODE SO THAT THIS ARROW SPINS CONTINUOUSLY
    //SIMILAR TO THE SECOND HAND ON A CLOCK
    //THE ARROW SHOULD ALSO BE CENTERED ON THE SCREEN AND SCALED 1 ON THE X AND 0.5 ON THE Y.
    void spin(){     
      pushMatrix();      
      angle = (angle+1)%360; //Increments the angle and resets it to 0 if it reaches 360     
      translate(width/2, height/2);
      rotate(radians(angle));
      scale(1, 0.5);
      shape(arrow, 0, -25);      
      popMatrix();
    }    
}