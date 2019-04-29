<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_to_Joachim_when_a_Partner_Lead_is_Won</fullName>
        <description>Email to Joachim, when a Partner Lead is Won</description>
        <protected>false</protected>
        <recipients>
            <recipient>sysauto@zeitgold.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_Mail_for_Joachim</template>
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
        <template>unfiled$public/SLS_Handover_Email_English</template>
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
        <fullName>Send_email_German_Template_Fastlane</fullName>
        <ccEmails>service@zeitgold.com</ccEmails>
        <description>Send email - German Template Fastlane_Formal</description>
        <protected>false</protected>
        <recipients>
            <field>First_ZG_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SLS_Handover_Email_German_formal</template>
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
    <fieldUpdates>
        <fullName>Offer_Sent_Stage</fullName>
        <field>StageName</field>
        <literalValue>Offer sent</literalValue>
        <name>Offer Sent Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_MGMT_Call_2</fullName>
        <description>Set MGMT Call in Opp to &quot;Demo scheduled&quot; after creation</description>
        <field>MGMT_Call__c</field>
        <literalValue>DEMO SCHEDULED</literalValue>
        <name>Set MGMT Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_MGMT_Call_to_CW</fullName>
        <field>MGMT_Call__c</field>
        <literalValue>CW</literalValue>
        <name>Set MGMT Call to CW</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_MGMT_Call_to_DS</fullName>
        <field>MGMT_Call__c</field>
        <literalValue>DEMO SCHEDULED</literalValue>
        <name>Set MGMT Call to DS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Closed_Date</fullName>
        <description>Updates Closed Date to day the opportunity is set to closed (lost or won)</description>
        <field>CloseDate</field>
        <formula>TODAY()</formula>
        <name>Update Closed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_zeitgold_date_Opp</fullName>
        <field>Date_Zeitgold_Rejection_Reasons_Changed__c</field>
        <formula>TODAY()</formula>
        <name>Update zeitgold date-Opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set MGMT Call to CW</fullName>
        <actions>
            <name>Set_MGMT_Call_to_CW</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <description>Set MGMT Call to CW, if Opportunity was won</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set MGMT Call to DS</fullName>
        <actions>
            <name>Set_MGMT_Call_to_DS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>AE acceptance pending,Accepted by AE</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Demo_date__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Set MGMT Call to Demos scheduled, if the demo date is in the future and the Opp stage is &lt; Demo completed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set MGMT Call to Demo sched</fullName>
        <actions>
            <name>Set_MGMT_Call_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.MGMT_Call__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Set MGMT Call to Demo scheduled for new created Opportunities.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Closed Date</fullName>
        <actions>
            <name>Update_Closed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Closed Date to the date the opportunity is set to closed won</description>
        <formula>AND(IsClosed = true,ISCHANGED(StageName),OR(ISPICKVAL(StageName,&quot;Closed Won&quot;),ISPICKVAL(StageName,&quot;Closed Lost&quot;),ISPICKVAL(StageName,&quot;Rejected&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Zeitgold Rejection Reason date field Oppty</fullName>
        <actions>
            <name>Update_zeitgold_date_Opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(Zeitgold_Rejection_Reasons__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Welcome_Handover_email_English</fullName>
        <assignedTo>saurav@zeitgold.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email - English</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_English_Fd</fullName>
        <assignedTo>saurav@zeitgold.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email - English</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Formal</fullName>
        <assignedTo>saurav@zeitgold.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Formal)</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Formal_Fd</fullName>
        <assignedTo>saurav@zeitgold.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Formal)</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Informal</fullName>
        <assignedTo>saurav@zeitgold.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Informal)</subject>
    </tasks>
    <tasks>
        <fullName>Welcome_Handover_email_German_Informal_Fd</fullName>
        <assignedTo>saurav@zeitgold.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Welcome Handover email-German(Informal)</subject>
    </tasks>
</Workflow>
