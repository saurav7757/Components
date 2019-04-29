<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Complete_Task</fullName>
        <field>Status</field>
        <literalValue>Completed</literalValue>
        <name>Complete Task</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Status_Update</fullName>
        <field>Status</field>
        <literalValue>Completed</literalValue>
        <name>Field Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Clicked a Facebook Ad - Completion</fullName>
        <actions>
            <name>Field_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Clicked a Facebook ad</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Open,In Progress</value>
        </criteriaItems>
        <description>Clicked a Facebook ad will be completed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Clicked an AdWords Ad - Completion</fullName>
        <actions>
            <name>Complete_Task</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>contains</operation>
            <value>Adwords Click</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Open,In Progress</value>
        </criteriaItems>
        <description>Clicked an AdWords ad will be completed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
