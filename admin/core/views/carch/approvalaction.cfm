<cftry>
	

<cfset approvalRequest=$.getBean('approvalRequest').loadBy(requestID=rc.requestID)>
<cfif rc.action eq 'approve'>
	<cfset approvalRequest.approve(rc.comment)>
<cfelse>
	<cfset approvalRequest.reject(rc.comment)>
</cfif>
<cfset content=$.getBean('content').loadBy(contenthistid=approvalRequest.getContentHistID())>
<cfset content=$.getBean('content').loadBy(contentid=content.getContentID())>

<cfset data={contenthistid=approvalRequest.getContentHistID(),previewurl=content.getURL(querystring="previewid=#approvalRequest.getContentHistID()#")}>
<cfcontent type="application/json">
<cfoutput>#createObject("component","mura.json").encode(data)#</cfoutput>
<cfcatch>
	<cfdump var="#cfcatch#">
</cfcatch>
</cftry>
<cfabort>