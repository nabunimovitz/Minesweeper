

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row=0; row<NUM_ROWS; row++)
    {
        for(int col=0; col<NUM_COLS; col++)
        {
            buttons[row][col] = new MSButton(row, col);
        }
    }
    
    
    setBombs();
}
public void setBombs()
{
  for(int i=1; i<=20; i++)
  {
    int randomR = (int)(Math.random()*20); 
    int randomC = (int)(Math.random()*20);

    if(!bombs.contains(buttons[randomR][randomC]))
    {
        bombs.add(buttons[randomR][randomC]);
        System.out.println(randomR + ", " + randomC);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //if not a bomb and clicked
    for(int rows=0; rows<NUM_ROWS; rows++)
    {
        for(int cols=0; cols<NUM_COLS; cols++)
        {
            if(!buttons[rows][cols].isClicked() && !bombs.contains(buttons[rows][cols]))
                return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    buttons[9][5].setLabel("G");
    buttons[9][6].setLabel("A");
    buttons[9][7].setLabel("M");
    buttons[9][8].setLabel("E");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("O");
    buttons[9][11].setLabel("V");
    buttons[9][12].setLabel("E");
    buttons[9][13].setLabel("R");
    //System.out.println("lose");

    for(int row=0; row<NUM_ROWS; row++)
    {
        for(int col=0; col<NUM_COLS; col++)
        {
            if(bombs.contains(buttons[row][col]))
                buttons[row][col].setLabel("B");
        }
    }
}
public void displayWinningMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
    buttons[9][13].setLabel("!");
    //System.out.println("win");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
        {
            marked = !marked;
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0)
        {
            setLabel(Integer.toString(countBombs(r,c)));
        }
        else 
        {
             for(int i= r-1; i<=r+1; i++)
             {
                for(int cols = c-1; cols<=c+1; cols++)
                {
                    if(isValid(i, cols) && !buttons[i][cols].isClicked())
                        buttons[i][cols].mousePressed();
                }   
            }
        }
    }

    public void draw() 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS && r>=0 && c<NUM_COLS && c>=0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1, col-1) == true)
        {
            if(bombs.contains(buttons[row-1][col-1]))
            {
                numBombs++;
            }
        }
        if(isValid(row-1, col) == true)
        {
            if(bombs.contains(buttons[row-1][col]))
            {
                numBombs++;
            }
        }
        if(isValid(row-1, col+1) == true)
        {
            if(bombs.contains(buttons[row-1][col+1]))
            {
                numBombs++;
            }
        }
        if(isValid(row, col-1) == true)
        {
            if(bombs.contains(buttons[row][col-1]))
            {
                numBombs++;
            }
        }
        if(isValid(row, col+1) == true)
        {
            if(bombs.contains(buttons[row][col+1]))
            {
                numBombs++;
            }
        }
        if(isValid(row+1, col-1) == true)
        {
            if(bombs.contains(buttons[row+1][col-1]))
            {
                numBombs++;
            }
        }
        if(isValid(row+1, col) == true)
        {
            if(bombs.contains(buttons[row+1][col]))
            {
                numBombs++;
            }
        }
        if(isValid(row+1, col+1) == true)
        {
            if(bombs.contains(buttons[row+1][col+1]))
            {
                numBombs++;
            }
        }
        return numBombs;
    }
}



