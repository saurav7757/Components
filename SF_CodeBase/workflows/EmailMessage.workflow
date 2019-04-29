<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <description>A closed case is reopened after a customer submits another reply to the initial email.</description>
        <field>Status</field>
        <literalValue>Open</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Reopen Case when customer replies to email</fullName>
        <actions>
            <name>Update_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Active Case Split</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
