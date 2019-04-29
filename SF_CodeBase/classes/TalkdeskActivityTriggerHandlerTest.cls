@isTest
private class TalkdeskActivityTriggerHandlerTest {
    static testMethod void insertActivityAfterTalkDeskTest() {
        Trigger_Settings__c cs = new Trigger_Settings__c();
        cs.Name='TalkDeskActivityTrigger';
        cs.Is_Active__c = true;
        insert cs;
        
        talkdesk__Talkdesk_Activity__c tks = new talkdesk__Talkdesk_Activity__c();
          tks.talkdesk__Call_Id__c = '23';
          tks.talkdesk__Talkdesk_Id__c = '2311';
          tks.Name = 'test789';
          tks.talkdesk__Start_Time__c = datetime.newInstance(2014, 9, 15, 12, 30, 0).addHours(1);
          tks.talkdesk__End_Time__c = datetime.newInstance(2014, 9, 15, 12, 30, 0).addHours(1);
          insert tks;
          
          Task tsk = new Task();
          tsk.Subject = 'Test';
            tsk.TalkDesk_Call_Id__c = '1132';// needs TOD talkdesk__Talkdesk_Id__c
            tsk.talkdesk__Talkdesk_Id__c = '113255';// needs TOD talkdesk__Call_Id__c
            //tsk.WhatId = tk.talkdesk__Account__c;
            //tsk.WhoId = tk.talkdesk__Contact__c;
            tsk.Phone_number__c = '123';
            //tsk.Answered_By_User__c = tk.talkdesk__User__c;
            tsk.Call_Recording__c = 'www.test123.com';
            tsk.Hour_of_the_day__c = '1';
            tsk.Is_Missed_call__c = true;
            tsk.Waiting_Time__c = 1;
            tsk.Disposition_Code__c = 'Other';
            tsk.Disposition_Code_External_Id__c = '1';
            tsk.Half_Hour_of_Day__c = '1';
            tsk.Hangup__c = 'Hold';
            tsk.If_No_Answer__c = true;
            tsk.In_Business_Hours__c = true;
            tsk.Is_Abandoned__c = true;
            tsk.Is_Callback__c = true;
            tsk.Is_Deleted__c = true;
            tsk.Is_External_Number__c = true;
            tsk.Is_Mood_set__c = true;
            tsk.Is_Sample__c = true;
            tsk.Is_Transfer__c = true;
            tsk.IVR_Options_raw__c = 'ss';
            tsk.Mood__c = 'happy';
            tsk.Mood_Face__c = 'happy';
            tsk.Mood_Num_Value__c = 1;
            tsk.Name_Id__c = 'aa';
            tsk.Notes__c = 'aa';
            tsk.Related_To__c = 'jj';
            tsk.SLA__c = false;
            tsk.Status__c = 'Sending';
            tsk.Start_Date__c = Date.newInstance(2016, 12, 9);
            tsk.Start_Time__c = datetime.newInstance(2014, 9, 15, 12, 30, 0).addHours(1);
            tsk.End_Time__c = datetime.newInstance(2014, 9, 15, 12, 30, 0).addHours(1);
            tsk.Hold_Time_sec__c = 5;
            tsk.Speed_to_Answer_sec__c = 4;
            tsk.Ring_Groups__c = 'Admins';
            tsk.Talk_Time__c = '8';
            tsk.Talk_Time_sec__c = 8;
            tsk.Type__c = 'Abandoned';
            tsk.Day_of_Week__c = '6';
            tsk.Month_of_Year__c = '6';
            tsk.Timezone__c = 4;
            tsk.CSAT__c = 1;
            tsk.CSAT_Icon__c = '8';
            tsk.CSAT_Response__c = false;
            tsk.CSAT_Text_Response__c = 'www';
          insert tsk;
         List<Task> lsttsk =[select id from Task where id=: tsk.id];
         //System.assert.equals(1,lstopp.size());
     }
}