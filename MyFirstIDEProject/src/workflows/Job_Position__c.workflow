<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_New_Position_Alert</fullName>
        <description>Email New Position Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>CEO</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Recruiting_App_New_Position_Alert</template>
    </alerts>
    <alerts>
        <fullName>Test_Email_Alert</fullName>
        <description>Test Email Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Sales Rep</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MarketingProductInquiryResponse</template>
    </alerts>
    <fieldUpdates>
        <fullName>Reassign_Position_to_Queue</fullName>
        <description>Assign job position to unclaimed postion queue</description>
        <field>OwnerId</field>
        <lookupValue>Unclaimed_Positions_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Reassign Position to Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_closed_date_to_today</fullName>
        <description>If position record is rejected set the closed date to today&apos;s date</description>
        <field>Close_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set closed date to today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_status_to_Closed_Not_Approved</fullName>
        <description>If the position is rejected set the status to Closed-Not Approved</description>
        <field>Status__c</field>
        <literalValue>Closed-Not Approved</literalValue>
        <name>Set status to Closed - Not Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_status_to_Open_Approved</fullName>
        <description>Once the position is approved set the status to Open Approved</description>
        <field>Status__c</field>
        <literalValue>Open-Approved</literalValue>
        <name>Set status to Open Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_status_to_Pending_Approval</fullName>
        <description>While a position is in approval process, its status should be set to Pending Approval</description>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Set status to Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign Position to Recruiter</fullName>
        <actions>
            <name>Test_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Reassign_Position_to_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notEqual</operation>
            <value>Recruiter,Recruiting Manager</value>
        </criteriaItems>
        <description>Reassign position records to a recruiter if they were created by another type of employee</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Assign_Unclaimed_Position_Records_to_Recruiters</name>
                <type>Task</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Email New Position Alert</fullName>
        <actions>
            <name>Email_New_Position_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Job_Position__c.Status__c</field>
            <operation>equals</operation>
            <value>Open-Approved</value>
        </criteriaItems>
        <description>Send an email to everyone whenever a new position is opened</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Position Alert</fullName>
        <actions>
            <name>Publish_New_Position</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Job_Position__c.Max_Pay__c</field>
            <operation>greaterOrEqual</operation>
            <value>30000</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Assign_Unclaimed_Position_Records_to_Recruiters</fullName>
        <assignedTo>Recruiting_Manager</assignedTo>
        <assignedToType>role</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>true</protected>
        <status>Not Started</status>
        <subject>Assign Unclaimed Position Records to Recruiters</subject>
    </tasks>
    <tasks>
        <fullName>Publish_New_Position</fullName>
        <assignedTo>mruiz01@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>-2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Job_Position__c.Hire_By__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Publish New Position</subject>
    </tasks>
</Workflow>
