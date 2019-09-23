/*Parse the level data from Included Files

It's possible to load externally too, but I haven't needed it
and wrote this code a while back (I may write something better one day)

So, I won't comment too much on this code:
It reads through the whole text document and parses/stores each piece in global ds_grids/arrays,
spawns all the sprites on the map, then tells objMain that we have finished "switchingMaps".
*/

for (var i=0; i < 6;i++)
    {
        var objToFind = "null";
    
        switch(i)
        {
            case 0: objToFind="objEnemyParent"; break;
            case 1: objToFind="objBean"; break;
            case 2: objToFind="objLion"; break;
            case 3: objToFind="objDee01"; break;
            case 4: objToFind="objCapsule"; break;
            case 5: objToFind="objVolcanoStarter"; break;
            case 6: objToFind="objVolcanoTop"; break;
            case 7: objToFind="objTankBossStarter"; break;
            default: break;
        }
    if (objToFind != "null")
        {
            objToFind = asset_get_index(objToFind);
            for (j = 0; j < instance_number(objToFind); j++)
            {
                thisEnemy = instance_find(objToFind,j);
                thisEnemy.silentKill=false;
            }
        }
}


if objMain.extFiles=true
{
    dir = program_directory + "maps\";    
    background_replace(tileset, program_directory + "/maps/tileset_test.png",0,0);
}
else
{
    dir=working_directory + "maps\";
}

var str = "";
var file = "";
var hey = "";

var lineCount = 0;
var tilemapWidthCountFlag=false;

global.mapWidth=0;

if (ds_exists(objMain.levelData,ds_type_grid))
{
    ds_grid_destroy(objMain.levelData);
}

if (ds_exists(objMain.levelDataLayer2,ds_type_grid))
{
    ds_grid_destroy(objMain.levelDataLayer2);
}

file = file_text_open_read(dir + argument[0]);

var mapHeader = file_text_readln(file);

for (k=1; k <= string_length(mapHeader); k++) {
        
    if (string_char_at(string(mapHeader),k)=='"') {
       
       var j="";
       k++;
           
       while (string_char_at(string(mapHeader),k)!='"') {
            j += string_char_at(string(mapHeader),k);
            k++;
       }
               
               if global.mapWidth<=0
               {
               global.mapWidth=real(j)/16;
               }
               else
               {
               global.mapHeight=real(j)/16;
               }
               
    j="";
      }    
}

global.tileWidth=16;
global.tileHeight=16;
objMain.levelData = ds_grid_create(global.mapWidth, global.mapHeight);
objMain.levelDataLayer2 = ds_grid_create(global.mapWidth, global.mapHeight);




global.tilesetIndex=0;

//This is totally ridiculous. Why not just iterate until you hit right angle bracket and go from there?
//Comment out the i,j for loops. Go over "hey" (ugh) until you hit >, then just do comma reading and set ds until you're done.

var i = 0;
var j = 0;
var hey = file_text_readln(file);
var commaCount = 0;
var tileBuffer = "";
var tileID = "";
//loop through every single character in our line (hey) until we hit a comma
 
//show_message(string(j) + ", " + string(i));

var startFrom = 0;
while (string_char_at(string(hey), startFrom) != '>') {
    startFrom++
}
startFrom++

var tileIDString = "";
var tilesRead = 0;
 
// First time, don't check, you know it's right.
var charToCheck = 999;
while (string_char_at(string(hey), charToCheck) != ' ') {
    for (var k = startFrom; k <= string_length(hey); k++) {
        var currentChar = string_char_at(string(hey), k);

        if (currentChar == ',') { // It's a comma, go to the next tile;
            i = tilesRead % global.mapWidth;
            j = floor(tilesRead / global.mapWidth);
            ds_grid_set(objMain.levelData, i, j, tileIDString);
            tileIDString = "";
            tilesRead++;
        } else {
            tileIDString += currentChar;
        }
    }
    i = tilesRead % global.mapWidth;
    j = floor(tilesRead / global.mapWidth);
    ds_grid_set(objMain.levelDataLayer2, i + 1, j, tileIDString);
    tileIDString = "";
    tilesRead++;
    
    hey = file_text_readln(file)
    charToCheck = 0;
    startFrom = 1;
}

i = 0;
j = 0;
//hey = file_text_readln(file);
commaCount = 0;
tileBuffer = "";
tileID = "";

while (string_char_at(string(hey), startFrom) != '>') {
    startFrom++;
}
startFrom++;

tileIDString = "";
tilesRead = 0;

charToCheck = 999;
while (string_char_at(string(hey), charToCheck) != ' ') { 
    for (var k=startFrom; k <= string_length(hey); k++) {
        var currentChar = string_char_at(string(hey), k);

        if (currentChar == ',') { // It's a comma, go to the next tile;
            i = tilesRead % global.mapWidth;
            j = floor(tilesRead / global.mapWidth);
            ds_grid_set(objMain.levelDataLayer2, i, j, tileIDString);
            tileIDString = "";
            tilesRead++;
        } else {
            tileIDString += currentChar;
        }   
    }
    i = tilesRead % global.mapWidth;
    j = floor(tilesRead / global.mapWidth);
    ds_grid_set(objMain.levelDataLayer2, i, j, tileIDString);
    tileIDString = "";
    tilesRead++;
    
    hey = file_text_readln(file);
    charToCheck = 0;
    startFrom = 1; // Do Game Maker strings start from a 1-index?
}



//Commented this out because if you fell out the while loop above, you already have this line.
//hey =  file_text_readln(file); //<entities>

hey =  file_text_readln(file); //first sprite


//entities layer

if (ds_exists(objMain.levelDataSprites,ds_type_grid))
{
ds_map_destroy(objMain.levelDataSprites);
}

objMain.levelDataSprites = ds_map_create();

var q = 0;

while (string_char_at(string(hey),5)=="<")
{

//loop through every sprite and draw them properly

var dataPart=0;
var spriteIndex="";
 for (var k=6; k <= string_length(hey); k++)
 {
    valueBuffer="";
    
    while (string_char_at(string(hey),k)!=' ') && (spriteIndex=="")
    {
        valueBuffer+=string_char_at(string(hey),k);
        k++;
    }
    if spriteIndex==""
    {spriteIndex=valueBuffer;}
    
    valueBuffer="";
        
    if(string_char_at(string(hey),k)=='"')
    {
        k++
        while string_char_at(string(hey),k)!='"'
        {
            valueBuffer+=string_char_at(string(hey),k);
            k++;
        }
        
        switch(dataPart)
        {
        case 0: spriteID=real(valueBuffer); break;
        case 1: spriteXPos=real(valueBuffer); break;
        case 2: spriteYPos=real(valueBuffer); break;
        default: break;
        }
        
        
        dataPart++;
    }
 }
var b = string(q);
ds_map_add(objMain.levelDataSprites, "spriteIndex" + b, spriteIndex);
ds_map_add(objMain.levelDataSprites, "spriteID" + b, spriteID);
ds_map_add(objMain.levelDataSprites, "spriteXPos" + b, spriteXPos);
ds_map_add(objMain.levelDataSprites, "spriteYPos" + b, spriteYPos);

//show_message(string(spriteIndex) + ", " + string(spriteID) + ", " + string(spriteXPos) + ", " + string(spriteYPos));

q++;


hey =  file_text_readln(file);
}
spawnSprites();

//Close the text document to avoid memory leaks
file_text_close(file);

global.tilesetWidth=32;
global.tilesetHeight=32;
global.currentMap = argument[0]; //Let the game know which map is currently loaded
objMain.switchingMaps = false;
