/*  DBZ / players / dialogs.inc  —  central OnDialogResponse dispatcher
 *  Included last so it can call handlers from every module.
 */
#if defined _dbz_dialogs_handler_included
    #endinput
#endif
#define _dbz_dialogs_handler_included

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DIALOG_REGISTER:
        {
            if (!response) { DelayedKick(playerid); return 1; }
            Account_Register(playerid, inputtext);
            return 1;
        }
        case DIALOG_LOGIN:
        {
            if (!response) { DelayedKick(playerid); return 1; }
            Account_Login(playerid, inputtext);
            return 1;
        }
        case DIALOG_SPAWN:
        {
            HandleBattleground(playerid, response, listitem);
            return 1;
        }
        case DIALOG_WISH:
        {
            HandleWish(playerid, response, listitem);
            return 1;
        }
        case DIALOG_TRAIN:
        {
            if (response) Training_PickType(playerid, listitem);
            return 1;
        }
        case DIALOG_TRAIN_TIER:
        {
            if (response) Training_PickTier(playerid, listitem);
            else ShowTrainingDialog(playerid);
            return 1;
        }
        case DIALOG_MOVES:
        {
            if (response) HandleMovePick(playerid, listitem);
            return 1;
        }
        case DIALOG_SKINS:
        {
            if (response) HandleSkinPick(playerid, listitem);
            return 1;
        }
    }
    return 0;
}
