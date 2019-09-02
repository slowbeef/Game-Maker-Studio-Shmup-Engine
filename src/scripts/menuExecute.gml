//This script handles objTitle's menu, depending which option in the menu the user pressed Confirm on.

if currentMenu==1
{
    switch (mpos)
    {
        //Start
        case 0:
            //Set a timer in objTitle to start single-player mode
            if (alarm[0]<=0)
            {
                audio_stop_sound(sfxMenuAccept);
                audio_play_sound(sfxMenuAccept,1,false);
                alarm[0] = 100;
            }
            break;
        //Co-Op Mode (2 Players)
        case 1:
            //Set a timer in objTitle to start co-op mode
            if (alarm[1]<=0)
            {
                audio_stop_sound(sfxMenuAccept);
                audio_play_sound(sfxMenuAccept,1,false);
                alarm[1] = 100;
            }
            break;
        //Options
        case 2:
            audio_stop_sound(sfxMenuAccept);audio_play_sound(sfxMenuAccept,1,false);
            mpos=0;currentMenu+=1;prevBGMVol=global.bgmVol;prevSFXVol=global.sfxVol;prevWindowSize=objMain.windowSize;
            prevKeyUp = global.keyUp;prevKeyDown = global.keyDown;prevKeyLeft = global.keyLeft;prevKeyRight = global.keyRight;prevKeyAction1 = global.keyAction1;prevKeyAction2 = global.keyAction2;prevKeyAction3 = global.keyAction3;prevKeyPause = global.keyPause;
            break;
        //Quit
        case 3:
            game_end();break;
        //Edge case handling
        default: break;
    }
}
else if currentMenu==2
{
    switch (mpos)
    {
        //BGM Vol
        case 0: 
            break;
        //SFX Vol
        case 1:
            break;
        //GRV Options toggle
        case 2:
            global.grVOptEnabled = !global.grVOptEnabled;
            audio_stop_sound(sfxMenuTweak);audio_play_sound(sfxMenuTweak,1,false);
            break;
        //Friendly Mode toggle
        case 3:
            global.frModeEnabled = !global.frModeEnabled;
            audio_stop_sound(sfxMenuTweak);audio_play_sound(sfxMenuTweak,1,false);
            break;
        //Window Size
        case 4:
            break;
        //Set Controls
        case 5:
            audio_stop_sound(sfxMenuAccept);audio_play_sound(sfxMenuAccept,1,false);
            currentConfig=0;currentMenu=3;
            break;
        case 6:
        //Save Config
            audio_stop_sound(sfxMenuStart);audio_play_sound(sfxMenuStart,1,false);
            saveOptions();
            mpos=1;currentMenu-=1;
            break;
        //Back
        case 7:
            audio_stop_sound(sfxMenuCancel);audio_play_sound(sfxMenuCancel,1,false);
            mpos=1;currentMenu-=1;global.bgmVol=prevBGMVol;global.sfxVol=prevSFXVol;objMain.windowSize=prevWindowSize;window_set_size(256*objMain.windowSize,144*objMain.windowSize); playerConfig = 1;
            global.keyUp = prevKeyUp;
            global.keyDown = prevKeyDown;
            global.keyLeft = prevKeyLeft;
            global.keyRight = prevKeyRight;
            global.keyAction1 = prevKeyAction1;
            global.keyAction2 = prevKeyAction2;
            global.keyAction3 = prevKeyAction3;
            global.keyPause = prevKeyPause;
            
            global.keyP2Up = prevKeyP2Up;
            global.keyP2Down = prevKeyP2Down;
            global.keyP2Left = prevKeyP2Left;
            global.keyP2Right = prevKeyP2Right;
            global.keyP2Action1 = prevKeyP2Action1;
            global.keyP2Action2 = prevKeyP2Action2;
            global.keyP2Action3 = prevKeyP2Action3;
            global.keyP2Pause = prevKeyP2Pause;
            
            break;
        //Edge case handling
        default: break;
    }
}
else if currentMenu==0
{
    pressStartText=false;
}
