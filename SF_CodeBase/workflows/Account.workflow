<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Calendly_Email_Invite_English</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send Calendly Email Invite-English</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_English_Cal</template>
    </alerts>
    <alerts>
        <fullName>Send_Calendly_Email_Invite_German_Formal</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send Calendly Email Invite-German-Formal</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_formal_Cal</template>
    </alerts>
    <alerts>
        <fullName>Send_Calendly_Email_Invite_German_Informal</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send Calendly Email Invite-German-Informal</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_informal_Cal</template>
    </alerts>
    <alerts>
        <fullName>Send_email_English_Template_Fastlane</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - English Template Fastlane</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_English_New</template>
    </alerts>
    <alerts>
        <fullName>Send_email_English_Template_Fastlane_Friedrike</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - English Template Fastlane(Friedrike)</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_English_Friedrike</template>
    </alerts>
    <alerts>
        <fullName>Send_email_German_Template_Fastlane_Formal</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - German Template Fastlane_Formal</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_New</template>
    </alerts>
    <alerts>
        <fullName>Send_email_German_Template_Fastlane_Formal_Friedrike</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - German Template Fastlane_Formal(Friedrike)</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_formal_Friedrike</template>
    </alerts>
    <alerts>
        <fullName>Send_email_German_Template_Fastlane_Informal</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - German Template Fastlane_Informal</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_informal</template>
    </alerts>
    <alerts>
        <fullName>Send_email_German_Template_Fastlane_Informal_Friedrike</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - German Template Fastlane_Informal(Friedrike)</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_informal_Friedrike</template>
    </alerts>
    <outboundMessages>
        <fullName>Test_data</fullName>
        <apiVersion>45.0</apiVersion>
        <endpointUrl>https://putsreq.com/sCBuBaezWpTBZMhhl5BA</endpointUrl>
        <fields>ACC_BIC_3rd_BA__c</fields>
        <fields>ACC_BIC_4th__c</fields>
        <fields>ACC_BIC_5th__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>saurav@zeitgold.com</integrationUser>
        <name>Test data</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Send Calendly Link to Customer-English</fullName>
        <actions>
            <name>Send_Calendly_Email_Invite_English</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Calendly_Invite_Email_English</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>AND(First_ZG_Contact__c !=null,ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c!=null, ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;English&quot;),  Is_Calendly_email_sent__c = true, Re_send_Assignment_Mail__c = true)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Calendly Link to Customer-German%28Formal%29</fullName>
        <actions>
            <name>Send_Calendly_Email_Invite_German_Formal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Calendly_Invite_Email_German_Formal</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>AND(First_ZG_Contact__c !=null,ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c!=null, ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;German&quot;),ISPICKVAL( First_ZG_Contact__r.Tone_of_address__c ,&quot;Formal&quot;),Is_Calendly_email_sent__c = true,Re_send_Assignment_Mail__c = true)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Calendly Link to Customer-German%28Informal%29</fullName>
        <actions>
            <name>Send_Calendly_Email_Invite_German_Informal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Calendly_Invite_Email_German_Informal</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>AND(First_ZG_Contact__c !=null,ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c!=null, ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;German&quot;),ISPICKVAL( First_ZG_Contact__r.Tone_of_address__c ,&quot;Informal&quot;),Is_Calendly_email_sent__c = true,Re_send_Assignment_Mail__c = true)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Fastlane Handover email-English</fullName>
        <actions>
            <name>Send_email_English_Template_Fastlane</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Welcome_Handover_email_English</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>AND(First_ZG_Contact__c !=null, First_Shareholder__c != null,First_ZG_Contact__r.Email !=null,First_ZG_Contact__r.Email !=&quot;na@na.com&quot;,ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;English&quot;), ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c != null, Is_Calendly_email_sent__c = false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Fastlane Handover email-English%28Friedrike%29</fullName>
        <actions>
            <name>Send_email_English_Template_Fastlane_Friedrike</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Welcome_Handover_email_English_FdAcc</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <formula>AND(First_ZG_Contact__c !=null,First_ZG_Contact__r.Email  !=null,First_ZG_Contact__r.Email !=&quot;na@na.com&quot;,ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;English&quot;), ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c != null, Onboarding_Manager__r.FirstName = &apos;Friederike&apos;,Is_Calendly_email_sent__c = false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Fastlane Handover email-German</fullName>
        <actions>
            <name>Send_email_German_Template_Fastlane_Formal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Welcome_Handover_email_German</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>AND(First_ZG_Contact__c !=null,First_Shareholder__c != null,First_ZG_Contact__r.Email !=null,First_ZG_Contact__r.Email !=&quot;na@na.com&quot;,ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;German&quot;), ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c != null,Is_Calendly_email_sent__c = false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Fastlane Handover email-German-Formal%28Friedrike%29</fullName>
        <actions>
            <name>Send_email_German_Template_Fastlane_Formal_Friedrike</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Welcome_Handover_email_German_Formal_Acc</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <formula>AND(First_ZG_Contact__c !=null,First_ZG_Contact__r.Email  !=null,First_ZG_Contact__r.Email !=&quot;na@na.com&quot;,ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;German&quot;),ISPICKVAL(First_ZG_Contact__r.Tone_of_address__c , &quot;Formal&quot;), ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c != null, Onboarding_Manager__r.FirstName = &apos;Friederike&apos;,Is_Calendly_email_sent__c = false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Fastlane Handover email-German-Informal</fullName>
        <actions>
            <name>Send_email_German_Template_Fastlane_Informal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Welcome_Handover_email_German_Informal</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <formula>AND(First_ZG_Contact__c !=null,First_ZG_Contact__r.Email !=null,First_ZG_Contact__r.Email !=&quot;na@na.com&quot;,ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;German&quot;),ISPICKVAL(First_ZG_Contact__r.Tone_of_address__c , &quot;Informal&quot;), ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c != null, Onboarding_Manager__r.FirstName != &apos;Friederike&apos;,Is_Calendly_email_sent__c = false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Fastlane Handover email-German-Informal%28Friedrike%29</fullName>
        <actions>
            <name>Send_email_German_Template_Fastlane_Informal_Friedrike</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Welcome_Handover_email_German_Informal_acc</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <formula>AND(First_ZG_Contact__c !=null,First_ZG_Contact__r.Email  !=null,First_ZG_Contact__r.Email !=&quot;na@na.com&quot;,ISPICKVAL(First_ZG_Contact__r.Language__c,&quot;German&quot;),ISPICKVAL(First_ZG_Contact__r.Tone_of_address__c , &quot;Informal&quot;), ISCHANGED(Onboarding_Manager__c),Onboarding_Manager__c != null, Onboarding_Manager__r.FirstName = &apos;Friederike&apos;,Is_Calendly_email_sent__c = false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Test data</fullName>
        <actions>
            <name>Test_data</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Company_Legal_Name__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Calendly_Invite_Email_English</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Calendly Invite Email-English</subject>
    </tasks>
    <tasks>
        <fullName>Calendly_Invite_Email_German_Formal</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Calendly Invite Email-German(Formal)</subject>
    </tasks>
    <tasks>
        <fullName>Calendly_Invite_Email_German_Informal</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Calendly Invite Email-German(Informal)</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_English</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email - English</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_English_FdAcc</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email - English</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Formal_Acc</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Formal)</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Informal</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Informal)</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Informal_acc</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Informal)</subject>
    </tasks>
</Workflow>
