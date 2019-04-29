<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_zeitgold_date</fullName>
        <field>Date_Zeitgold_Rejection_Reasons_Changed__c</field>
        <formula>TODAY()</formula>
        <name>Update zeitgold date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Zeitgold Rejection Reason date field Lead</fullName>
        <actions>
            <name>Update_zeitgold_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(Zeitgold_Rejection_Reasons__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
