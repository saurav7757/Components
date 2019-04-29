/*
*Name       : TalkdeskActivityTriggerHandler 
*Description  : TalkdeskActivity Handler Class is to handle the logic/methods for TalkdeskActivity.
*Author    : Saurav Jaiswal
*Date      : 1/2/2019
*
*MODIFICATION LOG:
*DEVELOPER                         DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 

public class TalkdeskActivityTriggerHandler {
      
    public static void insertActivityAfterTalkDesk(List<talkdesk__Talkdesk_Activity__c> tkAct) {
        List<Task> tasklist=new list<Task>();
        for(talkdesk__Talkdesk_Activity__c tk : tkAct){
            if(tk.talkdesk__Ring_Groups__c != 'customer_care') {
                Task tsk = new Task();
                tsk.Subject = 'Call ' + tk.Name;
                tsk.TalkDesk_Call_Id__c = tk.talkdesk__Call_Id__c;// needs TOD talkdesk__Talkdesk_Id__c
                tsk.talkdesk__Talkdesk_Id__c = tk.talkdesk__Talkdesk_Id__c;// needs TOD talkdesk__Call_Id__c
                if(tk.talkdesk__Account__c != null && tk.talkdesk__Case__c == null && tk.talkdesk__Opportunity__c == null){
                    system.debug('$$$123'+ tk.talkdesk__Account__c);
                    system.debug('$$$1234'+ tk.talkdesk__Case__c);
                    tsk.WhatId = tk.talkdesk__Account__c;
                }else if(tk.talkdesk__Case__c != null && tk.talkdesk__Account__c == null && tk.talkdesk__Opportunity__c == null){
                    system.debug('$$$123456'+ tk.talkdesk__Account__c);
                    system.debug('$$$123456788'+ tk.talkdesk__Case__c);
                    tsk.WhatId = tk.talkdesk__Case__c;
                }else if(tk.talkdesk__Opportunity__c != null && tk.talkdesk__Account__c == null && tk.talkdesk__Case__c == null){
                    tsk.WhatId = tk.talkdesk__Opportunity__c;
                }
                String lead_prefix = Schema.SObjectType.Lead.getKeyPrefix();
                String contact_prefix = Schema.SObjectType.Contact.getKeyPrefix();
                if(tk.talkdesk__Contact__c != null && tk.talkdesk__Lead__c == null){
                    tsk.WhoId = tk.talkdesk__Contact__c;
                }else if(tk.talkdesk__Contact__c == null && tk.talkdesk__Lead__c != null){
                    tsk.WhoId = tk.talkdesk__Lead__c;
                }
                tsk.Phone_number__c = tk.talkdesk__Talkdesk_Phone_Number__c;
                tsk.Answered_by__c = tk.talkdesk_Answered_by__c;
                tsk.Call_Recording__c = tk.talkdesk__Recording__c;
                tsk.Hour_of_the_day__c = tk.talkdesk__Hour_of_Day__c;
                tsk.Is_Missed_call__c = tk.talkdesk__Missed__c;
                tsk.Waiting_Time__c = tk.talkdesk__Wait_Time_sec__c;
                tsk.Disposition_Code__c = tk.talkdesk__Disposition_Code__c;
                system.debug('##1' + tsk.Disposition_Code__c);
                system.debug('##2' + tk.talkdesk__Disposition_Code__c);
                tsk.Disposition_Code_External_Id__c = tk.talkdesk__Disposition_Code_External_Id__c;
                tsk.Half_Hour_of_Day__c = tk.talkdesk__Half_Hour__c;
                tsk.Hangup__c = tk.talkdesk__Result__c;
                tsk.If_No_Answer__c = tk.talkdesk__If_No_Answer__c;
                tsk.In_Business_Hours__c = tk.talkdesk__In_Business_Hours_del__c;
                tsk.Is_Abandoned__c = tk.talkdesk__Abandoned__c;
                tsk.Is_Callback__c = tk.talkdesk__Is_Callback_del__c;
                tsk.Is_Deleted__c = tk.talkdesk__Is_Deleted__c;
                tsk.Is_External_Number__c = tk.talkdesk__External_Number__c;
                tsk.Is_Mood_set__c = tk.talkdesk__Is_Mood_set__c;
                tsk.Is_Sample__c = tk.talkdesk__Is_Sample__c;
                tsk.Is_Transfer__c = tk.talkdesk__Is_Transfer_del__c;
                tsk.IVR_Options_raw__c = tk.talkdesk__IVR_Options_raw__c;
                tsk.Mood__c = tk.talkdesk__Mood_PL__c;
                tsk.Mood_Face__c = tk.talkdesk__Mood_Face__c;
                tsk.Mood_Num_Value__c = tk.talkdesk__MoodNumValue__c;
                tsk.Name_Id__c = tk.talkdesk__Name_Id__c;
                tsk.Notes__c = tk.talkdesk__Notes__c;
                system.debug('##3' + tsk.Notes__c);
                tsk.Related_To__c = tk.talkdesk__Related_To__c;
                tsk.SLA__c = tk.talkdesk__SLA__c;
                tsk.Status__c = tk.talkdesk__Status__c;
                tsk.Start_Date__c = tk.talkdesk__Start_Date__c;
                tsk.Start_Time__c = tk.talkdesk__Start_Time__c;
                tsk.End_Time__c = tk.talkdesk__End_Time__c;
                tsk.Hold_Time_sec__c = tk.talkdesk__Hold_TIme_sec__c;
                tsk.Speed_to_Answer_sec__c = tk.talkdesk__Speed_to_Answer_sec_del__c;
                tsk.Ring_Groups__c = tk.talkdesk__Ring_Groups__c;
                tsk.Talk_Time__c = tk.talkdesk__CallDuration__c;
                tsk.Talk_Time_sec__c = tk.talkdesk__Talk_Time_sec__c;
                tsk.Type__c = tk.talkdesk__Type__c;
                tsk.Day_of_Week__c = tk.talkdesk__Day_of_Week__c;
                tsk.Month_of_Year__c = tk.talkdesk__Month_of_Year__c;
                tsk.Timezone__c = tk.talkdesk__user_timezone__c;
                tsk.CSAT__c = tk.talkdesk__CSAT__c;
                tsk.CSAT_Icon__c = tk.talkdesk__CSAT_Icon__c;
                tsk.CSAT_Response__c = tk.talkdesk__CSAT_Response_del__c;
                tsk.CSAT_Text_Response__c = tk.talkdesk__CSAT_Text_Response__c;
                tsk.Status = 'Completed';
                tsk.Contact_Phone__c = tk.talkdesk__Contact_Phone__c;
                tsk.OwnerId = tk.talkdesk__User__c;
                tsk.ActivityDate = date.today();
                if(Trigger.isAfter && Trigger.isInsert){
                    tsk.TaskSubtype = 'Call';
                }
                tsk.Description = 'Call disposition code:'+tk.talkdesk__Disposition_Code__c + '\n' + 'Start Time :' + tk.talkdesk__Start_Time__c.addHours(1) + '\n' + 'End Time :' + tk.talkdesk__End_Time__c.addHours(1) + '\n' + 'Notes :' + tk.talkdesk__Notes__c+ '\n' + 'Contact Phone :' +tk.talkdesk__Contact_Phone__c+ '\n' + 'Call Recording: ' + tk.talkdesk__Recording__c;
                //if(tk.talkdesk__Ring_Groups__c != 'customer_care'){
                tasklist.add(tsk);
            }
        }
        Schema.SObjectField ftoken = Task.Fields.TalkDesk_Call_Id__c;
        List<Database.UpsertResult> srList = new List<Database.UpsertResult>();
        if(!tasklist.isEmpty()){
            srList = Database.upsert(tasklist,ftoken,false);
        }
        if(!srList.isEmpty()){
            for (Database.UpsertResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful
                    System.debug('Success!!');
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('error has occurred.' + err.getStatusCode() + ': ' + err.getMessage());                    
                        System.debug('fields that affected this error: ' + err.getFields());
                        
                    }
                }
            }
        }
    }
    
}