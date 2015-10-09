<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_Notify_VP_about_cases_of_large_accounts</fullName>
        <description>Email Alert: Notify VP about cases of large accounts</description>
        <protected>false</protected>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportCaseCreatedPhoneInquiries</template>
    </alerts>
    <rules>
        <fullName>Case WF Rule1</fullName>
        <actions>
            <name>Email_Alert_Notify_VP_about_cases_of_large_accounts</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Asset.Price</field>
            <operation>greaterThan</operation>
            <value>10000</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
