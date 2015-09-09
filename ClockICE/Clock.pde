//Clock class
//Draws a representation of a clock face to the window
//Currently, this clock class does not draw any hour numbers

class Clock{
    PShape faceGroup, border, face;
    
    Clock(){
        //Sets up the PShape clock face group
        faceGroup = createShape(GROUP);
        border = createShape(ELLIPSE, 0, 0, 430, 430);
        border.setFill(color(140, 110, 65));
        face = createShape(ELLIPSE, 0, 0, 400, 400);
        face.setFill(color(200, 170, 125));
        faceGroup.addChild(border);
        faceGroup.addChild(face);
    }
    
    //ADD CODE TO THE METHOD BELOW SO THAT THE CLOCK APPEARS TO HAVE 12 NUMBERS, 
    //  OR 12 SHAPES OF SOME SORT (CIRCLES, RECTANGLES, TRIANGLES, ETC.) 
    //HINT 1: USE TRIGONOMETRY TO CALCULATE X AND Y POSITIONS AROUND A CIRCLE
    //HINT 2: IF USING TEXT, TEXT IS DRAWN WITH ANCHOR POINT OF UPPER-LEFT-CORNER
    //  https://processing.org/reference/text_.html
    void display(){
        shape(faceGroup, width/2, height/2);

    }
}